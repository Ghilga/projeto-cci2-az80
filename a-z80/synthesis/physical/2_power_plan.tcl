##############################################################
##         Initial Encounter Configuration                  ##
## Script Generated for Undergrad class of microelectronics ##
## Generated by Matheus Moreira/Fernando Moraes - 2018      ##
##                                                          ##
## Functionalities of this script:                          ##
##  -Generate and connects global nets                      ##
##  -Generate the power ring                                ##
##  -Connect the power rails                                ##
##  -Add the well taps for bulk polarization                ##
##############################################################
##Generate / connect global nets (VDD/GND)
delete_global_net_connections
connect_global_net vdd -type pg_pin -pin_base_name VDD -inst_base_name *
connect_global_net gnd -type pg_pin -pin_base_name VSS -inst_base_name *
connect_global_net vdd -type tie_hi -inst_base_name *
connect_global_net gnd -type tie_lo -inst_base_name *

##Generate power ring with 0.25um spacing (between metal lines), 0.5um width and 1.5um offset from the core. Use M1 for horizontal and M2 for vertical
#add_rings -spacing 0.25 -width 0.5 -layer {top M1 bottom M1 left M2 right M2} -jog_distance 2.5 -offset 1.5 -nets {gnd vdd} -threshold 2.5
#addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer METTP -type core_rings -jog_distance 0.315 -threshold 0.315 -nets {vdd gnd} -follow core -stacked_via_bottom_layer MET1 -layer {bottom MET1 top MET1 right MET2 left MET2} -width 0.44 -spacing 0.46 -offset 0.315
#eval_legacy { addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer METTP -type core_rings -jog_distance 0.315 -threshold 0.315 -nets {vdd gnd} -follow core -stacked_via_bottom_layer MET1 -layer {bottom MET1 top MET1 right MET2 left MET2} -width 0.44 -spacing 0.46 -offset 0.315 }
eval_legacy { addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer METTP -type core_rings -jog_distance 0.315 -threshold 0.315 -nets {vdd gnd} -follow core -stacked_via_bottom_layer MET1 -layer {bottom MET1 top MET1 right MET2 left MET2} -width 0.44 -spacing 0.46 -offset 0.315 }

##Route power rails using M1
#route_special -connect {block_pin core_pin pad_pin pad_ring floating_stripe} -layer_change_range {M1 AP} -block_pin_target {nearest_target} -pad_pin_port_connect {all_port one_geom} -block_pin {use_lef} -allow_jogging 1  -crossover_via_layer_range {M1 AP} -allow_layer_change 1 -target_via_layer_range {M1 AP} -nets {gnd vdd}
#route_special -connect {block_pin core_pin pad_pin pad_ring floating_stripe} -layer_change_range {MET1 METTP} -block_pin_target {nearest_target} -pad_pin_port_connect {all_port one_geom} -block_pin {use_lef} -allow_jogging 1  -crossover_via_layer_range {MET1 METTP} -allow_layer_change 1 -target_via_layer_range {MET1 METTP} -nets {gnd vdd}
route_special -connect { blockpin padpin padring corepin floatingstripe } -layer_change_range { MET1 METTP } -block_pin_target { nearesttarget } -pad_pin_port_connect { allport onegeom } -pad_pin_target { nearesttarget } -core_pin_target { firstafterrowend } -floating_stripe_target { blockring padring ring stripe ringpin blockpin followpin } -allow_jogging 1 -crossover_via_layer_range { MET1 METTP } -nets { vdd gnd } -allow_layer_change 1 -block_pin use_lef -target_via_layer_range { MET1 METTP }
#route_special -connect { blockpin padpin padring corepin floatingstripe } -layer_change_range { MET1 METTP } -block_pin_target { nearesttarget } -pad_pin_port_connect { allport onegeom } -pad_pin_target { nearesttarget } -core_pin_target { firstafterrowend } -floating_stripe_target { blockring padring ring stripe ringpin blockpin followpin } -allow_jogging 1 -crossover_via_layer_range { MET1 METTP } -nets { gnd vdd } -allow_layer_change 1 -block_pin use_lef -target_via_layer_range { MET1 METTP }

##Add well taps
#add_well_taps -cell HS65_GS_FILLERNPWPFP3 -cell_interval 20 -fixed_gap -prefix WELLTAP -in_row_offset 8.0
add_well_taps -cell FEED1 -cell_interval 20 -fixed_gap -prefix WELLTAP -in_row_offset 8.0

##Add power stripes
#add_stripes -block_ring_top_layer_limit M3 -max_same_layer_jog_length 6 -pad_core_ring_bottom_layer_limit M1 -set_to_set_distance 25 -pad_core_ring_top_layer_limit M3 -spacing 6 -merge_stripes_value 2.5 -layer M2 -block_ring_bottom_layer_limit M1 -width 0.5 -nets {gnd vdd}
eval_legacy { addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit MET3 -max_same_layer_jog_length 0.88 -padcore_ring_bottom_layer_limit MET1 -set_to_set_distance 100 -skip_via_on_pin Standardcell -stacked_via_top_layer METTP -padcore_ring_top_layer_limit MET3 -spacing 0.46 -merge_stripes_value 0.315 -layer MET2 -block_ring_bottom_layer_limit MET1 -width 0.44 -nets {vdd gnd} -stacked_via_bottom_layer MET1 }

