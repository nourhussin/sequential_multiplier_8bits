module multiplier_controller(
    input clk, start, reset_a,
    input [1:0] count,
    output reg done, clk_ena, sclr_n,
    output reg [1:0] input_sel, shift_sel,
    output [2:0] state_out
);
    localparam IDLE = 3'b000;
    localparam LSB  = 3'b001;
    localparam MID  = 3'b010;
    localparam MSB  = 3'b011;
    localparam ERR  = 3'b101;
    localparam CALC_DONE = 3'b100;
    
    reg [2:0] current_state, next_state;

    // Register Logic
    always @(posedge clk or posedge reset_a)
    begin
        if(reset_a)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Input and Output Logic
    always @(*)
    begin
        case(current_state)
        IDLE:
            if(start)
            begin
                next_state <= LSB;
                done <=    1'b0;
                clk_ena <= 1'b0;
                sclr_n <=  1'b1;
                //default
                input_sel <= 2'b00;
                shift_sel <= 2'b00;
            end
            else 
            begin
                next_state <= IDLE;
                done <=    1'b0;
                clk_ena <= 1'b1;
                sclr_n <=  1'b0;
                //default
                input_sel <= 2'b00;
                shift_sel <= 2'b00;
            end
    //------------------------------------------------------------            
        LSB:
            if(~start && count == 2'b00)
            begin
                next_state <= MID;
                done <=    1'b0;
                clk_ena <= 1'b1;
                sclr_n <=  1'b1;
                input_sel <= 2'b00;
                shift_sel <= 2'b00;
            end
            else
            begin
                next_state <= ERR;
                done <=    1'b0;
                clk_ena <= 1'b0;
                sclr_n <=  1'b1;
                //default
                input_sel <= 2'b00;
                shift_sel <= 2'b00;
            end
    //------------------------------------------------------------
        MID:
            if(~start && count == 2'b01)
            begin
                next_state <= MID;
                done <=    1'b0;
                clk_ena <= 1'b1;
                sclr_n <=  1'b1;
                input_sel <= 2'b01;
                shift_sel <= 2'b01;
            end
            else if(~start && count == 2'b10)
            begin
                next_state <= MSB;
                done <=    1'b0;
                clk_ena <= 1'b1;
                sclr_n <=  1'b1;
                input_sel <= 2'b10;
                shift_sel <= 2'b01;
            end
            else
            begin
                next_state <= ERR;
                done <=    1'b0;
                clk_ena <= 1'b0;
                sclr_n <=  1'b1;
                //default
                input_sel <= 2'b00;
                shift_sel <= 2'b00;
            end
    //------------------------------------------------------------
        MSB:
            if(~start && count == 2'b11)
            begin
                next_state <= CALC_DONE;
                done <=    1'b0;
                clk_ena <= 1'b1;
                sclr_n <=  1'b1;
                input_sel <= 2'b11;
                shift_sel <= 2'b10;
            end
            else
            begin
                next_state <= ERR;
                done <=    1'b0;
                clk_ena <= 1'b0;
                sclr_n <=  1'b1;
                //default
                input_sel <= 2'b00;
                shift_sel <= 2'b00;
            end
    //------------------------------------------------------------
        CALC_DONE:
            if(~start)
            begin
                next_state <= IDLE;
                done <=    1'b1;
                clk_ena <= 1'b0;
                sclr_n <=  1'b1;
                //default
                input_sel <= 2'b00;
                shift_sel <= 2'b00;
            end
            else
            begin
                next_state <= ERR;
                done <=    1'b0;
                clk_ena <= 1'b0;
                sclr_n <=  1'b1;
                //default
                input_sel <= 2'b00;
                shift_sel <= 2'b00;
            end
    //------------------------------------------------------------
        ERR:
            if(start)
            begin
                next_state <= LSB;
                done <=    1'b0;
                clk_ena <= 1'b1;
                sclr_n <=  1'b0;
                //default
                input_sel <= 2'b00;
                shift_sel <= 2'b00;
            end
            else
            begin
                next_state <= ERR;
                done <=    1'b0;
                clk_ena <= 1'b0;
                sclr_n <=  1'b1;
                //default
                input_sel <= 2'b00;
                shift_sel <= 2'b00;
            end

        endcase
    end
    assign state_out = current_state;
endmodule