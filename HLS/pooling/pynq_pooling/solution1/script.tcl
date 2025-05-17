############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
## Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
############################################################
open_project pynq_pooling
set_top image_pooling
add_files pynq_pooling/source/pooling.cpp
add_files pynq_pooling/source/pooling.h
add_files pynq_pooling/source/test1.PNG
add_files -tb pynq_pooling/source/pooling_tb.cpp
open_solution "solution1" -flow_target vivado
set_part {xc7z020-clg400-1}
create_clock -period 8 -name default
config_export -display_name image_pooling -format ip_catalog -output C:/DevWorks/HAC/pynq_pooling/ip_repo -rtl verilog -vendor robert
source "./pynq_pooling/solution1/directives.tcl"
csim_design -clean
csynth_design
cosim_design
export_design -rtl verilog -format ip_catalog -output C:/DevWorks/HAC/pynq_pooling/ip_repo
