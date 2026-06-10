// Copyright 2026 FABulous Contributors
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

(* keep *)
module GF_SRAM_1024x8_1RW #(
    parameter CLK_INV = 1'b0
  )(
    (* clkbuf_sink *) input        CLK,
    input        ADDR0,
    input        ADDR1,
    input        ADDR2,
    input        ADDR3,
    input        ADDR4,
    input        ADDR5,
    input        ADDR6,
    input        ADDR7,
    input        ADDR8,
    input        ADDR9,
    input        DIN0,
    input        DIN1,
    input        DIN2,
    input        DIN3,
    input        DIN4,
    input        DIN5,
    input        DIN6,
    input        DIN7,
    input        BM0,
    input        BM1,
    input        BM2,
    input        BM3,
    input        BM4,
    input        BM5,
    input        BM6,
    input        BM7,
    input        WEN,
    input        MEN,
    output       DOUT0,
    output       DOUT1,
    output       DOUT2,
    output       DOUT3,
    output       DOUT4,
    output       DOUT5,
    output       DOUT6,
    output       DOUT7
);
    localparam WIDTH = 8;
    localparam DEPTH = 10;

    // We need to combine individual bits into vectors
    // since FABulous doesn't support vectors for primitives yet
    wire [DEPTH-1:0] ADDR;
    wire [WIDTH-1:0] DIN;
    wire [WIDTH-1:0] BM;
    wire [WIDTH-1:0] DOUT;
    
    assign ADDR = {ADDR9, ADDR8, ADDR7, ADDR6, ADDR5, ADDR4, ADDR3, ADDR2, ADDR1, ADDR0};
    assign DIN = {DIN7, DIN6, DIN5, DIN4, DIN3, DIN2, DIN1, DIN0};
    assign BM = {BM7, BM6, BM5, BM4, BM3, BM2, BM1, BM0};

    assign {DOUT7, DOUT6, DOUT5, DOUT4, DOUT3, DOUT2, DOUT1, DOUT0} = DOUT;

    // Clock inversion
    wire clk;
    assign clk = CLK_INV ? !CLK : CLK;

    reg [WIDTH-1:0] mem [2**DEPTH];
    reg  [WIDTH-1:0] DOUT_reg;
    
    always @(posedge clk) begin
        if (MEN && WEN) begin
            mem[ADDR] <= (mem[ADDR] & ~BM) | (DIN & BM);
        end else if (MEN && !WEN) begin
            DOUT_reg <= mem[ADDR];
        end
    end
    
    assign DOUT = DOUT_reg;

endmodule
