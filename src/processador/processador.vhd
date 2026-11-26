library ieee;
use ieee.std_logic_1164.all;

entity processador is
    port(
        clk            : in  std_logic;
        rst            : in  std_logic;
        -- Saidas de observacao para simulacao e FPGA
        pc_out         : out std_logic_vector(31 downto 0);
        instr_out      : out std_logic_vector(31 downto 0); -- Instr (saida RD da ROM)
        alu_out        : out std_logic_vector(31 downto 0);
        writedata_out  : out std_logic_vector(31 downto 0);
        -- Saidas dos sinais da controladora para os LEDs
        regwrite_out   : out std_logic;
        regdst_out     : out std_logic;
        alusrc_out     : out std_logic;
        branch_out     : out std_logic;
        memwrite_out   : out std_logic;
        memtoreg_out   : out std_logic;
        alucontrol_out : out std_logic_vector(2 downto 0)
    );
end entity;

architecture structural of processador is

    -- 1. Datapath (PC, Somadores, Banco de Registradores, ULA, Muxes, SignExt, ShiftLeft2)
    component mips_datapath is
        port(
            clk        : in  std_logic;
            rst        : in  std_logic;
            -- Sinais de controle vindos da Controladora
            MemtoReg   : in  std_logic;
            Branch     : in  std_logic;
            ALUControl : in  std_logic_vector(2 downto 0);
            ALUSrc     : in  std_logic;
            RegDst     : in  std_logic;
            RegWrite   : in  std_logic;
            -- Interface com a Memoria de Instrucoes
            Instr      : in  std_logic_vector(31 downto 0);
            PC         : out std_logic_vector(31 downto 0);
            -- Interface com a Memoria de Dados
            ReadData   : in  std_logic_vector(31 downto 0);
            ALUResult  : out std_logic_vector(31 downto 0);
            WriteData  : out std_logic_vector(31 downto 0)
        );
    end component;

    -- 2. Controladora (src_top = main_decoder + alu_decoder)
    component src_top is
        port(
            Opcode     : in  std_logic_vector(5 downto 0);
            funct      : in  std_logic_vector(5 downto 0);
            ALUop      : out std_logic_vector(1 downto 0);
            MemtoReg   : out std_logic;
            MemWrite   : out std_logic;
            Branch     : out std_logic;
            ALUControl : out std_logic_vector(2 downto 0);
            ALUSrc     : out std_logic;
            RegDst     : out std_logic;
            RegWrite   : out std_logic
        );
    end component;

    -- 3. Memoria de Instrucoes (ROM)
    component instruction_memory is
        port(
            A  : in  std_logic_vector(31 downto 0);
            RD : out std_logic_vector(31 downto 0)
        );
    end component;

    -- 4. Memoria de Dados (RAM)
    component data_memory is
        port(
            CLK : in  std_logic;
            WE  : in  std_logic;
            A   : in  std_logic_vector(31 downto 0);
            WD  : in  std_logic_vector(31 downto 0);
            RD  : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Sinais de controle (Controladora -> Datapath / Data Memory), nomes do diagrama
    signal MemtoReg   : std_logic;
    signal MemWrite   : std_logic;
    signal Branch     : std_logic;
    signal ALUControl : std_logic_vector(2 downto 0);
    signal ALUSrc     : std_logic;
    signal RegDst     : std_logic;
    signal RegWrite   : std_logic;

    -- Barramentos entre Datapath e Memorias, nomes do diagrama
    signal PC         : std_logic_vector(31 downto 0);
    signal Instr      : std_logic_vector(31 downto 0);
    signal ALUResult  : std_logic_vector(31 downto 0);
    signal WriteData  : std_logic_vector(31 downto 0);
    signal ReadData   : std_logic_vector(31 downto 0);

begin

    -- Instanciacao da Memoria de Instrucoes
    IMEM : instruction_memory
        port map(
            A  => PC,
            RD => Instr
        );

    -- Instanciacao da Memoria de Dados
    DMEM : data_memory
        port map(
            CLK => clk,
            WE  => MemWrite,
            A   => ALUResult,
            WD  => WriteData,
            RD  => ReadData
        );

    -- Instanciacao da Controladora (fatiando Opcode e funct direto da instrucao)
    CONTROL : src_top
        port map(
            Opcode     => Instr(31 downto 26),
            funct      => Instr(5 downto 0),
            ALUop      => open,
            MemtoReg   => MemtoReg,
            MemWrite   => MemWrite,
            Branch     => Branch,
            ALUControl => ALUControl,
            ALUSrc     => ALUSrc,
            RegDst     => RegDst,
            RegWrite   => RegWrite
        );

    -- Instanciacao do Datapath
    DATA : mips_datapath
        port map(
            clk        => clk,
            rst        => rst,
            MemtoReg   => MemtoReg,
            Branch     => Branch,
            ALUControl => ALUControl,
            ALUSrc     => ALUSrc,
            RegDst     => RegDst,
            RegWrite   => RegWrite,
            Instr      => Instr,
            PC         => PC,
            ReadData   => ReadData,
            ALUResult  => ALUResult,
            WriteData  => WriteData
        );

    -- Conexao dos sinais internos as saidas externas do top-level
    pc_out         <= PC;
    instr_out      <= Instr;
    alu_out        <= ALUResult;
    writedata_out  <= WriteData;
    regwrite_out   <= RegWrite;
    regdst_out     <= RegDst;
    alusrc_out     <= ALUSrc;
    branch_out     <= Branch;
    memwrite_out   <= MemWrite;
    memtoreg_out   <= MemtoReg;
    alucontrol_out <= ALUControl;

end architecture;