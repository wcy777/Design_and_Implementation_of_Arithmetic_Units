module controller (Cout, adjust_exp1, adjust_exp2, en, exp_in, sign_out, exp_out, sub_en);
    
//input clk;
input Cout, adjust_exp2, en;
input [1:0] sub_en;
input [5:0] adjust_exp1;
input [7:0] exp_in;
output sign_out;
output [7:0] exp_out;





assign sign_out = (Cout)? 1 : 0;
assign exp_out = (en)?  exp_in + adjust_exp2 + adjust_exp1 :  exp_in + adjust_exp2 - adjust_exp1;








endmodule