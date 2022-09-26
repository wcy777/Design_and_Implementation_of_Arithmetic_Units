module pip_three (clk, rst, data_out, P3_data_out);

    input clk, rst;
    input [31:0] data_out;
    output reg [31:0] P3_data_out;


    always @(posedge clk , posedge rst) begin
        if(rst) begin
            P3_data_out <= {32{1'b0}};
        end
        else begin
            P3_data_out <= data_out;
        end
    end

endmodule