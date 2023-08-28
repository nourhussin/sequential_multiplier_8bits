module regsiter_16bits(
    input[15:0] data_in,
    input clk, async_clear_n, clk_enable,
    output reg[15:0] reg_out
);
    always @(posedge clk, negedge async_clear_n)begin
        if(clk_enable) begin
            if(~async_clear_n)
                reg_out <= 16'h0000;
            else
                reg_out <= data_in;
        end
    end

endmodule