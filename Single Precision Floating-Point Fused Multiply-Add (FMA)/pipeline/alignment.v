module alignment (sig_P_in, sig_C_in, sig_P_out, sig_C_out, sub_out, sub_en);

    input signed [49:0] sig_P_in, sig_C_in;
    input [7:0] sub_out;
    input [1:0] sub_en; 
    output [49:0] sig_P_out, sig_C_out;



    assign sig_P_out = (sub_en == 2'b00)? sig_P_in : (sub_en == 2'b01)? sig_P_in >>> sub_out : sig_P_in;
    assign sig_C_out = (sub_en == 2'b00)? sig_C_in >>> sub_out : (sub_en == 2'b01)? sig_C_in : sig_C_in;





endmodule