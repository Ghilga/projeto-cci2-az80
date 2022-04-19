#####################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 04/11/2022 23:06:00
#
#####################################################################


read_mmmc innovus/z80_top_direct_n.mmmc.tcl

read_physical -lef {/pdk/xfab/XC018_61_3.1.3/cadence/xc018/LEF/xc018_m6_FE/xc018m6_FE.lef /pdk/xfab/XC018_61_3.1.3/cadence/xc018/LEF/xc018_m6_FE/D_CELLS.lef /pdk/xfab/XC018_61_3.1.3/cadence/xc018/LEF/xc018_m6_FE/IO_CELLS_5V.lef}

read_netlist innovus/z80_top_direct_n.v

init_design -skip_sdc_read
