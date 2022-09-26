module pipeline_five (clk, rst, exp_out_in, sign_out_in, sig_out_in, exp_out_out, sign_out_out, sig_out_out);
    
    input clk, rst, sign_out_in;
    input [7:0] exp_out_in;
    input [22:0] sig_out_in;
    output reg sign_out_out;
    output reg [7:0] exp_out_out;
    output reg [22:0] sig_out_out;
    



    always @(posedge clk , posedge rst) begin
        if(rst) begin
            sign_out_out <= 1'b0;
            exp_out_out <= 8'b0;
            sig_out_out <= 23'b0;
        end
        else begin
            sign_out_out <= sign_out_in;
            exp_out_out <= exp_out_in;
            sig_out_out <= sig_out_in;
        end
    end

endmodule