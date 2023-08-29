`timescale 1ns/1ns
`include "top_module.v"
module top_module_tb;
    reg clk, start, reset_a;
    reg[7:0] dataa,datab;
    wire done_flag;
    wire[15:0] product_8x8_out;
    wire[0:6] segments; // (a, b, c, d, e, f, g)

    top_module UUT(
        .clk(clk),
        .start(start),
        .reset_a(reset_a),
        .dataa(dataa),
        .datab(datab),
        .done_flag(done_flag),
        .product_8x8_out(product_8x8_out),
        .segments(segments)
    );

    initial
    begin
        clk = 1'b0;
        forever begin
            #5; clk = ~clk;
        end
    end
    initial
    begin
        $dumpfile("top_module_tb.vcd");
        $dumpvars(0,top_module_tb);

        reset_a=0;
        #2

        reset_a=1;
        dataa=10;
        datab=20;
        #10
        reset_a=0;
        #1
        start=1;#10; start=0;
        #50;

        reset_a=1;
        dataa=100;
        datab=200;
        #10
        reset_a=0;
        #1
        start=1;#10; start=0;
        #50;
        $finish;
        

    end
endmodule