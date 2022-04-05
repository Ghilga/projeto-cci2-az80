#####################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution on 04/04/2022 21:59:38
#
# This file can only be run in Innovus Common UI mode.
#
#####################################################################


# User Specified CPU usage for Innovus
######################################
set_multi_cpu_usage -local_cpu 8


# Design Import
###########################################################
## Reading FlowKit settings file
source innovus/z80_top_direct_n.flowkit_settings.tcl

source innovus/z80_top_direct_n.invs_init.tcl

# Reading metrics file
######################
read_metric -id current innovus/z80_top_direct_n.metrics.json 



# Mode Setup
###########################################################
source innovus/z80_top_direct_n.mode

# Import list of instances with subdesigns having boundary optimization disabled
################################################################################
set_db opt_keep_ports innovus/z80_top_direct_n.boundary_opto.tcl 


# Import list of size_only instances
######################################
set_db opt_size_only_file innovus/z80_top_direct_n.size_ok.tcl 

