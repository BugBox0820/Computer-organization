`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/06 19:54:34
// Design Name: 
// Module Name: EXE
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


module EXE(clk, reset, Read_data1, Read_data2, Instruction_EXE, Alu_result, Instruction_MEM, Write_data_mem, Sign_extend, branch);

input clk,reset;
input signed [31:0] Read_data1,Read_data2;
input [31:0] Instruction_EXE;
input [31:0] Sign_extend;

output reg branch;
output reg [31:0] Instruction_MEM;
output reg signed [31:0] Alu_result;
output reg signed [31:0] Write_data_mem;

reg signed [31:0] Alu_input1, Alu_input2;

always @(*)
begin
    if(!reset)
    begin
        Alu_input1<=32'd0;
        Alu_input2<=32'd0;
    end
    else
    begin
        Alu_input1<=Read_data1;
        if((Instruction_EXE[31:26]==6'd43)||(Instruction_EXE[31:26]==6'd35)||(Instruction_EXE[31:26]==6'd8))//sw lw addi
            Alu_input2<=Sign_extend;
        else
            Alu_input2<=Read_data2;
    end   
end

always @(posedge clk or negedge reset)
begin
    if(!reset)
    begin
        Write_data_mem<=32'd0;
	    Instruction_MEM<=32'd0;
	    Alu_result<=32'b0;
	    branch<=0;
    end
    else
    begin
        Write_data_mem<=Read_data2;
        Instruction_MEM<=Instruction_EXE;
        if(Instruction_EXE==32'd0)
        begin
            Alu_result<=Alu_result;
			branch<=0;
        end
        else if((Instruction_EXE[31:26]==6'd0)//rtype
              &&(Instruction_EXE[5:0]==6'b100000)//add
              ||(Instruction_EXE[31:26]==6'd43)//sw
              ||(Instruction_EXE[31:26]==6'd35)//lw
              ||(Instruction_EXE[31:26]==6'd8))//addi
        begin
            Alu_result<=Alu_input1+Alu_input2;
            branch<=0;
        end
        else if((Instruction_EXE[31:26]==6'd0)//rtype
              &&(Instruction_EXE[5:0]==6'b100010))//sub
        begin
            Alu_result<=Alu_input1-Alu_input2;
            branch<=0;
        end
        else if((Instruction_EXE[31:26]==6'd0)//rtype
              &&(Instruction_EXE[5:0]==6'b100100))//and
        begin
            Alu_result<=Alu_input1&Alu_input2;
            branch<=0;
        end
        else if((Instruction_EXE[31:26]==6'd0)//rtype
              &&(Instruction_EXE[5:0]==6'b100101))//or
        begin
            Alu_result<=Alu_input1&Alu_input2;
            branch<=0;
        end
        else if((Instruction_EXE[31:26]==6'd0)//rtype
              &&(Instruction_EXE[5:0]==6'b101010))//slt
        begin
            branch<=0;
			if(Alu_input1<Alu_input2)
			    Alu_result<=32'd1;
			else
			    Alu_result<=32'd0; 
        end
        else if(Instruction_EXE[31:26]==6'b000100)//beq
        begin
            Alu_result<=Alu_result;
            if(Read_data1==Read_data2)
                branch<=1;
            else
                branch<=0;
        end
        else//jump
        begin
            Alu_result<=Alu_result;
            branch<=0;
        end
    end
end

endmodule
