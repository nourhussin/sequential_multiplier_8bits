module multiplier_4x4(
    input[3:0] first_number,second_number,
    output[7:0] product
);
    assign product = first_number * second_number;
    
endmodule