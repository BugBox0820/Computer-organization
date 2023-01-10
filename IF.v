`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/05 20:09:08
// Design Name: 
// Module Name: IF
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


module IF(clk, reset, pc,nextpc, instruction_IF, instruction_ID, branch, jump);

input clk,reset;
input [31:0] pc;

input branch;
input jump;

output reg [31:0] nextpc;
output reg [31:0] instruction_IF, instruction_ID;

wire [31:0] branchaddress;
wire [31:0] jumpaddress;

assign branchaddress = {14'd0,instruction_ID[15:0],2'd0}+32'd4+nextpc;
assign jumpaddress={4'd0,instruction_IF[25:0],2'd0};

always@(posedge clk or negedge reset)
begin
    if(!reset) 
    begin
	   nextpc[31:0]<=pc[31:0];
	end
	else
	begin 
	   if(jump)//jump
	       nextpc[31:0]<=jumpaddress; 
	   else if(branch)
		   nextpc[31:0]<=branchaddress; 
	   else
	       nextpc[31:0]<=nextpc[31:0]+32'd4;// calculate PC + 4		
	end 
end

always @(nextpc)
begin
    case(nextpc)
    32'd0: instruction_IF=32'd0;
    32'd4: instruction_IF=32'b00100010000010010000000110010000;//addi $t1, $s0, 400
    32'd8: instruction_IF=32'b10001101001100010000000000000000;//LOOP: lw $s1, 0($t1)
    32'd12: instruction_IF=32'b00000010010100101000100000100000;//add $s2, $s2, $s1
    32'd16: instruction_IF=32'b00100001001010011111111111111100;//addi $t1, $t1, -4
    32'd16: instruction_IF=32'b00010110000010011111111111111100;//bne $t1, $s0, LOOP
    endcase
end

always @(posedge clk or negedge reset)
begin
    if(!reset)
        instruction_ID<=32'd0;
    else
        instruction_ID<=instruction_IF;
end

endmodule
