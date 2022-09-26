module sig_add (sig_P, sig_C, sig_out, Cout);
    
    input [49:0] sig_P, sig_C;
    output [49:0] sig_out;
    output Cout;

    wire [49:0] sig;

    assign sig = sig_P + sig_C;
    assign Cout = sig[49];
    assign sig_out = (sig[49] == 1)? ~sig + 1'b1 : sig;


endmodule