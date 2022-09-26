module pipeline_one (clk, rst, A, B, C, data_A, data_B, data_C);

    input clk, rst;
    input [31:0] A, B, C;
    output reg [31:0] data_A, data_B, data_C;


    always @(posedge clk , posedge rst) begin
        if(rst) begin
            data_A <= {32{1'b0}};
            data_B <= {32{1'b0}};
            data_C <= {32{1'b0}};
        end
        else begin
            data_A <= A;
            data_B <= B;
            data_C <= C;
        end
    end

endmodule