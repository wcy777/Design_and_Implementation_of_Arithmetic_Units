module exp_add_final (exp_in, exp_adj, exp_out);

    input [7:0] exp_in;
    input [7:0] exp_adj;
    output [7:0] exp_out;

    assign exp_out = exp_in + exp_adj;

endmodule