library ieee;
use ieee.std_logic_1164.all;

entity fpga_top is
    port(
        MAX10_CLK1_50 : in  std_logic;
        KEY           : in  std_logic_vector(1 downto 0); -- KEY(0) = Reset
        SW            : in  std_logic_vector(9 downto 0); -- SW(0)  = 0: 1Hz | 1: 50MHz
        LEDR          : out std_logic_vector(9 downto 0);
        HEX0          : out std_logic_vector(6 downto 0);
        HEX1          : out std_logic_vector(6 downto 0);
        HEX2          : out std_logic_vector(6 downto 0);
        HEX3          : out std_logic_vector(6 downto 0);
        HEX4          : out std_logic_vector(6 downto 0);
        HEX5          : out std_logic_vector(6 downto 0)
    );
end entity;

architecture structural of fpga_top is

    component processador is
        port(
            clk            : in  std_logic;
            rst            : in  std_logic;
            pc_out         : out std_logic_vector(31 downto 0);
            alu_out        : out std_logic_vector(31 downto 0);
            writedata_out  : out std_logic_vector(31 downto 0);
            regwrite_out   : out std_logic;
            regdst_out     : out std_logic;
            alusrc_out     : out std_logic;
            branch_out     : out std_logic;
            memwrite_out   : out std_logic;
            memtoreg_out   : out std_logic;
            alucontrol_out : out std_logic_vector(2 downto 0)
        );
    end component;

    component hex_to_7seg is
        port(
            hex : in  std_logic_vector(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
        );
    end component;

    -- 24.999.999 = 1 Hz (troque para 12_499_999 se preferir 2 Hz)
    constant MAX_COUNT : integer := 24999999;
    signal cnt         : integer range 0 to MAX_COUNT := 0;
    signal clk_lento   : std_logic := '0';
    signal clk_proc    : std_logic;
    signal s_rst       : std_logic;

    -- Sinais vindos do processador
    signal s_pc         : std_logic_vector(31 downto 0);
    signal s_alu        : std_logic_vector(31 downto 0);
    signal s_writedata  : std_logic_vector(31 downto 0);
    signal s_regwrite   : std_logic;
    signal s_regdst     : std_logic;
    signal s_alusrc     : std_logic;
    signal s_branch     : std_logic;
    signal s_memwrite   : std_logic;
    signal s_memtoreg   : std_logic;
    signal s_alucontrol : std_logic_vector(2 downto 0);

    -- Registrador auxiliar para manter o ultimo valor de $t2 estavel nos displays
    signal s_t2_display : std_logic_vector(15 downto 0) := (others => '0');

begin

    -- KEY(0) da DE10-Lite e ativo em 0 (pressionado = '0')
    s_rst <= not KEY(0);

    -- 1. Divisor de clock (50 MHz -> 1 Hz)
    process(MAX10_CLK1_50)
    begin
        if rising_edge(MAX10_CLK1_50) then
            if cnt = MAX_COUNT then
                cnt       <= 0;
                clk_lento <= not clk_lento;
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;

    -- Seleciona entre modo lento (SW0 = 0) e 50 MHz (SW0 = 1)
    clk_proc <= MAX10_CLK1_50 when SW(0) = '1' else clk_lento;

    -- 2. Instanciacao do Processador MIPS
    MIPS : processador
        port map(
            clk            => clk_proc,
            rst            => s_rst,
            pc_out         => s_pc,
            alu_out        => s_alu,
            writedata_out  => s_writedata,
            regwrite_out   => s_regwrite,
            regdst_out     => s_regdst,
            alusrc_out     => s_alusrc,
            branch_out     => s_branch,
            memwrite_out   => s_memwrite,
            memtoreg_out   => s_memtoreg,
            alucontrol_out => s_alucontrol
        );

    -- 3. Captura o valor de $t2 toda vez que o programa executa SW na RAM
    process(clk_proc, s_rst)
    begin
        if s_rst = '1' then
            s_t2_display <= (others => '0');
        elsif rising_edge(clk_proc) then
            if s_memwrite = '1' then
                s_t2_display <= s_writedata(15 downto 0);
            end if;
        end if;
    end process;

    -- 4. Mapeamento dos 10 LEDs da DE10-Lite
    LEDR(0)          <= s_regwrite;
    LEDR(1)          <= s_regdst;
    LEDR(2)          <= s_alusrc;
    LEDR(3)          <= s_branch;
    LEDR(4)          <= s_memwrite;
    LEDR(5)          <= s_memtoreg;
    LEDR(8 downto 6) <= s_alucontrol;
    LEDR(9)          <= '1' when s_pc = x"0000003C" else '0'; -- Fim do programa

    -- 5. Displays de 7 segmentos: [HEX5 HEX4] = PC | [HEX3 HEX2 HEX1 HEX0] = $t2
    D5 : hex_to_7seg port map(hex => s_pc(7 downto 4),          seg => HEX5);
    D4 : hex_to_7seg port map(hex => s_pc(3 downto 0),          seg => HEX4);
    D3 : hex_to_7seg port map(hex => s_t2_display(15 downto 12), seg => HEX3);
    D2 : hex_to_7seg port map(hex => s_t2_display(11 downto 8),  seg => HEX2);
    D1 : hex_to_7seg port map(hex => s_t2_display(7 downto 4),   seg => HEX1);
    D0 : hex_to_7seg port map(hex => s_t2_display(3 downto 0),   seg => HEX0);

end architecture;