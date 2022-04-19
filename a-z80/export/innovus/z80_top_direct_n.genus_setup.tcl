#####################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution GENUS15.22 - 15.20-s024_1
#   on 04/11/2022 23:06:00
#
# This file can only be run in Genus Common UI mode.
#
#####################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version GENUS15.22 - 15.20-s024_1


# Remove Existing Design
###########################################################
if {[::legacy::find -design design:z80_top_direct_n] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  delete_obj design:z80_top_direct_n
}


# Source INIT Setup file
########################################################
source innovus/z80_top_direct_n.genus_init.tcl
read_metric -id current innovus/z80_top_direct_n.metrics.json

source innovus/z80_top_direct_n.g
puts "\n** Restoration Completed **\n"


# Data Integrity Check
###########################################################
# program version
if {"[string_representation [::legacy::get_attribute program_version /]]" != "{GENUS15.22 - 15.20-s024_1}"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden program_version: {GENUS15.22 - 15.20-s024_1}  current program_version: [string_representation [::legacy::get_attribute program_version /]]"
}
# license
if {"[string_representation [::legacy::get_attribute startup_license /]]" != "Genus_Synthesis"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden license: Genus_Synthesis  current license: [string_representation [::legacy::get_attribute startup_license /]]"
}
# slack
set _slk_ [::legacy::get_attribute slack design:z80_top_direct_n]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "-1535.1"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack: -1535.1,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
# tns
set _tns_ [::legacy::get_attribute tns design:z80_top_direct_n]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "21230"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden tns: 21230,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [::legacy::get_attribute cell_area design:z80_top_direct_n]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "94799"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden cell area: 94799,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [::legacy::get_attribute net_area design:z80_top_direct_n]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "49315"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden net area: 49315,  current net area: $_net_area_"
}
unset _net_area_
