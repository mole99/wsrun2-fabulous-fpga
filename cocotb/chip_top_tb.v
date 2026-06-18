// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`timescale 1 ns / 1 ps
`default_nettype none

`include "slot_defines.svh"

reg [1023:0] firmware_file;
module chip_top_tb;

    // Signal pads
    parameter NUM_FPGA_PADS = `NUM_FPGA_PADS;

    /*initial begin
        `ifdef DUMP_WAVEFORMS
            $dumpfile("chip_top_tb.fst");
            $dumpvars(0, chip_top_tb);
        `endif
    end*/

    `ifdef USE_POWER_PINS
    wire VDD;
    wire VSS;
    wire DVDD;
    wire DVSS;
    `endif

    wire clk_PAD;
    wire rst_n_PAD;
    
    wire fpga_mode_PAD;
    wire config_busy_PAD;
    
    wire fpga_sclk_PAD;
    wire fpga_cs_n_PAD;
    wire fpga_mosi_PAD;
    wire fpga_miso_PAD;

    wire [NUM_FPGA_PADS-1:0] fpga_PAD;
    
    wire fpga_PAD_0;
    wire fpga_PAD_1;
    wire fpga_PAD_2;
    wire fpga_PAD_3;
    wire fpga_PAD_4;
    wire fpga_PAD_5;
    wire fpga_PAD_6;
    wire fpga_PAD_7;
    wire fpga_PAD_8;
    wire fpga_PAD_9;
    wire fpga_PAD_10;
    wire fpga_PAD_11;
    wire fpga_PAD_12;
    wire fpga_PAD_13;
    wire fpga_PAD_14;
    wire fpga_PAD_15;
    wire fpga_PAD_16;
    wire fpga_PAD_17;
    wire fpga_PAD_18;
    wire fpga_PAD_19;
    wire fpga_PAD_20;
    wire fpga_PAD_21;
    wire fpga_PAD_22;
    wire fpga_PAD_23;
    wire fpga_PAD_24;
    wire fpga_PAD_25;
    wire fpga_PAD_26;
    wire fpga_PAD_27;
    wire fpga_PAD_28;
    wire fpga_PAD_29;
    wire fpga_PAD_30;
    wire fpga_PAD_31;
    wire fpga_PAD_32;
    wire fpga_PAD_33;
    wire fpga_PAD_34;
    wire fpga_PAD_35;
    wire fpga_PAD_36;
    wire fpga_PAD_37;
    wire fpga_PAD_38;
    wire fpga_PAD_39;
    wire fpga_PAD_40;
    wire fpga_PAD_41;
    wire fpga_PAD_42;
    wire fpga_PAD_43;
    wire fpga_PAD_44;
    wire fpga_PAD_45;
    wire fpga_PAD_46;
    wire fpga_PAD_47;
    
    `ifdef BITSTREAM_FLASH
    
    // SPI Flash - Bitstream
    spiflash_powered i_spiflash_powered (
	    .csb (fpga_cs_n_PAD),
	    .clk (fpga_sclk_PAD),
	    .io0 (fpga_mosi_PAD), // MOSI
	    .io1 (fpga_miso_PAD), // MISO
	    .io2 (  ),
	    .io3 (  )
    );
    
    // Pull down z to 0
    //assign (pull1, pull0) io_fpga_miso_PAD = 1'b0;
    
    `else

    assign fpga_cs_n_PAD = 1'b1;
    assign fpga_sclk_PAD = 1'b0;
    assign fpga_mosi_PAD = 1'b0;

    `endif

    // greyhound instance
    chip_top chip_top (
        `ifdef USE_POWER_PINS
        .VDD,
        .VSS,
        .DVDD,
        .DVSS,
        `endif

        .clk_PAD,
        .rst_n_PAD,
            
        .fpga_mode_PAD,
        .config_busy_PAD,
            
        .fpga_sclk_PAD,
        .fpga_cs_n_PAD,
        .fpga_mosi_PAD,
        .fpga_miso_PAD,

        //.fpga_PAD
        
        .fpga_PAD ({fpga_PAD_47, fpga_PAD_46, fpga_PAD_45, fpga_PAD_44, fpga_PAD_43, fpga_PAD_42, fpga_PAD_41, fpga_PAD_40, fpga_PAD_39, fpga_PAD_38, fpga_PAD_37, fpga_PAD_36, fpga_PAD_35, fpga_PAD_34, fpga_PAD_33, fpga_PAD_32, fpga_PAD_31, fpga_PAD_30, fpga_PAD_29, fpga_PAD_28, fpga_PAD_27, fpga_PAD_26, fpga_PAD_25, fpga_PAD_24, fpga_PAD_23, fpga_PAD_22, fpga_PAD_21, fpga_PAD_20, fpga_PAD_19, fpga_PAD_18, fpga_PAD_17, fpga_PAD_16, fpga_PAD_15, fpga_PAD_14, fpga_PAD_13, fpga_PAD_12, fpga_PAD_11, fpga_PAD_10, fpga_PAD_9, fpga_PAD_8, fpga_PAD_7, fpga_PAD_6, fpga_PAD_5, fpga_PAD_4, fpga_PAD_3, fpga_PAD_2, fpga_PAD_1, fpga_PAD_0})
    );

endmodule

`default_nettype wire
