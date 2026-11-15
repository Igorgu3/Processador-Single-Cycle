module src_top (
	input wire [5:0] Opcode,
	input wire [5:0] funct,
	output reg MemtoReg,
	output reg MemWrite,
	output reg Branch,
	output reg [2:0] ALUControl,
	output reg ALUSrc,
	output reg RegDst,
	output reg RegWrite,
	output reg [2:0] ALUControl
);

	control_unit u_control (
		
	);

	alu_decoder u_decoder (
		.funct(funct),
		.ALUCtrl(ALUCtrl)
	);

endmodule
