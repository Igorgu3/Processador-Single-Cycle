module src_top (
	input wire [5:0] Opcode,
	input wire [5:0] funct,
	output wire [1:0] ALUop,
	output wire MemtoReg,
	output wire MemWrite,
	output wire Branch,
	output wire [2:0] ALUControl,
	output wire ALUSrc,
	output wire RegDst,
	output wire RegWrite
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
