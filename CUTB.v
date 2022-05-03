module CUTB();

reg [31:0]instr;
reg reset;
reg clk;
reg [3:0]status;

wire co;
wire pcsrc;
wire [3:0]aluop;
wire [1:0]immsel;
wire wb;
wire alusrc;
wire regrw;
wire memrw;

CU dut(.clk(clk), .reset(reset), .instr(instr), .status(status), .pcsrc(pcsrc), .aluop(aluop), .immsel(immsel), .wb(wb), .alusrc(alusrc), .regrw(regrw), .memrw(memrw), .co(co));

always begin


#5 clk= ~clk;

end

initial begin
clk = 0;
reset = 1;
#10 reset = 0;
status = 4'b0000;
#10 instr = 32'b00000000010000000000000010010011; //I
#10 instr = 32'b00000000001000001000000110110011; //R
#10 instr = 32'b00000000000100000000000000100011; //S
#10 instr = 32'b01000000001000010000010001100011; //B

end

endmodule
