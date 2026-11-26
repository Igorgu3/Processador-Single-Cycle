--------------------------------------------------------------------------------
-- tb_processador - teste do processador MIPS single-cycle completo
--
-- O testbench tem um MODELO DE REFERENCIA proprio (independente do VHDL do
-- grupo): ele le o mesmo "instrucoes.txt", executa cada instrucao em software
-- e, a cada ciclo de clock, compara com o processador:
--   * PC (pc_out) e instrucao lida da ROM (instr_out)
--   * resultado da ULA (alu_out)
--   * dado escrito na RAM (writedata_out = RD2)
--   * todos os sinais da controladora (RegWrite, RegDst, ALUSrc, Branch,
--     MemWrite, MemtoReg, ALUControl)
-- Qualquer diferenca e impressa como ERRO. No fim aparece um resumo.
--
-- Instrucoes do modelo: R-type (add, sub, and, or, slt, mult), addi, lw, sw, beq.
--
-- O programa completo tem 100 bilhoes de instrucoes (impossivel simular), entao
-- o teste roda N_CICLOS ciclos. O padrao (60000) cobre o loop interno inteiro
-- (10000 voltas, ~50000 ciclos), a saida dele com beq tomado e a volta para o
-- loop do meio, ou seja: addi, sw, lw, beq tomado e beq nao tomado.
--
-- Como rodar (EDA Playground / GHDL, ModelSim etc.):
--   * top-level da simulacao: tb_processador
--   * o arquivo instrucoes.txt precisa estar junto dos .vhd (mesma pasta onde
--     o simulador roda), pois a memoria de instrucoes e o testbench leem ele.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_processador is
    generic(
        N_CICLOS     : natural := 60000;            -- ciclos de clock simulados
        N_TRACE      : natural := 40;               -- ciclos iniciais impressos no console
        ARQ_PROGRAMA : string  := "instrucoes.txt"  -- mesmo arquivo da memoria de instrucoes
    );
end entity;

architecture sim of tb_processador is

    constant T_CLK : time := 20 ns;  -- 50 MHz, igual ao clock da placa

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal fim : boolean   := false;

    -- Saidas do processador
    signal pc_out         : std_logic_vector(31 downto 0);
    signal instr_out      : std_logic_vector(31 downto 0);
    signal alu_out        : std_logic_vector(31 downto 0);
    signal writedata_out  : std_logic_vector(31 downto 0);
    signal regwrite_out   : std_logic;
    signal regdst_out     : std_logic;
    signal alusrc_out     : std_logic;
    signal branch_out     : std_logic;
    signal memwrite_out   : std_logic;
    signal memtoreg_out   : std_logic;
    signal alucontrol_out : std_logic_vector(2 downto 0);

    subtype word is std_logic_vector(31 downto 0);
    type mem_t is array (0 to 63) of word;
    type reg_t is array (0 to 31) of word;

    -- Le o programa do mesmo jeito que a instruction_memory
    impure function carrega_programa(nome : string) return mem_t is
        file arq      : text open read_mode is nome;
        variable l    : line;
        variable mem  : mem_t := (others => (others => '0'));
        variable i    : integer := 0;
    begin
        while not endfile(arq) and i <= 63 loop
            readline(arq, l);
            hread(l, mem(i));
            i := i + 1;
        end loop;
        return mem;
    end function;

    -- Nome dos registradores (so para deixar o trace legivel)
    function nome_reg(n : integer) return string is
    begin
        case n is
            when 0      => return "$zero";
            when 8      => return "$t0";
            when 9      => return "$t1";
            when 10     => return "$t2";
            when 11     => return "$t3";
            when 16     => return "$s0";
            when others => return "$" & integer'image(n);
        end case;
    end function;

