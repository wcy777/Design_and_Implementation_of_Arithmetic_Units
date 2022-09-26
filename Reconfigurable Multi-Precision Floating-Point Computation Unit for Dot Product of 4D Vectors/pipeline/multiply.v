module multiply (clk, rst, en, sign_a0,
 sign_a1, sign_a2, sign_a3, sign_b0, sign_b1, sign_b2, sign_b3,
 exp_a0, exp_a1, exp_a2, exp_a3, exp_b0, exp_b1, exp_b2, exp_b3,
 sig_a0_left, sig_a1_left, sig_a2_left, sig_a3_left, sig_b0_left, sig_b1_left, sig_b2_left, sig_b3_left,
 sig_a0_right, sig_a1_right, sig_a2_right, sig_a3_right, sig_b0_right, sig_b1_right, sig_b2_right, sig_b3_right,
 sign0, sign1, sign2, sign3,
 exp0, exp1, exp2, exp3,
 sig_out0, sig_out1, sig_out2, sig_out3,);

    input clk, rst, en;
    input sign_a0, sign_a1, sign_a2, sign_a3, sign_b0, sign_b1, sign_b2, sign_b3;
    input [7:0]exp_a0, exp_a1, exp_a2, exp_a3, exp_b0, exp_b1, exp_b2, exp_b3;
    input [11:0]sig_a0_left, sig_a1_left, sig_a2_left, sig_a3_left, sig_b0_left, sig_b1_left, sig_b2_left, sig_b3_left;
    input [12:0]sig_a0_right, sig_a1_right, sig_a2_right, sig_a3_right, sig_b0_right, sig_b1_right, sig_b2_right, sig_b3_right;
    output sign0, sign1, sign2, sign3;
    output [7:0]exp0, exp1, exp2, exp3;
    output reg [49:0]sig_out0, sig_out1, sig_out2, sig_out3;


    reg [23:0]sig_left_left0, sig_left_left1, sig_left_left2, sig_left_left3;
    reg [24:0]sig_left_right0, sig_left_right1, sig_left_right2, sig_left_right3;
    reg [24:0]sig_right_left0, sig_right_left1, sig_right_left2, sig_right_left3;
    reg [25:0]sig_right_right0, sig_right_right1, sig_right_right2, sig_right_right3;

    wire gclk;
    assign gclk = clk & en;

    assign sign0 = sign_a0 ^ sign_b0;
    assign sign1 = sign_a1 ^ sign_b1;
    assign sign2 = sign_a2 ^ sign_b2;
    assign sign3 = sign_a3 ^ sign_b3;
    assign exp0 = (en)? exp_a0 + exp_b0 - 7'd127 : exp_a0 + exp_b0 - 7'd15;
    assign exp1 = (en)? exp_a1 + exp_b1 - 7'd127 : exp_a1 + exp_b1 - 7'd15;
    assign exp2 = (en)? exp_a2 + exp_b2 - 7'd127 : exp_a2 + exp_b2 - 7'd15;
    assign exp3 = (en)? exp_a3 + exp_b3 - 7'd127 : exp_a3 + exp_b3 - 7'd15;

    always @(sig_a0_left, sig_b0_left) begin
        sig_left_left0 = sig_a0_left * sig_b0_left;      //Q4.46
        sig_left_left1 = sig_a1_left * sig_b1_left;
        sig_left_left2 = sig_a2_left * sig_b2_left;
        sig_left_left3 = sig_a3_left * sig_b3_left;
    end

    always @(posedge gclk or posedge rst) begin
        if(rst) begin
            sig_left_right0 <= 25'b0;
            sig_left_right1 <= 25'b0;
            sig_left_right2 <= 25'b0;
            sig_left_right3 <= 25'b0;

            sig_right_left0 <= 25'b0;
            sig_right_left1 <= 25'b0;
            sig_right_left2 <= 25'b0;
            sig_right_left3 <= 25'b0; 

            sig_right_right0 <= 26'b0;
            sig_right_right1 <= 26'b0;
            sig_right_right2 <= 26'b0;
            sig_right_right3 <= 26'b0;                     
        end
        else begin
            sig_left_right0 <= sig_a0_left * sig_b0_right;
            sig_left_right1 <= sig_a1_left * sig_b1_right;
            sig_left_right2 <= sig_a2_left * sig_b2_right;
            sig_left_right3 <= sig_a3_left * sig_b3_right;

            sig_right_left0 <= sig_a0_right * sig_b0_left;
            sig_right_left1 <= sig_a1_right * sig_b1_left;
            sig_right_left2 <= sig_a2_right * sig_b2_left;
            sig_right_left3 <= sig_a3_right * sig_b3_left;  

            sig_right_right0 <= sig_a0_right * sig_b0_right;
            sig_right_right1 <= sig_a1_right * sig_b1_right;
            sig_right_right2 <= sig_a2_right * sig_b2_right;
            sig_right_right3 <= sig_a3_right * sig_b3_right;
        end
    end

    always @(sig_left_left0, en) begin
        // if(~en) begin
        //     sig_out0 = {sig_left_left0, 26'b0};
        //     sig_out1 = {sig_left_left1, 26'b0};
        //     sig_out2 = {sig_left_left2, 26'b0};
        //     sig_out3 = {sig_left_left3, 26'b0};
        // end
        //else begin
            sig_out0 = {sig_left_left0, 26'b0} + {sig_left_right0, 13'b0} + {sig_right_left0, 13'b0} + {24'b0, sig_right_right0};
            sig_out1 = {sig_left_left1, 26'b0} + {sig_left_right1, 13'b0} + {sig_right_left1, 13'b0} + {24'b0, sig_right_right1};
            sig_out2 = {sig_left_left2, 26'b0} + {sig_left_right2, 13'b0} + {sig_right_left2, 13'b0} + {24'b0, sig_right_right2};
            sig_out3 = {sig_left_left3, 26'b0} + {sig_left_right3, 13'b0} + {sig_right_left3, 13'b0} + {24'b0, sig_right_right3};
        //end
    end

    // always @(posedge gclk ) begin
    //     sig_out0 = {sig_left_left0, 26'b0} + {sig_left_right0, 25'b0} + {sig_right_left0, 25'b0} + {24'b0, sig_right_right0};
    //     sig_out1 = {sig_left_left1, 26'b0} + {sig_left_right1, 25'b0} + {sig_right_left1, 25'b0} + {24'b0, sig_right_right1};
    //     sig_out2 = {sig_left_left2, 26'b0} + {sig_left_right2, 25'b0} + {sig_right_left2, 25'b0} + {24'b0, sig_right_right2};
    //     sig_out3 = {sig_left_left3, 26'b0} + {sig_left_right3, 25'b0} + {sig_right_left3, 25'b0} + {24'b0, sig_right_right3};
    // end
 
endmodule