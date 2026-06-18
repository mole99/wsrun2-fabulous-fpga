// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module counter_top (
    input  wire clk1,
    input  wire rst,
    output wire [7:0] c
);
    /*wire RESET, RESET_buf;
    
    SYS_RESET SYS_RESET_i (
        .RESET  (RESET)
    );
    
    GBUF GBUF_i (
        .IN   (RESET),
        .OUT  (RESET_buf)
    );*/

	  reg [7:0] ctr;

	  always @(posedge clk1) begin
        if (rst) begin
            ctr <= 0;
        end else begin
            ctr <= ctr + 1'b1;
        end
    end

	  assign c = ctr;
endmodule
