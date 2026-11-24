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
    imm_out <= (31 downto 16 => imm_in(15)) & imm_in; -- Preenche os 16 bits mais significativos com o bit de sinal (imm_in(15)) e concatena com os 16 bits menos significativos (imm_in)
end Behavioral;