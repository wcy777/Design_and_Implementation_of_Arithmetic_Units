module adder_final (exp_A, exp_B, sig_A, sig_B, sign_out, exp_out, sig_out);

    //input sign_A, sign_B;
    input [7:0] exp_A, exp_B;
    input [50:0] sig_A, sig_B;
    output sign_out;
    output [7:0] exp_out;
    output [22:0] sig_out;

    wire Cout, LOD_en, round_exp;
    wire [7:0] mux_out, sub_out,exp_out;
    wire [49:0] add_out;
    wire [50:0] ali_A, ali_B;
    wire [1:0] sub_en;
    wire [26:0] norm_out;
    wire [5:0] zero_cnt;



    sub_final subf (.exp_P(exp_A), .exp_C(exp_B), .sub_out(sub_out), .sub_en(sub_en));
    mux_final muxf (.exp_P(exp_A), .exp_C(exp_B), .sub_en(sub_en), .exp_out(mux_out));
    //Two two (.sign_P(sign_A), .sign_C(sign_B), .two_en(two_en));
    //select_c_final selcf (.in_P(sig_A), .in_C(sig_B), .out_P(sel_A), .out_C(sel_B), .two_en(two_en));
    alignment_final alignf (.sig_P_in(sig_A), .sig_C_in(sig_B), .sig_P_out(ali_A), .sig_C_out(ali_B), .sub_out(sub_out), .sub_en(sub_en));
    sig_add_final sigaddf (.sig_P(ali_A), .sig_C(ali_B), .sig_out(add_out), .Cout(Cout));
    normalize normal (.sig_in(add_out), .sig_out(norm_out), .zero_cnt(zero_cnt), .en_out(LOD_en));
    rounding round (.sig_in(norm_out), .sig_out(sig_out), .exp(round_exp));

    controller ctrl (.Cout(Cout), .adjust_exp1(zero_cnt), .adjust_exp2(round_exp), .en(LOD_en), .sign_out(sign_out), .exp_out(exp_out), .exp_in(mux_out));

endmodule

module sub_final (exp_P, exp_C, sub_out, sub_en);
    
    input [7:0] exp_P, exp_C;
    output reg [7:0] sub_out;
    output reg [1:0] sub_en;

    always @(exp_P or exp_C) begin
        if(exp_P > exp_C) begin
            sub_en = 2'b00;
            sub_out = exp_P - exp_C;
        end
        else if(exp_P < exp_C) begin
            sub_en = 2'b01;
            sub_out = exp_C - exp_P;
        end
        else begin
            sub_en = 2'b10;
            sub_out = exp_P - exp_C;
        end
    end

endmodule

module mux_final (exp_P, exp_C, sub_en, exp_out);

    input [7:0] exp_P, exp_C;
    input [1:0] sub_en;
    output reg [7:0] exp_out;

    always @(sub_en or exp_P or exp_C) 
    begin
        case(sub_en)
            2'b00: exp_out = exp_P;
            2'b01: exp_out = exp_C;
            default: exp_out = exp_P;
        endcase
    end

endmodule

// module Two (sign_P, sign_C, two_en);

//     input sign_P, sign_C;
//     output reg [1:0] two_en;

//     parameter S0 = 2'b00;
//     parameter S1 = 2'b01;
//     parameter S2 = 2'b10;
//     parameter S3 = 2'b11;

//     always @(sign_P, sign_C) begin
//     case ({sign_P, sign_C})
//         2'b00 : two_en = 2'b00;
//         2'b10 : two_en = 2'b01;
//         2'b01 : two_en = 2'b10;
//         2'b11 : two_en = 2'b11;
//         default : two_en = 2'b00;
//     endcase      
// end
    
// endmodule

// module select_c_final (in_P, in_C, out_P, out_C, two_en);
    
// input [1:0] two_en;
// input [50:0] in_P, in_C;
// output reg [50:0] out_P, out_C;

// always @(two_en, in_P, in_C) begin
//     case (two_en)
//         2'b01:  begin
//             out_P = ~in_P + 1'b1;
//             out_C = in_C;
//         end
//         2'b10:  begin
//             out_P = in_P;
//             out_C = ~in_C + 1'b1;
//         end
//         2'b11:  begin
//             out_P = ~in_P + 1'b1;
//             out_C = ~in_C + 1'b1;
//         end
//         default: begin
//             out_P = in_P;
//             out_C = in_C;
//         end
//     endcase
// end

// endmodule

