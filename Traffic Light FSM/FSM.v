module traffic_light (
    input  wire clk,
    input  wire reset,
    input  wire timer_done,

    output reg ns_red,
    output reg ns_yellow,
    output reg ns_green,

    output reg ew_red,
    output reg ew_yellow,
    output reg ew_green
);

    typedef enum logic [1:0] {
        S0_NS_GREEN  = 2'b00,
        S1_NS_YELLOW = 2'b01,
        S2_EW_GREEN  = 2'b10,
        S3_EW_YELLOW = 2'b11
    } state_t;

    state_t state, next_state;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0_NS_GREEN;
        else
            state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        case (state)
            S0_NS_GREEN:
                next_state = timer_done ? S1_NS_YELLOW : S0_NS_GREEN;

            S1_NS_YELLOW:
                next_state = timer_done ? S2_EW_GREEN : S1_NS_YELLOW;

            S2_EW_GREEN:
                next_state = timer_done ? S3_EW_YELLOW : S2_EW_GREEN;

            S3_EW_YELLOW:
                next_state = timer_done ? S0_NS_GREEN : S3_EW_YELLOW;

            default:
                next_state = S0_NS_GREEN;
        endcase
    end

    // Output logic
    always @(*) begin
        ns_red    = 0;
        ns_yellow = 0;
        ns_green  = 0;
        ew_red    = 0;
        ew_yellow = 0;
        ew_green  = 0;

        case (state)
            S0_NS_GREEN: begin
                ns_green = 1;
                ew_red   = 1;
            end

            S1_NS_YELLOW: begin
                ns_yellow = 1;
                ew_red    = 1;
            end

            S2_EW_GREEN: begin
                ns_red   = 1;
                ew_green = 1;
            end

            S3_EW_YELLOW: begin
                ns_red    = 1;
                ew_yellow = 1;
            end
        endcase
    end

endmodule
