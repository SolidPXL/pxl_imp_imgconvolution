// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XIMAGE_POOLING_H
#define XIMAGE_POOLING_H

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
#include "ximage_pooling_hw.h"

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
} XImage_pooling_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XImage_pooling;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XImage_pooling_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XImage_pooling_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XImage_pooling_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XImage_pooling_ReadReg(BaseAddress, RegOffset) \
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
int XImage_pooling_Initialize(XImage_pooling *InstancePtr, UINTPTR BaseAddress);
XImage_pooling_Config* XImage_pooling_LookupConfig(UINTPTR BaseAddress);
#else
int XImage_pooling_Initialize(XImage_pooling *InstancePtr, u16 DeviceId);
XImage_pooling_Config* XImage_pooling_LookupConfig(u16 DeviceId);
#endif
int XImage_pooling_CfgInitialize(XImage_pooling *InstancePtr, XImage_pooling_Config *ConfigPtr);
#else
int XImage_pooling_Initialize(XImage_pooling *InstancePtr, const char* InstanceName);
int XImage_pooling_Release(XImage_pooling *InstancePtr);
#endif

void XImage_pooling_Start(XImage_pooling *InstancePtr);
u32 XImage_pooling_IsDone(XImage_pooling *InstancePtr);
u32 XImage_pooling_IsIdle(XImage_pooling *InstancePtr);
u32 XImage_pooling_IsReady(XImage_pooling *InstancePtr);
void XImage_pooling_EnableAutoRestart(XImage_pooling *InstancePtr);
void XImage_pooling_DisableAutoRestart(XImage_pooling *InstancePtr);

void XImage_pooling_Set_src(XImage_pooling *InstancePtr, u64 Data);
u64 XImage_pooling_Get_src(XImage_pooling *InstancePtr);
void XImage_pooling_Set_dst_min(XImage_pooling *InstancePtr, u64 Data);
u64 XImage_pooling_Get_dst_min(XImage_pooling *InstancePtr);
void XImage_pooling_Set_dst_max(XImage_pooling *InstancePtr, u64 Data);
u64 XImage_pooling_Get_dst_max(XImage_pooling *InstancePtr);

void XImage_pooling_InterruptGlobalEnable(XImage_pooling *InstancePtr);
void XImage_pooling_InterruptGlobalDisable(XImage_pooling *InstancePtr);
void XImage_pooling_InterruptEnable(XImage_pooling *InstancePtr, u32 Mask);
void XImage_pooling_InterruptDisable(XImage_pooling *InstancePtr, u32 Mask);
void XImage_pooling_InterruptClear(XImage_pooling *InstancePtr, u32 Mask);
u32 XImage_pooling_InterruptGetEnabled(XImage_pooling *InstancePtr);
u32 XImage_pooling_InterruptGetStatus(XImage_pooling *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
