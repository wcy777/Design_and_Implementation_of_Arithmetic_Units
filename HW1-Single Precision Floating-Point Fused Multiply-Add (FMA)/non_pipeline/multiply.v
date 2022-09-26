module multiply (sig_A, sig_B, sig_P);

    input [24:0] sig_A, sig_B;
    output [49:0] sig_P;

    assign sig_P = sig_A * sig_B;

endmodule