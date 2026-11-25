--------------------------------------------------------------------------------
-- Somador combinacional que calcula o endereco de destino do branch (beq):
--   PCBranch = PCPlus4 + (SignImm << 2)
-- A entrada SignImmSh ja chega deslocada 2 bits (vinda do Shift Left 2. 
-- Puramente combinacional (sem clock).
-- Ligacoes no datapath:
--   PCPlus4   <- saida do adder_pc4
--   SignImmSh <- saida (data_out) do shift_left_2
--   PCBranch  -> Mux do PC (in1), selecionado quando PCSrc = '1'
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_branch is
    port (
        PCPlus4   : in  std_logic_vector(31 downto 0);  -- PC + 4
        SignImmSh : in  std_logic_vector(31 downto 0);  -- imediato estendido e deslocado (<<2)
        PCBranch  : out std_logic_vector(31 downto 0)   -- endereco de destino do branch
    );
end entity adder_branch;

architecture rtl of adder_branch is
begin
    PCBranch <= std_logic_vector(unsigned(PCPlus4) + unsigned(SignImmSh));
end architecture rtl;
