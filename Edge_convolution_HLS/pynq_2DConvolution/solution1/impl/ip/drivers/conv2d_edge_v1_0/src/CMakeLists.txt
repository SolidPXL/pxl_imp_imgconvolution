# ==============================================================
# Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1 (64-bit)
# Tool Version Limit: 2024.05
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
# 
# ==============================================================
cmake_minimum_required(VERSION 3.15)
project(conv2d_edge)
find_package(common)
collector_create (PROJECT_LIB_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}")
collect (PROJECT_LIB_SOURCES xconv2d_edge.c)
collect (PROJECT_LIB_SOURCES xconv2d_edge_sinit.c)
collect (PROJECT_LIB_SOURCES xconv2d_edge_linux.c)
collect (PROJECT_LIB_SOURCES xconv2d_edge_g.c)
collector_list (_sources PROJECT_LIB_SOURCES)
collector_create (PROJECT_LIB_HEADERS "${CMAKE_CURRENT_SOURCE_DIR}")
collect (PROJECT_LIB_HEADERS xconv2d_edge.h)
collect (PROJECT_LIB_HEADERS xconv2d_edge_hw.h)
collector_list (_headers PROJECT_LIB_HEADERS)
file(COPY ${_headers} DESTINATION ${CMAKE_BINARY_DIR}/include)
include_directories(${CMAKE_BINARY_DIR}/include)
add_library(conv2d_edge STATIC ${_sources})
set_target_properties(conv2d_edge PROPERTIES LINKER_LANGUAGE C)

