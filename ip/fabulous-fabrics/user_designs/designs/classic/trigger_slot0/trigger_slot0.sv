// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module trigger_slot0 (
    input  wire        clk1,
    output wire [5:0]  a
);
    
    // Boot from slot 0 when the counter
    // has reached the value 0
    
    wire RESET, RESET_buf;
    
    SYS_RESET SYS_RESET_i (
        .RESET  (RESET)
    );
    
    GBUF GBUF_i (
        .IN   (RESET),
        .OUT  (RESET_buf)
    );
    
    logic [3:0] counter;
    logic boot;
    
    always_ff @(posedge clk1) begin
        if (RESET_buf) begin
            counter <= '1;
            boot <= 1'b0;
        end else begin
            if (counter > 0) begin
                counter <= counter - 1;
            end else begin
                boot <= 1'b1;
            end
        end
    end
    
    WARMBOOT WARMBOOT_i (
        .SLOT0   (1'b0),
        .SLOT1   (1'b0),
        .SLOT2   (1'b0),
        .SLOT3   (1'b0),        
        .TRIGGER (boot)
    );

    assign a = '1;

endmodule
