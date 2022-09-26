module exp_add (exp_A, exp_B, exp_P);
    
    input [7:0] exp_A, exp_B;
    output [7:0] exp_P;

    //wire [7:0] A, B, P;

    assign exp_P = exp_A + exp_B - 7'd127;    //(A - bias) + (b - bias) + bias



endmodule