module pip_two (clk, rst, sign0, sign1, sign2, sign3, exp0, exp1, exp2, exp3,
                sig_out0, sig_out1, sig_out2, sig_out3,
                P2_sign0, P2_sign1, P2_sign2, P2_sign3, P2_exp0, P2_exp1, P2_exp2, P2_exp3,
                P2_sig_out0, P2_sig_out1, P2_sig_out2, P2_sig_out3);

    input clk, rst;
    input sign0, sign1, sign2, sign3;
    input [7:0]exp0, exp1, exp2, exp3;
    input [49:0] sig_out0, sig_out1, sig_out2, sig_out3;
    output reg P2_sign0, P2_sign1, P2_sign2, P2_sign3;
    output reg [7:0] P2_exp0, P2_exp1, P2_exp2, P2_exp3;
    output reg [49:0] P2_sig_out0, P2_sig_out1, P2_sig_out2, P2_sig_out3;


    always @(posedge clk , posedge rst) begin
        if(rst) begin
            P2_sign0 <= {1{1'b0}};
            P2_sign1 <= {1{1'b0}};
            P2_sign2 <= {1{1'b0}};
            P2_sign3 <= {1{1'b0}};
            P2_exp0 <= {8{1'b0}};
            P2_exp1 <= {8{1'b0}};
            P2_exp2 <= {8{1'b0}};
            P2_exp3 <= {8{1'b0}};
            P2_sig_out0 <= {50{1'b0}};
            P2_sig_out1 <= {50{1'b0}};
            P2_sig_out2 <= {50{1'b0}};
            P2_sig_out3 <= {50{1'b0}};
        end
        else begin
            P2_sign0 <= sign0;
            P2_sign1 <= sign1;
            P2_sign2 <= sign2;
            P2_sign3 <= sign3;
            P2_exp0 <= exp0;
            P2_exp1 <= exp1;
            P2_exp2 <= exp2;
            P2_exp3 <= exp3;
            P2_sig_out0 <= sig_out0;
            P2_sig_out1 <= sig_out1;
            P2_sig_out2 <= sig_out2;
            P2_sig_out3 <= sig_out3;
        end
    end

endmodule