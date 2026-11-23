library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_roteamento is
end tb_roteamento;

architecture Behavioral of tb_roteamento is
    -- Sinais para o MUX
    signal s_in0, s_in1, s_y : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal s_sel             : STD_LOGIC := '0';

    -- Sinais para o Sign Extend
    signal s_imm_in          : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal s_imm_out         : STD_LOGIC_VECTOR(31 downto 0);

    -- Sinais para o Shift Left 2
    signal s_shift_in        : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal s_shift_out       : STD_LOGIC_VECTOR(31 downto 0);
begin

    -- Conectando os 3 componentes
    UUT_MUX: entity work.mux2x1_32bits
        generic map (WIDTH => 32)
        port map (
            in0 => s_in0,
            in1 => s_in1,
            sel => s_sel,
            y   => s_y
        );

    UUT_SIGN_EXT: entity work.sign_extend
        port map (
            imm_in  => s_imm_in,
            imm_out => s_imm_out
        );

    UUT_SHIFT: entity work.shift_left_2
        port map (
            data_in  => s_shift_in,
            data_out => s_shift_out
        );

    -- Injetando valores de teste
    stim_proc: process
    begin
        -- TESTE 1: Mux seleciona in0 | Sign Extend positivo | Shift Left de 3
        s_in0      <= x"0000000A"; -- 10 em hexadecimal
        s_in1      <= x"00000014"; -- 20 em hexadecimal
        s_sel      <= '0';
        s_imm_in   <= x"0005";     -- +5
        s_shift_in <= x"00000003"; -- 3
        wait for 20 ns;

        assert (s_y = x"0000000A") report "ERRO no MUX (sel=0)" severity error;
        assert (s_imm_out = x"00000005") report "ERRO no Sign Extend positivo" severity error;
        assert (s_shift_out = x"0000000C") report "ERRO no Shift Left 2 (3*4=12)" severity error;

        -- TESTE 2: Mux seleciona in1 | Sign Extend negativo | Shift Left de -4
        s_sel      <= '1';
        s_imm_in   <= x"FFFC";     -- -4 em complemento de 2
        s_shift_in <= x"FFFFFFFC"; -- -4 em 32 bits
        wait for 20 ns;

        assert (s_y = x"00000014") report "ERRO no MUX (sel=1)" severity error;
        assert (s_imm_out = x"FFFFFFFC") report "ERRO no Sign Extend negativo" severity error;
        assert (s_shift_out = x"FFFFFFF0") report "ERRO no Shift Left 2 negativo" severity error;

        report "TODOS OS TESTES PASSARAM COM SUCESSO!" severity note;
        wait;
    end process;

end Behavioral;