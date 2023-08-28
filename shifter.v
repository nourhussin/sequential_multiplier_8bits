module shifter(
    input[7:0] in_to_shift,
    input[1:0] shift_control,
    output reg[15:0] shift_out
);
    /* If shift_control == 0 or 3 ---> defaut no shift
       If shift_control == 1      ---> 4 bits shift left
       If shift_control == 2      ---> 8 bits shift left */
       
    always @(*) begin
        case(shift_control)
        2'b01:  shift_out = {4'h0, in_to_shift, 4'h0};
        2'b10:  shift_out = {in_to_shift, 8'h00};
        default: shift_out = {8'h00, in_to_shift};
        endcase
    end
endmodule