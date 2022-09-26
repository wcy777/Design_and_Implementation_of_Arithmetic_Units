module pack (en, sign, exp, sig, data_out);

    input en, sign;
    input [7:0]exp;
    input [22:0]sig;
    output reg [31:0] data_out;

    always @(sign, exp, sig) begin
        if(en) begin
            data_out = {sign, exp, sig};
        end
        else begin
            data_out = {16'h0000, sign, exp[4:0], sig[22-:10]};
        end
    end
    
endmodule