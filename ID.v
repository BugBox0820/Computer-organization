`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/10 19:13:51
// Design Name: 
// Module Name: ID
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


module ID(IF_instruction, clk, rst, t0, t1, t2, t3, t4, t5, s0, s1, s2, s3, s4, s5, 
          ID_instruction, Readdata1, Readdata2, sign_extend, jump);


input [31:0] IF_instruction;
input clk, rst;
input [31:0] t0, t1, t2, t3, t4, t5;
input [31:0] s0, s1, s2, s3, s4, s5;

output [31:0] ID_instruction;
output [31:0] Readdata1, Readdata2;
output [31:0] sign_extend;
output jump;
reg [31:0] ID_instruction;
reg signed[31:0] Readdata1, Readdata2;
reg signed[31:0] sign_extend;
reg jump;

always @(posedge clk or negedge rst)begin
    if (!rst)begin
        ID_instruction <= 0;
        Readdata1 <= 0;
        Readdata2 <= 0;
        sign_extend <= 0;
        jump <= 0;
    end
    else begin
        ID_instruction <= IF_instruction;
        //identifiy instruction code
        if (IF_instruction == 32'b0)begin //NOP
            Readdata1 <= Readdata1;
            Readdata2 <= Readdata2;
        end
        else if (IF_instruction[31:26] == 6'b000000)begin //R_type
            jump <= 0;
            case (IF_instruction[25:21])
                5'd8:begin Readdata1 <= t0;end
                5'd9:begin Readdata1 <= t1;end
                5'd10:begin Readdata1 <= t2;end
                5'd11:begin Readdata1 <= t3;end
                5'd12:begin Readdata1 <= t4;end
                5'd13:begin Readdata1 <= t5;end
                5'd16:begin Readdata1 <= s0;end
                5'd17:begin Readdata1 <= s1;end
                5'd18:begin Readdata1 <= s2;end
                5'd19:begin Readdata1 <= s3;end
                5'd20:begin Readdata1 <= s4;end
                5'd21:begin Readdata1 <= s5;end
            endcase
            case (IF_instruction[20:16])
                5'd8:begin Readdata2 <= t0;end
                5'd9:begin Readdata2 <= t1;end
                5'd10:begin Readdata2 <= t2;end
                5'd11:begin Readdata2 <= t3;end
                5'd12:begin Readdata2 <= t4;end
                5'd13:begin Readdata2 <= t5;end
                5'd16:begin Readdata2 <= s0;end
                5'd17:begin Readdata2 <= s1;end
                5'd18:begin Readdata2 <= s2;end
                5'd19:begin Readdata2 <= s3;end
                5'd20:begin Readdata2 <= s4;end
                5'd21:begin Readdata2 <= s5;end
            endcase
        end
        else if (IF_instruction[31:26] == 6'b100011 || 
                 IF_instruction[31:26] == 6'b101011 ||
                 IF_instruction[31:26] == 6'b000101 ||
                 IF_instruction[31:26] == 6'b001000)begin //I_type
            jump <= 0;
            if (IF_instruction[31:26] == 6'b000101)begin //dealing branch address here
                sign_extend[31:18] <= {14{IF_instruction[15]}}; 
                sign_extend[17:2] <= IF_instruction[15:0];
                sign_extend[1:0] <= 2'b00;
            end
            else begin //other I_type
                sign_extend[31:16] <= {16{IF_instruction[15]}};
                sign_extend[15:0] <= IF_instruction[15:0];
            end
            
            case (IF_instruction[25:21])
                5'd8:begin Readdata1 <= t0;end
                5'd9:begin Readdata1 <= t1;end
                5'd10:begin Readdata1 <= t2;end
                5'd11:begin Readdata1 <= t3;end
                5'd12:begin Readdata1 <= t4;end
                5'd13:begin Readdata1 <= t5;end
                5'd16:begin Readdata1 <= s0;end
                5'd17:begin Readdata1 <= s1;end
                5'd18:begin Readdata1 <= s2;end
                5'd19:begin Readdata1 <= s3;end
                5'd20:begin Readdata1 <= s4;end
                5'd21:begin Readdata1 <= s5;end
            endcase
            case (IF_instruction[20:16])
                5'd8:begin Readdata2 <= t0;end
                5'd9:begin Readdata2 <= t1;end
                5'd10:begin Readdata2 <= t2;end
                5'd11:begin Readdata2 <= t3;end
                5'd12:begin Readdata2 <= t4;end
                5'd13:begin Readdata2 <= t5;end
                5'd16:begin Readdata2 <= s0;end
                5'd17:begin Readdata2 <= s1;end
                5'd18:begin Readdata2 <= s2;end
                5'd19:begin Readdata2 <= s3;end
                5'd20:begin Readdata2 <= s4;end
                5'd21:begin Readdata2 <= s5;end
            endcase
        end
        else if (IF_instruction[31:26])begin //junp
            jump <= 1'b1;
            Readdata1 <= {16{2'b01}}; //debug
            Readdata1 <= {16{2'b01}};
        end    
    end
end



endmodule
