library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_register_file is
end entity;

architecture sim of tb_register_file is
    signal clk_tb   : std_logic := '0';
    signal we3_tb   : std_logic := '0';
    signal a1_tb    : std_logic_vector(4 downto 0)  := (others => '0');
    signal a2_tb    : std_logic_vector(4 downto 0)  := (others => '0');
    signal a3_tb    : std_logic_vector(4 downto 0)  := (others => '0');
    signal wd3_tb   : std_logic_vector(31 downto 0) := (others => '0');
    signal rd1_tb   : std_logic_vector(31 downto 0);
    signal rd2_tb   : std_logic_vector(31 downto 0);

    -- Flag para parar o gerador de clock quando os testes terminarem
    signal sim_done : boolean := false;
begin

    -- Instancia o Banco de Registradores
    uut: entity work.register_file
        port map (
            CLK => clk_tb,
            WE3 => we3_tb,
            A1  => a1_tb,
            A2  => a2_tb,
            A3  => a3_tb,
            WD3 => wd3_tb,
            RD1 => rd1_tb,
            RD2 => rd2_tb
        );

    -- Gerador de Clock: período de 10 ns (5 ns em '0', 5 ns em '1')
    clk_proc: process
    begin
        while not sim_done loop
            clk_tb <= '0';
            wait for 5 ns;
            clk_tb <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Processo de testes
    stim_proc: process
    begin
        -- Teste 1: Escrever 0x12345678 no registrador $1
        we3_tb <= '1';
        a3_tb  <= "00001";       -- Registrador $1
        wd3_tb <= x"12345678";
        wait for 10 ns;          -- Passa 1 ciclo de clock (ocorre a escrita)

        -- Lê o registrador $1 em RD1
        we3_tb <= '0';
        a1_tb  <= "00001";
        wait for 2 ns;
        assert rd1_tb = x"12345678"
            report "ERRO no Teste 1: falha ao escrever/ler $1!" severity error;

        -- Teste 2: Escrever 0xAABBCCDD no registrador $2 e ler $1 e $2 simultaneamente
        we3_tb <= '1';
        a3_tb  <= "00010";       -- Registrador $2
        wd3_tb <= x"AABBCCDD";
        wait for 10 ns;

        we3_tb <= '0';
        a1_tb  <= "00001";       -- Lê $1 em RD1
        a2_tb  <= "00010";       -- Lê $2 em RD2
        wait for 2 ns;
        assert rd1_tb = x"12345678" and rd2_tb = x"AABBCCDD"
            report "ERRO no Teste 2: falha na leitura simultanea de $1 e $2!" severity error;

        -- Teste 3: Tentar escrever 0xFFFFFFFF no registrador $0 (deve ser ignorado!)
        we3_tb <= '1';
        a3_tb  <= "00000";       -- Registrador $0
        wd3_tb <= x"FFFFFFFF";
        wait for 10 ns;

        we3_tb <= '0';
        a1_tb  <= "00000";
        wait for 2 ns;
        assert rd1_tb = x"00000000"
            report "ERRO no Teste 3: registrador $0 foi sobrescrito!" severity error;

        -- Teste 4: Tentar escrever em $1 com WE3 = '0' (não deve alterar $1)
        we3_tb <= '0';
        a3_tb  <= "00001";
        wd3_tb <= x"DEADBEEF";
        wait for 10 ns;

        a1_tb  <= "00001";
        wait for 2 ns;
        assert rd1_tb = x"12345678"
            report "ERRO no Teste 4: escreveu em $1 mesmo com WE3 = 0!" severity error;

        report "SUCESSO: Todos os testes do Banco de Registradores passaram!" severity note;
        sim_done <= true; -- Encerra o gerador de clock
        wait;
    end process;

end architecture;