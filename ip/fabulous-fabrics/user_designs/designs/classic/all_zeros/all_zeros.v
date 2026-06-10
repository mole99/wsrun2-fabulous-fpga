// SPDX-FileCopyrightText: © 2026 FABulous Contributors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module all_zeros (
    `ifdef CLASSIC_FABRIC_WSRUN2
    output wire [47:0] all
    `else
    output wire [27:0] all
    `endif
);

    assign all = '0;

endmodule
