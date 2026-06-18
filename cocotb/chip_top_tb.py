# SPDX-FileCopyrightText: © 2025 Project Template Contributors
# SPDX-License-Identifier: Apache-2.0

import os
import re
import random
import logging
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.types import LogicArray, Logic
from cocotb.triggers import Timer, Edge, RisingEdge, FallingEdge, ClockCycles
from cocotb_tools.runner import get_runner

from cocotbext.spi import SpiBus, SpiConfig, SpiMaster

proj_path = Path(__file__).resolve().parent

sim = os.getenv("SIM", "icarus")
gl = os.getenv("GL", False)
pdk_root = os.getenv("PDK_ROOT", Path(__file__).resolve().parent / "../gf180mcu")
pdk = os.getenv("PDK", "gf180mcuD")
scl = os.getenv("SCL", "gf180mcu_fd_sc_mcu7t5v0")
pad = os.getenv("PAD", "gf180mcu_fd_io")
sram = os.getenv("SRAM", "gf180mcu_fd_ip_sram")
slot = os.getenv("SLOT", "1x1")
tile_library = os.getenv("TILE_LIBRARY", "classic")
fabric = os.getenv("FABRIC", "classic_fabric_wsrun2")

hdl_toplevel = "chip_top"
tb_toplevel = "chip_top_tb"

lookup = {
    "X0Y1/A" : "fpga_PAD_0",
    "X0Y1/B" : "fpga_PAD_1",
    "X0Y1/C" : "fpga_PAD_2",
    "X0Y1/D" : "fpga_PAD_3",

    "X0Y2/A" : "fpga_PAD_4",
    "X0Y2/B" : "fpga_PAD_5",
    "X0Y2/C" : "fpga_PAD_6",
    "X0Y2/D" : "fpga_PAD_7",

    "X0Y3/A" : "fpga_PAD_8",
    "X0Y3/B" : "fpga_PAD_9",
    "X0Y3/C" : "fpga_PAD_10",
    "X0Y3/D" : "fpga_PAD_11",

    "X0Y4/A" : "fpga_PAD_12",
    "X0Y4/B" : "fpga_PAD_13",
    "X0Y4/C" : "fpga_PAD_14",
    "X0Y4/D" : "fpga_PAD_15",

    "X0Y5/A" : "fpga_PAD_16",
    "X0Y5/B" : "fpga_PAD_17",
    "X0Y5/C" : "fpga_PAD_18",
    "X0Y5/D" : "fpga_PAD_19",

    "X0Y6/A" : "fpga_PAD_20",
    "X0Y6/B" : "fpga_PAD_21",
    "X0Y6/C" : "fpga_PAD_22",
    "X0Y6/D" : "fpga_PAD_23",

    "X0Y7/A" : "fpga_PAD_24",
    "X0Y7/B" : "fpga_PAD_25",
    "X0Y7/C" : "fpga_PAD_26",
    "X0Y7/D" : "fpga_PAD_27",

    "X0Y8/A" : "fpga_PAD_28",
    "X0Y8/B" : "fpga_PAD_29",
    "X0Y8/C" : "fpga_PAD_30",
    "X0Y8/D" : "fpga_PAD_31",

    "X0Y9/A" : "fpga_PAD_32",
    "X0Y9/B" : "fpga_PAD_33",
    "X0Y9/C" : "fpga_PAD_34",
    "X0Y9/D" : "fpga_PAD_35",

    "X0Y10/A" : "fpga_PAD_36",
    "X0Y10/B" : "fpga_PAD_37",
    "X0Y10/C" : "fpga_PAD_38",
    "X0Y10/D" : "fpga_PAD_39",

    "X0Y11/A" : "fpga_PAD_40",
    "X0Y11/B" : "fpga_PAD_41",
    "X0Y11/C" : "fpga_PAD_42",
    "X0Y11/D" : "fpga_PAD_43",

    "X0Y12/A" : "fpga_PAD_44",
    "X0Y12/B" : "fpga_PAD_45",
    "X0Y12/C" : "fpga_PAD_46",
    "X0Y12/D" : "fpga_PAD_47",
}

