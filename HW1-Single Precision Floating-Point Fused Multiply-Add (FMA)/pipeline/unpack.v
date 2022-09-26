module unpack (data_A, data_B, data_C, sign_A, sign_B, sign_C, exp_A, exp_B, exp_C, sig_A, sig_B, sig_C);
    
//parameter N = 32;
input [31:0] data_A, data_B, data_C;
output sign_A, sign_B, sign_C;
output [7:0] exp_A, exp_B, exp_C;
output [24:0] sig_A, sig_B;
output [49:0] sig_C;


assign sign_A = data_A[31];
assign sign_B = data_B[31];
assign sign_C = data_C[31];
assign exp_A = data_A[30:23];
assign exp_B = data_B[30:23];
assign exp_C = data_C[30:23];
assign sig_A = {2'b01, data_A[22:0]};  //Q2.23
assign sig_B = {2'b01, data_B[22:0]};

assign sig_C = {4'b0001, data_C[22:0], 23'b0};   //Q4.46


endmodule