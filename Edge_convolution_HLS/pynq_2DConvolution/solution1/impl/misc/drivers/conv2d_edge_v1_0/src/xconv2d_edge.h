// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XCONV2D_EDGE_H
#define XCONV2D_EDGE_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xconv2d_edge_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
} XConv2d_edge_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XConv2d_edge;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XConv2d_edge_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XConv2d_edge_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XConv2d_edge_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XConv2d_edge_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XConv2d_edge_Initialize(XConv2d_edge *InstancePtr, UINTPTR BaseAddress);
XConv2d_edge_Config* XConv2d_edge_LookupConfig(UINTPTR BaseAddress);
#else
int XConv2d_edge_Initialize(XConv2d_edge *InstancePtr, u16 DeviceId);
XConv2d_edge_Config* XConv2d_edge_LookupConfig(u16 DeviceId);
#endif
int XConv2d_edge_CfgInitialize(XConv2d_edge *InstancePtr, XConv2d_edge_Config *ConfigPtr);
#else
int XConv2d_edge_Initialize(XConv2d_edge *InstancePtr, const char* InstanceName);
int XConv2d_edge_Release(XConv2d_edge *InstancePtr);
#endif

void XConv2d_edge_Start(XConv2d_edge *InstancePtr);
u32 XConv2d_edge_IsDone(XConv2d_edge *InstancePtr);
u32 XConv2d_edge_IsIdle(XConv2d_edge *InstancePtr);
u32 XConv2d_edge_IsReady(XConv2d_edge *InstancePtr);
void XConv2d_edge_EnableAutoRestart(XConv2d_edge *InstancePtr);
void XConv2d_edge_DisableAutoRestart(XConv2d_edge *InstancePtr);

void XConv2d_edge_Set_input_r(XConv2d_edge *InstancePtr, u64 Data);
u64 XConv2d_edge_Get_input_r(XConv2d_edge *InstancePtr);
void XConv2d_edge_Set_output_r(XConv2d_edge *InstancePtr, u64 Data);
u64 XConv2d_edge_Get_output_r(XConv2d_edge *InstancePtr);

void XConv2d_edge_InterruptGlobalEnable(XConv2d_edge *InstancePtr);
void XConv2d_edge_InterruptGlobalDisable(XConv2d_edge *InstancePtr);
void XConv2d_edge_InterruptEnable(XConv2d_edge *InstancePtr, u32 Mask);
void XConv2d_edge_InterruptDisable(XConv2d_edge *InstancePtr, u32 Mask);
void XConv2d_edge_InterruptClear(XConv2d_edge *InstancePtr, u32 Mask);
u32 XConv2d_edge_InterruptGetEnabled(XConv2d_edge *InstancePtr);
u32 XConv2d_edge_InterruptGetStatus(XConv2d_edge *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
