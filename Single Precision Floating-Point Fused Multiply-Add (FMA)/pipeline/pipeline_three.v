module pipeline_three (clk, rst, sub_out_in, sub_en_in, out_P_in, out_C_in, exp_C_in, exp_P_in, sub_out_out, sub_en_out, out_P_out, out_C_out, exp_C_out, exp_P_out);
    
    input clk, rst;
    input [7:0] sub_out_in, exp_C_in, exp_P_in;
    input [1:0] sub_en_in;
    input [49:0] out_P_in, out_C_in;
    output reg [7:0] sub_out_out, exp_C_out, exp_P_out;
    output reg [1:0] sub_en_out;
    output reg [49:0] out_P_out, out_C_out;
    



    always @(posedge clk , posedge rst) begin
        if(rst) begin
            sub_out_out <= 8'b0;
            exp_C_out <= 8'b0;
            exp_P_out <= 8'b0;
            sub_en_out <= 2'b10;
            out_P_out <= 50'b0;
            out_C_out <= 50'b0;
        end
        else begin
            sub_out_out <= sub_out_in;
            exp_C_out <= exp_C_in;
            exp_P_out <= exp_P_in;
            sub_en_out <= sub_en_in;
            out_P_out <= out_P_in;
            out_C_out <= out_C_in;
        end
    end

endmodule