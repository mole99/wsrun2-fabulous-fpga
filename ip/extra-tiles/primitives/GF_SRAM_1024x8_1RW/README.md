# GF_SRAM_1024x8_1RW

The `GF_SRAM_1024x8_1RW` primitive provides an SRAM with 1024x8 bits of data and one synchronous read/write port.
It has a per-bit write mask (`BM`) which allows to only write individual bits of data.

![GF_SRAM_1024x8_1RW](images/svg/GF_SRAM_1024x8_1RW.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| CLK           | input     | 1     | The clock input for the R/W port. |
| ADDR          | input     | 10    | The address for the R/W port. |
| DIN           | input     | 8     | The write data.          |
| BM            | input     | 8     | The per-bit write mask.  |
| WEN           | input     | 1     | The write enable signal. |
| MEN           | input     | 1     | The memory enable signal. |
| DOUT          | output    | 8     | The read data.           |