# Note! There's a character limit for Icarus readmemh's path. It will start dropping the first characters.
all_ones = {
    'flash1_slot0': (proj_path / f"../ip/fabulous-fabrics/user_designs/designs/{tile_library}/all_ones/all_ones.hex").resolve(),
    'flash1_slot1': "",
}

all_zeros = {
    'flash1_slot0': (proj_path / f"../ip/fabulous-fabrics/user_designs/designs/{tile_library}/all_zeros/all_zeros.hex").resolve(),
    'flash1_slot1': "",
}

counter_top = {
    'flash1_slot0': (proj_path / f"../ip/fabulous-fabrics/user_designs/designs/{tile_library}/counter_top/counter_top.hex").resolve(),
    'flash1_slot1': "",
}

trigger_slot = {
    'flash1_slot0': (proj_path / f"../ip/fabulous-fabrics/user_designs/designs/{tile_library}/trigger_slot1/trigger_slot1.hex").resolve(),
    'flash1_slot1': (proj_path / f"../ip/fabulous-fabrics/user_designs/designs/{tile_library}/trigger_slot0/trigger_slot0.hex").resolve(),
}

enabled = trigger_slot

class PCF:
    "A class to read a PCF file and access the signals within cocotb."

    def __init__(self, dut, file, lookup):
        self.signals = {}
        self.top = dut._name
        print(f"Reading PCF file: {file}")
        with open(file, "r") as pcf_file:
            while line := pcf_file.readline():
                if match := re.match(r"\s*set_io\s+(?P<signal>\w+)(\[(?P<index>\d+)?\])?\s+X(?P<tilex>\d+)Y(?P<tiley>\d+)\/(?P<bel>\w+)", line):
                    signal = match.group("signal")
                    index = match.group("index")
                    tile_x = match.group("tilex")
                    tile_y = match.group("tiley")
                    bel = match.group("bel")

                    tile_bel = f"X{tile_x}Y{tile_y}/{bel}"
                    top_pad = lookup[tile_bel]
                    top_handle = eval(f"dut.{top_pad}", locals=dict(dut=dut))

                    if index is None:
                        index = 0
                    else:
                        index = int(index)
                    
                    # Add an index to a signal
                    if signal in self.signals:
                        self.signals[signal][index] = top_handle

                        # Sort by index
                        self.signals[signal] = dict(sorted(self.signals[signal].items()))
                    # Add a new signal
                    else:
                        self.signals[signal] = {
                             index: top_handle
                        }

    def write_gtkw(self, path, filter=None):
        "Write a gtkwave save file in order to view the selected signals"
        with open(path, "w") as outfile:
            outfile.write(f"@28\n")
            for signal_name, signal in self.signals.items():
                if filter is not None and signal_name in filter:
                    if len(signal) == 1:
                        outfile.write(f"#{{{signal_name}}} {self.top}.{signal[0]._name}\n")
                        outfile.write(f"@200\n")
                        outfile.write(f"-\n")
                        outfile.write(f"@28\n")
                    else:
                        bits = len(signal)
                        signals = [ self.top + "." + signal._name for index, signal in reversed(signal.items()) ]
                    
                        outfile.write(f"@c00022\n")
                        outfile.write(f"#{{{signal_name}[{bits-1}:0]}} {' '.join(signals)}\n")
                        outfile.write(f"@28\n")
                        for signal in signals:
                            outfile.write(f"{signal}\n")
                        outfile.write(f"@1401200\n")
                        outfile.write(f"-group_end\n")

                        outfile.write(f"@200\n")
                        outfile.write(f"-\n")

    def get(self, signal, index=None):
        "Get the value of a signal"
        #print(f"get {signal} {index}")
    
        # Get the full signal
        if index is None:
            return LogicArray("".join(str(bit.value) for bit in reversed(self.signals[signal].values())))
        # Get a single bit
        else:
            return Logic(self.signals[signal][index].value)
    
    def set(self, signal, value, index=None):
        "Set the value of a signal"
        #print(f"set {signal} {value} {index}")
        
        # Get the full signal
        if index is None:
            for index, bit in enumerate(reversed(value)):
                self.signals[signal][index].value = bit
        else:
            self.signals[signal][index].value = value

    def get_raw(self, signal, use, index=0):
        "Get the raw cocotb signal. Can be used for triggers."
        return self.signals[signal][index]

