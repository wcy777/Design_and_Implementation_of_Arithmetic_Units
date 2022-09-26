module unpack (data_a0, data_a1, data_a2, data_a3, data_b0, data_b1, data_b2, data_b3,
 sign_a0, sign_a1, sign_a2, sign_a3, sign_b0, sign_b1, sign_b2, sign_b3,
 exp_a0, exp_a1, exp_a2, exp_a3, exp_b0, exp_b1, exp_b2, exp_b3,
 sig_a0_left, sig_a1_left, sig_a2_left, sig_a3_left, sig_b0_left, sig_b1_left, sig_b2_left, sig_b3_left,
 sig_a0_right, sig_a1_right, sig_a2_right, sig_a3_right, sig_b0_right, sig_b1_right, sig_b2_right, sig_b3_right, en);
    
input [31:0] data_a0, data_a1, data_a2, data_a3, data_b0, data_b1, data_b2, data_b3;
output sign_a0, sign_a1, sign_a2, sign_a3, sign_b0, sign_b1, sign_b2, sign_b3;
output [7:0]exp_a0, exp_a1, exp_a2, exp_a3, exp_b0, exp_b1, exp_b2, exp_b3;
output [11:0]sig_a0_left, sig_a1_left, sig_a2_left, sig_a3_left, sig_b0_left, sig_b1_left, sig_b2_left, sig_b3_left;
output [12:0]sig_a0_right, sig_a1_right, sig_a2_right, sig_a3_right, sig_b0_right, sig_b1_right, sig_b2_right, sig_b3_right;
output en;


assign en = (|data_a1[30-:8])? 1 : 0;   //1 = single, 0 = half

assign sign_a0 = (en)? data_a0[31] : data_a0[15];
assign sign_a1 = (en)? data_a1[31] : data_a1[15];
assign sign_a2 = (en)? data_a2[31] : data_a2[15];
assign sign_a3 = (en)? data_a3[31] : data_a3[15];

assign sign_b0 = (en)? data_b0[31] : data_b0[15];
assign sign_b1 = (en)? data_b1[31] : data_b1[15];
assign sign_b2 = (en)? data_b2[31] : data_b2[15];
assign sign_b3 = (en)? data_b3[31] : data_b3[15];

assign exp_a0 = (en)? data_a0[30:23] : {3'b000, data_a0[14:10]};
assign exp_a1 = (en)? data_a1[30:23] : {3'b000, data_a1[14:10]};
assign exp_a2 = (en)? data_a2[30:23] : {3'b000, data_a2[14:10]};
assign exp_a3 = (en)? data_a3[30:23] : {3'b000, data_a3[14:10]};

assign exp_b0 = (en)? data_b0[30:23] : {3'b000, data_b0[14:10]};
assign exp_b1 = (en)? data_b1[30:23] : {3'b000, data_b1[14:10]};
assign exp_b2 = (en)? data_b2[30:23] : {3'b000, data_b2[14:10]};
assign exp_b3 = (en)? data_b3[30:23] : {3'b000, data_b3[14:10]};

assign sig_a0_left = (en)? {2'b01, data_a0[22:13]} : {2'b01, data_a0[9:0]};       //Q2.10
assign sig_a1_left = (en)? {2'b01, data_a1[22:13]} : {2'b01, data_a1[9:0]};
assign sig_a2_left = (en)? {2'b01, data_a2[22:13]} : {2'b01, data_a2[9:0]};
assign sig_a3_left = (en)? {2'b01, data_a3[22:13]} : {2'b01, data_a3[9:0]};

assign sig_b0_left = (en)? {2'b01, data_b0[22:13]} : {2'b01, data_b0[9:0]};       
assign sig_b1_left = (en)? {2'b01, data_b1[22:13]} : {2'b01, data_b1[9:0]};
assign sig_b2_left = (en)? {2'b01, data_b2[22:13]} : {2'b01, data_b2[9:0]};
assign sig_b3_left = (en)? {2'b01, data_b3[22:13]} : {2'b01, data_b3[9:0]};

assign sig_a0_right = (en)? data_a0[12:0] : 13'b0;                    //13'b
assign sig_a1_right = (en)? data_a1[12:0] : 13'b0;
assign sig_a2_right = (en)? data_a2[12:0] : 13'b0;
assign sig_a3_right = (en)? data_a3[12:0] : 13'b0;

assign sig_b0_right = (en)? data_b0[12:0] : 13'b0;
assign sig_b1_right = (en)? data_b1[12:0] : 13'b0;
assign sig_b2_right = (en)? data_b2[12:0] : 13'b0;
assign sig_b3_right = (en)? data_b3[12:0] : 13'b0;

endmodule