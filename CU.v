module CU(instr, reset, clk, status, pcsrc, aluop, immsel, wb, alusrc, regrw, memrw, co);

input [31:0]instr;
input reset;
input clk;
input [3:0]status;

output reg pcsrc;
output reg [3:0]aluop;
output reg [1:0]immsel;
output reg wb;
output reg alusrc;
output reg regrw;
output reg memrw;
output reg co;

always @(instr or reset)
if (reset == 0)
	case (instr[6:0])
	7'b0110011 : begin //R
					pcsrc = 0;
					immsel = 00;
					wb = 1;
					alusrc = 0;
					regrw = 1;
					memrw = 0;
					co = 0;
					aluop = {instr[30],instr[14:12]};
					end
					
	7'b0010011 : begin //I
					pcsrc = 0;
					immsel = 00;
					wb = 1;
					alusrc = 1;
					regrw = 1;
					memrw = 0;
					co = 0;
					aluop = {instr[30],instr[14:12]};
					end
					
	7'b0100011 : begin //S
					pcsrc = 0;
					immsel = 01;
					wb = 0;
					alusrc = 1;
					regrw = 0;
					memrw = 1;
					co = 0;
					aluop = {instr[30],instr[14:12]};
					end
					
	7'b1100011 : begin //B
					case (instr[14:12])
						3'b000 : begin
							pcsrc = status[2]; //beq so Zero flag
							end
						3'b101 : begin
							pcsrc = ~(status[1]); //bge so Negative flag
							end
					endcase
					immsel = 11;
					wb = 0;
					alusrc = 0;
					regrw = 0;
					memrw = 0;
					co = 0;
					aluop = {instr[30],instr[14:12]};
					end
					
	7'b0000011 : begin //lw
					pcsrc = 0;
					immsel = 00;
					wb = 0;
					alusrc = 1;
					regrw = 1;
					memrw = 0;
					co = 0;
					aluop = {instr[30],instr[14:12]};
					end
	endcase
	else
	case (instr[6:0])
	7'b0000000 : begin
					pcsrc = 0;
					immsel = 00;
					wb = 1;
					alusrc = 0;
					regrw = 1;
					memrw = 1;
					co = 0;
					aluop = {instr[30],instr[14:12]};
					end
	endcase
endmodule
