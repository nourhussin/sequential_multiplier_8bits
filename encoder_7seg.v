module encoder_7seg(
    input[2:0] in_to_display,
    output reg[0:6] segments // (a, b, c, d, e, f, g)
);
    always @(*)begin
        case(in_to_display)
        3'b000: segments = 7'b1111110; // display 0 
        3'b001: segments = 7'b0110000; // display 1 
        3'b010: segments = 7'b1101101; // display 2
        3'b011: segments = 7'b1111001; // display 3
        default:segments = 7'b1001111; // display E
        endcase
    end

endmodule