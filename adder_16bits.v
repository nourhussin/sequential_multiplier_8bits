module adder_16bits(
    input[15:0] first_number,second_number,
    output[15:0] sum
);
    assign sum = first_number + second_number;

endmodule