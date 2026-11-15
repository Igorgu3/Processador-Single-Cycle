module main_decoder(
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


always @(*) begin
	MemtoReg = 1'b0;	//Indica se escreve no registrador
	MemWrite = 1'b0;	//flag de escrita na memória
	Branch = 1'b0;		//permanece 0 até o tipo beq
	ALUControl = 1'b0;
	ALUSrc = 1'b0;		//indica se ALU recebe RD2 ou SignImm
	RegDst = 1'b0;		//destino é rt
	RegWrite = 1'b0;	//flag de escrita no registrador
	ALUop = 2'b00;
	
	case(opcode)
		// tipo R
		6'b000000: begin
			RegDst = 1'b1;		//destino é rd
			RegWrite = 1'b1;
			ALUSrc = 1'b0;
			ALUop = 2'b10;
		end
		
		// tipo sw
		6'b101011: begin
			ALUSrc = 1'b1;
			MemWrite = 1'b1;
		end
		// tipo lw
		6'b100011: begin
			RegDst = 1'b0;		//destino é rt
			ALUSrc = 1'b1;
			MemtoReg = 1'b1;
			RegWrite = 1'b1;
		end
		
		// tipo beq
		6'b000100: begin
			Branch = 1'b1;
			ALUSrc = 1'b0;
			ALUop = 2'b01;
		end
		
		//tipo immediate
		6'b001000: begin
			RegWrite = 1'b1;
			ALUSrc = 1'b1;
		end
		
		//tipo jump
		6'b000010: begin
			RegWrite = 1'b0;
			MemWrite = 1'b0;
		end
		
		default: begin
			//unknown instructions
		end
	endcase
end

endmodule
