#### Template Script for RTL->Gate-Level Flow (generated from RC GENUS15.22 - 15.20-s024_1)

if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

##############################################################################
## Preset global variables and attributes
##############################################################################


set DESIGN z80_top_direct_n
set SYN_EFF medium
set MAP_EFF high
set DATE [clock format [clock seconds] -format "%b%d-%T"]
set _OUTPUTS_PATH outputs_${DATE}
set _REPORTS_PATH reports_${DATE}
set _LOG_PATH logs_${DATE}
##set ET_WORKDIR <ET work directory>
set_db / .init_lib_search_path {. ./lib /pdk/xfab/XC018_61_3.1.3/synopsys/xc018/MOSST /pdk/xfab/XC018_61_3.1.3/synopsys/xc018/MOS5ST /pdk/xfab/XC018_61_3.1.3/cadence/xc018/LEF/xc018_m6_FE }
set_db / .script_search_path {. }
set_db / .init_hdl_search_path {. ../rtl}
##Uncomment and specify machine names to enable super-threading.
##set_db / .super_thread_servers {<machine names>}
##For design size of 1.5M - 5M gates, use 8 to 16 CPUs. For designs > 5M gates, use 16 to 32 CPUs
##set_db / .max_cpus_per_server 8

##Default undriven/unconnected setting is 'none'.
##set_db / .hdl_unconnected_input_port_value 0 | 1 | x | none
##set_db / .hdl_undriven_output_port_value   0 | 1 | x | none
##set_db / .hdl_undriven_signal_value        0 | 1 | x | none


##set_db / .wireload_mode <value>
set_db / .information_level 7
##set_db / .retime_reg_naming_suffix __retimed_reg

###############################################################
## Library setup
###############################################################


set_db / .library { D_CELLS_MOSST_typ_1_80V_25C.lib IO_CELLS_5V_MOS5ST_typ_1_80V_4_50V_25C.lib }
set_db / .lef_library { xc018m6_FE.lef D_CELLS.lef IO_CELLS_5V.lef }
set_db / .cap_table_file /pdk/xfab/XC018_61_3.1.3/cadence/xc018/LEF/xc018_m6_FE/xc018m6_typ.capTbl

set_db / .lp_insert_clock_gating true

## Power root attributes
#set_db / .lp_clock_gating_prefix <string>
#set_db / .lp_power_analysis_effort <high>
#set_db / .lp_power_unit mW
#set_db / .lp_toggle_rate_unit /ns
## The attribute has been set to default value "medium"
## you can try setting it to high to explore MVT QoR for low power optimization
set_db / .leakage_power_effort medium


####################################################################
## Load Design
####################################################################

set CORE_FILES [list address_latch.v address_mux.v address_pins.v alu_bit_select.v alu_control.v alu_core.v alu_flags.v alu_mux_2.v alu_mux_2z.v alu_mux_3z.v alu_mux_4.v alu_mux_8.v alu_prep_daa.v alu_select.v alu_shifter_core.v alu_slice.v alu.v bus_control.v bus_switch.v clk_delay.v control_pins_n.v data_pins.v data_switch_mask.v data_switch.v decode_state.v execute.v inc_dec_2bit.v inc_dec.v interrupts.v ir.v memory_ifc.v pin_control.v pla_decode.v reg_control.v reg_file.v reg_latch.v resets.v sequencer.v z80_top_direct_n.v]

read_hdl ${CORE_FILES}
puts "DEPOIS DO READ_HDL"
elaborate $DESIGN
puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration



check_design -unresolved

####################################################################
## Constraints Setup
####################################################################

read_sdc a-z80_constraints.sdc
puts "The number of exceptions is [llength [vfind "design:$DESIGN" -exception *]]"


#set_db "design:$DESIGN" .force_wireload <wireload name>

if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
  puts "Creating directory ${_LOG_PATH}"
}

if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
  puts "Creating directory ${_OUTPUTS_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
}
report_timing -lint


###################################################################################
## Define cost groups (clock-clock, clock-output, input-clock, input-output)
###################################################################################

## Uncomment to remove already existing costgroups before creating new ones.
## delete_obj [vfind /designs/* -cost_group *]

