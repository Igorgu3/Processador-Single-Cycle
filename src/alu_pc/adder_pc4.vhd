--------------------------------------------------------------------------------
-- Somador combinacional dedicado que soma a constante 4 ao PC.
-- Em MIPS as instrucoes tem 4 bytes, entao o proximo endereco sequencial
-- e sempre PC + 4. Puramente combinacional (sem clock).
--
-- Ligacoes no datapath:
--   PC       <- saida do pc_register
--   PCPlus4  -> Mux do PC (in0) e adder_branch (entrada a)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_pc4 is
    port (
        PC      : in  std_logic_vector(31 downto 0);  -- endereco atual
        PCPlus4 : out std_logic_vector(31 downto 0)   -- PC + 4
    );
end entity adder_pc4;

architecture rtl of adder_pc4 is
begin
    PCPlus4 <= std_logic_vector(unsigned(PC) + 4);
end architecture rtl;
