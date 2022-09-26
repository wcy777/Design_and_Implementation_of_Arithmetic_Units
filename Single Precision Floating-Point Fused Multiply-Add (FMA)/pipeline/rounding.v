module rounding (sig_in, sig_out, exp);

    input [26:0] sig_in;
    output [22:0] sig_out;
    output exp;

    wire [24:0] tst;
    wire even;

    assign even = sig_in[3];
    assign tst = (sig_in[2:0] > 3'b100)? {1'b0, sig_in[26:3]} + 1'b1 : (sig_in[2:0] < 3'b100)? {1'b0, sig_in[26:3]} : (sig_in[2:0] == 3'b100 && even == 1'b1)? {1'b0, sig_in[26:3]} + 1'b1 : {1'b0, sig_in[26:3]};
    assign sig_out = (tst[24])? tst[23:1] : tst[22:0];
    assign exp = (tst[24])? 1 : 0;

endmodule