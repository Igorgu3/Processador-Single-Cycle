library ieee;
use ieee.std_logic_1164.all;

entity hex_to_7seg is
    port(
        hex : in  std_logic_vector(3 downto 0);
        seg : out std_logic_vector(6 downto 0)  -- (g f e d c b a) ativo em 0
    );
end entity;

architecture rtl of hex_to_7seg is
begin
    with hex select
        seg <= "1000000" when x"0", -- 0
               "1111001" when x"1", -- 1
               "0100100" when x"2", -- 2
               "0110000" when x"3", -- 3
               "0011001" when x"4", -- 4
               "0010010" when x"5", -- 5
               "0000010" when x"6", -- 6
               "1111000" when x"7", -- 7
               "0000000" when x"8", -- 8
               "0010000" when x"9", -- 9
               "0001000" when x"A", -- A
               "0000011" when x"B", -- b
               "1000110" when x"C", -- C
               "0100001" when x"D", -- d
               "0000110" when x"E", -- E
               "0001110" when x"F", -- F
               "1111111" when others;
end architecture;