async def set_defaults(dut):
    dut.fpga_mode_PAD.value = 0

async def enable_power(dut):
    dut.VDD.value = 1
    dut.VSS.value = 0
    dut.DVDD.value = 1
    dut.DVSS.value = 0

async def start_clock(clock, freq=50):
    """Start the clock @ freq MHz"""
    c = Clock(clock, 1 / freq * 1000, "ns")
    cocotb.start_soon(c.start())


async def reset(reset, active_low=True, time_ns=500):
    """Reset dut"""
    cocotb.log.info("Reset asserted...")

    reset.value = not active_low
    await Timer(time_ns, "ns")
    reset.value = active_low

    cocotb.log.info("Reset deasserted.")


async def start_up(dut):
    """Startup sequence"""
    await set_defaults(dut)
    if gl:
        await enable_power(dut)
    await start_clock(dut.clk_PAD)
    await reset(dut.rst_n_PAD)


@cocotb.test(skip=enabled!=all_ones)
async def test_all_ones(dut):
    """Load bitstream that sets all ones"""

    testname = "all_ones"

    pcf = PCF(dut, proj_path / f"../ip/fabulous-fabrics/fabrics/{fabric}/constraints.pcf", lookup)
    pcf.write_gtkw(f"{testname}.gtkw", ["all"])

    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Setting defaults...")

    # FPGA config mode
    # if mode == 0: SPI controller
    # if mode == 1: SPI receiver
    dut.fpga_mode_PAD.value = 0

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut)

    logger.info("Running the test...")

    # Wait for a number of clock cycles
    await ClockCycles(dut.clk_PAD, 10000)
    
    # Wait for done
    await FallingEdge(dut.config_busy_PAD)
    await ClockCycles(dut.clk_PAD, 1)

    assert pcf.get("all").to_unsigned() == LogicArray.from_signed(-1, len(pcf.get("all")))

    logger.info("Done!")

@cocotb.test(skip=enabled!=all_zeros)
async def test_all_zeros(dut):
    """Load bitstream that sets all zeros"""

    testname = "all_zeros"

    pcf = PCF(dut, proj_path / f"../ip/fabulous-fabrics/fabrics/{fabric}/constraints.pcf", lookup)
    pcf.write_gtkw(f"{testname}.gtkw", ["all"])

    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Setting defaults...")

    # FPGA config mode
    # if mode == 0: SPI controller
    # if mode == 1: SPI receiver
    dut.fpga_mode_PAD.value = 0

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut)

    logger.info("Running the test...")

    # Wait for a number of clock cycles
    await ClockCycles(dut.clk_PAD, 10000)
    
    # Wait for done
    await FallingEdge(dut.config_busy_PAD)
    await ClockCycles(dut.clk_PAD, 1)

    assert pcf.get("all").to_unsigned() == LogicArray.from_unsigned(0, len(pcf.get("all")))

    logger.info("Done!")

