`timescale 1ns / 1ps

module traffic_light_top (

    input wire clk,
    input wire reset,

    output wire ns_red,
    output wire ns_yellow,
    output wire ns_green,

    output wire ew_red,
    output wire ew_yellow,
    output wire ew_green

);

    wire timer_done;

    //============================================================
    // Clock Divider / Timer
    //============================================================
    clock_divider #(
        .CLOCK_FREQ(100_000_000),
        .TIMER_FREQ(1)
    ) timer_inst (

        .clk(clk),
        .reset(reset),
        .timer_done(timer_done)

    );

    //============================================================
    // Traffic Light FSM
    //============================================================
    traffic_light traffic_light_inst (

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

endmodule
