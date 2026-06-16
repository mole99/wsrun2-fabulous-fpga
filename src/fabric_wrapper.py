from contextlib import redirect_stdout

FABRIC_NAME = "classic_fabric_wsrun2"

COLUMNS = 9
ROWS = 14

FABRIC_NUM_IO_WEST = 48
BELS_PER_IO_TILE = ['A', 'B', 'C', 'D']
NUM_SRAM = 6
SRAM_WIDTH = 8
SRAM_ADDR_BITS = 10
EFUSE_LOC = ["X2Y13", "X6Y13"]

with open('fabric_wrapper.sv', 'w') as f:
    with redirect_stdout(f):
        
        print(f"""module fabric_wrapper #(
    parameter FrameBitsPerRow = 32,
    parameter MaxFramesPerCol = 20,
    
    parameter NumColumns = {COLUMNS},
    parameter NumRows = {ROWS},
    
    parameter FABRIC_NUM_IO_WEST = {FABRIC_NUM_IO_WEST}
)(
    
    // Configuration
    input  logic [(FrameBitsPerRow*NumRows)-1:0]    FrameData_i,
    input  logic [(MaxFramesPerCol*NumColumns)-1:0] FrameStrobe_i,
        """)

        print(f'    // Fabric is configured')
        print("""    input                                configured_i,\n""")
        print("""    input                                sys_reset_i,\n""")

        print(f'    // Power on reset')
        print("""    input                                npor_i,\n""")

        # I/Os
        print(f'    // I/Os West')
        print("""    input  [FABRIC_NUM_IO_WEST-1:0]      io_west_in_i,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_out_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_oe_o,
    
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_cs_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_sl_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_pu_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_pd_o,\n""")

        # WARMBOOT
        print(f'    // WARMBOOT')
        print("""    output        fabric_warmboot_boot_o,""")
        print("""    output  [3:0] fabric_warmboot_slot_o\n""")
        
        print(");\n")

        # SRAM
        for i in range(NUM_SRAM):
            print(f'    // SRAM {i}')
            print(f"""    logic [{SRAM_WIDTH-1}:0] fabric_sram{i}_q_i;
    logic [{SRAM_ADDR_BITS}-1:0] fabric_sram{i}_a_o;
    logic [{SRAM_WIDTH-1}:0] fabric_sram{i}_wen_o;
    logic [{SRAM_WIDTH-1}:0] fabric_sram{i}_d_o;
    logic        fabric_sram{i}_gwen_o;
    logic        fabric_sram{i}_cen_o;
    logic        fabric_sram{i}_clk_o;\n""")

        # eFuses
        for i in range(len(EFUSE_LOC)):
            print(f'    // eFuse {i}')
            print(f"""    logic fabric_efuse{i}_clk_o;
    logic fabric_efuse{i}_rst_o;
    logic fabric_efuse{i}_spi_clk_o;
    logic fabric_efuse{i}_spi_csn_o;
    logic fabric_efuse{i}_spi_miso_i;
    logic fabric_efuse{i}_spi_mosi_o;\n""")

        print(f"""    {FABRIC_NAME}
    //#(
    //    .MaxFramesPerCol(MaxFramesPerCol),
    //    .FrameBitsPerRow(FrameBitsPerRow)
    //)
    {FABRIC_NAME}
    (
        .FrameData      (FrameData_i),
        .FrameStrobe    (FrameStrobe_i),
""")

        # I/Os
        print(f"""        // West I/Os""")
        num_bels = len(BELS_PER_IO_TILE)
        IO_WEST_OFFSET = 1
        for i in range(IO_WEST_OFFSET,(FABRIC_NUM_IO_WEST//num_bels)+1):
            for j, bel in enumerate(BELS_PER_IO_TILE):
                print(f"""        .Tile_X0Y{i}_{bel}_OUT_top(io_west_in_i[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_IN_top(io_west_out_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_EN_top(io_west_oe_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_CS_top(io_west_cs_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_SL_top(io_west_sl_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_PU_top(io_west_pu_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),
        .Tile_X0Y{i}_{bel}_PD_top(io_west_pd_o[{FABRIC_NUM_IO_WEST-1-((i-IO_WEST_OFFSET)*num_bels+j)}]),\n""")

        # SYS_RESET
        print(f"""        // SYS_RESET""")
        print(f"""        .Tile_X0Y{ROWS-1}_SYS_RESET_RESET_top(sys_reset_i),\n""")

        # WARMBOOT
        warmboot_coords = f'X1Y{ROWS-1}'
        print('        // WARMBOOT')
        print(f"""        .Tile_{warmboot_coords}_TRIGGER_top(fabric_warmboot_boot_o),
        .Tile_{warmboot_coords}_SLOT_top0(fabric_warmboot_slot_o[0]),
        .Tile_{warmboot_coords}_SLOT_top1(fabric_warmboot_slot_o[1]),
        .Tile_{warmboot_coords}_SLOT_top2(fabric_warmboot_slot_o[2]),
        .Tile_{warmboot_coords}_SLOT_top3(fabric_warmboot_slot_o[3]),\n""")

        # SRAM
        sram_coords = f'X{COLUMNS-1}'
        sram_y_start = 2
        for i in range(NUM_SRAM):
            print(f'        // SRAM {i}')
            for j in range(SRAM_WIDTH):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_Q_SRAM{j}(fabric_sram{i}_q_i[{j}]),')
            for j in range(SRAM_ADDR_BITS):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_A_SRAM{j}(fabric_sram{i}_a_o[{j}]),')
            for j in range(SRAM_WIDTH):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_WEN_SRAM{j}(fabric_sram{i}_wen_o[{j}]),')
            for j in range(SRAM_WIDTH):
                print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_D_SRAM{j}(fabric_sram{i}_d_o[{j}]),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_GWEN_SRAM(fabric_sram{i}_gwen_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_CEN_SRAM(fabric_sram{i}_cen_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_CLK_SRAM(fabric_sram{i}_clk_o),')
            print(f'        .Tile_{sram_coords}Y{sram_y_start+i*2}_CONFIGURED_top(configured_i),')

        for i, loc in enumerate(EFUSE_LOC):
            print(f'        // eFuse {i}')
            print(f'        .Tile_{loc}_EFUSE_A_CLK_top(fabric_efuse{i}_clk_o),')
            print(f'        .Tile_{loc}_EFUSE_A_RST_top(fabric_efuse{i}_rst_o),')
            print(f'        .Tile_{loc}_EFUSE_A_SPI_CLK_top(fabric_efuse{i}_spi_clk_o),')
            print(f'        .Tile_{loc}_EFUSE_A_SPI_CSN_top(fabric_efuse{i}_spi_csn_o),')
            print(f'        .Tile_{loc}_EFUSE_A_SPI_MISO_top(fabric_efuse{i}_spi_miso_i),')
            print(f'        .Tile_{loc}_EFUSE_A_SPI_MOSI_top(fabric_efuse{i}_spi_mosi_o),')
            
            if (i==len(EFUSE_LOC)-1):
                print(f'        .Tile_{loc}_EFUSE_A_CONFIGURED_top(configured_i)')
            else:
                print(f'        .Tile_{loc}_EFUSE_A_CONFIGURED_top(configured_i),')
            print('')

        print("    );\n")

        for i in range(NUM_SRAM):
            print(f"""    // SRAM {i} instance

    gf180mcu_ocd_ip_sram__sram1024x8m8wm1 sram_{i} (
      .CLK      (fabric_sram{i}_clk_o),
      .CEN      (fabric_sram{i}_cen_o),   //Chip Enable, negative
      .GWEN     (fabric_sram{i}_gwen_o),  //Global Write Enable, negative
      .WEN      (fabric_sram{i}_wen_o),   //Write Enable, negative
      .A        (fabric_sram{i}_a_o),
      .D        (fabric_sram{i}_d_o),
      .Q        (fabric_sram{i}_q_i)
    );
        """)

        for i, loc in enumerate(EFUSE_LOC):
            print(f"""    // eFuse {i} instance

    efuse_spi_mem_256x8 efuse_{i} (
      .clk_i      (fabric_efuse{i}_clk_o),
      .npor       (npor_i && !fabric_efuse{i}_rst_o),
      .spi_clk    (fabric_efuse{i}_spi_clk_o),
      .spi_csn    (fabric_efuse{i}_spi_csn_o),
      .spi_miso   (fabric_efuse{i}_spi_miso_i),
      .spi_mosi   (fabric_efuse{i}_spi_mosi_o)
    );
        """)



        print("endmodule")
