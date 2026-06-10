// Copyright 2026 FABulous Contributors
// Copyright 2025 Leo Moser
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

(* FABulous, BelMap,
CLK_INV=0
*)
module GF_SRAM_1024x8_1RW #(
    parameter NoConfigBits = 1,
    parameter DATA_WIDTH   = 8,
    parameter ADDR_BITS    = 10
)(
    // Fabric side
    input                         CLK,
    input  [(ADDR_BITS - 1) : 0]  ADDR,
    input  [(DATA_WIDTH - 1) : 0] DIN,
    input  [(DATA_WIDTH - 1) : 0] BM,
    input                         WEN,
    input                         MEN,
    	output [(DATA_WIDTH - 1) : 0] DOUT,

    // External side
    (* FABulous, EXTERNAL *) output                         CLK_SRAM,
    (* FABulous, EXTERNAL *) output [(ADDR_BITS - 1) : 0]   A_SRAM,
    (* FABulous, EXTERNAL *) output [(DATA_WIDTH - 1) : 0]  D_SRAM,
    (* FABulous, EXTERNAL *) output [(DATA_WIDTH - 1) : 0]  WEN_SRAM,
    (* FABulous, EXTERNAL *) output                         GWEN_SRAM,
    (* FABulous, EXTERNAL *) output                         CEN_SRAM,
    (* FABulous, EXTERNAL *) input  [(DATA_WIDTH - 1) : 0]  Q_SRAM,
    
    (* FABulous, EXTERNAL *) input                 CONFIGURED_top,

    // Static configuration bits
    (* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
    // Configuration bits
    wire CLK_INV;
    assign CLK_INV = ConfigBits[0];

    // Fabric -> External
    // Note: the N in WEN, GWEN, CEN means negative
    assign CLK_SRAM     = CLK_INV ? !CLK : CLK;
    assign A_SRAM       = ADDR;
    assign D_SRAM       = DIN;
    assign WEN_SRAM     = ~BM;
    assign GWEN_SRAM    = !WEN;
    // Only enable the SRAM if the fabric is configured
    assign CEN_SRAM     = !(MEN && CONFIGURED_top);
    
    // External -> Fabric
    assign DOUT         = Q_SRAM;

endmodule
