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