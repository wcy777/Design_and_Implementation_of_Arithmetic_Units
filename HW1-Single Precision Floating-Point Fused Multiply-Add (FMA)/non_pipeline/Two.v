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