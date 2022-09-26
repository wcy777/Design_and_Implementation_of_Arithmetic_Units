module pipeline_four (clk, rst, Cout_in, sig_out_in, sub_en_in, exp_C_in, exp_P_in, Cout_out, sig_out_out, sub_en_out, exp_C_out, exp_P_out);
    
    input clk, rst, Cout_in;
    input [7:0] exp_C_in, exp_P_in;
    input [1:0] sub_en_in;
    input [49:0] sig_out_in;
    output reg Cout_out;
    output reg [7:0] exp_C_out, exp_P_out;
    output reg [1:0] sub_en_out;
    output reg [49:0] sig_out_out;
    



    always @(posedge clk , posedge rst) begin
        if(rst) begin
            Cout_out <= 1'b0;
            exp_C_out <= 8'b0;
            exp_P_out <= 8'b0;
            sub_en_out <= 2'b0;
            sig_out_out <= 50'b0;
        end
        else begin
            Cout_out <= Cout_in;
            exp_C_out <= exp_C_in;
            exp_P_out <= exp_P_in;
            sub_en_out <= sub_en_in;
            sig_out_out <= sig_out_in;
        end
    end

endmodule