if {[llength [all::all_seqs]] > 0} {
  define_cost_group -name I2C -design $DESIGN
  define_cost_group -name C2O -design $DESIGN
  define_cost_group -name C2C -design $DESIGN
  path_group -from [all::all_seqs] -to [all::all_seqs] -group C2C -name C2C
  path_group -from [all::all_seqs] -to [all::all_outs] -group C2O -name C2O
  path_group -from [all::all_inps]  -to [all::all_seqs] -group I2C -name I2C
}

define_cost_group -name I2O -design $DESIGN
path_group -from [all::all_inps]  -to [all::all_outs] -group I2O -name I2O
foreach cg [vfind / -cost_group *] {
  report_timing -cost_group [list $cg] >> $_REPORTS_PATH/${DESIGN}_pretim.rpt
}


####################################################################################################
## Synthesizing to generic
####################################################################################################

set_db / .syn_generic_effort $SYN_EFF
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
report_dp > $_REPORTS_PATH/generic/${DESIGN}_datapath.rpt
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH


#### Build RTL power models
##build_rtl_power_models -design $DESIGN -clean_up_netlist [-clock_gating_logic] [-relative <hierarchical instance>]
#report power -rtl


####################################################################################################
## Synthesizing to gates
####################################################################################################

## Add '-auto_identify_shift_registers' to 'syn_map' to automatically
## identify functional shift register segments.
set_db / .syn_map_effort $MAP_EFF
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED
write_snapshot -outdir $_REPORTS_PATH -tag map
report_summary -directory $_REPORTS_PATH
report_dp > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt

foreach cg [vfind / -cost_group *] {
  report_timing -cost_group [list $cg] > $_REPORTS_PATH/${DESIGN}_[vbasename $cg]_post_map.rpt
}



##Intermediate netlist for LEC verification..
write_hdl -lec > ${_OUTPUTS_PATH}/${DESIGN}_intermediate.v
write_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_intermediate.v -logfile ${_LOG_PATH}/rtl2intermediate.lec.log > ${_OUTPUTS_PATH}/rtl2intermediate.lec.do

## ungroup -threshold <value>

#######################################################################################################
## Incremental Synthesis
#######################################################################################################
set_db / .syn_opt_effort $MAP_EFF
syn_opt
write_snapshot -outdir $_REPORTS_PATH -tag syn_opt
report_summary -directory $_REPORTS_PATH

puts "Runtime & Memory after incremental synthesis"
time_info INCREMENTAL

foreach cg [vfind / -cost_group *] {
  report_timing -cost_group [list $cg] > $_REPORTS_PATH/${DESIGN}_[vbasename $cg]_post_incr.rpt
}

#######################################################################################################
## Incremental Synthesis
#######################################################################################################

## An effort of low was selected to minimize runtime of incremental opto.
## If your timing is not met, rerun incremental opto with a different effort level
set_db / .syn_opt_effort low
syn_opt -incremental
write_snapshot -outdir $_REPORTS_PATH -tag syn_opt_low_incr
report_summary -directory $_REPORTS_PATH
puts "Runtime & Memory after incremental synthesis"
time_info INCREMENTAL_POST_SCAN_CHAINS




######################################################################################################
## write backend file set (verilog, SDC, config, etc.)
######################################################################################################



report_clock_gating > $_REPORTS_PATH/${DESIGN}_clockgating.rpt
report_power -depth 0 > $_REPORTS_PATH/${DESIGN}_power.rpt
report_gates -power > $_REPORTS_PATH/${DESIGN}_gates_power.rpt

report_dp > $_REPORTS_PATH/${DESIGN}_datapath_incr.rpt
report_messages > $_REPORTS_PATH/${DESIGN}_messages.rpt
write_snapshot -outdir $_REPORTS_PATH -tag final
report_summary -directory $_REPORTS_PATH
## write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_m.v
## write_script > ${_OUTPUTS_PATH}/${DESIGN}_m.script
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_m.sdc

#################################
### write_do_lec
#################################

write_do_lec -golden_design ${_OUTPUTS_PATH}/${DESIGN}_intermediate.v -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile  ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do
##Uncomment if the RTL is to be compared with the final netlist..
##write_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile ${_LOG_PATH}/rtl2final.lec.log > ${_OUTPUTS_PATH}/rtl2final.lec.do

puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

write_design -innovus -base_name innovus/z80_top_direct_n

file copy [get_db / .stdout_log] ${_LOG_PATH}/.

##quit
