library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_data_memory is
end entity;

architecture sim of tb_data_memory is
    signal clk_tb   : std_logic := '0';
    signal we_tb    : std_logic := '0';
    signal a_tb     : std_logic_vector(31 downto 0) := (others => '0');
    signal wd_tb    : std_logic_vector(31 downto 0) := (others => '0');
    signal rd_tb    : std_logic_vector(31 downto 0);

    signal sim_done : boolean := false;
begin

    uut: entity work.data_memory
        port map (
            CLK => clk_tb,
            WE  => we_tb,
            A   => a_tb,
            WD  => wd_tb,
            RD  => rd_tb
        );

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

    stim_proc: process
    begin
        -- Teste 1: Leitura inicial no endereço 0 (deve começar zerado)
        we_tb <= '0';
        a_tb  <= x"00000000";
        wait for 2 ns;
        assert rd_tb = x"00000000"
            report "ERRO no Teste 1: memoria nao comecou zerada!" severity error;

        -- Teste 2: Escrever 0xCAFEBABE no endereço 0 (índice 0 da RAM)
        we_tb <= '1';
        a_tb  <= x"00000000";
        wd_tb <= x"CAFEBABE";
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        assert rd_tb = x"CAFEBABE"
            report "ERRO no Teste 2: falha ao escrever/ler no endereco 0!" severity error;

        -- Teste 3: Escrever 0x12345678 no endereço 4 (índice 1 da RAM)
        we_tb <= '1';
        a_tb  <= x"00000004";
        wd_tb <= x"12345678";
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        assert rd_tb = x"12345678"
            report "ERRO no Teste 3: falha ao escrever/ler no endereco 4!" severity error;

        -- Confere se o endereço 0 manteve o valor anterior
        we_tb <= '0';
        a_tb  <= x"00000000";
        wait for 2 ns;
        assert rd_tb = x"CAFEBABE"
            report "ERRO no Teste 3b: valor do endereco 0 foi perdido!" severity error;

        -- Teste 4: Tentar escrever 0xDEADBEEF no endereço 0 com WE = '0' (deve ignorar)
        we_tb <= '0';
        a_tb  <= x"00000000";
        wd_tb <= x"DEADBEEF";
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        assert rd_tb = x"CAFEBABE"
            report "ERRO no Teste 4: escreveu na memoria mesmo com WE = 0!" severity error;

        -- Teste 5: Sobrescrever o endereço 4 com 0xAAAAAAAA (WE = '1')
        we_tb <= '1';
        a_tb  <= x"00000004";
        wd_tb <= x"AAAAAAAA";
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        assert rd_tb = x"AAAAAAAA"
            report "ERRO no Teste 5: falha ao sobrescrever o endereco 4!" severity error;

        -- Teste 6: Endereço > 252 (256 = 0x00000100) -> testa wrap-around para o índice 0
        we_tb <= '1';
        a_tb  <= x"00000100"; -- Bits (7 downto 2) = "000000" (índice 0)
        wd_tb <= x"55555555";
        wait until rising_edge(clk_tb);
        wait for 1 ns;
        assert rd_tb = x"55555555"
            report "ERRO no Teste 6a: falha ao escrever/ler no endereco 256!" severity error;

        -- Confirma que o endereço 0 também passou a valer 0x55555555 (sobrescrita circular)
        we_tb <= '0';
        a_tb  <= x"00000000";
        wait for 2 ns;
        assert rd_tb = x"55555555"
            report "ERRO no Teste 6b: wrap-around esperado no endereco 0 nao ocorreu!" severity error;

        report "SUCESSO: Todos os testes da Memoria de Dados passaram!" severity note;
        sim_done <= true;
        wait;
    end process;

end architecture;