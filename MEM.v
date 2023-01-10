`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/09 22:30:40
// Design Name: 
// Module Name: MEM
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


module MEM(clk,reset,Read_data_mem,Instruction_MEM,Alu_result,Write_data_mem,Instruction_WB,memory3);

input clk,reset;
input [31:0] Instruction_MEM;
input signed[31:0] Alu_result;
input signed [31:0] Write_data_mem;

output reg [31:0]Instruction_WB;
output reg signed [31:0] Read_data_mem;

output reg [31:0]memory3;

reg [31:0] memory0;
reg [31:0] memory1;
reg [31:0] memory2;
reg [31:0] memory4;
reg [31:0] memory5;

always @(posedge clk or negedge reset)
begin
    if(!reset)
    begin
        Read_data_mem<=32'b0;
		Instruction_WB<=32'b0;
    end
    else
    begin
	   Instruction_WB<=Instruction_MEM;
	   if(Instruction_MEM[31:26]==6'd35)//lw
	   begin
	       case(Alu_result)
		   32'd388:Read_data_mem<=memory0;
		   32'd392:Read_data_mem<=memory1;
		   32'd396:Read_data_mem<=memory2;
		   32'd400:Read_data_mem<=memory3;
		   32'd404:Read_data_mem<=memory4;
		   32'd408:Read_data_mem<=memory5;
		   endcase
	   end
	   else
	       Read_data_mem<=Alu_result;
    end
end

always @(posedge clk or negedge reset) // Write_data_mem
begin
    if(!reset)
		begin
			memory0<=32'd0;
			memory1<=32'd0;
			memory2<=32'd0;
			memory3<=32'd0;
			memory4<=32'd0;
			memory5<=32'd0;
		end
	else
	begin
	   if(Instruction_MEM[31:26]==6'd43)//sw
       begin
			 case(Alu_result)
             32'd388:memory0<=Write_data_mem;
             32'd392:memory1<=Write_data_mem;
             32'd396:memory2<=Write_data_mem;
             32'd400:memory3<=Write_data_mem;
             32'd404:memory4<=Write_data_mem;
             32'd408:memory5<=Write_data_mem;
			 endcase
        end
        else
        begin
            memory0<=memory0;
			memory1<=memory1;
			memory2<=memory2;
			memory3<=memory3;
			memory4<=memory4;
			memory5<=memory5;
        end
    end
end

endmodule
