library ieee;
use ieee.std_logic_1164.all;

entity seven_seg is
    port (
        din : in  std_logic_vector(3 downto 0);
        seg : out std_logic_vector(6 downto 0)
    );
end entity seven_seg;

architecture rtl of seven_seg is
begin
    process (din)
    begin
        case din is
            when "0000" => seg <= "1000000"; -- 0xC0
            when "0001" => seg <= "1111001"; -- 0xF9
            when "0010" => seg <= "0100100"; -- 0xA4
            when "0011" => seg <= "0110000"; -- 0xB0
            when "0100" => seg <= "0011001"; -- 0x99
            when "0101" => seg <= "0010010"; -- 0x92
            when "0110" => seg <= "0000010"; -- 0x82
            when "0111" => seg <= "1111000"; -- 0xF8
            when "1000" => seg <= "0000000"; -- 0x80
            when "1001" => seg <= "0010000"; -- 0x90
            when "1010" => seg <= "0001000"; -- 0x88
            when "1011" => seg <= "0000011"; -- 0x83
            when "1100" => seg <= "1000110"; -- 0xC6
            when "1101" => seg <= "0100001"; -- 0xA1
            when "1110" => seg <= "0000110"; -- 0x86
            when "1111" => seg <= "0001110"; -- 0x8E
            when others => seg <= "1111111"; -- 0xFF - fully clear
        end case;
    end process;
end architecture rtl;