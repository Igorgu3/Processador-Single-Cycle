library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2x1_32bits is
    Generic (
        WIDTH : integer := 32
    );
    Port (
        in0 : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        in1 : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        sel : in  STD_LOGIC;
        y   : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
    );
end mux2x1_32bits;

architecture Behavioral of mux2x1_32bits is
begin
    y <= in0 when sel = '0' else in1;
end Behavioral;