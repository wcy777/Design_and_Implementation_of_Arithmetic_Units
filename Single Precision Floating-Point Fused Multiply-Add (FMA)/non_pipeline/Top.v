module Top (A, B, C, D);

    input [31:0] A, B, C;
    output [31:0] D;

    wire sign_A, sign_B, sign_C, sign_P, Cout, LOD_en, round_exp, sign_out;
    wire [7:0] exp_A, exp_B, exp_C, exp_P, mux_out, sub_out,exp_out;
    wire [24:0] sig_A, sig_B;
    wire [49:0] sig_C, sig_P, sel_C, sel_P, ali_C, ali_P, add_out;
    wire [1:0] sub_en, two_en;
    wire [26:0] norm_out;
    wire [5:0] zero_cnt;
    wire [22:0] sig_out;




    unpack unp (.data_A(A), .data_B(B), .data_C(C), .sign_A(sign_A), .sign_B(sign_B), .sign_C(sign_C), .exp_A(exp_A), .exp_B(exp_B), .exp_C(exp_C), .sig_A(sig_A), .sig_B(sig_B), .sig_C(sig_C));
    xor1 xor1 (.sign_A(sign_A), .sign_B(sign_B), .sign_P(sign_P));
    exp_add expadd (.exp_A(exp_A), .exp_B(exp_B), .exp_P(exp_P));
    multiply mul (.sig_A(sig_A), .sig_B(sig_B), .sig_P(sig_P));
    sub sub (.exp_P(exp_P), .exp_C(exp_C), .sub_out(sub_out), .sub_en(sub_en));
    mux mux (.exp_P(exp_P), .exp_C(exp_C), .sub_en(sub_en), .exp_out(mux_out));
    Two two (.sign_P(sign_P), .sign_C(sign_C), .two_en(two_en));
    select_c selc (.in_P(sig_P), .in_C(sig_C), .out_P(sel_P), .out_C(sel_C), .two_en(two_en));
    alignment align (.sig_P_in(sel_P), .sig_C_in(sel_C), .sig_P_out(ali_P), .sig_C_out(ali_C), .sub_out(sub_out), .sub_en(sub_en));
    sig_add sigadd (.sig_P(ali_P), .sig_C(ali_C), .sig_out(add_out), .Cout(Cout));
    normalize normal (.sig_in(add_out), .sig_out(norm_out), .zero_cnt(zero_cnt), .en_out(LOD_en));
    rounding round (.sig_in(norm_out), .sig_out(sig_out), .exp(round_exp));

    controller ctrl (.Cout(Cout), .adjust_exp1(zero_cnt), .adjust_exp2(round_exp), .en(LOD_en), .sign_out(sign_out), .exp_out(exp_out), .sub_en(sub_en), .exp_in(mux_out));

    assign D = {sign_out, exp_out, sig_out};



endmodule