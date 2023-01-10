`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/05 20:06:42
// Design Name: 
// Module Name: CPU_3
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


module CPU(clk, rst,pc , t0_out, t1_out, t2_out, t3_out, t4_out, t5_out, s0_out, s1_out, s2_out, s3_out, s4_out, s5_out, memory3_out, nextpc_out);

input clk, rst;
input [31:0]pc; 
output reg [31:0] t0_out, t1_out, t2_out, t3_out, t4_out, t5_out, s0_out, s1_out, s2_out, s3_out, s4_out, s5_out, memory3_out, nextpc_out;//unneeded output

wire [31:0] instruction, IF_instruction, ID_instruction, EXE_instruction, MEM_instruction, WB_instruction;
wire [31:0] t0, t1, t2, t3, t4, t5, s0, s1, s2, s3, s4, s5;
wire [31:0] Readdata1, Readdata2, sign_extend;
wire [31:0] Alu_result;
wire [31:0] Write_data_mem;
wire [31:0] Readdata;
wire branch, jump;
wire [31:0] memory3;
wire [31:0] next_pc;

always @(*)begin //observe
    t0_out = t0;
    t1_out = t1;
    t2_out = t2;
    t3_out = t3;
    t4_out = t4;
    t5_out = t5;
    
    s0_out = s0;
    s1_out = s1;
    s2_out = s2;
    s3_out = s3;
    s4_out = s4;
    s5_out = s5;
    memory3_out = memory3;
    nextpc_out = next_pc;
end

IF u1(.clk(clk), .reset(rst), 
      .pc(pc), .nextpc(next_pc), 
      .Instruction_IF(instruction), //unneeded output
      .Instruction_ID(IF_instruction), 
      .branch (branch), 
      .jump (jump));



ID u2(.IF_instruction(IF_instruction), 
    .clk(clk), .rst(rst), 
    .t0(t0), .t1(t1), .t2(t2), .t3(t3), .t4(t4), .t5(t5), 
    .s0(so), .s1(s1), .s2(s2), .s3(s3), .s4(s4), .s5(s5), 
    .ID_instruction(ID_instruction), 
    .Readdata1(Readdata1), .Readdata2(Readdata2), 
    .sign_extend(sign_extend), 
    .jump(jump));



EXE u3(.clk(clk), .reset(rst), 
    .Read_data1(Readdata1), .Read_data2(Readdata2), 
    .Instruction_EXE(ID_instruction), 
    .Alu_result(Alu_result), 
    .Instruction_MEM(EXE_instruction), 
    .Write_data_mem(Write_data_mem), 
    .Sign_extend(sign_extend), 
    .branch(branch));

MEM u4(.clk(clk), .reset(rst), 
    .Read_data_mem(Readdata), 
    .Instruction_MEM(EXE_instruction), 
    .Alu_result(Alu_result), 
    .Write_data_mem(Write_data_mem), 
    .Instruction_WB(MEM_instruction), 
    .memory3(memory3));

WB u5(.clk(clk), .rst(rst), 
   .MEM_instruction(MEM_instruction), 
   .Readdata(Readdata), 
   .t0(t0), .t1(t1), .t2(t2), .t3(t3), .t4(t4), .t5(t5), 
   .s0(s0), .s1(s1), .s2(s2), .s3(s3), .s4(s4), .s5(s5));

endmodule
