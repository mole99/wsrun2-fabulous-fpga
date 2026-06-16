# GlobalFoundries 180nm MCU eFuse memory macros

This repository contains several precompiled eFuse non-volatile memory macros implementation as part of open source PDK for GlobalFoundries 180nm MCU process node. eFuse memory blocks were produced by the open-source [GF180MCU eFuse compiler](https://github.com/egorxe/gf180_efuse_compiler).

## Precompiled eFuse macros

1. efuse_async_mem_1x8 - 8-bit wide asynchronous eFuse memory with simple parallel interface.
2. efuse_spi_mem_256x8 - 8-bit wide, 256 words deep synchronous eFuse memory array with EEPROM-like SPI interface.
3. efuse_wb_mem_1024x32 - 32-bit wide, 1024 words deep synchronous eFuse memory array with Wishbone bus interface.
4. efuse_wb_mem_128x8 - 8-bit wide, 128 words deep synchronous eFuse memory array with Wishbone bus interface.
5. efuse_wb_mem_32x8 - 8-bit wide, 32 words deep synchronous eFuse memory array with Wishbone bus interface.
6. efuse_wb_mem_64x32 - 32-bit wide, 64 words deep synchronous eFuse memory array with Wishbone bus interface.
7. efuse_array_64x32 - 32-bit wide, 64 words deep eFuse memory with native eFuse interface. Used as a building block for efuse_wb_mem_1024x32 and efuse_wb_mem_64x32.

## Documentation

For the documentation please refer to the compiler documentation page: https://egorxe.github.io/gf180_efuse_compiler .

Macro interfaces descriptions for design integration:

* [Asynchronous](https://egorxe.github.io/gf180_efuse_compiler/modules/efuse_array_async.html)
* [SPI](https://egorxe.github.io/gf180_efuse_compiler/modules/efuse_spi_mem.html)
* [Wishbone](https://egorxe.github.io/gf180_efuse_compiler/modules/efuse_wb_mem.html)
* [Native](https://egorxe.github.io/gf180_efuse_compiler/modules/efuse_array.html)