library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips_datapath is
    port(
        clk        : in  std_logic;                      -- Clock do sistema
        rst        : in  std_logic;                      -- Reset do PC
        -- Sinais de controle vindos da Controladora
        memtoreg   : in  std_logic;                      -- 0: ALUResult | 1: ReadData (RAM)
        branch     : in  std_logic;                      -- Habilita desvio condicional (BEQ)
        alucontrol : in  std_logic_vector(2 downto 0);   -- Operacao da ULA (3 bits)
        alusrc     : in  std_logic;                      -- 0: RD2 | 1: SignImm
        regdst     : in  std_logic;                      -- 0: rt (20:16) | 1: rd (15:11)
        regwrite   : in  std_logic;                      -- Habilita escrita no Banco de Registradores
        -- Interface com a Memoria de Instrucoes (no processador.vhd)
        instr      : in  std_logic_vector(31 downto 0);  -- Instrucao lida da ROM
        pc         : out std_logic_vector(31 downto 0);  -- Endereco atual enviado para a ROM
        -- Interface com a Memoria de Dados (no processador.vhd)
        readdata   : in  std_logic_vector(31 downto 0);  -- Dado lido da RAM (LW)
        aluout     : out std_logic_vector(31 downto 0);  -- Saida da ULA (endereco A da RAM)
        writedata  : out std_logic_vector(31 downto 0)   -- Dado RD2 enviado para WD da RAM (SW)
    );
end entity;

