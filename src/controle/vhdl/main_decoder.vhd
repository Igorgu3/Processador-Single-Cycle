library ieee;
use ieee.std_logic_1164.all;
 
entity main_decoder is
    port (
        Opcode   : in  std_logic_vector(5 downto 0);
        ALUop    : out std_logic_vector(1 downto 0);
        MemtoReg : out std_logic;
        MemWrite : out std_logic;
        Branch   : out std_logic;
        ALUSrc   : out std_logic;
        RegDst   : out std_logic;
        RegWrite : out std_logic
    );
end entity main_decoder;
 
architecture rtl of main_decoder is
 
    -- Internal signals (registers of the Verilog "always @(*)" block)
    signal aluop_i    : std_logic_vector(1 downto 0);
    signal memtoreg_i : std_logic;
    signal memwrite_i : std_logic;
    signal branch_i   : std_logic;
    signal alusrc_i   : std_logic;
    signal regdst_i   : std_logic;
    signal regwrite_i : std_logic;
 
begin
 
    ----------------------------------------------------------------------------
    -- Combinational decode process (sensitivity list = all inputs)
    ----------------------------------------------------------------------------
    decode_proc : process (Opcode)
    begin
        -- Default values: every control signal is de-asserted
        memtoreg_i <= '0';          -- indicates whether the register file is written from memory
        memwrite_i <= '0';          -- memory write flag
        branch_i   <= '0';          -- stays '0' until a beq-type instruction
        alusrc_i   <= '0';          -- '0' -> ALU gets RD2, '1' -> ALU gets SignImm
        regdst_i   <= '0';          -- destination is rt
        regwrite_i <= '0';          -- register file write flag
        aluop_i    <= "00";
 
        case Opcode is
            -- R type
            when "000000" =>
                regdst_i   <= '1';  -- destination is rd
                regwrite_i <= '1';
                alusrc_i   <= '0';
                aluop_i    <= "10";
 
            -- sw type
            when "101011" =>
                alusrc_i   <= '1';
                memwrite_i <= '1';
 
            -- lw type
            when "100011" =>
                regdst_i   <= '0';  -- destination is rt
                alusrc_i   <= '1';
                memtoreg_i <= '1';
                regwrite_i <= '1';
 
            -- beq type
            when "000100" =>
                branch_i <= '1';
                alusrc_i <= '0';
                aluop_i  <= "01";
 
            -- immediate type (addi)
            when "001000" =>
                regwrite_i <= '1';
                alusrc_i   <= '1';
 
            -- jump type
            when "000010" =>
                regwrite_i <= '0';
                memwrite_i <= '0';
 
            -- unknown instructions: keep the default values
            when others =>
                null;
        end case;
    end process decode_proc;
 
    ----------------------------------------------------------------------------
    -- Continuous assignments to the output ports
    ----------------------------------------------------------------------------
    ALUop    <= aluop_i;
    MemtoReg <= memtoreg_i;
    MemWrite <= memwrite_i;
    Branch   <= branch_i;
    ALUSrc   <= alusrc_i;
    RegDst   <= regdst_i;
    RegWrite <= regwrite_i;
 
end architecture rtl;
