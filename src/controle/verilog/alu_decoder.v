module alu_decoder(
input wire [5:0] funct,
input wire [1:0] ALUop,
output reg [2:0] ALUControl
);

	always @(*) begin		
		casez(ALUop)
			2'b00: begin
				//add
				ALUControl = 3'b010;
			end
			2'b?1: begin
				//sub
				ALUControl = 3'b110;
			end
			2'b1?: begin
				casez(funct)
					6'b100000: begin
						//add
						ALUControl = 3'b010;
					end
					6'b100010: begin
						//sub
						ALUControl = 3'b110;
					end
					6'b100100: begin
						//and
						ALUControl = 3'b000;
					end
					6'b100101: begin
						//or
						ALUControl = 3'b001;
					end
					6'b101010: begin
						//slt
						ALUControl = 3'b111;
					end
					6'b101011: begin
						//mult
						ALUControl = 3'b011;
					end
					
					default: ALUControl = 3'b000;
					
				endcase
			end
		endcase
	end

endmodule
