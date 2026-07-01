module fabric_wrapper #(
    parameter FrameBitsPerRow = 32,
    parameter MaxFramesPerCol = 20,
    
    parameter NumColumns = 9,
    parameter NumRows = 15,
    
    parameter FABRIC_NUM_IO_WEST = 48
)(
    
    // Configuration
    input  logic [(FrameBitsPerRow*NumRows)-1:0]    FrameData_i,
    input  logic [(MaxFramesPerCol*NumColumns)-1:0] FrameStrobe_i,
        
    // Fabric is configured
    input                                configured_i,

    input                                sys_reset_i,

    // I/Os West
    input  [FABRIC_NUM_IO_WEST-1:0]      io_west_in_i,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_out_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_oe_o,
    
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_cs_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_sl_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_pu_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_pd_o,

    // WARMBOOT
    output        fabric_warmboot_boot_o,
    output  [3:0] fabric_warmboot_slot_o

);

    // SRAM 0
    logic [7:0] fabric_sram0_q_i;
    logic [10-1:0] fabric_sram0_a_o;
    logic [7:0] fabric_sram0_wen_o;
    logic [7:0] fabric_sram0_d_o;
    logic        fabric_sram0_gwen_o;
    logic        fabric_sram0_cen_o;
    logic        fabric_sram0_clk_o;

    // SRAM 1
    logic [7:0] fabric_sram1_q_i;
    logic [10-1:0] fabric_sram1_a_o;
    logic [7:0] fabric_sram1_wen_o;
    logic [7:0] fabric_sram1_d_o;
    logic        fabric_sram1_gwen_o;
    logic        fabric_sram1_cen_o;
    logic        fabric_sram1_clk_o;

    // SRAM 2
    logic [7:0] fabric_sram2_q_i;
    logic [10-1:0] fabric_sram2_a_o;
    logic [7:0] fabric_sram2_wen_o;
    logic [7:0] fabric_sram2_d_o;
    logic        fabric_sram2_gwen_o;
    logic        fabric_sram2_cen_o;
    logic        fabric_sram2_clk_o;

    // SRAM 3
    logic [7:0] fabric_sram3_q_i;
    logic [10-1:0] fabric_sram3_a_o;
    logic [7:0] fabric_sram3_wen_o;
    logic [7:0] fabric_sram3_d_o;
    logic        fabric_sram3_gwen_o;
    logic        fabric_sram3_cen_o;
    logic        fabric_sram3_clk_o;

    // SRAM 4
    logic [7:0] fabric_sram4_q_i;
    logic [10-1:0] fabric_sram4_a_o;
    logic [7:0] fabric_sram4_wen_o;
    logic [7:0] fabric_sram4_d_o;
    logic        fabric_sram4_gwen_o;
    logic        fabric_sram4_cen_o;
    logic        fabric_sram4_clk_o;

    // SRAM 5
    logic [7:0] fabric_sram5_q_i;
    logic [10-1:0] fabric_sram5_a_o;
    logic [7:0] fabric_sram5_wen_o;
    logic [7:0] fabric_sram5_d_o;
    logic        fabric_sram5_gwen_o;
    logic        fabric_sram5_cen_o;
    logic        fabric_sram5_clk_o;

    // SRAM 6
    logic [7:0] fabric_sram6_q_i;
    logic [10-1:0] fabric_sram6_a_o;
    logic [7:0] fabric_sram6_wen_o;
    logic [7:0] fabric_sram6_d_o;
    logic        fabric_sram6_gwen_o;
    logic        fabric_sram6_cen_o;
    logic        fabric_sram6_clk_o;

    // SRAM 7
    logic [7:0] fabric_sram7_q_i;
    logic [10-1:0] fabric_sram7_a_o;
    logic [7:0] fabric_sram7_wen_o;
    logic [7:0] fabric_sram7_d_o;
    logic        fabric_sram7_gwen_o;
    logic        fabric_sram7_cen_o;
    logic        fabric_sram7_clk_o;

    // SRAM 8
    logic [7:0] fabric_sram8_q_i;
    logic [10-1:0] fabric_sram8_a_o;
    logic [7:0] fabric_sram8_wen_o;
    logic [7:0] fabric_sram8_d_o;
    logic        fabric_sram8_gwen_o;
    logic        fabric_sram8_cen_o;
    logic        fabric_sram8_clk_o;

    // SRAM 9
    logic [7:0] fabric_sram9_q_i;
    logic [10-1:0] fabric_sram9_a_o;
    logic [7:0] fabric_sram9_wen_o;
    logic [7:0] fabric_sram9_d_o;
    logic        fabric_sram9_gwen_o;
    logic        fabric_sram9_cen_o;
    logic        fabric_sram9_clk_o;

    // SRAM 10
    logic [7:0] fabric_sram10_q_i;
    logic [10-1:0] fabric_sram10_a_o;
    logic [7:0] fabric_sram10_wen_o;
    logic [7:0] fabric_sram10_d_o;
    logic        fabric_sram10_gwen_o;
    logic        fabric_sram10_cen_o;
    logic        fabric_sram10_clk_o;

    // SRAM 11
    logic [7:0] fabric_sram11_q_i;
    logic [10-1:0] fabric_sram11_a_o;
    logic [7:0] fabric_sram11_wen_o;
    logic [7:0] fabric_sram11_d_o;
    logic        fabric_sram11_gwen_o;
    logic        fabric_sram11_cen_o;
    logic        fabric_sram11_clk_o;

    // SRAM 12
    logic [7:0] fabric_sram12_q_i;
    logic [10-1:0] fabric_sram12_a_o;
    logic [7:0] fabric_sram12_wen_o;
    logic [7:0] fabric_sram12_d_o;
    logic        fabric_sram12_gwen_o;
    logic        fabric_sram12_cen_o;
    logic        fabric_sram12_clk_o;

    classic_fabric_wsrun2
    //#(
    //    .MaxFramesPerCol(MaxFramesPerCol),
    //    .FrameBitsPerRow(FrameBitsPerRow)
    //)
    classic_fabric_wsrun2
    (
        .FrameData      (FrameData_i),
        .FrameStrobe    (FrameStrobe_i),

        // West I/Os
        .Tile_X0Y2_A_OUT_top(io_west_in_i[47]),
        .Tile_X0Y2_A_IN_top(io_west_out_o[47]),
        .Tile_X0Y2_A_EN_top(io_west_oe_o[47]),
        .Tile_X0Y2_A_CS_top(io_west_cs_o[47]),
        .Tile_X0Y2_A_SL_top(io_west_sl_o[47]),
        .Tile_X0Y2_A_PU_top(io_west_pu_o[47]),
        .Tile_X0Y2_A_PD_top(io_west_pd_o[47]),

        .Tile_X0Y2_B_OUT_top(io_west_in_i[46]),
        .Tile_X0Y2_B_IN_top(io_west_out_o[46]),
        .Tile_X0Y2_B_EN_top(io_west_oe_o[46]),
        .Tile_X0Y2_B_CS_top(io_west_cs_o[46]),
        .Tile_X0Y2_B_SL_top(io_west_sl_o[46]),
        .Tile_X0Y2_B_PU_top(io_west_pu_o[46]),
        .Tile_X0Y2_B_PD_top(io_west_pd_o[46]),

        .Tile_X0Y2_C_OUT_top(io_west_in_i[45]),
        .Tile_X0Y2_C_IN_top(io_west_out_o[45]),
        .Tile_X0Y2_C_EN_top(io_west_oe_o[45]),
        .Tile_X0Y2_C_CS_top(io_west_cs_o[45]),
        .Tile_X0Y2_C_SL_top(io_west_sl_o[45]),
        .Tile_X0Y2_C_PU_top(io_west_pu_o[45]),
        .Tile_X0Y2_C_PD_top(io_west_pd_o[45]),

        .Tile_X0Y2_D_OUT_top(io_west_in_i[44]),
        .Tile_X0Y2_D_IN_top(io_west_out_o[44]),
        .Tile_X0Y2_D_EN_top(io_west_oe_o[44]),
        .Tile_X0Y2_D_CS_top(io_west_cs_o[44]),
        .Tile_X0Y2_D_SL_top(io_west_sl_o[44]),
        .Tile_X0Y2_D_PU_top(io_west_pu_o[44]),
        .Tile_X0Y2_D_PD_top(io_west_pd_o[44]),

        .Tile_X0Y3_A_OUT_top(io_west_in_i[43]),
        .Tile_X0Y3_A_IN_top(io_west_out_o[43]),
        .Tile_X0Y3_A_EN_top(io_west_oe_o[43]),
        .Tile_X0Y3_A_CS_top(io_west_cs_o[43]),
        .Tile_X0Y3_A_SL_top(io_west_sl_o[43]),
        .Tile_X0Y3_A_PU_top(io_west_pu_o[43]),
        .Tile_X0Y3_A_PD_top(io_west_pd_o[43]),

        .Tile_X0Y3_B_OUT_top(io_west_in_i[42]),
        .Tile_X0Y3_B_IN_top(io_west_out_o[42]),
        .Tile_X0Y3_B_EN_top(io_west_oe_o[42]),
        .Tile_X0Y3_B_CS_top(io_west_cs_o[42]),
        .Tile_X0Y3_B_SL_top(io_west_sl_o[42]),
        .Tile_X0Y3_B_PU_top(io_west_pu_o[42]),
        .Tile_X0Y3_B_PD_top(io_west_pd_o[42]),

        .Tile_X0Y3_C_OUT_top(io_west_in_i[41]),
        .Tile_X0Y3_C_IN_top(io_west_out_o[41]),
        .Tile_X0Y3_C_EN_top(io_west_oe_o[41]),
        .Tile_X0Y3_C_CS_top(io_west_cs_o[41]),
        .Tile_X0Y3_C_SL_top(io_west_sl_o[41]),
        .Tile_X0Y3_C_PU_top(io_west_pu_o[41]),
        .Tile_X0Y3_C_PD_top(io_west_pd_o[41]),

        .Tile_X0Y3_D_OUT_top(io_west_in_i[40]),
        .Tile_X0Y3_D_IN_top(io_west_out_o[40]),
        .Tile_X0Y3_D_EN_top(io_west_oe_o[40]),
        .Tile_X0Y3_D_CS_top(io_west_cs_o[40]),
        .Tile_X0Y3_D_SL_top(io_west_sl_o[40]),
        .Tile_X0Y3_D_PU_top(io_west_pu_o[40]),
        .Tile_X0Y3_D_PD_top(io_west_pd_o[40]),

        .Tile_X0Y4_A_OUT_top(io_west_in_i[39]),
        .Tile_X0Y4_A_IN_top(io_west_out_o[39]),
        .Tile_X0Y4_A_EN_top(io_west_oe_o[39]),
        .Tile_X0Y4_A_CS_top(io_west_cs_o[39]),
        .Tile_X0Y4_A_SL_top(io_west_sl_o[39]),
        .Tile_X0Y4_A_PU_top(io_west_pu_o[39]),
        .Tile_X0Y4_A_PD_top(io_west_pd_o[39]),

        .Tile_X0Y4_B_OUT_top(io_west_in_i[38]),
        .Tile_X0Y4_B_IN_top(io_west_out_o[38]),
        .Tile_X0Y4_B_EN_top(io_west_oe_o[38]),
        .Tile_X0Y4_B_CS_top(io_west_cs_o[38]),
        .Tile_X0Y4_B_SL_top(io_west_sl_o[38]),
        .Tile_X0Y4_B_PU_top(io_west_pu_o[38]),
        .Tile_X0Y4_B_PD_top(io_west_pd_o[38]),

        .Tile_X0Y4_C_OUT_top(io_west_in_i[37]),
        .Tile_X0Y4_C_IN_top(io_west_out_o[37]),
        .Tile_X0Y4_C_EN_top(io_west_oe_o[37]),
        .Tile_X0Y4_C_CS_top(io_west_cs_o[37]),
        .Tile_X0Y4_C_SL_top(io_west_sl_o[37]),
        .Tile_X0Y4_C_PU_top(io_west_pu_o[37]),
        .Tile_X0Y4_C_PD_top(io_west_pd_o[37]),

        .Tile_X0Y4_D_OUT_top(io_west_in_i[36]),
        .Tile_X0Y4_D_IN_top(io_west_out_o[36]),
        .Tile_X0Y4_D_EN_top(io_west_oe_o[36]),
        .Tile_X0Y4_D_CS_top(io_west_cs_o[36]),
        .Tile_X0Y4_D_SL_top(io_west_sl_o[36]),
        .Tile_X0Y4_D_PU_top(io_west_pu_o[36]),
        .Tile_X0Y4_D_PD_top(io_west_pd_o[36]),

        .Tile_X0Y5_A_OUT_top(io_west_in_i[35]),
        .Tile_X0Y5_A_IN_top(io_west_out_o[35]),
        .Tile_X0Y5_A_EN_top(io_west_oe_o[35]),
        .Tile_X0Y5_A_CS_top(io_west_cs_o[35]),
        .Tile_X0Y5_A_SL_top(io_west_sl_o[35]),
        .Tile_X0Y5_A_PU_top(io_west_pu_o[35]),
        .Tile_X0Y5_A_PD_top(io_west_pd_o[35]),

        .Tile_X0Y5_B_OUT_top(io_west_in_i[34]),
        .Tile_X0Y5_B_IN_top(io_west_out_o[34]),
        .Tile_X0Y5_B_EN_top(io_west_oe_o[34]),
        .Tile_X0Y5_B_CS_top(io_west_cs_o[34]),
        .Tile_X0Y5_B_SL_top(io_west_sl_o[34]),
        .Tile_X0Y5_B_PU_top(io_west_pu_o[34]),
        .Tile_X0Y5_B_PD_top(io_west_pd_o[34]),

        .Tile_X0Y5_C_OUT_top(io_west_in_i[33]),
        .Tile_X0Y5_C_IN_top(io_west_out_o[33]),
        .Tile_X0Y5_C_EN_top(io_west_oe_o[33]),
        .Tile_X0Y5_C_CS_top(io_west_cs_o[33]),
        .Tile_X0Y5_C_SL_top(io_west_sl_o[33]),
        .Tile_X0Y5_C_PU_top(io_west_pu_o[33]),
        .Tile_X0Y5_C_PD_top(io_west_pd_o[33]),

        .Tile_X0Y5_D_OUT_top(io_west_in_i[32]),
        .Tile_X0Y5_D_IN_top(io_west_out_o[32]),
        .Tile_X0Y5_D_EN_top(io_west_oe_o[32]),
        .Tile_X0Y5_D_CS_top(io_west_cs_o[32]),
        .Tile_X0Y5_D_SL_top(io_west_sl_o[32]),
        .Tile_X0Y5_D_PU_top(io_west_pu_o[32]),
        .Tile_X0Y5_D_PD_top(io_west_pd_o[32]),

        .Tile_X0Y6_A_OUT_top(io_west_in_i[31]),
        .Tile_X0Y6_A_IN_top(io_west_out_o[31]),
        .Tile_X0Y6_A_EN_top(io_west_oe_o[31]),
        .Tile_X0Y6_A_CS_top(io_west_cs_o[31]),
        .Tile_X0Y6_A_SL_top(io_west_sl_o[31]),
        .Tile_X0Y6_A_PU_top(io_west_pu_o[31]),
        .Tile_X0Y6_A_PD_top(io_west_pd_o[31]),

        .Tile_X0Y6_B_OUT_top(io_west_in_i[30]),
        .Tile_X0Y6_B_IN_top(io_west_out_o[30]),
        .Tile_X0Y6_B_EN_top(io_west_oe_o[30]),
        .Tile_X0Y6_B_CS_top(io_west_cs_o[30]),
        .Tile_X0Y6_B_SL_top(io_west_sl_o[30]),
        .Tile_X0Y6_B_PU_top(io_west_pu_o[30]),
        .Tile_X0Y6_B_PD_top(io_west_pd_o[30]),

        .Tile_X0Y6_C_OUT_top(io_west_in_i[29]),
        .Tile_X0Y6_C_IN_top(io_west_out_o[29]),
        .Tile_X0Y6_C_EN_top(io_west_oe_o[29]),
        .Tile_X0Y6_C_CS_top(io_west_cs_o[29]),
        .Tile_X0Y6_C_SL_top(io_west_sl_o[29]),
        .Tile_X0Y6_C_PU_top(io_west_pu_o[29]),
        .Tile_X0Y6_C_PD_top(io_west_pd_o[29]),

        .Tile_X0Y6_D_OUT_top(io_west_in_i[28]),
        .Tile_X0Y6_D_IN_top(io_west_out_o[28]),
        .Tile_X0Y6_D_EN_top(io_west_oe_o[28]),
        .Tile_X0Y6_D_CS_top(io_west_cs_o[28]),
        .Tile_X0Y6_D_SL_top(io_west_sl_o[28]),
        .Tile_X0Y6_D_PU_top(io_west_pu_o[28]),
        .Tile_X0Y6_D_PD_top(io_west_pd_o[28]),

        .Tile_X0Y7_A_OUT_top(io_west_in_i[27]),
        .Tile_X0Y7_A_IN_top(io_west_out_o[27]),
        .Tile_X0Y7_A_EN_top(io_west_oe_o[27]),
        .Tile_X0Y7_A_CS_top(io_west_cs_o[27]),
        .Tile_X0Y7_A_SL_top(io_west_sl_o[27]),
        .Tile_X0Y7_A_PU_top(io_west_pu_o[27]),
        .Tile_X0Y7_A_PD_top(io_west_pd_o[27]),

        .Tile_X0Y7_B_OUT_top(io_west_in_i[26]),
        .Tile_X0Y7_B_IN_top(io_west_out_o[26]),
        .Tile_X0Y7_B_EN_top(io_west_oe_o[26]),
        .Tile_X0Y7_B_CS_top(io_west_cs_o[26]),
        .Tile_X0Y7_B_SL_top(io_west_sl_o[26]),
        .Tile_X0Y7_B_PU_top(io_west_pu_o[26]),
        .Tile_X0Y7_B_PD_top(io_west_pd_o[26]),

        .Tile_X0Y7_C_OUT_top(io_west_in_i[25]),
        .Tile_X0Y7_C_IN_top(io_west_out_o[25]),
        .Tile_X0Y7_C_EN_top(io_west_oe_o[25]),
        .Tile_X0Y7_C_CS_top(io_west_cs_o[25]),
        .Tile_X0Y7_C_SL_top(io_west_sl_o[25]),
        .Tile_X0Y7_C_PU_top(io_west_pu_o[25]),
        .Tile_X0Y7_C_PD_top(io_west_pd_o[25]),

        .Tile_X0Y7_D_OUT_top(io_west_in_i[24]),
        .Tile_X0Y7_D_IN_top(io_west_out_o[24]),
        .Tile_X0Y7_D_EN_top(io_west_oe_o[24]),
        .Tile_X0Y7_D_CS_top(io_west_cs_o[24]),
        .Tile_X0Y7_D_SL_top(io_west_sl_o[24]),
        .Tile_X0Y7_D_PU_top(io_west_pu_o[24]),
        .Tile_X0Y7_D_PD_top(io_west_pd_o[24]),

        .Tile_X0Y8_A_OUT_top(io_west_in_i[23]),
        .Tile_X0Y8_A_IN_top(io_west_out_o[23]),
        .Tile_X0Y8_A_EN_top(io_west_oe_o[23]),
        .Tile_X0Y8_A_CS_top(io_west_cs_o[23]),
        .Tile_X0Y8_A_SL_top(io_west_sl_o[23]),
        .Tile_X0Y8_A_PU_top(io_west_pu_o[23]),
        .Tile_X0Y8_A_PD_top(io_west_pd_o[23]),

        .Tile_X0Y8_B_OUT_top(io_west_in_i[22]),
        .Tile_X0Y8_B_IN_top(io_west_out_o[22]),
        .Tile_X0Y8_B_EN_top(io_west_oe_o[22]),
        .Tile_X0Y8_B_CS_top(io_west_cs_o[22]),
        .Tile_X0Y8_B_SL_top(io_west_sl_o[22]),
        .Tile_X0Y8_B_PU_top(io_west_pu_o[22]),
        .Tile_X0Y8_B_PD_top(io_west_pd_o[22]),

        .Tile_X0Y8_C_OUT_top(io_west_in_i[21]),
        .Tile_X0Y8_C_IN_top(io_west_out_o[21]),
        .Tile_X0Y8_C_EN_top(io_west_oe_o[21]),
        .Tile_X0Y8_C_CS_top(io_west_cs_o[21]),
        .Tile_X0Y8_C_SL_top(io_west_sl_o[21]),
        .Tile_X0Y8_C_PU_top(io_west_pu_o[21]),
        .Tile_X0Y8_C_PD_top(io_west_pd_o[21]),

        .Tile_X0Y8_D_OUT_top(io_west_in_i[20]),
        .Tile_X0Y8_D_IN_top(io_west_out_o[20]),
        .Tile_X0Y8_D_EN_top(io_west_oe_o[20]),
        .Tile_X0Y8_D_CS_top(io_west_cs_o[20]),
        .Tile_X0Y8_D_SL_top(io_west_sl_o[20]),
        .Tile_X0Y8_D_PU_top(io_west_pu_o[20]),
        .Tile_X0Y8_D_PD_top(io_west_pd_o[20]),

        .Tile_X0Y9_A_OUT_top(io_west_in_i[19]),
        .Tile_X0Y9_A_IN_top(io_west_out_o[19]),
        .Tile_X0Y9_A_EN_top(io_west_oe_o[19]),
        .Tile_X0Y9_A_CS_top(io_west_cs_o[19]),
        .Tile_X0Y9_A_SL_top(io_west_sl_o[19]),
        .Tile_X0Y9_A_PU_top(io_west_pu_o[19]),
        .Tile_X0Y9_A_PD_top(io_west_pd_o[19]),

        .Tile_X0Y9_B_OUT_top(io_west_in_i[18]),
        .Tile_X0Y9_B_IN_top(io_west_out_o[18]),
        .Tile_X0Y9_B_EN_top(io_west_oe_o[18]),
        .Tile_X0Y9_B_CS_top(io_west_cs_o[18]),
        .Tile_X0Y9_B_SL_top(io_west_sl_o[18]),
        .Tile_X0Y9_B_PU_top(io_west_pu_o[18]),
        .Tile_X0Y9_B_PD_top(io_west_pd_o[18]),

        .Tile_X0Y9_C_OUT_top(io_west_in_i[17]),
        .Tile_X0Y9_C_IN_top(io_west_out_o[17]),
        .Tile_X0Y9_C_EN_top(io_west_oe_o[17]),
        .Tile_X0Y9_C_CS_top(io_west_cs_o[17]),
        .Tile_X0Y9_C_SL_top(io_west_sl_o[17]),
        .Tile_X0Y9_C_PU_top(io_west_pu_o[17]),
        .Tile_X0Y9_C_PD_top(io_west_pd_o[17]),

        .Tile_X0Y9_D_OUT_top(io_west_in_i[16]),
        .Tile_X0Y9_D_IN_top(io_west_out_o[16]),
        .Tile_X0Y9_D_EN_top(io_west_oe_o[16]),
        .Tile_X0Y9_D_CS_top(io_west_cs_o[16]),
        .Tile_X0Y9_D_SL_top(io_west_sl_o[16]),
        .Tile_X0Y9_D_PU_top(io_west_pu_o[16]),
        .Tile_X0Y9_D_PD_top(io_west_pd_o[16]),

        .Tile_X0Y10_A_OUT_top(io_west_in_i[15]),
        .Tile_X0Y10_A_IN_top(io_west_out_o[15]),
        .Tile_X0Y10_A_EN_top(io_west_oe_o[15]),
        .Tile_X0Y10_A_CS_top(io_west_cs_o[15]),
        .Tile_X0Y10_A_SL_top(io_west_sl_o[15]),
        .Tile_X0Y10_A_PU_top(io_west_pu_o[15]),
        .Tile_X0Y10_A_PD_top(io_west_pd_o[15]),

        .Tile_X0Y10_B_OUT_top(io_west_in_i[14]),
        .Tile_X0Y10_B_IN_top(io_west_out_o[14]),
        .Tile_X0Y10_B_EN_top(io_west_oe_o[14]),
        .Tile_X0Y10_B_CS_top(io_west_cs_o[14]),
        .Tile_X0Y10_B_SL_top(io_west_sl_o[14]),
        .Tile_X0Y10_B_PU_top(io_west_pu_o[14]),
        .Tile_X0Y10_B_PD_top(io_west_pd_o[14]),

        .Tile_X0Y10_C_OUT_top(io_west_in_i[13]),
        .Tile_X0Y10_C_IN_top(io_west_out_o[13]),
        .Tile_X0Y10_C_EN_top(io_west_oe_o[13]),
        .Tile_X0Y10_C_CS_top(io_west_cs_o[13]),
        .Tile_X0Y10_C_SL_top(io_west_sl_o[13]),
        .Tile_X0Y10_C_PU_top(io_west_pu_o[13]),
        .Tile_X0Y10_C_PD_top(io_west_pd_o[13]),

        .Tile_X0Y10_D_OUT_top(io_west_in_i[12]),
        .Tile_X0Y10_D_IN_top(io_west_out_o[12]),
        .Tile_X0Y10_D_EN_top(io_west_oe_o[12]),
        .Tile_X0Y10_D_CS_top(io_west_cs_o[12]),
        .Tile_X0Y10_D_SL_top(io_west_sl_o[12]),
        .Tile_X0Y10_D_PU_top(io_west_pu_o[12]),
        .Tile_X0Y10_D_PD_top(io_west_pd_o[12]),

        .Tile_X0Y11_A_OUT_top(io_west_in_i[11]),
        .Tile_X0Y11_A_IN_top(io_west_out_o[11]),
        .Tile_X0Y11_A_EN_top(io_west_oe_o[11]),
        .Tile_X0Y11_A_CS_top(io_west_cs_o[11]),
        .Tile_X0Y11_A_SL_top(io_west_sl_o[11]),
        .Tile_X0Y11_A_PU_top(io_west_pu_o[11]),
        .Tile_X0Y11_A_PD_top(io_west_pd_o[11]),

        .Tile_X0Y11_B_OUT_top(io_west_in_i[10]),
        .Tile_X0Y11_B_IN_top(io_west_out_o[10]),
        .Tile_X0Y11_B_EN_top(io_west_oe_o[10]),
        .Tile_X0Y11_B_CS_top(io_west_cs_o[10]),
        .Tile_X0Y11_B_SL_top(io_west_sl_o[10]),
        .Tile_X0Y11_B_PU_top(io_west_pu_o[10]),
        .Tile_X0Y11_B_PD_top(io_west_pd_o[10]),

        .Tile_X0Y11_C_OUT_top(io_west_in_i[9]),
        .Tile_X0Y11_C_IN_top(io_west_out_o[9]),
        .Tile_X0Y11_C_EN_top(io_west_oe_o[9]),
        .Tile_X0Y11_C_CS_top(io_west_cs_o[9]),
        .Tile_X0Y11_C_SL_top(io_west_sl_o[9]),
        .Tile_X0Y11_C_PU_top(io_west_pu_o[9]),
        .Tile_X0Y11_C_PD_top(io_west_pd_o[9]),

        .Tile_X0Y11_D_OUT_top(io_west_in_i[8]),
        .Tile_X0Y11_D_IN_top(io_west_out_o[8]),
        .Tile_X0Y11_D_EN_top(io_west_oe_o[8]),
        .Tile_X0Y11_D_CS_top(io_west_cs_o[8]),
        .Tile_X0Y11_D_SL_top(io_west_sl_o[8]),
        .Tile_X0Y11_D_PU_top(io_west_pu_o[8]),
        .Tile_X0Y11_D_PD_top(io_west_pd_o[8]),

        .Tile_X0Y12_A_OUT_top(io_west_in_i[7]),
        .Tile_X0Y12_A_IN_top(io_west_out_o[7]),
        .Tile_X0Y12_A_EN_top(io_west_oe_o[7]),
        .Tile_X0Y12_A_CS_top(io_west_cs_o[7]),
        .Tile_X0Y12_A_SL_top(io_west_sl_o[7]),
        .Tile_X0Y12_A_PU_top(io_west_pu_o[7]),
        .Tile_X0Y12_A_PD_top(io_west_pd_o[7]),

        .Tile_X0Y12_B_OUT_top(io_west_in_i[6]),
        .Tile_X0Y12_B_IN_top(io_west_out_o[6]),
        .Tile_X0Y12_B_EN_top(io_west_oe_o[6]),
        .Tile_X0Y12_B_CS_top(io_west_cs_o[6]),
        .Tile_X0Y12_B_SL_top(io_west_sl_o[6]),
        .Tile_X0Y12_B_PU_top(io_west_pu_o[6]),
        .Tile_X0Y12_B_PD_top(io_west_pd_o[6]),

        .Tile_X0Y12_C_OUT_top(io_west_in_i[5]),
        .Tile_X0Y12_C_IN_top(io_west_out_o[5]),
        .Tile_X0Y12_C_EN_top(io_west_oe_o[5]),
        .Tile_X0Y12_C_CS_top(io_west_cs_o[5]),
        .Tile_X0Y12_C_SL_top(io_west_sl_o[5]),
        .Tile_X0Y12_C_PU_top(io_west_pu_o[5]),
        .Tile_X0Y12_C_PD_top(io_west_pd_o[5]),

        .Tile_X0Y12_D_OUT_top(io_west_in_i[4]),
        .Tile_X0Y12_D_IN_top(io_west_out_o[4]),
        .Tile_X0Y12_D_EN_top(io_west_oe_o[4]),
        .Tile_X0Y12_D_CS_top(io_west_cs_o[4]),
        .Tile_X0Y12_D_SL_top(io_west_sl_o[4]),
        .Tile_X0Y12_D_PU_top(io_west_pu_o[4]),
        .Tile_X0Y12_D_PD_top(io_west_pd_o[4]),

        .Tile_X0Y13_A_OUT_top(io_west_in_i[3]),
        .Tile_X0Y13_A_IN_top(io_west_out_o[3]),
        .Tile_X0Y13_A_EN_top(io_west_oe_o[3]),
        .Tile_X0Y13_A_CS_top(io_west_cs_o[3]),
        .Tile_X0Y13_A_SL_top(io_west_sl_o[3]),
        .Tile_X0Y13_A_PU_top(io_west_pu_o[3]),
        .Tile_X0Y13_A_PD_top(io_west_pd_o[3]),

        .Tile_X0Y13_B_OUT_top(io_west_in_i[2]),
        .Tile_X0Y13_B_IN_top(io_west_out_o[2]),
        .Tile_X0Y13_B_EN_top(io_west_oe_o[2]),
        .Tile_X0Y13_B_CS_top(io_west_cs_o[2]),
        .Tile_X0Y13_B_SL_top(io_west_sl_o[2]),
        .Tile_X0Y13_B_PU_top(io_west_pu_o[2]),
        .Tile_X0Y13_B_PD_top(io_west_pd_o[2]),

        .Tile_X0Y13_C_OUT_top(io_west_in_i[1]),
        .Tile_X0Y13_C_IN_top(io_west_out_o[1]),
        .Tile_X0Y13_C_EN_top(io_west_oe_o[1]),
        .Tile_X0Y13_C_CS_top(io_west_cs_o[1]),
        .Tile_X0Y13_C_SL_top(io_west_sl_o[1]),
        .Tile_X0Y13_C_PU_top(io_west_pu_o[1]),
        .Tile_X0Y13_C_PD_top(io_west_pd_o[1]),

        .Tile_X0Y13_D_OUT_top(io_west_in_i[0]),
        .Tile_X0Y13_D_IN_top(io_west_out_o[0]),
        .Tile_X0Y13_D_EN_top(io_west_oe_o[0]),
        .Tile_X0Y13_D_CS_top(io_west_cs_o[0]),
        .Tile_X0Y13_D_SL_top(io_west_sl_o[0]),
        .Tile_X0Y13_D_PU_top(io_west_pu_o[0]),
        .Tile_X0Y13_D_PD_top(io_west_pd_o[0]),

        // SYS_RESET
        .Tile_X0Y14_SYS_RESET_RESET_top(sys_reset_i),

        // WARMBOOT
        .Tile_X1Y14_TRIGGER_top(fabric_warmboot_boot_o),
        .Tile_X1Y14_SLOT_top0(fabric_warmboot_slot_o[0]),
        .Tile_X1Y14_SLOT_top1(fabric_warmboot_slot_o[1]),
        .Tile_X1Y14_SLOT_top2(fabric_warmboot_slot_o[2]),
        .Tile_X1Y14_SLOT_top3(fabric_warmboot_slot_o[3]),


        // SRAM 0
        .Tile_X8Y1_Q_SRAM0(fabric_sram0_q_i[0]),
        .Tile_X8Y1_Q_SRAM1(fabric_sram0_q_i[1]),
        .Tile_X8Y1_Q_SRAM2(fabric_sram0_q_i[2]),
        .Tile_X8Y1_Q_SRAM3(fabric_sram0_q_i[3]),
        .Tile_X8Y1_Q_SRAM4(fabric_sram0_q_i[4]),
        .Tile_X8Y1_Q_SRAM5(fabric_sram0_q_i[5]),
        .Tile_X8Y1_Q_SRAM6(fabric_sram0_q_i[6]),
        .Tile_X8Y1_Q_SRAM7(fabric_sram0_q_i[7]),
        .Tile_X8Y1_A_SRAM0(fabric_sram0_a_o[0]),
        .Tile_X8Y1_A_SRAM1(fabric_sram0_a_o[1]),
        .Tile_X8Y1_A_SRAM2(fabric_sram0_a_o[2]),
        .Tile_X8Y1_A_SRAM3(fabric_sram0_a_o[3]),
        .Tile_X8Y1_A_SRAM4(fabric_sram0_a_o[4]),
        .Tile_X8Y1_A_SRAM5(fabric_sram0_a_o[5]),
        .Tile_X8Y1_A_SRAM6(fabric_sram0_a_o[6]),
        .Tile_X8Y1_A_SRAM7(fabric_sram0_a_o[7]),
        .Tile_X8Y1_A_SRAM8(fabric_sram0_a_o[8]),
        .Tile_X8Y1_A_SRAM9(fabric_sram0_a_o[9]),
        .Tile_X8Y1_WEN_SRAM0(fabric_sram0_wen_o[0]),
        .Tile_X8Y1_WEN_SRAM1(fabric_sram0_wen_o[1]),
        .Tile_X8Y1_WEN_SRAM2(fabric_sram0_wen_o[2]),
        .Tile_X8Y1_WEN_SRAM3(fabric_sram0_wen_o[3]),
        .Tile_X8Y1_WEN_SRAM4(fabric_sram0_wen_o[4]),
        .Tile_X8Y1_WEN_SRAM5(fabric_sram0_wen_o[5]),
        .Tile_X8Y1_WEN_SRAM6(fabric_sram0_wen_o[6]),
        .Tile_X8Y1_WEN_SRAM7(fabric_sram0_wen_o[7]),
        .Tile_X8Y1_D_SRAM0(fabric_sram0_d_o[0]),
        .Tile_X8Y1_D_SRAM1(fabric_sram0_d_o[1]),
        .Tile_X8Y1_D_SRAM2(fabric_sram0_d_o[2]),
        .Tile_X8Y1_D_SRAM3(fabric_sram0_d_o[3]),
        .Tile_X8Y1_D_SRAM4(fabric_sram0_d_o[4]),
        .Tile_X8Y1_D_SRAM5(fabric_sram0_d_o[5]),
        .Tile_X8Y1_D_SRAM6(fabric_sram0_d_o[6]),
        .Tile_X8Y1_D_SRAM7(fabric_sram0_d_o[7]),
        .Tile_X8Y1_GWEN_SRAM(fabric_sram0_gwen_o),
        .Tile_X8Y1_CEN_SRAM(fabric_sram0_cen_o),
        .Tile_X8Y1_CLK_SRAM(fabric_sram0_clk_o),
        .Tile_X8Y1_CONFIGURED_top(configured_i),

        // SRAM 1
        .Tile_X8Y2_Q_SRAM0(fabric_sram1_q_i[0]),
        .Tile_X8Y2_Q_SRAM1(fabric_sram1_q_i[1]),
        .Tile_X8Y2_Q_SRAM2(fabric_sram1_q_i[2]),
        .Tile_X8Y2_Q_SRAM3(fabric_sram1_q_i[3]),
        .Tile_X8Y2_Q_SRAM4(fabric_sram1_q_i[4]),
        .Tile_X8Y2_Q_SRAM5(fabric_sram1_q_i[5]),
        .Tile_X8Y2_Q_SRAM6(fabric_sram1_q_i[6]),
        .Tile_X8Y2_Q_SRAM7(fabric_sram1_q_i[7]),
        .Tile_X8Y2_A_SRAM0(fabric_sram1_a_o[0]),
        .Tile_X8Y2_A_SRAM1(fabric_sram1_a_o[1]),
        .Tile_X8Y2_A_SRAM2(fabric_sram1_a_o[2]),
        .Tile_X8Y2_A_SRAM3(fabric_sram1_a_o[3]),
        .Tile_X8Y2_A_SRAM4(fabric_sram1_a_o[4]),
        .Tile_X8Y2_A_SRAM5(fabric_sram1_a_o[5]),
        .Tile_X8Y2_A_SRAM6(fabric_sram1_a_o[6]),
        .Tile_X8Y2_A_SRAM7(fabric_sram1_a_o[7]),
        .Tile_X8Y2_A_SRAM8(fabric_sram1_a_o[8]),
        .Tile_X8Y2_A_SRAM9(fabric_sram1_a_o[9]),
        .Tile_X8Y2_WEN_SRAM0(fabric_sram1_wen_o[0]),
        .Tile_X8Y2_WEN_SRAM1(fabric_sram1_wen_o[1]),
        .Tile_X8Y2_WEN_SRAM2(fabric_sram1_wen_o[2]),
        .Tile_X8Y2_WEN_SRAM3(fabric_sram1_wen_o[3]),
        .Tile_X8Y2_WEN_SRAM4(fabric_sram1_wen_o[4]),
        .Tile_X8Y2_WEN_SRAM5(fabric_sram1_wen_o[5]),
        .Tile_X8Y2_WEN_SRAM6(fabric_sram1_wen_o[6]),
        .Tile_X8Y2_WEN_SRAM7(fabric_sram1_wen_o[7]),
        .Tile_X8Y2_D_SRAM0(fabric_sram1_d_o[0]),
        .Tile_X8Y2_D_SRAM1(fabric_sram1_d_o[1]),
        .Tile_X8Y2_D_SRAM2(fabric_sram1_d_o[2]),
        .Tile_X8Y2_D_SRAM3(fabric_sram1_d_o[3]),
        .Tile_X8Y2_D_SRAM4(fabric_sram1_d_o[4]),
        .Tile_X8Y2_D_SRAM5(fabric_sram1_d_o[5]),
        .Tile_X8Y2_D_SRAM6(fabric_sram1_d_o[6]),
        .Tile_X8Y2_D_SRAM7(fabric_sram1_d_o[7]),
        .Tile_X8Y2_GWEN_SRAM(fabric_sram1_gwen_o),
        .Tile_X8Y2_CEN_SRAM(fabric_sram1_cen_o),
        .Tile_X8Y2_CLK_SRAM(fabric_sram1_clk_o),
        .Tile_X8Y2_CONFIGURED_top(configured_i),

        // SRAM 2
        .Tile_X8Y3_Q_SRAM0(fabric_sram2_q_i[0]),
        .Tile_X8Y3_Q_SRAM1(fabric_sram2_q_i[1]),
        .Tile_X8Y3_Q_SRAM2(fabric_sram2_q_i[2]),
        .Tile_X8Y3_Q_SRAM3(fabric_sram2_q_i[3]),
        .Tile_X8Y3_Q_SRAM4(fabric_sram2_q_i[4]),
        .Tile_X8Y3_Q_SRAM5(fabric_sram2_q_i[5]),
        .Tile_X8Y3_Q_SRAM6(fabric_sram2_q_i[6]),
        .Tile_X8Y3_Q_SRAM7(fabric_sram2_q_i[7]),
        .Tile_X8Y3_A_SRAM0(fabric_sram2_a_o[0]),
        .Tile_X8Y3_A_SRAM1(fabric_sram2_a_o[1]),
        .Tile_X8Y3_A_SRAM2(fabric_sram2_a_o[2]),
        .Tile_X8Y3_A_SRAM3(fabric_sram2_a_o[3]),
        .Tile_X8Y3_A_SRAM4(fabric_sram2_a_o[4]),
        .Tile_X8Y3_A_SRAM5(fabric_sram2_a_o[5]),
        .Tile_X8Y3_A_SRAM6(fabric_sram2_a_o[6]),
        .Tile_X8Y3_A_SRAM7(fabric_sram2_a_o[7]),
        .Tile_X8Y3_A_SRAM8(fabric_sram2_a_o[8]),
        .Tile_X8Y3_A_SRAM9(fabric_sram2_a_o[9]),
        .Tile_X8Y3_WEN_SRAM0(fabric_sram2_wen_o[0]),
        .Tile_X8Y3_WEN_SRAM1(fabric_sram2_wen_o[1]),
        .Tile_X8Y3_WEN_SRAM2(fabric_sram2_wen_o[2]),
        .Tile_X8Y3_WEN_SRAM3(fabric_sram2_wen_o[3]),
        .Tile_X8Y3_WEN_SRAM4(fabric_sram2_wen_o[4]),
        .Tile_X8Y3_WEN_SRAM5(fabric_sram2_wen_o[5]),
        .Tile_X8Y3_WEN_SRAM6(fabric_sram2_wen_o[6]),
        .Tile_X8Y3_WEN_SRAM7(fabric_sram2_wen_o[7]),
        .Tile_X8Y3_D_SRAM0(fabric_sram2_d_o[0]),
        .Tile_X8Y3_D_SRAM1(fabric_sram2_d_o[1]),
        .Tile_X8Y3_D_SRAM2(fabric_sram2_d_o[2]),
        .Tile_X8Y3_D_SRAM3(fabric_sram2_d_o[3]),
        .Tile_X8Y3_D_SRAM4(fabric_sram2_d_o[4]),
        .Tile_X8Y3_D_SRAM5(fabric_sram2_d_o[5]),
        .Tile_X8Y3_D_SRAM6(fabric_sram2_d_o[6]),
        .Tile_X8Y3_D_SRAM7(fabric_sram2_d_o[7]),
        .Tile_X8Y3_GWEN_SRAM(fabric_sram2_gwen_o),
        .Tile_X8Y3_CEN_SRAM(fabric_sram2_cen_o),
        .Tile_X8Y3_CLK_SRAM(fabric_sram2_clk_o),
        .Tile_X8Y3_CONFIGURED_top(configured_i),

        // SRAM 3
        .Tile_X8Y4_Q_SRAM0(fabric_sram3_q_i[0]),
        .Tile_X8Y4_Q_SRAM1(fabric_sram3_q_i[1]),
        .Tile_X8Y4_Q_SRAM2(fabric_sram3_q_i[2]),
        .Tile_X8Y4_Q_SRAM3(fabric_sram3_q_i[3]),
        .Tile_X8Y4_Q_SRAM4(fabric_sram3_q_i[4]),
        .Tile_X8Y4_Q_SRAM5(fabric_sram3_q_i[5]),
        .Tile_X8Y4_Q_SRAM6(fabric_sram3_q_i[6]),
        .Tile_X8Y4_Q_SRAM7(fabric_sram3_q_i[7]),
        .Tile_X8Y4_A_SRAM0(fabric_sram3_a_o[0]),
        .Tile_X8Y4_A_SRAM1(fabric_sram3_a_o[1]),
        .Tile_X8Y4_A_SRAM2(fabric_sram3_a_o[2]),
        .Tile_X8Y4_A_SRAM3(fabric_sram3_a_o[3]),
        .Tile_X8Y4_A_SRAM4(fabric_sram3_a_o[4]),
        .Tile_X8Y4_A_SRAM5(fabric_sram3_a_o[5]),
        .Tile_X8Y4_A_SRAM6(fabric_sram3_a_o[6]),
        .Tile_X8Y4_A_SRAM7(fabric_sram3_a_o[7]),
        .Tile_X8Y4_A_SRAM8(fabric_sram3_a_o[8]),
        .Tile_X8Y4_A_SRAM9(fabric_sram3_a_o[9]),
        .Tile_X8Y4_WEN_SRAM0(fabric_sram3_wen_o[0]),
        .Tile_X8Y4_WEN_SRAM1(fabric_sram3_wen_o[1]),
        .Tile_X8Y4_WEN_SRAM2(fabric_sram3_wen_o[2]),
        .Tile_X8Y4_WEN_SRAM3(fabric_sram3_wen_o[3]),
        .Tile_X8Y4_WEN_SRAM4(fabric_sram3_wen_o[4]),
        .Tile_X8Y4_WEN_SRAM5(fabric_sram3_wen_o[5]),
        .Tile_X8Y4_WEN_SRAM6(fabric_sram3_wen_o[6]),
        .Tile_X8Y4_WEN_SRAM7(fabric_sram3_wen_o[7]),
        .Tile_X8Y4_D_SRAM0(fabric_sram3_d_o[0]),
        .Tile_X8Y4_D_SRAM1(fabric_sram3_d_o[1]),
        .Tile_X8Y4_D_SRAM2(fabric_sram3_d_o[2]),
        .Tile_X8Y4_D_SRAM3(fabric_sram3_d_o[3]),
        .Tile_X8Y4_D_SRAM4(fabric_sram3_d_o[4]),
        .Tile_X8Y4_D_SRAM5(fabric_sram3_d_o[5]),
        .Tile_X8Y4_D_SRAM6(fabric_sram3_d_o[6]),
        .Tile_X8Y4_D_SRAM7(fabric_sram3_d_o[7]),
        .Tile_X8Y4_GWEN_SRAM(fabric_sram3_gwen_o),
        .Tile_X8Y4_CEN_SRAM(fabric_sram3_cen_o),
        .Tile_X8Y4_CLK_SRAM(fabric_sram3_clk_o),
        .Tile_X8Y4_CONFIGURED_top(configured_i),

        // SRAM 4
        .Tile_X8Y5_Q_SRAM0(fabric_sram4_q_i[0]),
        .Tile_X8Y5_Q_SRAM1(fabric_sram4_q_i[1]),
        .Tile_X8Y5_Q_SRAM2(fabric_sram4_q_i[2]),
        .Tile_X8Y5_Q_SRAM3(fabric_sram4_q_i[3]),
        .Tile_X8Y5_Q_SRAM4(fabric_sram4_q_i[4]),
        .Tile_X8Y5_Q_SRAM5(fabric_sram4_q_i[5]),
        .Tile_X8Y5_Q_SRAM6(fabric_sram4_q_i[6]),
        .Tile_X8Y5_Q_SRAM7(fabric_sram4_q_i[7]),
        .Tile_X8Y5_A_SRAM0(fabric_sram4_a_o[0]),
        .Tile_X8Y5_A_SRAM1(fabric_sram4_a_o[1]),
        .Tile_X8Y5_A_SRAM2(fabric_sram4_a_o[2]),
        .Tile_X8Y5_A_SRAM3(fabric_sram4_a_o[3]),
        .Tile_X8Y5_A_SRAM4(fabric_sram4_a_o[4]),
        .Tile_X8Y5_A_SRAM5(fabric_sram4_a_o[5]),
        .Tile_X8Y5_A_SRAM6(fabric_sram4_a_o[6]),
        .Tile_X8Y5_A_SRAM7(fabric_sram4_a_o[7]),
        .Tile_X8Y5_A_SRAM8(fabric_sram4_a_o[8]),
        .Tile_X8Y5_A_SRAM9(fabric_sram4_a_o[9]),
        .Tile_X8Y5_WEN_SRAM0(fabric_sram4_wen_o[0]),
        .Tile_X8Y5_WEN_SRAM1(fabric_sram4_wen_o[1]),
        .Tile_X8Y5_WEN_SRAM2(fabric_sram4_wen_o[2]),
        .Tile_X8Y5_WEN_SRAM3(fabric_sram4_wen_o[3]),
        .Tile_X8Y5_WEN_SRAM4(fabric_sram4_wen_o[4]),
        .Tile_X8Y5_WEN_SRAM5(fabric_sram4_wen_o[5]),
        .Tile_X8Y5_WEN_SRAM6(fabric_sram4_wen_o[6]),
        .Tile_X8Y5_WEN_SRAM7(fabric_sram4_wen_o[7]),
        .Tile_X8Y5_D_SRAM0(fabric_sram4_d_o[0]),
        .Tile_X8Y5_D_SRAM1(fabric_sram4_d_o[1]),
        .Tile_X8Y5_D_SRAM2(fabric_sram4_d_o[2]),
        .Tile_X8Y5_D_SRAM3(fabric_sram4_d_o[3]),
        .Tile_X8Y5_D_SRAM4(fabric_sram4_d_o[4]),
        .Tile_X8Y5_D_SRAM5(fabric_sram4_d_o[5]),
        .Tile_X8Y5_D_SRAM6(fabric_sram4_d_o[6]),
        .Tile_X8Y5_D_SRAM7(fabric_sram4_d_o[7]),
        .Tile_X8Y5_GWEN_SRAM(fabric_sram4_gwen_o),
        .Tile_X8Y5_CEN_SRAM(fabric_sram4_cen_o),
        .Tile_X8Y5_CLK_SRAM(fabric_sram4_clk_o),
        .Tile_X8Y5_CONFIGURED_top(configured_i),

        // SRAM 5
        .Tile_X8Y6_Q_SRAM0(fabric_sram5_q_i[0]),
        .Tile_X8Y6_Q_SRAM1(fabric_sram5_q_i[1]),
        .Tile_X8Y6_Q_SRAM2(fabric_sram5_q_i[2]),
        .Tile_X8Y6_Q_SRAM3(fabric_sram5_q_i[3]),
        .Tile_X8Y6_Q_SRAM4(fabric_sram5_q_i[4]),
        .Tile_X8Y6_Q_SRAM5(fabric_sram5_q_i[5]),
        .Tile_X8Y6_Q_SRAM6(fabric_sram5_q_i[6]),
        .Tile_X8Y6_Q_SRAM7(fabric_sram5_q_i[7]),
        .Tile_X8Y6_A_SRAM0(fabric_sram5_a_o[0]),
        .Tile_X8Y6_A_SRAM1(fabric_sram5_a_o[1]),
        .Tile_X8Y6_A_SRAM2(fabric_sram5_a_o[2]),
        .Tile_X8Y6_A_SRAM3(fabric_sram5_a_o[3]),
        .Tile_X8Y6_A_SRAM4(fabric_sram5_a_o[4]),
        .Tile_X8Y6_A_SRAM5(fabric_sram5_a_o[5]),
        .Tile_X8Y6_A_SRAM6(fabric_sram5_a_o[6]),
        .Tile_X8Y6_A_SRAM7(fabric_sram5_a_o[7]),
        .Tile_X8Y6_A_SRAM8(fabric_sram5_a_o[8]),
        .Tile_X8Y6_A_SRAM9(fabric_sram5_a_o[9]),
        .Tile_X8Y6_WEN_SRAM0(fabric_sram5_wen_o[0]),
        .Tile_X8Y6_WEN_SRAM1(fabric_sram5_wen_o[1]),
        .Tile_X8Y6_WEN_SRAM2(fabric_sram5_wen_o[2]),
        .Tile_X8Y6_WEN_SRAM3(fabric_sram5_wen_o[3]),
        .Tile_X8Y6_WEN_SRAM4(fabric_sram5_wen_o[4]),
        .Tile_X8Y6_WEN_SRAM5(fabric_sram5_wen_o[5]),
        .Tile_X8Y6_WEN_SRAM6(fabric_sram5_wen_o[6]),
        .Tile_X8Y6_WEN_SRAM7(fabric_sram5_wen_o[7]),
        .Tile_X8Y6_D_SRAM0(fabric_sram5_d_o[0]),
        .Tile_X8Y6_D_SRAM1(fabric_sram5_d_o[1]),
        .Tile_X8Y6_D_SRAM2(fabric_sram5_d_o[2]),
        .Tile_X8Y6_D_SRAM3(fabric_sram5_d_o[3]),
        .Tile_X8Y6_D_SRAM4(fabric_sram5_d_o[4]),
        .Tile_X8Y6_D_SRAM5(fabric_sram5_d_o[5]),
        .Tile_X8Y6_D_SRAM6(fabric_sram5_d_o[6]),
        .Tile_X8Y6_D_SRAM7(fabric_sram5_d_o[7]),
        .Tile_X8Y6_GWEN_SRAM(fabric_sram5_gwen_o),
        .Tile_X8Y6_CEN_SRAM(fabric_sram5_cen_o),
        .Tile_X8Y6_CLK_SRAM(fabric_sram5_clk_o),
        .Tile_X8Y6_CONFIGURED_top(configured_i),

        // SRAM 6
        .Tile_X8Y7_Q_SRAM0(fabric_sram6_q_i[0]),
        .Tile_X8Y7_Q_SRAM1(fabric_sram6_q_i[1]),
        .Tile_X8Y7_Q_SRAM2(fabric_sram6_q_i[2]),
        .Tile_X8Y7_Q_SRAM3(fabric_sram6_q_i[3]),
        .Tile_X8Y7_Q_SRAM4(fabric_sram6_q_i[4]),
        .Tile_X8Y7_Q_SRAM5(fabric_sram6_q_i[5]),
        .Tile_X8Y7_Q_SRAM6(fabric_sram6_q_i[6]),
        .Tile_X8Y7_Q_SRAM7(fabric_sram6_q_i[7]),
        .Tile_X8Y7_A_SRAM0(fabric_sram6_a_o[0]),
        .Tile_X8Y7_A_SRAM1(fabric_sram6_a_o[1]),
        .Tile_X8Y7_A_SRAM2(fabric_sram6_a_o[2]),
        .Tile_X8Y7_A_SRAM3(fabric_sram6_a_o[3]),
        .Tile_X8Y7_A_SRAM4(fabric_sram6_a_o[4]),
        .Tile_X8Y7_A_SRAM5(fabric_sram6_a_o[5]),
        .Tile_X8Y7_A_SRAM6(fabric_sram6_a_o[6]),
        .Tile_X8Y7_A_SRAM7(fabric_sram6_a_o[7]),
        .Tile_X8Y7_A_SRAM8(fabric_sram6_a_o[8]),
        .Tile_X8Y7_A_SRAM9(fabric_sram6_a_o[9]),
        .Tile_X8Y7_WEN_SRAM0(fabric_sram6_wen_o[0]),
        .Tile_X8Y7_WEN_SRAM1(fabric_sram6_wen_o[1]),
        .Tile_X8Y7_WEN_SRAM2(fabric_sram6_wen_o[2]),
        .Tile_X8Y7_WEN_SRAM3(fabric_sram6_wen_o[3]),
        .Tile_X8Y7_WEN_SRAM4(fabric_sram6_wen_o[4]),
        .Tile_X8Y7_WEN_SRAM5(fabric_sram6_wen_o[5]),
        .Tile_X8Y7_WEN_SRAM6(fabric_sram6_wen_o[6]),
        .Tile_X8Y7_WEN_SRAM7(fabric_sram6_wen_o[7]),
        .Tile_X8Y7_D_SRAM0(fabric_sram6_d_o[0]),
        .Tile_X8Y7_D_SRAM1(fabric_sram6_d_o[1]),
        .Tile_X8Y7_D_SRAM2(fabric_sram6_d_o[2]),
        .Tile_X8Y7_D_SRAM3(fabric_sram6_d_o[3]),
        .Tile_X8Y7_D_SRAM4(fabric_sram6_d_o[4]),
        .Tile_X8Y7_D_SRAM5(fabric_sram6_d_o[5]),
        .Tile_X8Y7_D_SRAM6(fabric_sram6_d_o[6]),
        .Tile_X8Y7_D_SRAM7(fabric_sram6_d_o[7]),
        .Tile_X8Y7_GWEN_SRAM(fabric_sram6_gwen_o),
        .Tile_X8Y7_CEN_SRAM(fabric_sram6_cen_o),
        .Tile_X8Y7_CLK_SRAM(fabric_sram6_clk_o),
        .Tile_X8Y7_CONFIGURED_top(configured_i),

        // SRAM 7
        .Tile_X8Y8_Q_SRAM0(fabric_sram7_q_i[0]),
        .Tile_X8Y8_Q_SRAM1(fabric_sram7_q_i[1]),
        .Tile_X8Y8_Q_SRAM2(fabric_sram7_q_i[2]),
        .Tile_X8Y8_Q_SRAM3(fabric_sram7_q_i[3]),
        .Tile_X8Y8_Q_SRAM4(fabric_sram7_q_i[4]),
        .Tile_X8Y8_Q_SRAM5(fabric_sram7_q_i[5]),
        .Tile_X8Y8_Q_SRAM6(fabric_sram7_q_i[6]),
        .Tile_X8Y8_Q_SRAM7(fabric_sram7_q_i[7]),
        .Tile_X8Y8_A_SRAM0(fabric_sram7_a_o[0]),
        .Tile_X8Y8_A_SRAM1(fabric_sram7_a_o[1]),
        .Tile_X8Y8_A_SRAM2(fabric_sram7_a_o[2]),
        .Tile_X8Y8_A_SRAM3(fabric_sram7_a_o[3]),
        .Tile_X8Y8_A_SRAM4(fabric_sram7_a_o[4]),
        .Tile_X8Y8_A_SRAM5(fabric_sram7_a_o[5]),
        .Tile_X8Y8_A_SRAM6(fabric_sram7_a_o[6]),
        .Tile_X8Y8_A_SRAM7(fabric_sram7_a_o[7]),
        .Tile_X8Y8_A_SRAM8(fabric_sram7_a_o[8]),
        .Tile_X8Y8_A_SRAM9(fabric_sram7_a_o[9]),
        .Tile_X8Y8_WEN_SRAM0(fabric_sram7_wen_o[0]),
        .Tile_X8Y8_WEN_SRAM1(fabric_sram7_wen_o[1]),
        .Tile_X8Y8_WEN_SRAM2(fabric_sram7_wen_o[2]),
        .Tile_X8Y8_WEN_SRAM3(fabric_sram7_wen_o[3]),
        .Tile_X8Y8_WEN_SRAM4(fabric_sram7_wen_o[4]),
        .Tile_X8Y8_WEN_SRAM5(fabric_sram7_wen_o[5]),
        .Tile_X8Y8_WEN_SRAM6(fabric_sram7_wen_o[6]),
        .Tile_X8Y8_WEN_SRAM7(fabric_sram7_wen_o[7]),
        .Tile_X8Y8_D_SRAM0(fabric_sram7_d_o[0]),
        .Tile_X8Y8_D_SRAM1(fabric_sram7_d_o[1]),
        .Tile_X8Y8_D_SRAM2(fabric_sram7_d_o[2]),
        .Tile_X8Y8_D_SRAM3(fabric_sram7_d_o[3]),
        .Tile_X8Y8_D_SRAM4(fabric_sram7_d_o[4]),
        .Tile_X8Y8_D_SRAM5(fabric_sram7_d_o[5]),
        .Tile_X8Y8_D_SRAM6(fabric_sram7_d_o[6]),
        .Tile_X8Y8_D_SRAM7(fabric_sram7_d_o[7]),
        .Tile_X8Y8_GWEN_SRAM(fabric_sram7_gwen_o),
        .Tile_X8Y8_CEN_SRAM(fabric_sram7_cen_o),
        .Tile_X8Y8_CLK_SRAM(fabric_sram7_clk_o),
        .Tile_X8Y8_CONFIGURED_top(configured_i),

        // SRAM 8
        .Tile_X8Y9_Q_SRAM0(fabric_sram8_q_i[0]),
        .Tile_X8Y9_Q_SRAM1(fabric_sram8_q_i[1]),
        .Tile_X8Y9_Q_SRAM2(fabric_sram8_q_i[2]),
        .Tile_X8Y9_Q_SRAM3(fabric_sram8_q_i[3]),
        .Tile_X8Y9_Q_SRAM4(fabric_sram8_q_i[4]),
        .Tile_X8Y9_Q_SRAM5(fabric_sram8_q_i[5]),
        .Tile_X8Y9_Q_SRAM6(fabric_sram8_q_i[6]),
        .Tile_X8Y9_Q_SRAM7(fabric_sram8_q_i[7]),
        .Tile_X8Y9_A_SRAM0(fabric_sram8_a_o[0]),
        .Tile_X8Y9_A_SRAM1(fabric_sram8_a_o[1]),
        .Tile_X8Y9_A_SRAM2(fabric_sram8_a_o[2]),
        .Tile_X8Y9_A_SRAM3(fabric_sram8_a_o[3]),
        .Tile_X8Y9_A_SRAM4(fabric_sram8_a_o[4]),
        .Tile_X8Y9_A_SRAM5(fabric_sram8_a_o[5]),
        .Tile_X8Y9_A_SRAM6(fabric_sram8_a_o[6]),
        .Tile_X8Y9_A_SRAM7(fabric_sram8_a_o[7]),
        .Tile_X8Y9_A_SRAM8(fabric_sram8_a_o[8]),
        .Tile_X8Y9_A_SRAM9(fabric_sram8_a_o[9]),
        .Tile_X8Y9_WEN_SRAM0(fabric_sram8_wen_o[0]),
        .Tile_X8Y9_WEN_SRAM1(fabric_sram8_wen_o[1]),
        .Tile_X8Y9_WEN_SRAM2(fabric_sram8_wen_o[2]),
        .Tile_X8Y9_WEN_SRAM3(fabric_sram8_wen_o[3]),
        .Tile_X8Y9_WEN_SRAM4(fabric_sram8_wen_o[4]),
        .Tile_X8Y9_WEN_SRAM5(fabric_sram8_wen_o[5]),
        .Tile_X8Y9_WEN_SRAM6(fabric_sram8_wen_o[6]),
        .Tile_X8Y9_WEN_SRAM7(fabric_sram8_wen_o[7]),
        .Tile_X8Y9_D_SRAM0(fabric_sram8_d_o[0]),
        .Tile_X8Y9_D_SRAM1(fabric_sram8_d_o[1]),
        .Tile_X8Y9_D_SRAM2(fabric_sram8_d_o[2]),
        .Tile_X8Y9_D_SRAM3(fabric_sram8_d_o[3]),
        .Tile_X8Y9_D_SRAM4(fabric_sram8_d_o[4]),
        .Tile_X8Y9_D_SRAM5(fabric_sram8_d_o[5]),
        .Tile_X8Y9_D_SRAM6(fabric_sram8_d_o[6]),
        .Tile_X8Y9_D_SRAM7(fabric_sram8_d_o[7]),
        .Tile_X8Y9_GWEN_SRAM(fabric_sram8_gwen_o),
        .Tile_X8Y9_CEN_SRAM(fabric_sram8_cen_o),
        .Tile_X8Y9_CLK_SRAM(fabric_sram8_clk_o),
        .Tile_X8Y9_CONFIGURED_top(configured_i),

        // SRAM 9
        .Tile_X8Y10_Q_SRAM0(fabric_sram9_q_i[0]),
        .Tile_X8Y10_Q_SRAM1(fabric_sram9_q_i[1]),
        .Tile_X8Y10_Q_SRAM2(fabric_sram9_q_i[2]),
        .Tile_X8Y10_Q_SRAM3(fabric_sram9_q_i[3]),
        .Tile_X8Y10_Q_SRAM4(fabric_sram9_q_i[4]),
        .Tile_X8Y10_Q_SRAM5(fabric_sram9_q_i[5]),
        .Tile_X8Y10_Q_SRAM6(fabric_sram9_q_i[6]),
        .Tile_X8Y10_Q_SRAM7(fabric_sram9_q_i[7]),
        .Tile_X8Y10_A_SRAM0(fabric_sram9_a_o[0]),
        .Tile_X8Y10_A_SRAM1(fabric_sram9_a_o[1]),
        .Tile_X8Y10_A_SRAM2(fabric_sram9_a_o[2]),
        .Tile_X8Y10_A_SRAM3(fabric_sram9_a_o[3]),
        .Tile_X8Y10_A_SRAM4(fabric_sram9_a_o[4]),
        .Tile_X8Y10_A_SRAM5(fabric_sram9_a_o[5]),
        .Tile_X8Y10_A_SRAM6(fabric_sram9_a_o[6]),
        .Tile_X8Y10_A_SRAM7(fabric_sram9_a_o[7]),
        .Tile_X8Y10_A_SRAM8(fabric_sram9_a_o[8]),
        .Tile_X8Y10_A_SRAM9(fabric_sram9_a_o[9]),
        .Tile_X8Y10_WEN_SRAM0(fabric_sram9_wen_o[0]),
        .Tile_X8Y10_WEN_SRAM1(fabric_sram9_wen_o[1]),
        .Tile_X8Y10_WEN_SRAM2(fabric_sram9_wen_o[2]),
        .Tile_X8Y10_WEN_SRAM3(fabric_sram9_wen_o[3]),
        .Tile_X8Y10_WEN_SRAM4(fabric_sram9_wen_o[4]),
        .Tile_X8Y10_WEN_SRAM5(fabric_sram9_wen_o[5]),
        .Tile_X8Y10_WEN_SRAM6(fabric_sram9_wen_o[6]),
        .Tile_X8Y10_WEN_SRAM7(fabric_sram9_wen_o[7]),
        .Tile_X8Y10_D_SRAM0(fabric_sram9_d_o[0]),
        .Tile_X8Y10_D_SRAM1(fabric_sram9_d_o[1]),
        .Tile_X8Y10_D_SRAM2(fabric_sram9_d_o[2]),
        .Tile_X8Y10_D_SRAM3(fabric_sram9_d_o[3]),
        .Tile_X8Y10_D_SRAM4(fabric_sram9_d_o[4]),
        .Tile_X8Y10_D_SRAM5(fabric_sram9_d_o[5]),
        .Tile_X8Y10_D_SRAM6(fabric_sram9_d_o[6]),
        .Tile_X8Y10_D_SRAM7(fabric_sram9_d_o[7]),
        .Tile_X8Y10_GWEN_SRAM(fabric_sram9_gwen_o),
        .Tile_X8Y10_CEN_SRAM(fabric_sram9_cen_o),
        .Tile_X8Y10_CLK_SRAM(fabric_sram9_clk_o),
        .Tile_X8Y10_CONFIGURED_top(configured_i),

        // SRAM 10
        .Tile_X8Y11_Q_SRAM0(fabric_sram10_q_i[0]),
        .Tile_X8Y11_Q_SRAM1(fabric_sram10_q_i[1]),
        .Tile_X8Y11_Q_SRAM2(fabric_sram10_q_i[2]),
        .Tile_X8Y11_Q_SRAM3(fabric_sram10_q_i[3]),
        .Tile_X8Y11_Q_SRAM4(fabric_sram10_q_i[4]),
        .Tile_X8Y11_Q_SRAM5(fabric_sram10_q_i[5]),
        .Tile_X8Y11_Q_SRAM6(fabric_sram10_q_i[6]),
        .Tile_X8Y11_Q_SRAM7(fabric_sram10_q_i[7]),
        .Tile_X8Y11_A_SRAM0(fabric_sram10_a_o[0]),
        .Tile_X8Y11_A_SRAM1(fabric_sram10_a_o[1]),
        .Tile_X8Y11_A_SRAM2(fabric_sram10_a_o[2]),
        .Tile_X8Y11_A_SRAM3(fabric_sram10_a_o[3]),
        .Tile_X8Y11_A_SRAM4(fabric_sram10_a_o[4]),
        .Tile_X8Y11_A_SRAM5(fabric_sram10_a_o[5]),
        .Tile_X8Y11_A_SRAM6(fabric_sram10_a_o[6]),
        .Tile_X8Y11_A_SRAM7(fabric_sram10_a_o[7]),
        .Tile_X8Y11_A_SRAM8(fabric_sram10_a_o[8]),
        .Tile_X8Y11_A_SRAM9(fabric_sram10_a_o[9]),
        .Tile_X8Y11_WEN_SRAM0(fabric_sram10_wen_o[0]),
        .Tile_X8Y11_WEN_SRAM1(fabric_sram10_wen_o[1]),
        .Tile_X8Y11_WEN_SRAM2(fabric_sram10_wen_o[2]),
        .Tile_X8Y11_WEN_SRAM3(fabric_sram10_wen_o[3]),
        .Tile_X8Y11_WEN_SRAM4(fabric_sram10_wen_o[4]),
        .Tile_X8Y11_WEN_SRAM5(fabric_sram10_wen_o[5]),
        .Tile_X8Y11_WEN_SRAM6(fabric_sram10_wen_o[6]),
        .Tile_X8Y11_WEN_SRAM7(fabric_sram10_wen_o[7]),
        .Tile_X8Y11_D_SRAM0(fabric_sram10_d_o[0]),
        .Tile_X8Y11_D_SRAM1(fabric_sram10_d_o[1]),
        .Tile_X8Y11_D_SRAM2(fabric_sram10_d_o[2]),
        .Tile_X8Y11_D_SRAM3(fabric_sram10_d_o[3]),
        .Tile_X8Y11_D_SRAM4(fabric_sram10_d_o[4]),
        .Tile_X8Y11_D_SRAM5(fabric_sram10_d_o[5]),
        .Tile_X8Y11_D_SRAM6(fabric_sram10_d_o[6]),
        .Tile_X8Y11_D_SRAM7(fabric_sram10_d_o[7]),
        .Tile_X8Y11_GWEN_SRAM(fabric_sram10_gwen_o),
        .Tile_X8Y11_CEN_SRAM(fabric_sram10_cen_o),
        .Tile_X8Y11_CLK_SRAM(fabric_sram10_clk_o),
        .Tile_X8Y11_CONFIGURED_top(configured_i),

        // SRAM 11
        .Tile_X8Y12_Q_SRAM0(fabric_sram11_q_i[0]),
        .Tile_X8Y12_Q_SRAM1(fabric_sram11_q_i[1]),
        .Tile_X8Y12_Q_SRAM2(fabric_sram11_q_i[2]),
        .Tile_X8Y12_Q_SRAM3(fabric_sram11_q_i[3]),
        .Tile_X8Y12_Q_SRAM4(fabric_sram11_q_i[4]),
        .Tile_X8Y12_Q_SRAM5(fabric_sram11_q_i[5]),
        .Tile_X8Y12_Q_SRAM6(fabric_sram11_q_i[6]),
        .Tile_X8Y12_Q_SRAM7(fabric_sram11_q_i[7]),
        .Tile_X8Y12_A_SRAM0(fabric_sram11_a_o[0]),
        .Tile_X8Y12_A_SRAM1(fabric_sram11_a_o[1]),
        .Tile_X8Y12_A_SRAM2(fabric_sram11_a_o[2]),
        .Tile_X8Y12_A_SRAM3(fabric_sram11_a_o[3]),
        .Tile_X8Y12_A_SRAM4(fabric_sram11_a_o[4]),
        .Tile_X8Y12_A_SRAM5(fabric_sram11_a_o[5]),
        .Tile_X8Y12_A_SRAM6(fabric_sram11_a_o[6]),
        .Tile_X8Y12_A_SRAM7(fabric_sram11_a_o[7]),
        .Tile_X8Y12_A_SRAM8(fabric_sram11_a_o[8]),
        .Tile_X8Y12_A_SRAM9(fabric_sram11_a_o[9]),
        .Tile_X8Y12_WEN_SRAM0(fabric_sram11_wen_o[0]),
        .Tile_X8Y12_WEN_SRAM1(fabric_sram11_wen_o[1]),
        .Tile_X8Y12_WEN_SRAM2(fabric_sram11_wen_o[2]),
        .Tile_X8Y12_WEN_SRAM3(fabric_sram11_wen_o[3]),
        .Tile_X8Y12_WEN_SRAM4(fabric_sram11_wen_o[4]),
        .Tile_X8Y12_WEN_SRAM5(fabric_sram11_wen_o[5]),
        .Tile_X8Y12_WEN_SRAM6(fabric_sram11_wen_o[6]),
        .Tile_X8Y12_WEN_SRAM7(fabric_sram11_wen_o[7]),
        .Tile_X8Y12_D_SRAM0(fabric_sram11_d_o[0]),
        .Tile_X8Y12_D_SRAM1(fabric_sram11_d_o[1]),
        .Tile_X8Y12_D_SRAM2(fabric_sram11_d_o[2]),
        .Tile_X8Y12_D_SRAM3(fabric_sram11_d_o[3]),
        .Tile_X8Y12_D_SRAM4(fabric_sram11_d_o[4]),
        .Tile_X8Y12_D_SRAM5(fabric_sram11_d_o[5]),
        .Tile_X8Y12_D_SRAM6(fabric_sram11_d_o[6]),
        .Tile_X8Y12_D_SRAM7(fabric_sram11_d_o[7]),
        .Tile_X8Y12_GWEN_SRAM(fabric_sram11_gwen_o),
        .Tile_X8Y12_CEN_SRAM(fabric_sram11_cen_o),
        .Tile_X8Y12_CLK_SRAM(fabric_sram11_clk_o),
        .Tile_X8Y12_CONFIGURED_top(configured_i),

        // SRAM 12
        .Tile_X8Y13_Q_SRAM0(fabric_sram12_q_i[0]),
        .Tile_X8Y13_Q_SRAM1(fabric_sram12_q_i[1]),
        .Tile_X8Y13_Q_SRAM2(fabric_sram12_q_i[2]),
        .Tile_X8Y13_Q_SRAM3(fabric_sram12_q_i[3]),
        .Tile_X8Y13_Q_SRAM4(fabric_sram12_q_i[4]),
        .Tile_X8Y13_Q_SRAM5(fabric_sram12_q_i[5]),
        .Tile_X8Y13_Q_SRAM6(fabric_sram12_q_i[6]),
        .Tile_X8Y13_Q_SRAM7(fabric_sram12_q_i[7]),
        .Tile_X8Y13_A_SRAM0(fabric_sram12_a_o[0]),
        .Tile_X8Y13_A_SRAM1(fabric_sram12_a_o[1]),
        .Tile_X8Y13_A_SRAM2(fabric_sram12_a_o[2]),
        .Tile_X8Y13_A_SRAM3(fabric_sram12_a_o[3]),
        .Tile_X8Y13_A_SRAM4(fabric_sram12_a_o[4]),
        .Tile_X8Y13_A_SRAM5(fabric_sram12_a_o[5]),
        .Tile_X8Y13_A_SRAM6(fabric_sram12_a_o[6]),
        .Tile_X8Y13_A_SRAM7(fabric_sram12_a_o[7]),
        .Tile_X8Y13_A_SRAM8(fabric_sram12_a_o[8]),
        .Tile_X8Y13_A_SRAM9(fabric_sram12_a_o[9]),
        .Tile_X8Y13_WEN_SRAM0(fabric_sram12_wen_o[0]),
        .Tile_X8Y13_WEN_SRAM1(fabric_sram12_wen_o[1]),
        .Tile_X8Y13_WEN_SRAM2(fabric_sram12_wen_o[2]),
        .Tile_X8Y13_WEN_SRAM3(fabric_sram12_wen_o[3]),
        .Tile_X8Y13_WEN_SRAM4(fabric_sram12_wen_o[4]),
        .Tile_X8Y13_WEN_SRAM5(fabric_sram12_wen_o[5]),
        .Tile_X8Y13_WEN_SRAM6(fabric_sram12_wen_o[6]),
        .Tile_X8Y13_WEN_SRAM7(fabric_sram12_wen_o[7]),
        .Tile_X8Y13_D_SRAM0(fabric_sram12_d_o[0]),
        .Tile_X8Y13_D_SRAM1(fabric_sram12_d_o[1]),
        .Tile_X8Y13_D_SRAM2(fabric_sram12_d_o[2]),
        .Tile_X8Y13_D_SRAM3(fabric_sram12_d_o[3]),
        .Tile_X8Y13_D_SRAM4(fabric_sram12_d_o[4]),
        .Tile_X8Y13_D_SRAM5(fabric_sram12_d_o[5]),
        .Tile_X8Y13_D_SRAM6(fabric_sram12_d_o[6]),
        .Tile_X8Y13_D_SRAM7(fabric_sram12_d_o[7]),
        .Tile_X8Y13_GWEN_SRAM(fabric_sram12_gwen_o),
        .Tile_X8Y13_CEN_SRAM(fabric_sram12_cen_o),
        .Tile_X8Y13_CLK_SRAM(fabric_sram12_clk_o),
        .Tile_X8Y13_CONFIGURED_top(configured_i)

    );

    // SRAM 0 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_0 (
      .CLK      (fabric_sram0_clk_o),
      .CEN      (fabric_sram0_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram0_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram0_wen_o),   //Write Enable, negative
      .A        (fabric_sram0_a_o),
      .D        (fabric_sram0_d_o),
      .Q        (fabric_sram0_q_i)
    );
        
    // SRAM 1 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_1 (
      .CLK      (fabric_sram1_clk_o),
      .CEN      (fabric_sram1_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram1_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram1_wen_o),   //Write Enable, negative
      .A        (fabric_sram1_a_o),
      .D        (fabric_sram1_d_o),
      .Q        (fabric_sram1_q_i)
    );
        
    // SRAM 2 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_2 (
      .CLK      (fabric_sram2_clk_o),
      .CEN      (fabric_sram2_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram2_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram2_wen_o),   //Write Enable, negative
      .A        (fabric_sram2_a_o),
      .D        (fabric_sram2_d_o),
      .Q        (fabric_sram2_q_i)
    );
        
    // SRAM 3 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_3 (
      .CLK      (fabric_sram3_clk_o),
      .CEN      (fabric_sram3_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram3_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram3_wen_o),   //Write Enable, negative
      .A        (fabric_sram3_a_o),
      .D        (fabric_sram3_d_o),
      .Q        (fabric_sram3_q_i)
    );
        
    // SRAM 4 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_4 (
      .CLK      (fabric_sram4_clk_o),
      .CEN      (fabric_sram4_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram4_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram4_wen_o),   //Write Enable, negative
      .A        (fabric_sram4_a_o),
      .D        (fabric_sram4_d_o),
      .Q        (fabric_sram4_q_i)
    );
        
    // SRAM 5 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_5 (
      .CLK      (fabric_sram5_clk_o),
      .CEN      (fabric_sram5_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram5_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram5_wen_o),   //Write Enable, negative
      .A        (fabric_sram5_a_o),
      .D        (fabric_sram5_d_o),
      .Q        (fabric_sram5_q_i)
    );
        
    // SRAM 6 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_6 (
      .CLK      (fabric_sram6_clk_o),
      .CEN      (fabric_sram6_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram6_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram6_wen_o),   //Write Enable, negative
      .A        (fabric_sram6_a_o),
      .D        (fabric_sram6_d_o),
      .Q        (fabric_sram6_q_i)
    );
        
    // SRAM 7 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_7 (
      .CLK      (fabric_sram7_clk_o),
      .CEN      (fabric_sram7_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram7_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram7_wen_o),   //Write Enable, negative
      .A        (fabric_sram7_a_o),
      .D        (fabric_sram7_d_o),
      .Q        (fabric_sram7_q_i)
    );
        
    // SRAM 8 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_8 (
      .CLK      (fabric_sram8_clk_o),
      .CEN      (fabric_sram8_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram8_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram8_wen_o),   //Write Enable, negative
      .A        (fabric_sram8_a_o),
      .D        (fabric_sram8_d_o),
      .Q        (fabric_sram8_q_i)
    );
        
    // SRAM 9 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_9 (
      .CLK      (fabric_sram9_clk_o),
      .CEN      (fabric_sram9_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram9_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram9_wen_o),   //Write Enable, negative
      .A        (fabric_sram9_a_o),
      .D        (fabric_sram9_d_o),
      .Q        (fabric_sram9_q_i)
    );
        
    // SRAM 10 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_10 (
      .CLK      (fabric_sram10_clk_o),
      .CEN      (fabric_sram10_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram10_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram10_wen_o),   //Write Enable, negative
      .A        (fabric_sram10_a_o),
      .D        (fabric_sram10_d_o),
      .Q        (fabric_sram10_q_i)
    );
        
    // SRAM 11 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_11 (
      .CLK      (fabric_sram11_clk_o),
      .CEN      (fabric_sram11_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram11_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram11_wen_o),   //Write Enable, negative
      .A        (fabric_sram11_a_o),
      .D        (fabric_sram11_d_o),
      .Q        (fabric_sram11_q_i)
    );
        
    // SRAM 12 instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_12 (
      .CLK      (fabric_sram12_clk_o),
      .CEN      (fabric_sram12_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram12_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram12_wen_o),   //Write Enable, negative
      .A        (fabric_sram12_a_o),
      .D        (fabric_sram12_d_o),
      .Q        (fabric_sram12_q_i)
    );
        
endmodule
