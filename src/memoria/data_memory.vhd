library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
    port (
        CLK : in  std_logic;                     -- Clock do sistema
        WE  : in  std_logic;                     -- Write Enable (recebe MemWrite da Controladora)
        A   : in  std_logic_vector(31 downto 0); -- Endereço vindo do ALUResult
        WD  : in  std_logic_vector(31 downto 0); -- Dado a ser escrito (vem do RD2 do Banco)
        RD  : out std_logic_vector(31 downto 0)  -- Dado lido da memória (vai para o Mux MemtoReg)
    );
end entity;

architecture rtl of data_memory is
    -- Tabela de 64 palavras de 32 bits (ajuste se precisar de mais espaço)
    type ram_type is array (0 to 63) of std_logic_vector(31 downto 0);

    -- Utiliza-se SIGNAL para permitir escrita síncrona na memória (processo com clock) e leitura assíncrona (combinacional)
    signal ram : ram_type := (others => (others => '0'));
begin

    -- Escrita síncrona na borda de subida do clock
    process(CLK)
    begin
        if rising_edge(CLK) then
            if WE = '1' then
                ram(to_integer(unsigned(A(7 downto 2)))) <= WD;
            end if;
        end if;
    end process;

    -- Leitura assíncrona (combinacional)
    RD <= ram(to_integer(unsigned(A(7 downto 2))));

end architecture;