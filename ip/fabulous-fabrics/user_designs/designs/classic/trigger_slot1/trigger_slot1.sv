// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module trigger_slot1 (
    output wire [5:0]  a
);
    
    // Boot from slot 1
    WARMBOOT WARMBOOT_i (
        .SLOT0   (1'b1),
        .SLOT1   (1'b0),
        .SLOT2   (1'b0),
        .SLOT3   (1'b0),        
        .TRIGGER (1'b1)
    );
    
    assign a = '0;

endmodule
