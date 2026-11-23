----------------------------------------------------------------------------------
-- alu_decoder
--
-- VHDL translation of the Verilog module:
--
--   module alu_decoder(
--     input wire [5:0] funct,
--     input wire [1:0] ALUop,
--     output reg [2:0] ALUControl
--   );
--
-- The Verilog "casez" wildcard items (2'b?1 and 2'b1?) are translated with the
-- VHDL-2008 wildcard "case?" statement, where '-' denotes a "don't care" bit,
-- and where - exactly as in Verilog casez - the first matching alternative wins.
----------------------------------------------------------------------------------
 
library ieee;
use ieee.std_logic_1164.all;
 
entity alu_decoder is
    port (
        funct      : in  std_logic_vector(5 downto 0);
        ALUop      : in  std_logic_vector(1 downto 0);
        ALUControl : out std_logic_vector(2 downto 0)
    );
end entity alu_decoder;
 
architecture rtl of alu_decoder is
begin
 
    process (funct, ALUop) is
begin
    case ALUop is

        when "00" =>
            -- lw / sw: add
            ALUControl <= "010";

        when "01" =>
            -- beq: sub
            ALUControl <= "110";

        when "10" =>
            -- R-type: decodifica funct
            case funct is
                when "100000" =>   -- add
                    ALUControl <= "010";
                when "100010" =>   -- sub
                    ALUControl <= "110";
                when "100100" =>   -- and
                    ALUControl <= "000";
                when "100101" =>   -- or
                    ALUControl <= "001";
                when "101010" =>   -- slt
                    ALUControl <= "111";
                when "101011" =>   -- mult
                    ALUControl <= "011";
                when others =>
                    ALUControl <= "000";
            end case;

        when others =>
            -- ALUop = "11" (não usado)
            ALUControl <= "000";

    end case;
end process;
 
end architecture rtl;
