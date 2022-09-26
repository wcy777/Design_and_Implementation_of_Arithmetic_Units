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