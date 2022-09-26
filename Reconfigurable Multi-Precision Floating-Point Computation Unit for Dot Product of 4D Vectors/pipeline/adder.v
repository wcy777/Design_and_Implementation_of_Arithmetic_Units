module adder (sign_A, sign_B, exp_A, exp_B, sig_A, sig_B, adder_exp_out, adder_sig_out);

    input sign_A, sign_B;
    input [7:0] exp_A, exp_B;
    input [49:0] sig_A, sig_B;
    output [50:0] adder_sig_out;
    output [7:0] adder_exp_out;
    //output adder_sign_out;

    wire [7:0] sub_out;
    wire [49:0] sel_A, sel_B, ali_A, ali_B;
    wire [1:0] sub_en, two_en;

    sub sub (.exp_P(exp_A), .exp_C(exp_B), .sub_out(sub_out), .sub_en(sub_en));
    mux mux (.exp_P(exp_A), .exp_C(exp_B), .sub_en(sub_en), .exp_out(adder_exp_out));
    Two two (.sign_P(sign_A), .sign_C(sign_B), .two_en(two_en));
    select_c selc (.in_P(sig_A), .in_C(sig_B), .out_P(sel_A), .out_C(sel_B), .two_en(two_en));
    alignment align (.sig_P_in(sel_A), .sig_C_in(sel_B), .sig_P_out(ali_A), .sig_C_out(ali_B), .sub_out(sub_out), .sub_en(sub_en));
    sig_add sigadd (.sig_P(ali_A), .sig_C(ali_B), .sig_out(adder_sig_out));

endmodule

module sub (exp_P, exp_C, sub_out, sub_en);
    
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

module mux (exp_P, exp_C, sub_en, exp_out);

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

module Two (sign_P, sign_C, two_en);

    input sign_P, sign_C;
    output reg [1:0] two_en;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    always @(sign_P, sign_C) begin
    case ({sign_P, sign_C})
        2'b00 : two_en = 2'b00;
        2'b10 : two_en = 2'b01;
        2'b01 : two_en = 2'b10;
        2'b11 : two_en = 2'b11;
        default : two_en = 2'b00;
    endcase      
end
    
endmodule

module select_c (in_P, in_C, out_P, out_C, two_en);
    
input [1:0] two_en;
input [49:0] in_P, in_C;
output reg [49:0] out_P, out_C;

always @(two_en, in_P, in_C) begin
    case (two_en)
        2'b01:  begin
            out_P = ~in_P + 1'b1;
            out_C = in_C;
        end
        2'b10:  begin
            out_P = in_P;
            out_C = ~in_C + 1'b1;
        end
        2'b11:  begin
            out_P = ~in_P + 1'b1;
            out_C = ~in_C + 1'b1;
        end
        default: begin
            out_P = in_P;
            out_C = in_C;
        end
    endcase
end

endmodule

module alignment (sig_P_in, sig_C_in, sig_P_out, sig_C_out, sub_out, sub_en);

    input signed [49:0] sig_P_in, sig_C_in;
    input [7:0] sub_out;
    input [1:0] sub_en; 
    output [49:0] sig_P_out, sig_C_out;



    assign sig_P_out = (sub_en == 2'b00)? sig_P_in : (sub_en == 2'b01)? sig_P_in >>> sub_out : sig_P_in;
    assign sig_C_out = (sub_en == 2'b00)? sig_C_in >>> sub_out : (sub_en == 2'b01)? sig_C_in : sig_C_in;

endmodule

module sig_add (sig_P, sig_C, sig_out);
    
    input [49:0] sig_P, sig_C;
    output [50:0] sig_out;
    //output Cout;

    wire [49:0] sig;

    assign sig = sig_P + sig_C;
    //assign Cout = sig[49];
    assign sig_out = {sig[49], sig};

endmodule