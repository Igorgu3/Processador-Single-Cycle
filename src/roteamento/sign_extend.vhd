library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sign_extend is
    Port (
        imm_in  : in  STD_LOGIC_VECTOR(15 downto 0);
        imm_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
end sign_extend;

architecture Behavioral of sign_extend is
begin
    imm_out <= (31 downto 16 => imm_in(15)) & imm_in;
end Behavioral;