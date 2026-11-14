module main_decoder(
input wire [5:0] Opcode,
input wire [5:0] funct,

output reg MemtoReg,
output reg MemWrite,
output reg Branch,
output reg [2:0] ALUControl,
output reg ALUSrc,
output reg RegDst,
output reg RegWrite
);


always @(*) begin
	MemtoReg = 1'b0;
	MemWrite = 1'b0;
	Branch = 1'b0;
	ALUControl = 1'b0;
	ALUSrc = 1'b0;
	RegDst = 1'b0;
	RegWrite = 1'b0;
end

