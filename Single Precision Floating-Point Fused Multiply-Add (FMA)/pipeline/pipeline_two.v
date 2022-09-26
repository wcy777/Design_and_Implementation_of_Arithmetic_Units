module pipeline_two (clk, rst, exp_P_in, sig_P_in, two_en_in, exp_C_in, sig_C_in, exp_P_out, sig_P_out, two_en_out, exp_C_out, sig_C_out);
    
    input clk, rst;
    input [7:0] exp_P_in, exp_C_in;
    input [49:0] sig_P_in, sig_C_in;
    input [1:0] two_en_in;
    output reg [7:0] exp_P_out, exp_C_out;
    output reg [49:0] sig_P_out, sig_C_out;
    output reg [1:0] two_en_out;


    always @(posedge clk , posedge rst) begin
        if(rst) begin
            exp_P_out <= 8'b0;
            sig_P_out <= 50'b0;
            two_en_out <= 2'b0;
            exp_C_out <= 8'b0;
            sig_C_out <= 50'b0;
        end
        else begin
            exp_P_out <= exp_P_in;
            sig_P_out <= sig_P_in;
            two_en_out <= two_en_in;
            exp_C_out <= exp_C_in;
            sig_C_out <= sig_C_in;
        end
    end

endmodule