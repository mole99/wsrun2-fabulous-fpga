module \$__RAM_1024x8_1RW_ (...);

    // 1 for posedge clocks and 0 for negedge
    parameter PORT_A_CLK_POL = 1;

    localparam WIDTH = 8;
    localparam ABITS = 10;

    input  PORT_A_CLK;
    input  PORT_A_CLK_EN;
    input  [WIDTH-1:0] PORT_A_WR_DATA;
    input  [ABITS-1:0] PORT_A_ADDR;
    input  PORT_A_WR_EN;
    input  [WIDTH-1:0] PORT_A_WR_BE;
    output [WIDTH-1:0] PORT_A_RD_DATA;

    IHP_SRAM_1024x32_1RW #(
        .CLK_INV (PORT_A_CLK_POL != 1'b1)
    ) _TECHMAP_REPLACE_ (
        // Port A - Read/Write
        .CLK    (PORT_A_CLK),
        .ADDR0  (PORT_A_ADDR[0]),
        .ADDR1  (PORT_A_ADDR[1]),
        .ADDR2  (PORT_A_ADDR[2]),
        .ADDR3  (PORT_A_ADDR[3]),
        .ADDR4  (PORT_A_ADDR[4]),
        .ADDR5  (PORT_A_ADDR[5]),
        .ADDR6  (PORT_A_ADDR[6]),
        .ADDR7  (PORT_A_ADDR[7]),
        .ADDR8  (PORT_A_ADDR[8]),
        .ADDR9  (PORT_A_ADDR[9]),
        .DIN0   (PORT_A_WR_DATA[0]),
        .DIN1   (PORT_A_WR_DATA[1]),
        .DIN2   (PORT_A_WR_DATA[2]),
        .DIN3   (PORT_A_WR_DATA[3]),
        .DIN4   (PORT_A_WR_DATA[4]),
        .DIN5   (PORT_A_WR_DATA[5]),
        .DIN6   (PORT_A_WR_DATA[6]),
        .DIN7   (PORT_A_WR_DATA[7]),
        .BM0    (PORT_A_WR_BE[0]),
        .BM1    (PORT_A_WR_BE[1]),
        .BM2    (PORT_A_WR_BE[2]),
        .BM3    (PORT_A_WR_BE[3]),
        .BM4    (PORT_A_WR_BE[4]),
        .BM5    (PORT_A_WR_BE[5]),
        .BM6    (PORT_A_WR_BE[6]),
        .BM7    (PORT_A_WR_BE[7]),
        .WEN    (PORT_A_WR_EN),
        .MEN    (PORT_A_CLK_EN),
        .DOUT0  (PORT_A_RD_DATA[0]),
        .DOUT1  (PORT_A_RD_DATA[1]),
        .DOUT2  (PORT_A_RD_DATA[2]),
        .DOUT3  (PORT_A_RD_DATA[3]),
        .DOUT4  (PORT_A_RD_DATA[4]),
        .DOUT5  (PORT_A_RD_DATA[5]),
        .DOUT6  (PORT_A_RD_DATA[6]),
        .DOUT7  (PORT_A_RD_DATA[7])
    );

endmodule
