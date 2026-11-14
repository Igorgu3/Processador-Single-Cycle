module alu_decoder(
input reg [5:0] funct,
input reg [1:0] ALUop,
output reg [2:0] ALUControl
);

	always @(*) begin		
		casez(ALUop) begin
			2'b00: begin
				ALUControl = 3'b010;
			end
			2'b?1: begin
				ALUControl = 3'b110;
			end
			2'b1?: begin
				casez(funct) begin
					6'b100000: begin
						ALUControl = 3'b010;
					end
					6'b100010: begin
						ALUControl = 3'b110;
					end
					6'b100100: begin
						ALUControl = 3'b000;
					end
					6'b100101: begin
						ALUControl = 3'b001;
					end
					6'b101010: begin
						ALUControl = 3'b111;
					end
					6'b101011: begin
						ALUControl = 3'b011;
					end
				endcase
			end
		endcase
	end

endmodule
