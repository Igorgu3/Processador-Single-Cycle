--------------------------------------------------------------------------------
-- Usa asserts: se algum resultado estiver
-- errado, o simulador imprime FAILURE na transcript. No fim imprime
-- "== TB Parte 2 OK ==" e encerra com 'stop'.
--
-- Como rodar no ModelSim:
--   vlib work
--   vcom pc_register.vhd adder_pc4.vhd adder_branch.vhd alu.vhd tb_alu_pc.vhd
--   vsim work.tb_alu_pc
--   run -all
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu_pc is
end entity tb_alu_pc;

architecture sim of tb_alu_pc is

    -- PC
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '1';
    signal pc_next : std_logic_vector(31 downto 0) := (others => '0');
    signal pc      : std_logic_vector(31 downto 0);

    -- somadores
    signal pc_plus4   : std_logic_vector(31 downto 0);
    signal signimm_sh : std_logic_vector(31 downto 0) := (others => '0');
    signal pc_branch  : std_logic_vector(31 downto 0);

    -- ALU
    signal srcA, srcB  : std_logic_vector(31 downto 0) := (others => '0');
    signal alu_ctrl    : std_logic_vector(2 downto 0)  := (others => '0');
    signal alu_result  : std_logic_vector(31 downto 0);
    signal zero        : std_logic;

    constant TCLK : time := 10 ns;

    -- helper: int -> slv(32)
    function i2v(n : integer) return std_logic_vector is
    begin
        return std_logic_vector(to_signed(n, 32));
    end function;

begin

    ----------------------------------------------------------------------------
    -- DUTs
    ----------------------------------------------------------------------------
    u_pc : entity work.pc_register
        port map (CLK => clk, reset => reset, PC_next => pc_next, PC => pc);

    u_add4 : entity work.adder_pc4
        port map (PC => pc, PCPlus4 => pc_plus4);

    u_addb : entity work.adder_branch
        port map (PCPlus4 => pc_plus4, SignImmSh => signimm_sh, PCBranch => pc_branch);

    u_alu : entity work.alu
        port map (SrcA => srcA, SrcB => srcB, ALUControl => alu_ctrl,
                  ALUResult => alu_result, Zero => zero);

    -- clock
    clk <= not clk after TCLK/2;

    ----------------------------------------------------------------------------
    -- Estimulos
    ----------------------------------------------------------------------------
    stim : process
    begin
        ----------------------------------------------------------------------
        -- 1) PC: reset zera; depois conta PC+4 a cada ciclo
        ----------------------------------------------------------------------
        reset <= '1';
        wait for TCLK;
        assert pc = x"00000000" report "PC nao zerou no reset" severity failure;

        reset <= '0';
        -- liga PC_next na saida do somador +4 (encadeia o contador)
        for i in 0 to 3 loop
            pc_next <= pc_plus4;            -- proximo = PC + 4
            wait until rising_edge(clk);
            wait for 1 ns;                  -- deixa os combinacionais estabilizarem
        end loop;
        assert pc = x"00000010" report "PC+4 nao contou ate 0x10" severity failure;

        -- checa somadores com valores diretos
        pc_next <= x"00000020"; wait until rising_edge(clk); wait for 1 ns;
        assert pc_plus4 = x"00000024" report "adder_pc4 errado" severity failure;
        signimm_sh <= i2v(16);             -- offset 4 instrucoes << 2 = 16
        wait for 1 ns;
        assert pc_branch = x"00000034" report "adder_branch errado" severity failure;

        ----------------------------------------------------------------------
        -- 2) ALU: uma checagem por operacao
        ----------------------------------------------------------------------
        srcA <= x"0000000C"; srcB <= x"0000000A";   -- 12 e 10

        alu_ctrl <= "000"; wait for 1 ns;           -- AND
        assert alu_result = x"00000008" report "AND errado" severity failure;

        alu_ctrl <= "001"; wait for 1 ns;           -- OR
        assert alu_result = x"0000000E" report "OR errado" severity failure;

        alu_ctrl <= "010"; wait for 1 ns;           -- ADD
        assert alu_result = x"00000016" report "ADD errado" severity failure; -- 22

        alu_ctrl <= "011"; wait for 1 ns;           -- MULT
        assert alu_result = x"00000078" report "MULT errado" severity failure; -- 120

        alu_ctrl <= "100"; wait for 1 ns;           -- A and (not B): 0x0C and 0xF5 = 0x04
        assert alu_result = x"00000004" report "AND-not errado" severity failure;

        alu_ctrl <= "101"; wait for 1 ns;           -- A or (not B): 0x0C or 0xFFFFFFF5 = 0xFFFFFFFD
        assert alu_result = x"FFFFFFFD" report "OR-not errado" severity failure;

        alu_ctrl <= "110"; wait for 1 ns;           -- SUB: 12 - 10 = 2
        assert alu_result = x"00000002" report "SUB errado" severity failure;
        assert zero = '0' report "Zero deveria ser 0" severity failure;

        alu_ctrl <= "111"; wait for 1 ns;           -- SLT: 12 < 10 ? nao -> 0
        assert alu_result = x"00000000" report "SLT (>) errado" severity failure;
        assert zero = '1' report "Zero deveria ser 1" severity failure;

        -- SLT com sinal: -5 < 3 ? sim -> 1
        srcA <= i2v(-5); srcB <= i2v(3); alu_ctrl <= "111"; wait for 1 ns;
        assert alu_result = x"00000001" report "SLT com sinal errado" severity failure;

        -- SUB resultando zero -> flag Zero = 1
        srcA <= x"00000007"; srcB <= x"00000007"; alu_ctrl <= "110"; wait for 1 ns;
        assert zero = '1' report "Zero no SUB igual deveria ser 1" severity failure;

        report "== TB Parte 2 OK ==" severity note;
        wait;
    end process;

end architecture sim;
