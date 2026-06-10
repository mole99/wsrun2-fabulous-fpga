// SPDX-FileCopyrightText: © 2025 Project Template Contributors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`include "generated_defines.svh"
`include "slot_defines.svh"

`ifdef SRAM_gf180mcu_ocd_ip_sram
`define gf180mcu_xxx_ip_sram__sram512x8m8wm1 gf180mcu_ocd_ip_sram__sram512x8m8wm1
`else
`define gf180mcu_xxx_ip_sram__sram512x8m8wm1 gf180mcu_fd_ip_sram__sram512x8m8wm1
`endif

`ifdef PAD_gf180mcu_ocd_io
`define gf180mcu_xxx_io__vdd gf180mcu_ocd_io__vdd
`define gf180mcu_xxx_io__vss gf180mcu_ocd_io__vss
`define gf180mcu_xxx_io__dvdd gf180mcu_ocd_io__dvdd
`define gf180mcu_xxx_io__dvss gf180mcu_ocd_io__dvss
`define gf180mcu_xxx_io__in_s gf180mcu_ocd_io__in_s
`define gf180mcu_xxx_io__in_c gf180mcu_ocd_io__in_c
`define gf180mcu_xxx_io__bi_24t gf180mcu_ocd_io__bi_24t
`define gf180mcu_xxx_io__asig_5p0 gf180mcu_ocd_io__asig_5p0
`else
`define gf180mcu_xxx_io__vdd gf180mcu_fd_io__dvdd
`define gf180mcu_xxx_io__vss gf180mcu_fd_io__dvss
`define gf180mcu_xxx_io__dvdd gf180mcu_fd_io__dvdd
`define gf180mcu_xxx_io__dvss gf180mcu_fd_io__dvss
`define gf180mcu_xxx_io__in_s gf180mcu_fd_io__in_s
`define gf180mcu_xxx_io__in_c gf180mcu_fd_io__in_c
`define gf180mcu_xxx_io__bi_24t gf180mcu_fd_io__bi_24t
`define gf180mcu_xxx_io__asig_5p0 gf180mcu_fd_io__asig_5p0
`endif

module chip_top #(
    // Power/ground pads for I/O
    parameter NUM_DVDD_PADS = `NUM_DVDD_PADS,
    parameter NUM_DVSS_PADS = `NUM_DVSS_PADS,

    // Power/ground pads for core
    parameter NUM_VDD_PADS = `NUM_VDD_PADS,
    parameter NUM_VSS_PADS = `NUM_VSS_PADS,

    // Signal pads
    parameter NUM_FPGA_PADS = `NUM_FPGA_PADS
    )(
    `ifdef USE_POWER_PINS
    inout  wire VDD,
    inout  wire VSS,
    inout  wire DVDD,
    inout  wire DVSS,
    `endif

    inout  wire clk_PAD,
    inout  wire rst_n_PAD,
    
    inout  wire fpga_mode_PAD,
    inout  wire config_busy_PAD,
    
    inout  wire fpga_sclk_PAD,
    inout  wire fpga_cs_n_PAD,
    inout  wire fpga_mosi_PAD,
    inout  wire fpga_miso_PAD,

    inout  wire [NUM_FPGA_PADS-1:0] fpga_PAD
);

    wire clk_PAD2CORE;
    wire rst_n_PAD2CORE;
    
    wire fpga_mode_PAD2CORE;
    wire config_busy_CORE2PAD;
    
    wire fpga_sclk_PAD2CORE;
    wire fpga_sclk_CORE2PAD;
    wire fpga_sclk_CORE2PAD_OE;
    
    wire fpga_cs_n_PAD2CORE;
    wire fpga_cs_n_CORE2PAD;
    wire fpga_cs_n_CORE2PAD_OE;
    
    wire fpga_mosi_PAD2CORE;
    wire fpga_mosi_CORE2PAD;
    wire fpga_mosi_CORE2PAD_OE;
    
    wire fpga_miso_PAD2CORE;
    wire fpga_miso_CORE2PAD;
    wire fpga_miso_CORE2PAD_OE;

    wire [NUM_FPGA_PADS-1:0] fpga_PAD2CORE;
    wire [NUM_FPGA_PADS-1:0] fpga_CORE2PAD;
    wire [NUM_FPGA_PADS-1:0] fpga_CORE2PAD_OE;
    wire [NUM_FPGA_PADS-1:0] fpga_CORE2PAD_CS;
    wire [NUM_FPGA_PADS-1:0] fpga_CORE2PAD_SL;
    wire [NUM_FPGA_PADS-1:0] fpga_CORE2PAD_IE;
    wire [NUM_FPGA_PADS-1:0] fpga_CORE2PAD_PU;
    wire [NUM_FPGA_PADS-1:0] fpga_CORE2PAD_PD;

    // In the foundry pads, the I/O and
    // core voltage domains are shorted
    `ifdef USE_POWER_PINS
    `ifdef PAD_gf180mcu_fd_io
    assign VDD = DVDD;
    assign VSS = DVSS;
    `endif
    `endif

    // Power/ground pad instances
    generate
    for (genvar i=0; i<NUM_DVDD_PADS; i++) begin : dvdd_pads
        (* keep *)
        `gf180mcu_xxx_io__dvdd pad (
            `ifdef USE_POWER_PINS
            .DVDD   (DVDD),
            .DVSS   (DVSS),
            .VDD    (VDD),
            .VSS    (VSS)
            `endif
        );
    end
    for (genvar i=0; i<NUM_DVSS_PADS; i++) begin : dvss_pads
        (* keep *)
        `gf180mcu_xxx_io__dvss pad (
            `ifdef USE_POWER_PINS
            .DVDD   (DVDD),
            .DVSS   (DVSS),
            .VDD    (VDD),
            .VSS    (VSS)
            `endif
        );
    end
    for (genvar i=0; i<NUM_VDD_PADS; i++) begin : vdd_pads
        (* keep *)
        `gf180mcu_xxx_io__vdd pad (
            `ifdef USE_POWER_PINS
            .DVDD   (DVDD),
            .DVSS   (DVSS),
            .VDD    (VDD),
            .VSS    (VSS)
            `endif
        );
    end
    for (genvar i=0; i<NUM_VSS_PADS; i++) begin : vss_pads
        (* keep *)
        `gf180mcu_xxx_io__vss pad (
            `ifdef USE_POWER_PINS
            .DVDD   (DVDD),
            .DVSS   (DVSS),
            .VDD    (VDD),
            .VSS    (VSS)
            `endif
        );
    end
    endgenerate

    // Signal IO pad instances

    // Schmitt trigger
    `gf180mcu_xxx_io__in_s clk_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (DVDD),
        .DVSS   (DVSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (clk_PAD2CORE),
        .PAD    (clk_PAD),
        
        .PU     (1'b0),
        .PD     (1'b0)
    );
    
    // Normal input
    `gf180mcu_xxx_io__in_c rst_n_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (DVDD),
        .DVSS   (DVSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (rst_n_PAD2CORE),
        .PAD    (rst_n_PAD),
        
        .PU     (1'b0),
        .PD     (1'b0)
    );

    // Normal input
    `gf180mcu_xxx_io__in_c fpga_mode_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (DVDD),
        .DVSS   (DVSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .Y      (fpga_mode_PAD2CORE),
        .PAD    (fpga_mode_PAD),
        
        .PU     (1'b0),
        .PD     (1'b0)
    );

    `gf180mcu_xxx_io__bi_24t config_busy_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (DVDD),
        .DVSS   (DVSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .A      (config_busy_CORE2PAD),
        .OE     (1'b1),
        .Y      (  ),
        .PAD    (config_busy_PAD),
        
        .CS     (1'b0),
        .SL     (1'b0),
        .IE     (1'b0),

        .PU     (1'b0),
        .PD     (1'b0)
    );

    `gf180mcu_xxx_io__bi_24t fpga_sclk_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (DVDD),
        .DVSS   (DVSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .A      (fpga_sclk_CORE2PAD),
        .OE     (fpga_sclk_CORE2PAD_OE),
        .Y      (fpga_sclk_PAD2CORE),
        .PAD    (fpga_sclk_PAD),
        
        .CS     (1'b0),
        .SL     (1'b0),
        .IE     (!fpga_sclk_CORE2PAD_OE),

        .PU     (1'b0),
        .PD     (1'b0)
    );

    `gf180mcu_xxx_io__bi_24t fpga_cs_n_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (DVDD),
        .DVSS   (DVSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .A      (fpga_cs_n_CORE2PAD),
        .OE     (fpga_cs_n_CORE2PAD_OE),
        .Y      (fpga_cs_n_PAD2CORE),
        .PAD    (fpga_cs_n_PAD),
        
        .CS     (1'b0),
        .SL     (1'b0),
        .IE     (!fpga_cs_n_CORE2PAD_OE),

        .PU     (1'b0),
        .PD     (1'b0)
    );

    `gf180mcu_xxx_io__bi_24t fpga_mosi_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (DVDD),
        .DVSS   (DVSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .A      (fpga_mosi_CORE2PAD),
        .OE     (fpga_mosi_CORE2PAD_OE),
        .Y      (fpga_mosi_PAD2CORE),
        .PAD    (fpga_mosi_PAD),
        
        .CS     (1'b0),
        .SL     (1'b0),
        .IE     (!fpga_mosi_CORE2PAD_OE),

        .PU     (1'b0),
        .PD     (1'b0)
    );

    `gf180mcu_xxx_io__bi_24t fpga_miso_pad (
        `ifdef USE_POWER_PINS
        .DVDD   (DVDD),
        .DVSS   (DVSS),
        .VDD    (VDD),
        .VSS    (VSS),
        `endif
    
        .A      (fpga_miso_CORE2PAD),
        .OE     (fpga_miso_CORE2PAD_OE),
        .Y      (fpga_miso_PAD2CORE),
        .PAD    (fpga_miso_PAD),
        
        .CS     (1'b0),
        .SL     (1'b0),
        .IE     (!fpga_miso_CORE2PAD_OE),

        .PU     (1'b0),
        .PD     (1'b0)
    );

    generate
    for (genvar i=0; i<NUM_FPGA_PADS; i++) begin : fpga
        (* keep *)
        `gf180mcu_xxx_io__bi_24t pad (
            `ifdef USE_POWER_PINS
            .DVDD   (DVDD),
            .DVSS   (DVSS),
            .VDD    (VDD),
            .VSS    (VSS),
            `endif
        
            .A      (fpga_CORE2PAD[i]),
            .OE     (fpga_CORE2PAD_OE[i]),
            .Y      (fpga_PAD2CORE[i]),
            .PAD    (fpga_PAD[i]),
            
            .CS     (fpga_CORE2PAD_CS[i]),
            .SL     (fpga_CORE2PAD_SL[i]),
            .IE     (fpga_CORE2PAD_IE[i]),

            .PU     (fpga_CORE2PAD_PU[i]),
            .PD     (fpga_CORE2PAD_PD[i])
        );
    end
    endgenerate

    // Core design

    chip_core #(
        .NUM_FPGA_PADS   (NUM_FPGA_PADS)
    ) i_chip_core (
        `ifdef USE_POWER_PINS
        .VDD        (VDD),
        .VSS        (VSS),
        `endif
    
        .clk        (clk_PAD2CORE),
        .rst_n      (rst_n_PAD2CORE),
        
        .fpga_mode_i    (fpga_mode_PAD2CORE),
        .config_busy_o  (config_busy_CORE2PAD),

        .fpga_sclk_i    (fpga_sclk_PAD2CORE),
        .fpga_sclk_o    (fpga_sclk_CORE2PAD),
        .fpga_sclk_oe_o (fpga_sclk_CORE2PAD_OE),
            
        .fpga_cs_n_i    (fpga_cs_n_PAD2CORE),
        .fpga_cs_n_o    (fpga_cs_n_CORE2PAD),
        .fpga_cs_n_oe_o (fpga_cs_n_CORE2PAD_OE),
            
        .fpga_mosi_i    (fpga_mosi_PAD2CORE),
        .fpga_mosi_o    (fpga_mosi_CORE2PAD),
        .fpga_mosi_oe_o (fpga_mosi_CORE2PAD_OE),
            
        .fpga_miso_i    (fpga_miso_PAD2CORE),
        .fpga_miso_o    (fpga_miso_CORE2PAD),
        .fpga_miso_oe_o (fpga_miso_CORE2PAD_OE),

        .fpga_in   (fpga_PAD2CORE),
        .fpga_out  (fpga_CORE2PAD),
        .fpga_oe   (fpga_CORE2PAD_OE),
        .fpga_cs   (fpga_CORE2PAD_CS),
        .fpga_sl   (fpga_CORE2PAD_SL),
        .fpga_ie   (fpga_CORE2PAD_IE),
        .fpga_pu   (fpga_CORE2PAD_PU),
        .fpga_pd   (fpga_CORE2PAD_PD)
    );
    
    // Do not remove, necessary for tapeout
    (* keep *) gf180mcu_ws_ip__qrcode_id qrcode_id ();
    (* keep *) gf180mcu_ws_ip__shuttle_id shuttle_id ();
    (* keep *) gf180mcu_ws_ip__project_id project_id ();
    (* keep *) gf180mcu_ws_ip__marker marker ();
    
    // wafer.space logo - can be removed if desired
    (* keep *) gf180mcu_ws_ip__logo wafer_space_logo ();

    (* keep *) gf180mcu_ws_ip__credits credits ();

endmodule

`default_nettype wire
