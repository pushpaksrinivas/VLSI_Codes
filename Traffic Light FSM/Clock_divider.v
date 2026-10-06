`timescale 1ns / 1ps

module clock_divider #(
    parameter integer CLOCK_FREQ = 100_000_000,
    parameter integer TIMER_FREQ = 1
)(
    input  wire clk,
    input  wire reset,

    output reg timer_done
);

    localparam integer COUNT_MAX = CLOCK_FREQ / TIMER_FREQ;

    // Calculate counter width
    localparam integer COUNTER_WIDTH =
        (COUNT_MAX <= 2) ? 1 : $clog2(COUNT_MAX);

    reg [COUNTER_WIDTH-1:0] counter;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            counter    <= 0;
            timer_done <= 1'b0;
        end

        else begin

            if (counter == COUNT_MAX - 1) begin
                counter    <= 0;
                timer_done <= 1'b1;
            end

            else begin
                counter    <= counter + 1'b1;
                timer_done <= 1'b0;
            end

        end

    end

endmodule
