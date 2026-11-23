----------------------------------------------------------------------------------
-- src_top_board  --  Quartus "Top-level entity" for stand-alone board testing
--
--   SW(5 downto 0)   -> funct        (R-type only)
--   SW(11 downto 6)  -> Opcode
--
--   LEDR(7)          -> RegWrite     LEDR(6) -> RegDst
--   LEDR(5)          -> ALUSrc       LEDR(4) -> MemtoReg
--   LEDR(3)          -> MemWrite     LEDR(2) -> Branch
--   LEDR(1 downto 0) -> ALUop        LEDR(9 downto 8) -> '0'
--
--   HEX0 -> ALUControl   HEX1 -> ALUop
--   HEX2 -> funct low nibble   HEX3 -> funct high nibble
--
-- Needs 12 switches (DE2-115, DE10-Standard style). On a 10-switch board
-- (DE10-Lite) drive the two high Opcode bits from two push buttons instead,
-- or use this wrapper in simulation only.
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
entity src_top_board is
    port (
        SW   : in  std_logic_vector(11 downto 0);
        LEDR : out std_logic_vector(9 downto 0);
        HEX0 : out std_logic_vector(6 downto 0);
        HEX1 : out std_logic_vector(6 downto 0);
        HEX2 : out std_logic_vector(6 downto 0);
        HEX3 : out std_logic_vector(6 downto 0)
    );
end entity src_top_board;
 
architecture structural of src_top_board is
 
    signal Opcode : std_logic_vector(5 downto 0);
    signal funct : std_logic_vector(5 downto 0);
    signal ALUop : std_logic_vector(1 downto 0);
    signal ALUControl : std_logic_vector(2 downto 0);
    signal MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite : std_logic;
 
begin
 
    funct  <= SW(5 downto 0);
    Opcode <= SW(11 downto 6);
 
    u_dut : entity work.src_top
        port map (
            Opcode     => Opcode,
            funct      => funct,
            ALUop      => ALUop,
            MemtoReg   => MemtoReg,
            MemWrite   => MemWrite,
            Branch     => Branch,
            ALUControl => ALUControl,
            ALUSrc     => ALUSrc,
            RegDst     => RegDst,
            RegWrite   => RegWrite
        );
 
    LEDR <= "00" & RegWrite & RegDst & ALUSrc & MemtoReg & MemWrite & Branch & ALUop;
 
    u_hex_ctrl : entity work.seven_seg
        port map (din => '0' & ALUControl, seg => HEX0);
 
    u_hex_aluop : entity work.seven_seg
        port map (din => "00" & ALUop, seg => HEX1);
 
    u_hex_f_lo : entity work.seven_seg
        port map (din => funct(3 downto 0), seg => HEX2);
 
    u_hex_f_hi : entity work.seven_seg
        port map (din => "00" & funct(5 downto 4), seg => HEX3);
 
end architecture structural;
