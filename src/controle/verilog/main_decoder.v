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
	Branch = 1'b0;		//permanece 0 até o tipo beq
	ALUControl = 1'b0;
	ALUSrc = 1'b0;
	RegDst = 1'b0;		//destino é rt
	RegWrite = 1'b0;
	
	case(opcode) begin
		// tipo R
		6'b000000: begin
			RegDst = 1'b1;		//destino é rd
			RegWrite = 1'b1;
			ALUOP = 2'b10;
		end
		
		// tipo sw
		6'b101011: begin
			ALUSrc = 1'b1;
			MemWrite = 1'b1;
			ALUOP = 2'b00;
		end
		// tipo lw
		6'b100011: begin
			RegDst = 1'b0;		//destino é rt
			ALUSrc = 1'b1;
			MemtoReg = 1'b1;
			RegWrite = 1'b1;
			ALUOP = 2'b00;
		end
		
		// tipo beq
		6'b000100: begin
			Branch = 1'b1;
			ALUOP = 1'b1;	//subtração
		end
		
		default: begin
			//unknown instructions
		end
	endcase
    end
end

endmodule
