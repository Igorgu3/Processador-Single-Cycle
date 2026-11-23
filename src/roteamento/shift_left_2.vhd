library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_left_2 is
    Port (
        data_in  : in  STD_LOGIC_VECTOR(31 downto 0);
        data_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
end shift_left_2;

architecture Behavioral of shift_left_2 is
begin
    data_out <= data_in(29 downto 0) & "00";
end Behavioral;