`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/10 19:40:18
// Design Name: 
// Module Name: CPU_3_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU_tb();

// Inputs
	reg [31:0] pc;
	reg clk;

	reg rst;

	// Outputs
	wire [31:0] t0_out;
	wire [31:0] t1_out;
	wire [31:0] t2_out;
	wire [31:0] t3_out;
	wire [31:0] t4_out;
	wire [31:0] t5_out;
	wire [31:0] s5_out;
	wire [31:0] s4_out;
	wire [31:0] s3_out;
	wire [31:0] s2_out;
	wire [31:0] s1_out;
	wire [31:0] s0_out;
	wire [31:0]memory3_out, nextpc_out, data_out1, data_out2;

CPU M1(clk, rst, pc, t0_out, t1_out, t2_out, t3_out, t4_out, t5_out, s0_out, s1_out, s2_out, s3_out, s4_out, s5_out, memory3_out, nextpc_out, data_out1, data_out2);

initial begin
		pc = 0;
		rst = 1;

		#20 rst=0;
		#10 rst=1;
	end

initial
begin
clk = 1'b0;
forever
#50 clk = ~clk;
end

endmodule
