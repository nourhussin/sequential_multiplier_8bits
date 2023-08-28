module counter(
    input clk, async_clear_n,
    output reg[1:0] count_out
);
    always @(posedge clk, negedge async_clear_n)begin
        if(~async_clear_n)
            count_out <= 2'b00;
        else
            count_out <= count_out +1;
    end
endmodule