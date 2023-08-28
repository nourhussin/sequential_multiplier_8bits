module mux_4bits_2to1(
    input[3:0] first_input, second_input,
    input selector,
    output[3:0] mux_out
);
    assign mux_out = selector? second_input : first_input;

endmodule