library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- =============================================================================
-- Caminho de dados (datapath) do MIPS single-cycle.
-- Os nomes de portas e fios seguem o diagrama do enunciado do projeto
-- (PC, PC', PCPlus4, PCBranch, PCSrc, Instr, SignImm, WriteReg, SrcA, SrcB,
--  ALUResult, Zero, WriteData, ReadData, Result).
--
-- Obs.: VHDL nao diferencia maiusculas/minusculas e nao deixa LER uma porta
-- "out". Por isso os tres fios que saem para as memorias E tambem sao usados
-- aqui dentro (PC, ALUResult e WriteData) tem uma copia interna com sufixo _i.
-- =============================================================================
entity mips_datapath is
    port(
        clk        : in  std_logic;                      -- Clock do sistema
        rst        : in  std_logic;                      -- Reset do PC
        -- Sinais de controle vindos da Controladora
        MemtoReg   : in  std_logic;                      -- 0: ALUResult | 1: ReadData (RAM)
        Branch     : in  std_logic;                      -- Habilita desvio condicional (BEQ)
        ALUControl : in  std_logic_vector(2 downto 0);   -- Operacao da ULA (3 bits)
        ALUSrc     : in  std_logic;                      -- 0: RD2 | 1: SignImm
        RegDst     : in  std_logic;                      -- 0: rt (20:16) | 1: rd (15:11)
        RegWrite   : in  std_logic;                      -- Habilita escrita no Banco de Registradores
        -- Interface com a Memoria de Instrucoes (no processador.vhd)
        Instr      : in  std_logic_vector(31 downto 0);  -- Instrucao lida da ROM (RD)
        PC         : out std_logic_vector(31 downto 0);  -- Endereco atual enviado para a ROM (A)
        -- Interface com a Memoria de Dados (no processador.vhd)
        ReadData   : in  std_logic_vector(31 downto 0);  -- Dado lido da RAM (RD) - LW
        ALUResult  : out std_logic_vector(31 downto 0);  -- Saida da ULA (endereco A da RAM)
        WriteData  : out std_logic_vector(31 downto 0)   -- RD2 enviado para WD da RAM - SW
    );
end entity;

