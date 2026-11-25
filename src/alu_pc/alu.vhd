--------------------------------------------------------------------------------
-- Logica combinacional pura selecionada por ALUControl(2:0)
-- Gera a flag Zero usada pelo branch.
--
-- Tabela de operacoes:
--   000 -> A and B
--   001 -> A or  B
--   010 -> A + B           (add)   [lw/sw, addi, R-add]
--   011 -> A * B           (mult)  [32 bits menos significativos do produto]
--   100 -> A and (not B)
--   101 -> A or  (not B)
--   110 -> A - B           (sub)   [beq, R-sub]
--   111 -> slt             (set less than com sinal: 1 se A < B, senao 0)
--
-- Ligacoes no datapath:
--   SrcA       <- RD1 (register file)
--   SrcB       <- saida do Mux da ULA (RD2 ou SignImm, por ALUSrc)
--   ALUControl <- controle
--   ALUResult  -> Mux da Memoria (in0) e endereco da Data Memory
--   Zero       -> AND com Branch gera o PCSrc
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port (
        SrcA       : in  std_logic_vector(31 downto 0);
        SrcB       : in  std_logic_vector(31 downto 0);
        ALUControl : in  std_logic_vector(2 downto 0);
        ALUResult  : out std_logic_vector(31 downto 0);
        Zero       : out std_logic
    );
end entity alu;

architecture rtl of alu is
    signal res  : std_logic_vector(31 downto 0);
    signal prod : std_logic_vector(63 downto 0);
begin

    -- produto completo com sinal (usamos so os 32 bits menos significativos)
    prod <= std_logic_vector(signed(SrcA) * signed(SrcB));

    process (SrcA, SrcB, ALUControl, prod)
    begin
        case ALUControl is
            when "000" =>                                   -- AND
                res <= SrcA and SrcB;
            when "001" =>                                   -- OR
                res <= SrcA or SrcB;
            when "010" =>                                   -- ADD
                res <= std_logic_vector(signed(SrcA) + signed(SrcB));
            when "011" =>                                   -- MULT
                res <= prod(31 downto 0);
            when "100" =>                                   -- A and (not B)
                res <= SrcA and (not SrcB);
            when "101" =>                                   -- A or (not B)
                res <= SrcA or (not SrcB);
            when "110" =>                                   -- SUB
                res <= std_logic_vector(signed(SrcA) - signed(SrcB));
            when "111" =>                                   -- SLT (com sinal)
                if signed(SrcA) < signed(SrcB) then
                    res <= (0 => '1', others => '0');       -- 0x00000001
                else
                    res <= (others => '0');
                end if;
            when others =>
                res <= (others => '0');
        end case;
    end process;

    ALUResult <= res;

    -- flag Zero: '1' quando o resultado for exatamente zero
    Zero <= '1' when res = x"00000000" else '0';

end architecture rtl;
