module Top (clk, rst, A, B, C, D);

    input clk, rst;
    input [31:0] A, B, C;
    output [31:0] D;

    wire [31:0] data_A, data_B, data_C;
    wire sign_A, sign_B, sign_C, sign_P, Cout, LOD_en, round_exp, sign_out, Cout_out, sign_out_D;
    wire [7:0] exp_A, exp_B, exp_C, exp_P, mux_out, sub_out, exp_out, exp_C_out, exp_P_out, exp_C_out_p3, exp_P_out_p3, exp_C_out_p4, exp_P_out_p4, exp_out_D, sub_out_out;
    wire [24:0] sig_A, sig_B;
    wire [49:0] sig_C, sig_P, sel_C, sel_P, ali_C, ali_P, add_out, sig_P_out, sig_C_out, out_P_out, out_C_out, sig_out_out;
    wire [1:0] sub_en, two_en, two_en_out, sub_en_out, sub_en_out_p4;
    wire [26:0] norm_out;
    wire [5:0] zero_cnt;
    wire [22:0] sig_out, sig_out_D;



    pipeline_one p1 (.clk(clk), .rst(rst), .A(A), .B(B), .C(C), .data_A(data_A), .data_B(data_B), .data_C(data_C));
    unpack unp (.data_A(data_A), .data_B(data_B), .data_C(data_C), .sign_A(sign_A), .sign_B(sign_B), .sign_C(sign_C), .exp_A(exp_A), .exp_B(exp_B), .exp_C(exp_C), .sig_A(sig_A), .sig_B(sig_B), .sig_C(sig_C));
    xor1 xor1 (.sign_A(sign_A), .sign_B(sign_B), .sign_P(sign_P));
    exp_add expadd (.exp_A(exp_A), .exp_B(exp_B), .exp_P(exp_P));
    multiply mul (.sig_A(sig_A), .sig_B(sig_B), .sig_P(sig_P));
    Two two (.sign_P(sign_P), .sign_C(sign_C), .two_en(two_en));
    pipeline_two p2 (.clk(clk), .rst(rst), .exp_P_in(exp_P), .sig_P_in(sig_P), .two_en_in(two_en), .exp_C_in(exp_C), .sig_C_in(sig_C), .exp_P_out(exp_P_out), .sig_P_out(sig_P_out), .two_en_out(two_en_out), .exp_C_out(exp_C_out), .sig_C_out(sig_C_out));
    sub sub (.exp_P(exp_P_out), .exp_C(exp_C_out), .sub_out(sub_out), .sub_en(sub_en));
    select_c selc (.in_P(sig_P_out), .in_C(sig_C_out), .out_P(sel_P), .out_C(sel_C), .two_en(two_en_out));
    pipeline_three p3 (.clk(clk), .rst(rst), .sub_out_in(sub_out), .sub_en_in(sub_en), .out_P_in(sel_P), .out_C_in(sel_C), .exp_C_in(exp_C_out), .exp_P_in(exp_P_out), .sub_out_out(sub_out_out), .sub_en_out(sub_en_out), .out_P_out(out_P_out), .out_C_out(out_C_out), .exp_C_out(exp_C_out_p3), .exp_P_out(exp_P_out_p3));
    alignment align (.sig_P_in(out_P_out), .sig_C_in(out_C_out), .sig_P_out(ali_P), .sig_C_out(ali_C), .sub_out(sub_out_out), .sub_en(sub_en_out));
    sig_add sigadd (.sig_P(ali_P), .sig_C(ali_C), .sig_out(add_out), .Cout(Cout));
    pipeline_four p4 (.clk(clk), .rst(rst), .Cout_in(Cout), .sig_out_in(add_out), .sub_en_in(sub_en_out), .exp_C_in(exp_C_out_p3), .exp_P_in(exp_P_out_p3), .Cout_out(Cout_out), .sig_out_out(sig_out_out), .sub_en_out(sub_en_out_p4), .exp_C_out(exp_C_out_p4), .exp_P_out(exp_P_out_p4));
    normalize normal (.sig_in(sig_out_out), .sig_out(norm_out), .zero_cnt(zero_cnt), .en_out(LOD_en));
    rounding round (.sig_in(norm_out), .sig_out(sig_out), .exp(round_exp));
    mux mux (.exp_P(exp_P_out_p4), .exp_C(exp_C_out_p4), .sub_en(sub_en_out_p4), .exp_out(mux_out));
    controller ctrl (.Cout(Cout_out), .adjust_exp1(zero_cnt), .adjust_exp2(round_exp), .en(LOD_en), .sign_out(sign_out), .exp_out(exp_out), .sub_en(sub_en_out_p4), .exp_in(mux_out));
    pipeline_five p5 (.clk(clk), .rst(rst), .exp_out_in(exp_out), .sign_out_in(sign_out), .sig_out_in(sig_out), .exp_out_out(exp_out_D), .sign_out_out(sign_out_D), .sig_out_out(sig_out_D));


    assign D = {sign_out_D, exp_out_D, sig_out_D};



endmodule