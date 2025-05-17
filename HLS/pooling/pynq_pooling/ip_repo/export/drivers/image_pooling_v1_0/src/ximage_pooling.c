// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "ximage_pooling.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XImage_pooling_CfgInitialize(XImage_pooling *InstancePtr, XImage_pooling_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XImage_pooling_Start(XImage_pooling *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_AP_CTRL) & 0x80;
    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XImage_pooling_IsDone(XImage_pooling *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XImage_pooling_IsIdle(XImage_pooling *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XImage_pooling_IsReady(XImage_pooling *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XImage_pooling_EnableAutoRestart(XImage_pooling *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XImage_pooling_DisableAutoRestart(XImage_pooling *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_AP_CTRL, 0);
}

void XImage_pooling_Set_src(XImage_pooling *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_SRC_DATA, (u32)(Data));
    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_SRC_DATA + 4, (u32)(Data >> 32));
}

u64 XImage_pooling_Get_src(XImage_pooling *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_SRC_DATA);
    Data += (u64)XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_SRC_DATA + 4) << 32;
    return Data;
}

void XImage_pooling_Set_dst_min(XImage_pooling *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_DST_MIN_DATA, (u32)(Data));
    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_DST_MIN_DATA + 4, (u32)(Data >> 32));
}

u64 XImage_pooling_Get_dst_min(XImage_pooling *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_DST_MIN_DATA);
    Data += (u64)XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_DST_MIN_DATA + 4) << 32;
    return Data;
}

void XImage_pooling_Set_dst_max(XImage_pooling *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_DST_MAX_DATA, (u32)(Data));
    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_DST_MAX_DATA + 4, (u32)(Data >> 32));
}

u64 XImage_pooling_Get_dst_max(XImage_pooling *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_DST_MAX_DATA);
    Data += (u64)XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_DST_MAX_DATA + 4) << 32;
    return Data;
}

void XImage_pooling_InterruptGlobalEnable(XImage_pooling *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_GIE, 1);
}

void XImage_pooling_InterruptGlobalDisable(XImage_pooling *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_GIE, 0);
}

void XImage_pooling_InterruptEnable(XImage_pooling *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_IER);
    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_IER, Register | Mask);
}

void XImage_pooling_InterruptDisable(XImage_pooling *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_IER);
    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_IER, Register & (~Mask));
}

void XImage_pooling_InterruptClear(XImage_pooling *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XImage_pooling_WriteReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_ISR, Mask);
}

u32 XImage_pooling_InterruptGetEnabled(XImage_pooling *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_IER);
}

u32 XImage_pooling_InterruptGetStatus(XImage_pooling *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XImage_pooling_ReadReg(InstancePtr->Control_BaseAddress, XIMAGE_POOLING_CONTROL_ADDR_ISR);
}

