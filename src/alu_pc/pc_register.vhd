--------------------------------------------------------------------------------
-- Registrador de 32 bits que guarda o endereco da instrucao atual.
-- Atualiza seu valor na borda de SUBIDA do clock (PC <= PC_next).
-- Reset assincrono ativo em '1' zera o PC (endereco inicial do programa).
--
-- Ligacoes no datapath:
--   PC_next  <- saida y do Mux do PC (PCPlus4 / PCBranch, selecionado por PCSrc)
--   PC       -> endereco (A) da Instruction Memory e entrada do adder_pc4
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity pc_register is
    port (
        CLK     : in  std_logic;                      -- clock do sistema
        reset   : in  std_logic;                      -- reset assincrono (ativo em '1')
        PC_next : in  std_logic_vector(31 downto 0);  -- proximo endereco (PC')
        PC      : out std_logic_vector(31 downto 0)   -- endereco atual
    );
end entity pc_register;

architecture rtl of pc_register is
begin
    process (CLK, reset)
    begin
        if reset = '1' then
            PC <= (others => '0');      -- zera o PC ao resetar
        elsif rising_edge(CLK) then
            PC <= PC_next;              -- captura o proximo endereco
        end if;
    end process;
end architecture rtl;
