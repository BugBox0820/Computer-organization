`timescale 1ns / 1ps


module WB(clk, rst, MEM_instruction, Readdata, t0, t1, t2, t3, t4, t5, s0, s1, s2, s3, s4, s5);

input clk, rst;
input [31:0]MEM_instruction, Readdata;

output [31:0]t0, t1, t2, t3, t4, t5;
output [31:0]s0, s1, s2, s3, s4, s5;
reg signed [31:0]t0, t1, t2, t3, t4, t5;
reg signed [31:0]s0, s1, s2, s3, s4, s5;

always @(negedge clk or negedge rst)begin
    if (!rst)begin
        t0 <= 32'd1;
        t1 <= 32'd2;
        t2 <= 32'd3;
        t3 <= 32'd4;
        t4 <= 32'd5;
        t5 <= 32'd6;
        s0 <= 32'd4;
        s1 <= 32'd8;
        s2 <= 32'd9;
        s3 <= 32'd10;
        s4 <= 32'd11;
        s5 <= 32'd12;
    end
    else begin
        if (MEM_instruction[31:26] == 6'b100011 || MEM_instruction[31:26] == 6'b001000)begin //lw & addi
            case (MEM_instruction[20:16])
                5'd8:begin t0 <= Readdata;end
                5'd9:begin t1 <= Readdata;end
                5'd10:begin t2 <= Readdata;end
                5'd11:begin t3 <= Readdata;end
                5'd12:begin t4 <= Readdata;end
                5'd13:begin t5 <= Readdata;end
                5'd16:begin s0 <= Readdata;end
                5'd17:begin s1 <= Readdata;end
                5'd18:begin s2 <= Readdata;end
                5'd19:begin s3 <= Readdata;end
                5'd20:begin s4 <= Readdata;end
                5'd21:begin s5 <= Readdata;end
            endcase
        end
        else if (MEM_instruction[31:26] == 6'b000000)begin
            case (MEM_instruction[15:11])
                5'd8:begin t0 <= Readdata;end
                5'd9:begin t1 <= Readdata;end
                5'd10:begin t2 <= Readdata;end
                5'd11:begin t3 <= Readdata;end
                5'd12:begin t4 <= Readdata;end
                5'd13:begin t5 <= Readdata;end
                5'd16:begin s0 <= Readdata;end
                5'd17:begin s1 <= Readdata;end
                5'd18:begin s2 <= Readdata;end
                5'd19:begin s3 <= Readdata;end
                5'd20:begin s4 <= Readdata;end
                5'd21:begin s5 <= Readdata;end
            endcase 
        end
        else begin
            t0 <= t0;
            t1 <= t1;
            t2 <= t2;
            t3 <= t3;
            t4 <= t4;
            t5 <= t5;
            s0 <= s0;
            s1 <= s1;
            s2 <= s2;
            s3 <= s3;
            s4 <= s4;
            s5 <= s5;
        end        
    end
end



endmodule