@cocotb.test(skip=enabled!=counter_top)
async def test_counter_top(dut):
    """Load bitstream that counts"""

    testname = "counter_top"

    pcf = PCF(dut, proj_path / f"../ip/fabulous-fabrics/fabrics/{fabric}/constraints.pcf", lookup)
    pcf.write_gtkw(f"{testname}.gtkw", ["clk1", "rst", "c"])

    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Setting defaults...")

    # FPGA config mode
    # if mode == 0: SPI controller
    # if mode == 1: SPI receiver
    dut.fpga_mode_PAD.value = 0

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut)

    logger.info("Running the test...")
    
    # Wait for done
    await FallingEdge(dut.config_busy_PAD)
    
    # Start a clock on clk1
    clock = pcf.get_raw("clk1", "OUT")
    cocotb.start_soon(Clock(clock, 10, 'ns').start())
    
    pcf.set("rst", Logic(1), index=0)
    await ClockCycles(clock, 10)
    pcf.set("rst", Logic(0), index=0)

    # Wait for a number of clock cycles
    NUM_CYCLES = 123
    await ClockCycles(clock, NUM_CYCLES)

    assert pcf.get("all").to_unsigned() == NUM_CYCLES-1

    logger.info("Done!")

@cocotb.test(skip=enabled!=trigger_slot)
async def test_trigger_slot(dut):
    """Load bitstream that loads another bitstream"""

    testname = "trigger_slot"

    pcf = PCF(dut, proj_path / f"../ip/fabulous-fabrics/fabrics/{fabric}/constraints.pcf", lookup)
    pcf.write_gtkw(f"{testname}.gtkw", ["clk1", "a"])

    # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")

    logger.info("Setting defaults...")

    # FPGA config mode
    # if mode == 0: SPI controller
    # if mode == 1: SPI receiver
    dut.fpga_mode_PAD.value = 0

    logger.info("Startup sequence...")

    # Start up
    await start_up(dut)

    logger.info("Running the test...")
    
    # Start a clock on clk1
    clock = pcf.get_raw("clk1", "OUT")
    cocotb.start_soon(Clock(clock, 10, 'ns').start())
    
    # Wait for done
    await FallingEdge(dut.config_busy_PAD)
    await ClockCycles(dut.clk_PAD, 1)

    assert pcf.get("a").to_unsigned() == LogicArray.from_unsigned(0, len(pcf.get("a")))

    # Wait for done
    await FallingEdge(dut.config_busy_PAD)
    await ClockCycles(dut.clk_PAD, 1)

    assert pcf.get("a").to_unsigned() == LogicArray.from_signed(-1, len(pcf.get("a")))

    # Wait for done
    await FallingEdge(dut.config_busy_PAD)
    await ClockCycles(dut.clk_PAD, 1)

    assert pcf.get("a").to_unsigned() == LogicArray.from_unsigned(0, len(pcf.get("a")))

    logger.info("Done!")


