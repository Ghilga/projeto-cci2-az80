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
connect_global_net vdd -type pg_pin -pin_base_name vdd -inst_base_name *
connect_global_net gnd -type pg_pin -pin_base_name gnd -inst_base_name *
connect_global_net vdd -type tie_hi -inst_base_name *
connect_global_net gnd -type tie_lo -inst_base_name *

##Generate power ring with 0.25um spacing (between metal lines), 0.5um width and 1.5um offset from the core. Use M1 for horizontal and M2 for vertical
add_rings -spacing 0.25 -width 0.5 -layer {top M1 bottom M1 left M2 right M2} -jog_distance 2.5 -offset 1.5 -nets {gnd vdd} -threshold 2.5

##Route power rails using M1
route_special -connect {block_pin core_pin pad_pin pad_ring floating_stripe} -layer_change_range {M1 METTP} -block_pin_target {nearest_target} -pad_pin_port_connect {all_port one_geom} -block_pin {use_lef} -allow_jogging 1 -crossover_via_layer_range {M1 METTP} -allow_layer_change 1 -target_via_layer_range {M1 METTP} -nets {gnd vdd}

##Add well taps
add_well_taps -cell FEED1 -cell_interval 20 -fixed_gap -prefix WELLTAP -in_row_offset 8.0

##Add power stripes
add_stripes -block_ring_top_layer_limit M3 -max_same_layer_jog_length 6 -pad_core_ring_bottom_layer_limit M1 -set_to_set_distance 25 -pad_core_ring_top_layer_limit M3 -spacing 6 -merge_stripes_value 2.5 -layer M2 -block_ring_bottom_layer_limit M1 -width 0.5 -nets {gnd vdd}

