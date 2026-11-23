module src_top (
	input wire [5:0] Opcode,
	input wire [5:0] funct,
	output reg [1:0] ALUop,
	output reg MemtoReg,
	output reg MemWrite,
	output reg Branch,
	output reg [2:0] ALUControl,
	output reg ALUSrc,
	output reg RegDst,
	output reg RegWrite
);

	main_decoder u_control (
		.Opcode(Opcode),
		.ALUop(ALUop),
		.MemtoReg(MemtoReg),
		.MemWrite(MemWrite),
		.Branch(Branch),
		.ALUSrc(ALUSrc),
		.RegDst(RegDst),
		.RegWrite(RegWrite)
	);

	alu_decoder u_decoder (
		.funct(funct),
		.ALUop(ALUop),
		.ALUControl(ALUControl)
	);

endmodule
