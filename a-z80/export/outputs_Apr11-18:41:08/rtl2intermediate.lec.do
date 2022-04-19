// Generated by Cadence Genus(TM) Synthesis Solution GENUS15.22 - 15.20-s024_1
tclmode
set env(RC_VERSION) "GENUS15.22 - 15.20-s024_1"
vpxmode
set dofile abort exit
usage -auto -elapse
set log file logs_Apr11-18:41:08/rtl2intermediate.lec.log -replace
tclmode
set ver [lindex [split [lindex [get_version_info] 0] "-"] 0]
vpxmode
tclmode
set env(CDN_SYNTH_ROOT) /tools/cadence/rhel5/GENUS_15.22/tools.lnx86
set CDN_SYNTH_ROOT /tools/cadence/rhel5/GENUS_15.22/tools.lnx86
vpxmode
tclmode
if {$ver >= 08.10} {
  vpx set naming style rc
}
vpxmode
set naming rule "%s[%d]" -instance_array
set naming rule "%s_reg" -register -golden
set naming rule "%L.%s" "%L[%d].%s" "%s" -instance
set naming rule "%L.%s" "%L[%d].%s" "%s" -variable
set undefined cell black_box -noascend -both
set hdl options -VERILOG_INCLUDE_DIR "incdir:sep:src:cwd"
set undriven signal Z -golden

add search path -library . ./lib /pdk/xfab/XC018_61_3.1.3/synopsys/xc018/MOSST /pdk/xfab/XC018_61_3.1.3/synopsys/xc018/MOS5ST /pdk/xfab/XC018_61_3.1.3/cadence/xc018/LEF/xc018_m6_FE 
read library -statetable -liberty -both  \
	/pdk/xfab/XC018_61_3.1.3/synopsys/xc018/MOSST/D_CELLS_MOSST_typ_1_80V_25C.lib \
	/pdk/xfab/XC018_61_3.1.3/synopsys/xc018/MOS5ST/IO_CELLS_5V_MOS5ST_typ_1_80V_4_50V_25C.lib

delete search path -all
add search path -design . ../rtl
tclmode
if {$ver < 13.10} {
vpx read design   -define SYNTHESIS  -golden -lastmod -noelab -verilog2k \
	address_latch.v \
	address_mux.v \
	address_pins.v \
	alu_bit_select.v \
	alu_control.v \
	alu_core.v \
	alu_flags.v \
	alu_mux_2.v \
	alu_mux_2z.v \
	alu_mux_3z.v \
	alu_mux_4.v \
	alu_mux_8.v \
	alu_prep_daa.v \
	alu_select.v \
	alu_shifter_core.v \
	alu_slice.v \
	alu.v \
	bus_control.v \
	bus_switch.v \
	clk_delay.v \
	control_pins_n.v \
	data_pins.v \
	data_switch_mask.v \
	data_switch.v \
	decode_state.v \
	execute.v \
	inc_dec_2bit.v \
	inc_dec.v \
	interrupts.v \
	ir.v \
	memory_ifc.v \
	pin_control.v \
	pla_decode.v \
	reg_control.v \
	reg_file.v \
	reg_latch.v \
	resets.v \
	sequencer.v \
	z80_top_direct_n.v
} else {
vpx read design   -define SYNTHESIS  -merge bbox -golden -lastmod -noelab -verilog2k \
	address_latch.v \
	address_mux.v \
	address_pins.v \
	alu_bit_select.v \
	alu_control.v \
	alu_core.v \
	alu_flags.v \
	alu_mux_2.v \
	alu_mux_2z.v \
	alu_mux_3z.v \
	alu_mux_4.v \
	alu_mux_8.v \
	alu_prep_daa.v \
	alu_select.v \
	alu_shifter_core.v \
	alu_slice.v \
	alu.v \
	bus_control.v \
	bus_switch.v \
	clk_delay.v \
	control_pins_n.v \
	data_pins.v \
	data_switch_mask.v \
	data_switch.v \
	decode_state.v \
	execute.v \
	inc_dec_2bit.v \
	inc_dec.v \
	interrupts.v \
	ir.v \
	memory_ifc.v \
	pin_control.v \
	pla_decode.v \
	reg_control.v \
	reg_file.v \
	reg_latch.v \
	resets.v \
	sequencer.v \
	z80_top_direct_n.v
}
vpxmode

elaborate design -golden -root z80_top_direct_n -rootonly

tclmode
if {$ver < 13.10} {
vpx read design -verilog -revised -lastmod -noelab \
	outputs_Apr11-18:41:08/z80_top_direct_n_intermediate.v
} else {
vpx read design -verilog95 -revised -lastmod -noelab \
	outputs_Apr11-18:41:08/z80_top_direct_n_intermediate.v
}
vpxmode

elaborate design -revised -root z80_top_direct_n

tclmode
set ver [lindex [split [lindex [get_version_info] 0] "-"] 0]
if {$ver < 13.10} {
vpx substitute blackbox model -golden
}
vpxmode
report design data
report black box

uniquify -all -nolib
set flatten model -seq_constant -seq_constant_x_to 0
set flatten model -nodff_to_dlat_zero -nodff_to_dlat_feedback
set parallel option -threads 4 -license xl -norelease_license
set flatten model -gated_clock
set analyze option -auto

write hier_compare dofile outputs_Apr11-18:41:08/hier_rtl2intermediate.lec.do \
	-noexact_pin_match -constraint -usage -replace -balanced_extraction -input_output_pin_equivalence \
	-prepend_string "analyze datapath -module -verbose ; usage; analyze datapath  -verbose"
run hier_compare outputs_Apr11-18:41:08/hier_rtl2intermediate.lec.do -dynamic_hierarchy
// report hier_compare result -dynamicflattened
set system mode lec
tclmode
puts "No of diff points    = [get_compare_points -NONequivalent -count]"
if {[get_compare_points -NONequivalent -count] > 0} {
    puts "------------------------------------"
    puts "ERROR: Different Key Points detected"
    puts "------------------------------------"
#     foreach i [get_compare_points -NONequivalent] {
#         vpx report test vector [get_keypoint $i]
#         puts "     ----------------------------"
#     }
}
vpxmode
exit -force
