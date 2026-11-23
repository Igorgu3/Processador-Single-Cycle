library ieee;
use ieee.std_logic_1164.all;

entity src_top is
    port (
        Opcode     : in  std_logic_vector(5 downto 0);
        funct      : in  std_logic_vector(5 downto 0);
        ALUop      : out std_logic_vector(1 downto 0);
        MemtoReg   : out std_logic;
        MemWrite   : out std_logic;
        Branch     : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0);
        ALUSrc     : out std_logic;
        RegDst     : out std_logic;
        RegWrite   : out std_logic
    );
end entity src_top;

architecture structural of src_top is
    signal aluop_int : std_logic_vector(1 downto 0);
begin

    u_control : entity work.main_decoder
        port map (
            Opcode   => Opcode,
            ALUop    => aluop_int,
            MemtoReg => MemtoReg,
            MemWrite => MemWrite,
            Branch   => Branch,
            ALUSrc   => ALUSrc,
            RegDst   => RegDst,
            RegWrite => RegWrite
        );

    u_decoder : entity work.alu_decoder
        port map (
            funct      => funct,
            ALUop      => aluop_int,
            ALUControl => ALUControl
        );

    ALUop <= aluop_int;

end architecture structural;