architecture structural of mips_datapath is

    -- =========================================================================
    -- DECLARACAO DOS COMPONENTES (portas iguais as entidades dos arquivos do grupo)
    -- =========================================================================

    -- Registrador do Program Counter (PC)
    component pc_register is
        port(
            CLK     : in  std_logic;
            reset   : in  std_logic;
            PC_next : in  std_logic_vector(31 downto 0);
            PC      : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Somador dedicado PC + 4
    component adder_pc4 is
        port(
            PC      : in  std_logic_vector(31 downto 0);
            PCPlus4 : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Somador do endereco de desvio: PCBranch = PCPlus4 + (SignImm << 2)
    component adder_branch is
        port(
            PCPlus4   : in  std_logic_vector(31 downto 0);
            SignImmSh : in  std_logic_vector(31 downto 0);
            PCBranch  : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Multiplexador 2x1 generico (usado em 5 bits para RegDst e 32 bits nos demais)
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

    -- Banco de Registradores
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

    -- Extensor de Sinal 16 -> 32 bits
    component sign_extend is
        port(
            imm_in  : in  std_logic_vector(15 downto 0);
            imm_out : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Deslocador de 2 bits a esquerda (<<2: multiplica imediato de branch por 4)
    component shift_left_2 is
        port(
            data_in  : in  std_logic_vector(31 downto 0);
            data_out : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Unidade Logica e Aritmetica (ULA)
    component alu is
        port(
            SrcA       : in  std_logic_vector(31 downto 0);
            SrcB       : in  std_logic_vector(31 downto 0);
            ALUControl : in  std_logic_vector(2 downto 0);
            ALUResult  : out std_logic_vector(31 downto 0);
            Zero       : out std_logic
        );
    end component;

    -- =========================================================================
    -- FIOS INTERNOS (mesmos nomes do diagrama)
    -- =========================================================================

    -- Campos da instrucao
    signal rs        : std_logic_vector(4 downto 0);   -- Instr(25:21) -> A1
    signal rt        : std_logic_vector(4 downto 0);   -- Instr(20:16) -> A2 e Mux RegDst (0)
    signal rd        : std_logic_vector(4 downto 0);   -- Instr(15:11) -> Mux RegDst (1)
    signal imm16     : std_logic_vector(15 downto 0);  -- Instr(15:0)  -> Sign Extend

    -- Fluxo do PC e Branch
    signal PCNext    : std_logic_vector(31 downto 0);  -- PC' (entrada do registrador do PC)
    signal PC_i      : std_logic_vector(31 downto 0);  -- PC  (copia interna da porta PC)
    signal PCPlus4   : std_logic_vector(31 downto 0);  -- PCPlus4
    signal PCBranch  : std_logic_vector(31 downto 0);  -- PCBranch
    signal SignImm   : std_logic_vector(31 downto 0);  -- SignImm
    signal SignImmSh : std_logic_vector(31 downto 0);  -- SignImm << 2
    signal PCSrc     : std_logic;                      -- Branch AND Zero

    -- Banco de Registradores e ULA
    signal WriteReg    : std_logic_vector(4 downto 0);  -- WriteReg (A3)
    signal SrcA        : std_logic_vector(31 downto 0); -- SrcA (RD1)
    signal WriteData_i : std_logic_vector(31 downto 0); -- WriteData (RD2, copia interna)
    signal SrcB        : std_logic_vector(31 downto 0); -- SrcB
    signal ALUResult_i : std_logic_vector(31 downto 0); -- ALUResult (copia interna)
    signal Zero        : std_logic;                     -- Flag Zero da ULA
    signal Result      : std_logic_vector(31 downto 0); -- Result (WD3)

begin

    -- =========================================================================
    -- 1. DIVISAO DOS CAMPOS DA INSTRUCAO (Op e Funct vao direto na Controladora)
    -- =========================================================================
    rs    <= Instr(25 downto 21); -- Registrador fonte 1 (A1)
    rt    <= Instr(20 downto 16); -- Registrador fonte 2 (A2) / destino tipo-I (Mux RegDst 0)
    rd    <= Instr(15 downto 11); -- Registrador destino tipo-R (Mux RegDst 1)
    imm16 <= Instr(15 downto 0);  -- Imediato de 16 bits (Sign Extend)

    -- =========================================================================
    -- 2. LOGICA DE ATUALIZACAO DO PC (PC+4 e Branch)
    -- =========================================================================
    -- Porta AND do diagrama: desvia somente se for instrucao de Branch E Zero = '1'
    PCSrc <= Branch and Zero;

    -- Mux do proximo PC (0: PCPlus4 | 1: PCBranch)
    MUX_PC : mux2x1_32bits
        generic map(WIDTH => 32)
        port map(
            in0 => PCPlus4,
            in1 => PCBranch,
            sel => PCSrc,
            y   => PCNext
        );

    -- Registrador do PC
    REG_PC : pc_register
        port map(
            CLK     => clk,
            reset   => rst,
            PC_next => PCNext,
            PC      => PC_i
        );

    -- Somador PC + 4
    ADD_PC4 : adder_pc4
        port map(
            PC      => PC_i,
            PCPlus4 => PCPlus4
        );

    -- Shift Left 2 (desloca SignImm em 2 bits para alinhar endereco de palavra)
    SHL2 : shift_left_2
        port map(
            data_in  => SignImm,
            data_out => SignImmSh
        );

    -- Somador do endereco de desvio: PCBranch = (SignImm << 2) + PCPlus4
    ADD_BRANCH : adder_branch
        port map(
            PCPlus4   => PCPlus4,
            SignImmSh => SignImmSh,
            PCBranch  => PCBranch
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
            sel => RegDst,
            y   => WriteReg
        );

    -- Banco de Registradores
    REGFILE : register_file
        port map(
            CLK => clk,
            WE3 => RegWrite,
            A1  => rs,
            A2  => rt,
            A3  => WriteReg,
            WD3 => Result,
            RD1 => SrcA,
            RD2 => WriteData_i
        );

    -- Extensor de Sinal (16 -> 32 bits)
    SIGNEXT : sign_extend
        port map(
            imm_in  => imm16,
            imm_out => SignImm
        );

    -- =========================================================================
    -- 4. ULA E WRITE-BACK (RETORNO PARA O BANCO DE REGISTRADORES)
    -- =========================================================================
    -- Mux da entrada B da ULA (0: RD2 | 1: SignImm)
    MUX_ALUSRC : mux2x1_32bits
        generic map(WIDTH => 32)
        port map(
            in0 => WriteData_i,
            in1 => SignImm,
            sel => ALUSrc,
            y   => SrcB
        );

    -- ULA
    ULA : alu
        port map(
            SrcA       => SrcA,
            SrcB       => SrcB,
            ALUControl => ALUControl,
            ALUResult  => ALUResult_i,
            Zero       => Zero
        );

    -- Mux de escrita de volta no registrador WD3 (0: ALUResult | 1: ReadData)
    MUX_MEMTOREG : mux2x1_32bits
        generic map(WIDTH => 32)
        port map(
            in0 => ALUResult_i,
            in1 => ReadData,
            sel => MemtoReg,
            y   => Result
        );

    -- =========================================================================
    -- 5. SAIDAS DO DATAPATH PARA AS MEMORIAS (CONECTADAS NO PROCESSADOR.VHD)
    -- =========================================================================
    PC        <= PC_i;
    ALUResult <= ALUResult_i;
    WriteData <= WriteData_i;

end architecture;