begin

    -- Processador completo (o mesmo que vai para a FPGA, sem o fpga_top)
    DUT : entity work.processador
        port map(
            clk            => clk,
            rst            => rst,
            pc_out         => pc_out,
            instr_out      => instr_out,
            alu_out        => alu_out,
            writedata_out  => writedata_out,
            regwrite_out   => regwrite_out,
            regdst_out     => regdst_out,
            alusrc_out     => alusrc_out,
            branch_out     => branch_out,
            memwrite_out   => memwrite_out,
            memtoreg_out   => memtoreg_out,
            alucontrol_out => alucontrol_out
        );

    -- Clock: para sozinho quando o teste termina (assim "run -all" encerra)
    gera_clock : process
    begin
        while not fim loop
            clk <= '0';
            wait for T_CLK / 2;
            clk <= '1';
            wait for T_CLK / 2;
        end loop;
        wait;
    end process;

    verifica : process
        variable rom   : mem_t := carrega_programa(ARQ_PROGRAMA);
        variable ram   : mem_t := (others => (others => '0'));
        variable regs  : reg_t := (others => (others => '0'));
        variable pc    : unsigned(31 downto 0) := (others => '0');

        variable instr : word;
        variable op    : std_logic_vector(5 downto 0);
        variable funct : std_logic_vector(5 downto 0);
        variable rs, rt, rd : integer;
        variable imm   : word;
        variable a, b  : word;
        variable res   : word;
        variable prod  : signed(63 downto 0);
        variable pc4   : unsigned(31 downto 0);
        variable pc_prox : unsigned(31 downto 0);
        variable destino : integer;
        variable valor   : word;

        -- valores esperados da controladora
        variable e_regwrite, e_regdst, e_alusrc, e_branch : std_logic;
        variable e_memwrite, e_memtoreg                   : std_logic;
        variable e_alucontrol                             : std_logic_vector(2 downto 0);

        variable ciclo      : integer := 0;
        variable erros      : integer := 0;
        variable n_sw       : integer := 0;
        variable n_lw       : integer := 0;
        variable n_addi     : integer := 0;
        variable n_beq_tom  : integer := 0;
        variable n_beq_ntom : integer := 0;
        variable l          : line;

        procedure confere(nome : string; obtido, esperado : std_logic_vector) is
            variable lc : line;
        begin
            if obtido /= esperado then
                erros := erros + 1;
                if erros <= 30 then
                    write(lc, string'("ERRO ciclo "));
                    write(lc, ciclo);
                    write(lc, string'(" PC=0x"));
                    hwrite(lc, std_logic_vector(pc));
                    write(lc, string'(" | " & nome & ": obtido="));
                    write(lc, obtido);
                    write(lc, string'(" esperado="));
                    write(lc, esperado);
                    writeline(output, lc);
                end if;
            end if;
        end procedure;

        procedure confere(nome : string; obtido, esperado : std_logic) is
        begin
            confere(nome, std_logic_vector'(0 => obtido), std_logic_vector'(0 => esperado));
        end procedure;

    begin
        -- Reset do PC (assincrono) e solto ANTES da primeira borda de subida.
        -- Obs.: o banco de registradores nao tem reset; se o reset ficasse ativo
        -- durante uma borda, o PC ficaria em 0 mas a instrucao do endereco 0
        -- seria executada nessa borda (no programa atual isso e inofensivo).
        rst <= '1';
        wait for T_CLK / 4;
        rst <= '0';
        wait for 1 ns;

        write(l, string'("=== tb_processador: ")); write(l, N_CICLOS);
        write(l, string'(" ciclos, programa ") & ARQ_PROGRAMA & " ===");
        writeline(output, l);

        while ciclo < N_CICLOS loop
            ---------------------------------------------------------------
            -- 1. Modelo de referencia: o que a instrucao atual deve fazer
            ---------------------------------------------------------------
            instr := rom(to_integer(pc(7 downto 2)));
            op    := instr(31 downto 26);
            funct := instr(5 downto 0);
            rs    := to_integer(unsigned(instr(25 downto 21)));
            rt    := to_integer(unsigned(instr(20 downto 16)));
            rd    := to_integer(unsigned(instr(15 downto 11)));
            imm   := std_logic_vector(resize(signed(instr(15 downto 0)), 32));
            a     := regs(rs);
            b     := regs(rt);
            pc4   := pc + 4;
            pc_prox := pc4;
            destino := 0;               -- 0 = nao escreve no banco
            valor   := (others => '0');

            e_regwrite := '0'; e_regdst := '0'; e_alusrc := '0'; e_branch := '0';
            e_memwrite := '0'; e_memtoreg := '0'; e_alucontrol := "010";
            res := std_logic_vector(signed(a) + signed(b));

            case op is
                when "000000" =>                          -- R-type
                    e_regwrite := '1'; e_regdst := '1';
                    case funct is
                        when "100000" => e_alucontrol := "010";
                                         res := std_logic_vector(signed(a) + signed(b));
                        when "100010" => e_alucontrol := "110";
                                         res := std_logic_vector(signed(a) - signed(b));
                        when "100100" => e_alucontrol := "000"; res := a and b;
                        when "100101" => e_alucontrol := "001"; res := a or b;
                        when "101010" => e_alucontrol := "111";
                                         if signed(a) < signed(b) then res := x"00000001";
                                         else res := x"00000000"; end if;
                        when "101011" => e_alucontrol := "011";   -- mult (tabela do projeto)
                                         prod := signed(a) * signed(b);
                                         res  := std_logic_vector(prod(31 downto 0));
                        when others   => e_alucontrol := "000"; res := a and b;
                    end case;
                    destino := rd; valor := res;

                when "001000" =>                          -- addi
                    e_regwrite := '1'; e_alusrc := '1';
                    res := std_logic_vector(signed(a) + signed(imm));
                    destino := rt; valor := res;
                    n_addi := n_addi + 1;

                when "100011" =>                          -- lw
                    e_regwrite := '1'; e_alusrc := '1'; e_memtoreg := '1';
                    res := std_logic_vector(signed(a) + signed(imm));
                    destino := rt; valor := ram(to_integer(unsigned(res(7 downto 2))));
                    n_lw := n_lw + 1;

                when "101011" =>                          -- sw
                    e_alusrc := '1'; e_memwrite := '1';
                    res := std_logic_vector(signed(a) + signed(imm));
                    n_sw := n_sw + 1;

                when "000100" =>                          -- beq
                    e_branch := '1'; e_alucontrol := "110";
                    res := std_logic_vector(signed(a) - signed(b));
                    if res = x"00000000" then
                        pc_prox := pc4 + shift_left(unsigned(imm), 2);  -- PCPlus4 + (SignImm << 2)
                        n_beq_tom := n_beq_tom + 1;
                    else
                        n_beq_ntom := n_beq_ntom + 1;
                    end if;

                when others =>                            -- nao suportada: nada acontece
                    null;
            end case;

            ---------------------------------------------------------------
            -- 2. Compara com o processador (meio do ciclo, tudo estavel)
            ---------------------------------------------------------------
            confere("PC",         pc_out,         std_logic_vector(pc));
            confere("Instr",      instr_out,      instr);
            confere("ALUResult",  alu_out,        res);
            confere("WriteData",  writedata_out,  b);
            confere("RegWrite",   regwrite_out,   e_regwrite);
            confere("RegDst",     regdst_out,     e_regdst);
            confere("ALUSrc",     alusrc_out,     e_alusrc);
            confere("Branch",     branch_out,     e_branch);
            confere("MemWrite",   memwrite_out,   e_memwrite);
            confere("MemtoReg",   memtoreg_out,   e_memtoreg);
            confere("ALUControl", alucontrol_out, e_alucontrol);

            -- Trace dos primeiros ciclos
            if ciclo < N_TRACE then
                write(l, string'("ciclo ")); write(l, ciclo, right, 3);
                write(l, string'(" | PC=0x")); hwrite(l, pc_out);
                write(l, string'(" | instr=0x")); hwrite(l, instr);
                write(l, string'(" | ALU=0x")); hwrite(l, alu_out);
                case op is
                    when "001000" => write(l, string'(" | addi " & nome_reg(rt) & ", " & nome_reg(rs) & ", ")
                                               & integer'image(to_integer(signed(imm))));
                    when "100011" => write(l, string'(" | lw   " & nome_reg(rt) & ", ")
                                               & integer'image(to_integer(signed(imm))) & "(" & nome_reg(rs) & ")");
                    when "101011" => write(l, string'(" | sw   " & nome_reg(rt) & ", ")
                                               & integer'image(to_integer(signed(imm))) & "(" & nome_reg(rs) & ")");
                    when "000100" => write(l, string'(" | beq  " & nome_reg(rs) & ", " & nome_reg(rt) & ", ")
                                               & integer'image(to_integer(signed(imm))));
                    when "000000" => write(l, string'(" | R-type funct=")); write(l, funct);
                    when others   => write(l, string'(" | (nao suportada)"));
                end case;
                writeline(output, l);
            end if;

            ---------------------------------------------------------------
            -- 3. Borda de subida: atualiza o modelo como o hardware faria
            ---------------------------------------------------------------
            if destino /= 0 then
                regs(destino) := valor;
            end if;
            if e_memwrite = '1' then
                ram(to_integer(unsigned(res(7 downto 2)))) := b;
            end if;
            pc := pc_prox;
            ciclo := ciclo + 1;

            wait until rising_edge(clk);
            wait for T_CLK / 4;
        end loop;

        ---------------------------------------------------------------
        -- Resumo
        ---------------------------------------------------------------
        write(l, string'("=== RESUMO apos ")); write(l, ciclo); write(l, string'(" instrucoes ==="));
        writeline(output, l);
        write(l, string'("addi=")); write(l, n_addi);
        write(l, string'("  sw=")); write(l, n_sw);
        write(l, string'("  lw=")); write(l, n_lw);
        write(l, string'("  beq tomado=")); write(l, n_beq_tom);
        write(l, string'("  beq nao tomado=")); write(l, n_beq_ntom);
        writeline(output, l);
        write(l, string'("Modelo: $s0=0x")); hwrite(l, regs(16));
        write(l, string'(" $t0=")); write(l, to_integer(signed(regs(8))));
        write(l, string'(" $t1=")); write(l, to_integer(signed(regs(9))));
        write(l, string'(" $t2=")); write(l, to_integer(signed(regs(10))));
        write(l, string'(" $t3=")); write(l, to_integer(signed(regs(11))));
        writeline(output, l);

        if erros = 0 then
            report "SUCESSO: processador bateu com o modelo de referencia em todos os ciclos" severity note;
        else
            report "FALHA: " & integer'image(erros) & " divergencias (veja as linhas ERRO acima)" severity error;
        end if;

        fim <= true;
        wait;
    end process;

end architecture;