def chip_top_runner():
    sources = []
    defines = {f"SLOT_{slot.upper()}": True, "BITSTREAM_FLASH": True, "SIM": True}
    includes = [proj_path / "../src/"]

    sources.append(proj_path / "chip_top_tb.v")
    sources.append(proj_path / "spiflash_powered.v")

    # Set the LibreLane PDK/SCL/PAD defines
    defines[f"PDK_{pdk.replace('-','_')}"] = True
    defines[f"SCL_{scl}"] = True
    defines[f"PAD_{pad}"] = True
    defines[f"SRAM_{sram}"] = True

    if gl:
        # SCL models
        sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v")
        if scl != "gf180mcu_as_sc_mcu7t3v3":
            sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / "primitives.v")

        # We use the powered netlist
        sources.append(proj_path / f"../final/pnl/{hdl_toplevel}.pnl.v")

        defines.update({"FUNCTIONAL": True, "USE_POWER_PINS": True})
    else:
        sources.append(proj_path / "../src/chip_top.sv")
        sources.append(proj_path / "../src/chip_core.sv")

        sources.append(proj_path / "../src/fabric_wrapper.sv")
        
        sources.append(proj_path / "../ip/fabric_config/fabric_config.sv")
        sources.append(proj_path / "../ip/fabric_config/fabric_spi_controller.sv")
        sources.append(proj_path / "../ip/fabric_config/fabric_spi_receiver.sv")

        defines.update({"FUNCTIONAL": True, "USE_POWER_PINS": False})

    sources += [
        # IO pad models
        Path(pdk_root) / pdk / f"libs.ref/{pad}/verilog/{pad}.v",
        
        # SRAM macros
        Path(pdk_root) / pdk / f"libs.ref/{sram}/verilog/{sram}__sram1024x8m8wm1.v",
        
        # PoR
        proj_path / "../ip/simple_por/verilog/simple_por.v",
        
        # eFuse
        proj_path / "../ip/gf180mcu_re_efuse/verilog/nl/efuse_spi_mem_256x8.nl.v",
        proj_path / "../ip/gf180mcu_re_efuse/verilog/sim/efuse_array_64x8.v",
        Path(pdk_root) / pdk / "libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/gf180mcu_fd_sc_mcu7t5v0.v",
        Path(pdk_root) / pdk / "libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/primitives.v",
        
        # Custom IP
        proj_path / "../ip/gf180mcu_ws_ip__logo/vh/gf180mcu_ws_ip__logo.v",
        proj_path / "../ip/gf180mcu_ws_ip__marker/vh/gf180mcu_ws_ip__marker.v",
        proj_path / "../ip/gf180mcu_ws_ip__qrcode_id/vh/gf180mcu_ws_ip__qrcode_id.v",
        proj_path / "../ip/gf180mcu_ws_ip__shuttle_id/vh/gf180mcu_ws_ip__shuttle_id.v",
        proj_path / "../ip/gf180mcu_ws_ip__project_id/vh/gf180mcu_ws_ip__project_id.v",
        proj_path / "../ip/gf180mcu_ws_ip__credits/vh/gf180mcu_ws_ip__credits.v",
    ]
    
    # Tiles
    
    tiles_path = Path(proj_path / "../ip" / "fabulous-tiles")
    primitives_path = Path(tiles_path) / "primitives"
    tile_library_path = Path(tiles_path) / "tiles" / tile_library

    extra_tiles_path = Path(proj_path / "../ip" / "extra-tiles")
    extra_primitives_path = Path(extra_tiles_path) / "primitives"
    extra_tile_library_path = Path(extra_tiles_path) / "tiles" / tile_library

    primitives_files = list(primitives_path.glob('**/fabulous/*.v'))
    tile_files = list(tile_library_path.glob(f'**/macro/{pdk}/fabulous/*.v'))
    
    primitives_files += list(extra_primitives_path.glob('**/fabulous/*.v'))
    tile_files += list(extra_tile_library_path.glob(f'**/macro/{pdk}/fabulous/*.v'))

    sources.extend(primitives_files)
    sources.extend(tile_files)

    # Add models pack
    sources.append(tiles_path / "models_pack.v")

    # Add custom cells
    sources.append(tiles_path / "custom.v")

    # Add fabric netlist
    sources.append(proj_path / f'../ip/fabulous-fabrics/fabrics/{fabric}/macro/{pdk}/fabulous/{fabric}.v')


    build_args = []

    if sim == "icarus":
        # For debugging
        # build_args = ["-Winfloop", "-pfileline=1"]
        pass

    if sim == "verilator":
        build_args = ["--timing", "--trace", "--trace-fst", "--trace-structs"]

    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel=tb_toplevel,
        defines=defines,
        always=True,
        includes=includes,
        build_args=build_args,
        waves=True,
    )

    plusargs = []

    if enabled["flash1_slot0"]:
        plusargs += [f'+flash1_slot0={enabled["flash1_slot0"]}']
    if enabled["flash1_slot1"]:
        plusargs += [f'+flash1_slot1={enabled["flash1_slot1"]}']

    runner.test(
        hdl_toplevel=tb_toplevel,
        test_module="chip_top_tb,",
        plusargs=plusargs,
        waves=True,
    )


if __name__ == "__main__":
    chip_top_runner()
