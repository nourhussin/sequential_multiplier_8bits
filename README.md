# Sequential 8x8 Multiplier

## Objective
The objective of this project is to build an 8x8 multiplier. This multiplier takes two 8-bit multiplicands (dataa and datab) as inputs and produces a 16-bit product (product8x8_out). Additionally, it generates a "done" flag and seven signals to drive a 7-segment display.

The 8x8 multiplier operates in four clock cycles to perform the full multiplication. During each cycle, a pair of 4-bit portions of the multiplicands is multiplied by a 4x4 multiplier. The multiplication results of these 4-bit slices are accumulated. The fully composed 16-bit product can be read at the output at the end of the four cycles. 

## Components
- 16-bits Adder.
- 4x4 Multiplier.
- 2-1 Multiplexer.
- Shifter.
- 7-Segment Display Encoder.
- Asynchronous 16-bits Register.
- 2-bits Counter.
- Multiplier Controller.
## Top-Level Design
Combine all components with the appropriate instantiations to create the top-level design.

