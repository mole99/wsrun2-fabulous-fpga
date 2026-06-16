// Copyright 2026 Leo Moser
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

module GF_EFUSE_SPI_256x8 #(
    parameter NoConfigBits = 0
)(
    // Fabric side
    input  CLK,
    input  RST,
    input  SPI_CLK,
    input  SPI_CSN,
    output SPI_MISO,
    input  SPI_MOSI,

    // External side
    (* FABulous, EXTERNAL *) output CLK_top,
    (* FABulous, EXTERNAL *) output RST_top,
    (* FABulous, EXTERNAL *) output SPI_CLK_top,
    (* FABulous, EXTERNAL *) output SPI_CSN_top,
    (* FABulous, EXTERNAL *) input  SPI_MISO_top,
    (* FABulous, EXTERNAL *) output SPI_MOSI_top,
    
    (* FABulous, EXTERNAL *) input  CONFIGURED_top
);
    // Fabric -> External
    assign CLK_top       = CLK;
    // Only enable the eFUSE if the fabric is configured
    assign RST_top     = RST || !CONFIGURED_top;
    assign SPI_CLK_top   = SPI_CLK;
    assign SPI_CSN_top   = SPI_CSN;
    assign SPI_MOSI_top  = SPI_MOSI;
    
    // External -> Fabric
    assign SPI_MISO      = SPI_MISO_top;

endmodule
