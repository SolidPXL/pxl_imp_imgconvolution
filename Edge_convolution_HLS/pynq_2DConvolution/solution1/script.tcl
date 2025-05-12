############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
## Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
############################################################
open_project pynq_2DConvolution
set_top conv2d_edge
add_files pynq_2DConvolution/source/conv2d_edge.cpp
add_files pynq_2DConvolution/source/conv2d_edge.h
add_files pynq_2DConvolution/source/test1.PNG
add_files -tb pynq_2DConvolution/source/conv2d_edge_tb.cpp
open_solution "solution1" -flow_target vivado
set_part {xc7z020clg400-1}
create_clock -period 8 -name default
config_export -display_name convolution2d_edge -format ip_catalog -output C:/DevWorks/HAC/pynq_2DConvolution/ip_repo -rtl verilog
source "./pynq_2DConvolution/solution1/directives.tcl"
csim_design -clean
csynth_design
cosim_design
export_design -rtl verilog -format ip_catalog -output C:/DevWorks/HAC/pynq_2DConvolution/ip_repo
