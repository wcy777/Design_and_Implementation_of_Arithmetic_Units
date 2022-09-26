module sub (exp_P, exp_C, sub_out, sub_en);
    
    input [7:0] exp_P, exp_C;
    output reg [7:0] sub_out;
    output reg [1:0] sub_en;


    // assign sub_en = (exp_P > exp_C)? 1 : 0;
    // assign sub_out = (exp_P > exp_C)? exp_P - exp_C : exp_C - exp_P
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