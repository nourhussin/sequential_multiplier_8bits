`include "adder_16bits.v"
`include "counter.v"
`include "encoder_7seg.v"
`include "multiplier_4x4.v"
`include "multiplier_controller.v"
`include "mux_4bits_2to1.v"
`include "shifter.v"
`include "register_16bits.v"

module top_module(
    input clk, start, reset_a,
    input[7:0] dataa,datab,
    output done_flag,
    output[15:0] product_8x8_out,
    output[0:6] segments // (a, b, c, d, e, f, g)
);
    wire clk_enable,clear_n; 
    wire[1:0] count,select,shift;
    wire[2:0] state_out;			  
    wire[7:0] product;
    wire[15:0] shift_out,sum;
    wire[3:0] aout,bout;

    // Set the controller signals
    multiplier_controller MCU(
        .clk(clk),
        .reset_a(reset_a),
        .start(start),
        .count(count),
        .input_sel(select),
        .shift_sel(shift),
        .done(done_flag),
        .state_out(state_out),
        .clk_enable(clk_enable),
        .clear_n(clear_n)
        );

    // Take the state code and convert it to 7 segment display
    encoder_7seg encoderU(
        .in_to_display(state_out),
        .segments(segments)
    );
    // Take active low start signal to make async clear and count 0 to 3
    counter counterU(
        .clk(clk),
        .async_clear_n(!start),
        .count_out(count)
    );
    // Take shift control signal from the controller and input data from 4x4 multiplier
    shifter shifterU(
        .in_to_shift(product),
        .shift_control(shift),
        .shift_out(shift_out)
    );

    adder_16bits adderU(
        .first_number(shift_out),
        .second_number(product_8x8_out),
        .sum(sum)
    );

    multiplier_4x4 multiplierU(
        .first_number(aout[3:0]),
        .second_number(bout[3:0]),
        .product(product)
    );

    register_16bits regsiterU(
        .clk(clk),
        .async_clear_n(clear_n),
        .clk_enable(clk_enable),
        .data_in(sum),
        .reg_out(product_8x8_out)
    );

    mux_4bits_2to1 mux1U(
        .first_input(dataa[3:0]),
        .second_input(dataa[7:4]),
        .selector(select[1]),
        .mux_out(aout)
    );
    mux_4bits_2to1 mux2U(
        .first_input(datab[3:0]),
        .second_input(datab[7:4]),
        .selector(select[0]),
        .mux_out(bout)
    );


endmodule