module alignment_final (sig_P_in, sig_C_in, sig_P_out, sig_C_out, sub_out, sub_en);

    input signed [50:0] sig_P_in, sig_C_in;
    input [7:0] sub_out;
    input [1:0] sub_en; 
    output [50:0] sig_P_out, sig_C_out;

    //wire [49:0] sig_P_out_tmp, sig_C_out_tmp;

    assign sig_P_out = (sub_en == 2'b00)? sig_P_in : (sub_en == 2'b01)? sig_P_in >>> sub_out : sig_P_in;
    assign sig_C_out = (sub_en == 2'b00)? sig_C_in >>> sub_out : (sub_en == 2'b01)? sig_C_in : sig_C_in;

    //assign sig_P_out_tmp = (two_en[1] == 0)? ~sig_P_out + 1'b1 : sig_P_out;
    //assign sig_C_out_tmp = (two_en[0] == 0)? ~sig_C_out + 1'b1 : sig_C_out;

    //assign select = (sig_P_out_tmp[49-:4] + sig_C_out_tmp[49-:4] > 4'b0111)? 1 : 0;     //大於7看第50bit，小於看第49bit

endmodule

module sig_add_final (sig_P, sig_C, sig_out, Cout);
    
    //input select;
    input [50:0] sig_P, sig_C;
    output [49:0] sig_out;
    output Cout;

    wire [50:0] sig;


    assign sig = sig_P + sig_C;
    assign Cout = sig[50];
    assign sig_out = (sig[50] == 1)? ~sig[50:1] + 1'b1 : sig[50:1];


    // always @(sig_P, sig_C, select) begin
    //     sig = sig_P + sig_C;
    //     case(select)
    //         1'b0 : begin
    //             Cout = sig[49];
    //             if(sig[49]) sig_out = ~sig + 1'b1;
    //             else sig_out = sig;
    //         end
    //         1'b1 : begin
    //             Cout = sig[50];
    //             if(sig[50]) sig_out = ~sig[50:1] + 1'b1;
    //             else sig_out = sig[50:1];
    //         end
    //     endcase

    // end

endmodule

module normalize (sig_in, sig_out, zero_cnt, en_out);
    
    input [49:0] sig_in;
    output [26:0] sig_out;
    output [5:0] zero_cnt;
    output en_out;

    wire [49:0] tmp;
    wire s_bit, en;

    assign en_out = en;

    LOD lod (.sig_in(sig_in), .zero_cnt(zero_cnt), .en(en));

    assign tmp =  (en)? sig_in >> zero_cnt : sig_in << zero_cnt;
    assign s_bit = |tmp[19:0];
    assign sig_out = {tmp[46:21], s_bit};


endmodule

module LOD (sig_in, zero_cnt, en);

    input [49:0] sig_in;
    output reg en;
    output reg [5:0] zero_cnt;

    always @(sig_in) begin
        casex(sig_in)
            default : begin
                en = 1'b0;
                zero_cnt = 6'd0;
            end
            50'b1x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx :begin
                en = 1'b1;
                zero_cnt = 6'd4;
            end 
            50'b01_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b1;
                zero_cnt = 6'd3;
            end

            50'b00_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b1;
                zero_cnt = 6'd2;
            end
            50'b00_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b1;
                zero_cnt = 6'd1;
            end
            50'b00_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd0;
            end
            50'b00_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd1;
            end
            50'b00_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd2;
            end
            50'b00_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd3;
            end
            50'b00_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd4;
            end
            50'b00_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd5;
            end
            50'b00_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd6;
            end
            50'b00_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd7;
            end
            50'b00_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd8;
            end
            50'b00_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd9;
            end
            50'b00_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd10;
            end
            50'b00_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd11;
            end
            50'b00_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd12;
            end
            50'b00_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd13;
            end
            50'b00_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd14;
            end
            50'b00_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd15;
            end
            50'b00_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd16;
            end
            50'b00_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd17;
            end
            50'b00_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd18;
            end
            50'b00_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd19;
            end
            50'b00_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd20;
            end
            50'b00_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd21;
            end
            50'b00_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd22;
            end
            50'b00_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd23;
            end
            50'b00_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd24;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd25;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd26;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd27;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd28;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd29;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd30;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd31;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd32;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd33;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd34;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd35;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd36;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd37;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd38;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd39;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd40;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd41;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx : begin
                en = 1'b0;
                zero_cnt = 6'd42;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx : begin
                en = 1'b0;
                zero_cnt = 6'd43;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x : begin
                en = 1'b0;
                zero_cnt = 6'd44;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001 : begin
                en = 1'b0;
                zero_cnt = 6'd45;
            end
        endcase
    end  
endmodule

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

module controller (Cout, adjust_exp1, adjust_exp2, en, exp_in, sign_out, exp_out);
    
//input clk;
input Cout, adjust_exp2, en;
input [5:0] adjust_exp1;
input [7:0] exp_in;
output sign_out;
output [7:0] exp_out;

assign sign_out = (Cout)? 1 : 0;
assign exp_out = (en)?  exp_in + adjust_exp2 + adjust_exp1 :  exp_in + adjust_exp2 - adjust_exp1;

endmodule