architecture structural of mips_datapath is

    -- =========================================================================
    -- DECLARACAO DOS COMPONENTES (ajustar nomes/portas conforme arquivos do grupo)
    -- =========================================================================

    -- Registrador do Program Counter (PC)
    component pc_register is
        port(
            clk    : in  std_logic;
            rst    : in  std_logic;
            pc_in  : in  std_logic_vector(31 downto 0);
            pc_out : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Somador de 32 bits (reutilizado para PC+4 e para PCBranch)
    component adder_32 is
        port(
            a : in  std_logic_vector(31 downto 0);
            b : in  std_logic_vector(31 downto 0);
            y : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Multiplexador 2x1 generico (ja validado - usado em 5 bits para RegDst e 32 bits nos demais)
    component mux2x1_32bits is
        generic(
            WIDTH : integer := 32
        );
        port(
            in0 : in  std_logic_vector(WIDTH - 1 downto 0);
            in1 : in  std_logic_vector(WIDTH - 1 downto 0);
            sel : in  std_logic;
            y   : out std_logic_vector(WIDTH - 1 downto 0)
        );
    end component;

    -- Banco de Registradores (ja validado)
    component register_file is
        port(
            CLK : in  std_logic;
            WE3 : in  std_logic;
            A1  : in  std_logic_vector(4 downto 0);
            A2  : in  std_logic_vector(4 downto 0);
            A3  : in  std_logic_vector(4 downto 0);
            WD3 : in  std_logic_vector(31 downto 0);
            RD1 : out std_logic_vector(31 downto 0);
            RD2 : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Extensor de Sinal 16 -> 32 bits (ja validado)
    component sign_extend is
        port(
            imm_in  : in  std_logic_vector(15 downto 0);
            imm_out : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Deslocador de 2 bits a esquerda (multiplica imediato de branch por 4)
    component shift_left_2 is
        port(
            a : in  std_logic_vector(31 downto 0);
            y : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Unidade Logica e Aritmetica (ULA)
    component alu is
        port(
            src_a      : in  std_logic_vector(31 downto 0);
            src_b      : in  std_logic_vector(31 downto 0);
            alucontrol : in  std_logic_vector(2 downto 0);
            alu_result : out std_logic_vector(31 downto 0);
            zero       : out std_logic
        );
    end component;

    -- =========================================================================
    -- SINAIS INTERNOS (FIOS DO CAMINHO DE DADOS)
    -- =========================================================================

    -- Fatiamento explicito dos campos da instrucao (facilita leitura e debug)
    signal rs        : std_logic_vector(4 downto 0);   -- instr(25 downto 21)
    signal rt        : std_logic_vector(4 downto 0);   -- instr(20 downto 16)
    signal rd        : std_logic_vector(4 downto 0);   -- instr(15 downto 11)
    signal imm16     : std_logic_vector(15 downto 0);  -- instr(15 downto 0)

    -- Sinais do fluxo do PC e Branch
    signal s_pc_next          : std_logic_vector(31 downto 0); -- PC'
    signal s_pc_current       : std_logic_vector(31 downto 0); -- PC
    signal s_pc_plus4         : std_logic_vector(31 downto 0); -- PCPlus4
    signal s_pc_branch        : std_logic_vector(31 downto 0); -- PCBranch
    signal s_sign_imm         : std_logic_vector(31 downto 0); -- SignImm
    signal s_sign_imm_shifted : std_logic_vector(31 downto 0); -- SignImm << 2
    signal s_pcsrc            : std_logic;                     -- Branch AND Zero

    -- Sinais do Banco de Registradores e ULA
    signal s_write_reg  : std_logic_vector(4 downto 0);        -- WriteReg (A3)
    signal s_rd1        : std_logic_vector(31 downto 0);       -- SrcA
    signal s_rd2        : std_logic_vector(31 downto 0);       -- WriteData / entrada 0 do Mux ALUSrc
    signal s_src_b      : std_logic_vector(31 downto 0);       -- SrcB
    signal s_alu_result : std_logic_vector(31 downto 0);       -- ALUResult
    signal s_zero       : std_logic;                           -- Flag Zero da ULA
    signal s_result     : std_logic_vector(31 downto 0);       -- Result (WD3)

begin

    -- =========================================================================
    -- 1. DIVISAO DOS CAMPOS DA INSTRUCAO (op e funct vao direto na Controladora)
    -- =========================================================================
    rs    <= instr(25 downto 21); -- Registrador fonte 1 (A1)
    rt    <= instr(20 downto 16); -- Registrador fonte 2 (A2) / destino tipo-I (Mux RegDst 0)
    rd    <= instr(15 downto 11); -- Registrador destino tipo-R (Mux RegDst 1)
    imm16 <= instr(15 downto 0);  -- Imediato de 16 bits (Sign Extend)

    -- =========================================================================
    -- 2. LOGICA DE ATUALIZACAO DO PC (PC+4 e Branch)
    -- =========================================================================
    -- Porta AND do diagrama: desvia somente se for instrucao de Branch E Zero = '1'
    s_pcsrc <= branch and s_zero;

    -- Mux do proximo PC (0: PC+4 | 1: PCBranch)
    MUX_PC : mux2x1_32bits
        generic map(WIDTH => 32)
        port map(
            in0 => s_pc_plus4,
            in1 => s_pc_branch,
            sel => s_pcsrc,
            y   => s_pc_next
        );

    -- Registrador do PC
    REG_PC : pc_register
        port map(
            clk    => clk,
            rst    => rst,
            pc_in  => s_pc_next,
            pc_out => s_pc_current
        );

    -- Somador PC + 4
    ADD_PC4 : adder_32
        port map(
            a => s_pc_current,
            b => x"00000004",
            y => s_pc_plus4
        );

    -- Shift Left 2 (desloca SignImm em 2 bits para alinhar endereco de palavra)
    SHL2 : shift_left_2
        port map(
            a => s_sign_imm,
            y => s_sign_imm_shifted
        );

    -- Somador do endereco de desvio: PCBranch = (SignImm << 2) + PCPlus4
    ADD_BRANCH : adder_32
        port map(
            a => s_sign_imm_shifted,
            b => s_pc_plus4,
            y => s_pc_branch
        );

    -- =========================================================================
    -- 3. BANCO DE REGISTRADORES E EXTENSOR DE SINAL
    -- =========================================================================
    -- Mux de selecao do registrador destino A3 (0: rt | 1: rd)
    MUX_REGDST : mux2x1_32bits
        generic map(WIDTH => 5)
        port map(
            in0 => rt,
            in1 => rd,
            sel => regdst,
            y   => s_write_reg
        );

    -- Banco de Registradores
    REGFILE : register_file
        port map(
            CLK => clk,
            WE3 => regwrite,
            A1  => rs,
            A2  => rt,
            A3  => s_write_reg,
            WD3 => s_result,
            RD1 => s_rd1,
            RD2 => s_rd2
        );

    -- Extensor de Sinal (16 -> 32 bits)
    SIGNEXT : sign_extend
        port map(
            imm_in  => imm16,
            imm_out => s_sign_imm
        );

    -- =========================================================================
    -- 4. ULA E WRITE-BACK (RETORNO PARA O BANCO DE REGISTRADORES)
    -- =========================================================================
    -- Mux da entrada B da ULA (0: RD2 | 1: SignImm)
    MUX_ALUSRC : mux2x1_32bits
        generic map(WIDTH => 32)
        port map(
            in0 => s_rd2,
            in1 => s_sign_imm,
            sel => alusrc,
            y   => s_src_b
        );

    -- ULA
    ULA : alu
        port map(
            src_a      => s_rd1,
            src_b      => s_src_b,
            alucontrol => alucontrol,
            alu_result => s_alu_result,
            zero       => s_zero
        );

    -- Mux de escrita de volta no registrador WD3 (0: ALUResult | 1: ReadData)
    MUX_MEMTOREG : mux2x1_32bits
        generic map(WIDTH => 32)
        port map(
            in0 => s_alu_result,
            in1 => readdata,
            sel => memtoreg,
            y   => s_result
        );

    -- =========================================================================
    -- 5. SAIDAS DO DATAPATH PARA AS MEMORIAS (CONECTADAS NO PROCESSADOR.VHD)
    -- =========================================================================
    pc        <= s_pc_current;
    aluout    <= s_alu_result;
    writedata <= s_rd2;

end architecture;