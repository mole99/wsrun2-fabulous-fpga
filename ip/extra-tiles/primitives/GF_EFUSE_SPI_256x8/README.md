# GF_EFUSE_SPI_256x8

The `GF_EFUSE_SPI_256x8` primitive provides access to an eFuse memory via SPI.

The SPI protocol is a subset of the 25-series SPI EEPROMs protocol with an active-low chip-select and data latching on the rising clock edge.
For the supported SPI commands, please see: https://egorxe.github.io/gf180_efuse_compiler/modules/efuse_spi_mem.html

Maximum SPI clock frequency is 10 MHz.

![GF_EFUSE_SPI_256x8](images/svg/GF_EFUSE_SPI_256x8.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| CLK           | input     | 1     | The clock input for the eFuse memory. |
| RST           | input     | 1     | The reset.               |
| SPI_CLK       | input     | 1     | SPI clock (max 10 MHz).  |
| SPI_CSN       | input     | 1     | SPI chip select (active low). |
| SPI_MISO      | output    | 1     | SPI MISO.                |
| SPI_MOSI      | input     | 1     | SPI MOSI.                |

