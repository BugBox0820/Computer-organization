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


module IF(clk, reset, pc, nextpc, Instruction_IF, Instruction_ID, branch, jump);

input clk,reset;
input [31:0] pc;

input branch;
input jump;

output reg [31:0] nextpc;
output reg [31:0] Instruction_IF, Instruction_ID;

wire [31:0] branchaddress;
wire [31:0] jumpaddress;

assign branchaddress={14'd0,Instruction_ID[15:0],2'd0}+32'd4+nextpc;
assign jumpaddress={4'd0,Instruction_IF[25:0],2'd0};

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
    32'd0: Instruction_IF=32'd0;
    32'd4: Instruction_IF=32'b001000_10000_01001_0000000110010000;//addi $t1, $s0, 400
    32'd8: Instruction_IF=32'd0;//nop
    32'd12: Instruction_IF=32'd0;//nop
    32'd16: Instruction_IF=32'b10001101001100010000000000000000;//LOOP: lw $s1, 0($t1)
    32'd20: Instruction_IF=32'd0;//nop
    32'd24: Instruction_IF=32'd0;//nop
    32'd28: Instruction_IF=32'b00000010010100101000100000100000;//add $s2, $s2, $s1
    32'd32: Instruction_IF=32'b00100001001010011111111111111100;//addi $t1, $t1, -4
    32'd36: Instruction_IF=32'd0;//nop
    32'd40: Instruction_IF=32'd0;//nop
    32'd44: Instruction_IF=32'b00010110000010011111111111111100;//bne $t1, $s0, LOOP
    default: Instruction_IF=32'd0;
    endcase
end

always @(posedge clk or negedge reset)
begin
    if(!reset)
        Instruction_ID<=32'd0;
    else
        Instruction_ID<=Instruction_IF;
end

endmodule
