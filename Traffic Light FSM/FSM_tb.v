`timescale 1ns / 1ps

module traffic_light_tb;

    // Inputs
    reg clk;
    reg reset;
    reg timer_done;

    // Outputs
    wire ns_red;
    wire ns_yellow;
    wire ns_green;

    wire ew_red;
    wire ew_yellow;
    wire ew_green;

    // Instantiate DUT
    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .timer_done(timer_done),

        .ns_red(ns_red),
        .ns_yellow(ns_yellow),
        .ns_green(ns_green),

        .ew_red(ew_red),
        .ew_yellow(ew_yellow),
        .ew_green(ew_green)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin

        // Initialize
        clk = 0;
        reset = 1;
        timer_done = 0;

        // Apply reset
        #20;
        reset = 0;

        // S0: NS Green, EW Red
        #50;
        timer_done = 1;
        #10;
        timer_done = 0;

        // S1: NS Yellow, EW Red
        #50;
        timer_done = 1;
        #10;
        timer_done = 0;

        // S2: NS Red, EW Green
        #50;
        timer_done = 1;
        #10;
        timer_done = 0;

        // S3: NS Red, EW Yellow
        #50;
        timer_done = 1;
        #10;
        timer_done = 0;

        // Back to S0
        #50;

        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor(
            "Time=%0t | Reset=%b Timer=%b | NS(RYG)=%b%b%b | EW(RYG)=%b%b%b",
            $time,
            reset,
            timer_done,
            ns_red, ns_yellow, ns_green,
            ew_red, ew_yellow, ew_green
        );
    end

endmodule

