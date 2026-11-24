library ieee;
use ieee.std_logic_1164.all;

entity processador is
    port(
        clk     : in  std_logic;                      -- Clock do sistema
        rst     : in  std_logic;                      -- Reset do PC
        -- Saidas de observacao (evitam otimizacao no Quartus e ajudam no debug/FPGA)
        pc_out  : out std_logic_vector(31 downto 0);  -- Endereco atual da instrucao (PC)
        alu_out : out std_logic_vector(31 downto 0)   -- Resultado atual da ULA (endereco da RAM)
    );
end entity;

architecture structural of processador is

    -- 1. Datapath (PC, Somadores, Banco de Registradores, ULA, Muxes, SignExt, ShiftLeft2)
    component mips_datapath is
        port(
            clk        : in  std_logic;
            rst        : in  std_logic;
            -- Sinais de controle vindos da Controladora
            memtoreg   : in  std_logic;
            branch     : in  std_logic;
            alucontrol : in  std_logic_vector(2 downto 0);
            alusrc     : in  std_logic;
            regdst     : in  std_logic;
            regwrite   : in  std_logic;
            -- Interface com a Memoria de Instrucoes
            instr      : in  std_logic_vector(31 downto 0);
            pc         : out std_logic_vector(31 downto 0);
            -- Interface com a Memoria de Dados
            readdata   : in  std_logic_vector(31 downto 0);
            aluout     : out std_logic_vector(31 downto 0);
            writedata  : out std_logic_vector(31 downto 0)
        );
    end component;

    -- 2. Controladora (Main Decoder + ALU Decoder)
    component controladora is
        port(
            op         : in  std_logic_vector(5 downto 0);
            funct      : in  std_logic_vector(5 downto 0);
            memtoreg   : out std_logic;
            memwrite   : out std_logic;
            branch     : out std_logic;
            alucontrol : out std_logic_vector(2 downto 0);
            alusrc     : out std_logic;
            regdst     : out std_logic;
            regwrite   : out std_logic
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

    -- Sinais de controle (Controladora -> Datapath / Data Memory)
    signal s_memtoreg   : std_logic;
    signal s_memwrite   : std_logic;
    signal s_branch     : std_logic;
    signal s_alucontrol : std_logic_vector(2 downto 0);
    signal s_alusrc     : std_logic;
    signal s_regdst     : std_logic;
    signal s_regwrite   : std_logic;

    -- Barramentos entre Datapath e Memorias
    signal s_pc         : std_logic_vector(31 downto 0);
    signal s_instr      : std_logic_vector(31 downto 0);
    signal s_aluout     : std_logic_vector(31 downto 0);
    signal s_writedata  : std_logic_vector(31 downto 0);
    signal s_readdata   : std_logic_vector(31 downto 0);

begin

    -- Instanciacao da Memoria de Instrucoes
    IMEM : instruction_memory
        port map(
            A  => s_pc,
            RD => s_instr
        );

    -- Instanciacao da Memoria de Dados
    DMEM : data_memory
        port map(
            CLK => clk,
            WE  => s_memwrite,
            A   => s_aluout,
            WD  => s_writedata,
            RD  => s_readdata
        );

    -- Instanciacao da Controladora (fatiando Op e Funct direto da instrucao)
    CONTROL : controladora
        port map(
            op         => s_instr(31 downto 26),
            funct      => s_instr(5 downto 0),
            memtoreg   => s_memtoreg,
            memwrite   => s_memwrite,
            branch     => s_branch,
            alucontrol => s_alucontrol,
            alusrc     => s_alusrc,
            regdst     => s_regdst,
            regwrite   => s_regwrite
        );

    -- Instanciacao do Datapath
    DATA : mips_datapath
        port map(
            clk        => clk,
            rst        => rst,
            memtoreg   => s_memtoreg,
            branch     => s_branch,
            alucontrol => s_alucontrol,
            alusrc     => s_alusrc,
            regdst     => s_regdst,
            regwrite   => s_regwrite,
            instr      => s_instr,
            pc         => s_pc,
            readdata   => s_readdata,
            aluout     => s_aluout,
            writedata  => s_writedata
        );

    -- Conexao dos sinais internos as saidas externas do top-level
    pc_out  <= s_pc;
    alu_out <= s_aluout;

end architecture;