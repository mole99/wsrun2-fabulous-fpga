# SRAM macros

define_pdn_grid \
    -macro \
    -instances "\
      i_chip_core.fabric_wrapper.sram_0 \
      i_chip_core.fabric_wrapper.sram_1 \
      i_chip_core.fabric_wrapper.sram_2 \
      i_chip_core.fabric_wrapper.sram_3 \
      i_chip_core.fabric_wrapper.sram_4 \
      i_chip_core.fabric_wrapper.sram_5 \
      i_chip_core.fabric_wrapper.sram_6 \
      i_chip_core.fabric_wrapper.sram_7 \
      i_chip_core.fabric_wrapper.sram_8 \
      i_chip_core.fabric_wrapper.sram_9 \
      i_chip_core.fabric_wrapper.sram_10 \
      i_chip_core.fabric_wrapper.sram_11 \
      i_chip_core.fabric_wrapper.sram_12" \
    -name sram_macros_WE \
    -starts_with POWER \
    -halo "$::env(PDN_HORIZONTAL_HALO) $::env(PDN_VERTICAL_HALO)"

add_pdn_connect \
    -grid sram_macros_WE \
    -layers "$::env(PDN_VERTICAL_LAYER) $::env(PDN_HORIZONTAL_LAYER)"

add_pdn_connect \
    -grid sram_macros_WE \
    -layers "$::env(PDN_VERTICAL_LAYER) Metal3"

# Add stripes on W/E edges of SRAM
add_pdn_stripe \
    -grid sram_macros_WE \
    -layer Metal4 \
    -width 1.36 \
    -offset 0.68 \
    -spacing 0.28 \
    -pitch 513.01 \
    -starts_with POWER \
    -number_of_straps 2

# Since the above stripes block the top level PDN at Metal4, add some more stripes
# to improve the PDN's integrity and ensure a better connection for the macro.
add_pdn_stripe \
    -grid sram_macros_WE \
    -layer Metal4 \
    -width 4.00 \
    -offset 28.0 \
    -spacing 0.28 \
    -pitch 43.50 \
    -starts_with GROUND \
    -number_of_straps 11

# soc sram grid
#define_pdn_grid \
#    -macro \
#    -instances i_chip_core.por_inst \
#    -name por_grid \
#    -starts_with POWER

#add_pdn_stripe \
#    -grid por_grid \
#    -layer Metal4 \
#    -width 2.5 \
#    -pitch 7 \
#    -offset 0 \
#    -spacing 1 \
#    -nets "VSS VDD" \
#    -starts_with POWER

#add_pdn_connect \
#    -grid por_grid \
#    -layers "$::env(PDN_VERTICAL_LAYER) $::env(PDN_HORIZONTAL_LAYER)"
