module DP4 (clk, rst, data_a0, data_a1, data_a2, data_a3, data_b0, data_b1, data_b2, data_b3, data_out);

    input clk, rst;
    input [31:0] data_a0, data_a1, data_a2, data_a3, data_b0, data_b1, data_b2, data_b3;
    output [31:0] data_out;
 
    wire sign_a0, sign_a1, sign_a2, sign_a3, sign_b0, sign_b1, sign_b2, sign_b3, sign0, sign1, sign2, sign3, en, sign_out;
    wire [7:0]exp_a0, exp_a1, exp_a2, exp_a3, exp_b0, exp_b1, exp_b2, exp_b3, exp0, exp1, exp2, exp3, adder_exp_out1, adder_exp_out2, exp_out;
    wire [11:0]sig_a0_left, sig_a1_left, sig_a2_left, sig_a3_left, sig_b0_left, sig_b1_left, sig_b2_left, sig_b3_left;
    wire [12:0]sig_a0_right, sig_a1_right, sig_a2_right, sig_a3_right, sig_b0_right, sig_b1_right, sig_b2_right, sig_b3_right;
    wire [49:0]sig_out0, sig_out1, sig_out2, sig_out3;
    wire [50:0]adder_sig_out1, adder_sig_out2;
    wire [22:0]sig_out;

    wire gclk;
    assign en = (|data_a1[30-:8])? 1 : 0;
    assign gclk = clk & en;


    unpack unp(.gclk(gclk), .rst(rst), .en(en), .data_a0(data_a0), .data_a1(data_a1), .data_a2(data_a2), .data_a3(data_a3),
                .data_b0(data_b0), .data_b1(data_b1), .data_b2(data_b2), .data_b3(data_b3),
                .sign_a0(sign_a0), .sign_a1(sign_a1), .sign_a2(sign_a2), .sign_a3(sign_a3),
                .sign_b0(sign_b0), .sign_b1(sign_b1), .sign_b2(sign_b2), .sign_b3(sign_b3),
                .exp_a0(exp_a0), .exp_a1(exp_a1), .exp_a2(exp_a2), .exp_a3(exp_a3),
                .exp_b0(exp_b0), .exp_b1(exp_b1), .exp_b2(exp_b2), .exp_b3(exp_b3),
                .sig_a0_left(sig_a0_left), .sig_a1_left(sig_a1_left), .sig_a2_left(sig_a2_left), .sig_a3_left(sig_a3_left),
                .sig_b0_left(sig_b0_left), .sig_b1_left(sig_b1_left), .sig_b2_left(sig_b2_left), .sig_b3_left(sig_b3_left),
                .sig_a0_right(sig_a0_right), .sig_a1_right(sig_a1_right), .sig_a2_right(sig_a2_right), .sig_a3_right(sig_a3_right),
                .sig_b0_right(sig_b0_right), .sig_b1_right(sig_b1_right), .sig_b2_right(sig_b2_right), .sig_b3_right(sig_b3_right));

    multiply mul (.en(en), .sign_a0(sign_a0), .sign_a1(sign_a1), .sign_a2(sign_a2), .sign_a3(sign_a3), .sign_b0(sign_b0), .sign_b1(sign_b1), .sign_b2(sign_b2), .sign_b3(sign_b3),
                   .exp_a0(exp_a0), .exp_a1(exp_a1), .exp_a2(exp_a2), .exp_a3(exp_a3), .exp_b0(exp_b0), .exp_b1(exp_b1), .exp_b2(exp_b2), .exp_b3(exp_b3),
                   .sig_a0_left(sig_a0_left), .sig_a1_left(sig_a1_left), .sig_a2_left(sig_a2_left), .sig_a3_left(sig_a3_left),
                   .sig_b0_left(sig_b0_left), .sig_b1_left(sig_b1_left), .sig_b2_left(sig_b2_left), .sig_b3_left(sig_b3_left),
                   .sig_a0_right(sig_a0_right), .sig_a1_right(sig_a1_right), .sig_a2_right(sig_a2_right), .sig_a3_right(sig_a3_right),
                   .sig_b0_right(sig_b0_right), .sig_b1_right(sig_b1_right), .sig_b2_right(sig_b2_right), .sig_b3_right(sig_b3_right),
                   .sign0(sign0), .sign1(sign1), .sign2(sign2), .sign3(sign3),
                   .exp0(exp0), .exp1(exp1), .exp2(exp2), .exp3(exp3),
                   .sig_out0(sig_out0), .sig_out1(sig_out1), .sig_out2(sig_out2), .sig_out3(sig_out3));

    adder ad1 (.sign_A(sign0), .sign_B(sign1), .exp_A(exp0), .exp_B(exp1), .sig_A(sig_out0), .sig_B(sig_out1),
                .adder_exp_out(adder_exp_out1), .adder_sig_out(adder_sig_out1));

    adder ad2 (.sign_A(sign2), .sign_B(sign3), .exp_A(exp2), .exp_B(exp3), .sig_A(sig_out2), .sig_B(sig_out3),
                .adder_exp_out(adder_exp_out2), .adder_sig_out(adder_sig_out2));

    adder_final addf (.exp_A(adder_exp_out1), .exp_B(adder_exp_out2),
                        .sig_A(adder_sig_out1), .sig_B(adder_sig_out2), .sign_out(sign_out), .exp_out(exp_out), .sig_out(sig_out));

    pack pk (.en(en), .sign(sign_out), .exp(exp_out), .sig(sig_out), .data_out(data_out));

    //assign data_out = {sign_out, exp_out, sig_out};

endmodule