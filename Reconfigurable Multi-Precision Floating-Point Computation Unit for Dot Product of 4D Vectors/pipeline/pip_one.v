module pip_one (clk, rst, data_a0, data_a1, data_a2, data_a3, data_b0, data_b1, data_b2, data_b3,
                 p1_data_a0, p1_data_a1, p1_data_a2, p1_data_a3, p1_data_b0, p1_data_b1, p1_data_b2, p1_data_b3);

    input clk, rst;
    input [31:0] data_a0, data_a1, data_a2, data_a3, data_b0, data_b1, data_b2, data_b3;
    output reg [31:0] p1_data_a0, p1_data_a1, p1_data_a2, p1_data_a3, p1_data_b0, p1_data_b1, p1_data_b2, p1_data_b3;


    always @(posedge clk , posedge rst) begin
        if(rst) begin
            p1_data_a0 <= {32{1'b0}};
            p1_data_a1 <= {32{1'b0}};
            p1_data_a2 <= {32{1'b0}};
            p1_data_a3 <= {32{1'b0}};
            p1_data_b0 <= {32{1'b0}};
            p1_data_b1 <= {32{1'b0}};
            p1_data_b2 <= {32{1'b0}};
            p1_data_b3 <= {32{1'b0}};
        end
        else begin
            p1_data_a0 <= data_a0;
            p1_data_a1 <= data_a1;
            p1_data_a2 <= data_a2;
            p1_data_a3 <= data_a3;
            p1_data_b0 <= data_b0;
            p1_data_b1 <= data_b1;
            p1_data_b2 <= data_b2;
            p1_data_b3 <= data_b3;
        end
    end

endmodule