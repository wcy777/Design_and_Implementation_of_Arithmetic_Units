module normalize (sig_in, sig_out, zero_cnt, en_out);
    
    input [49:0] sig_in;
    output [26:0] sig_out;
    output [5:0] zero_cnt;
    output en_out;

    wire [49:0] tmp;
    wire s_bit, en;

    assign en_out = en;

    LOD lod (.sig_in(sig_in), .zero_cnt(zero_cnt), .en(en));

    assign tmp =  (en)? sig_in >> zero_cnt : sig_in << zero_cnt;
    assign s_bit = |tmp[19:0];
    assign sig_out = {tmp[46:21], s_bit};


endmodule










module LOD (sig_in, zero_cnt, en);

    input [49:0] sig_in;
    output reg en;
    output reg [5:0] zero_cnt;

    always @(sig_in) begin
        casex(sig_in)
            default : begin
                en = 1'b0;
                zero_cnt = 6'd0;
            end
            50'b1x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx :begin
                en = 1'b1;
                zero_cnt = 6'd3;
            end 
            50'b01_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b1;
                zero_cnt = 6'd2;
            end

            50'b00_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b1;
                zero_cnt = 6'd1;
            end
            50'b00_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b1;
                zero_cnt = 6'd0;
            end
            50'b00_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd1;
            end
            50'b00_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd2;
            end
            50'b00_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd3;
            end
            50'b00_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd4;
            end
            50'b00_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd5;
            end
            50'b00_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd6;
            end
            50'b00_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd7;
            end
            50'b00_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd8;
            end
            50'b00_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd9;
            end
            50'b00_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd10;
            end
            50'b00_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd11;
            end
            50'b00_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd12;
            end
            50'b00_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd13;
            end
            50'b00_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd14;
            end
            50'b00_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd15;
            end
            50'b00_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd16;
            end
            50'b00_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd17;
            end
            50'b00_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd18;
            end
            50'b00_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd19;
            end
            50'b00_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd20;
            end
            50'b00_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd21;
            end
            50'b00_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd22;
            end
            50'b00_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd23;
            end
            50'b00_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd24;
            end
            50'b00_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd25;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd26;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd27;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd28;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd29;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd30;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd31;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd32;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd33;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd34;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd35;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd36;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd37;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd38;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd39;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd40;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd41;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx : begin
                en = 1'b0;
                zero_cnt = 6'd42;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx : begin
                en = 1'b0;
                zero_cnt = 6'd43;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx : begin
                en = 1'b0;
                zero_cnt = 6'd44;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x : begin
                en = 1'b0;
                zero_cnt = 6'd45;
            end
            50'b00_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001 : begin
                en = 1'b0;
                zero_cnt = 6'd46;
            end
           
          
        endcase
    end  
endmodule