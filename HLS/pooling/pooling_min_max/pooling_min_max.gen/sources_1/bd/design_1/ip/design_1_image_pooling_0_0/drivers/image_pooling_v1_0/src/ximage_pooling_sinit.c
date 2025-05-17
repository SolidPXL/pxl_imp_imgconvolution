// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "ximage_pooling.h"

extern XImage_pooling_Config XImage_pooling_ConfigTable[];

#ifdef SDT
XImage_pooling_Config *XImage_pooling_LookupConfig(UINTPTR BaseAddress) {
	XImage_pooling_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XImage_pooling_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XImage_pooling_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XImage_pooling_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XImage_pooling_Initialize(XImage_pooling *InstancePtr, UINTPTR BaseAddress) {
	XImage_pooling_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XImage_pooling_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XImage_pooling_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XImage_pooling_Config *XImage_pooling_LookupConfig(u16 DeviceId) {
	XImage_pooling_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XIMAGE_POOLING_NUM_INSTANCES; Index++) {
		if (XImage_pooling_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XImage_pooling_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XImage_pooling_Initialize(XImage_pooling *InstancePtr, u16 DeviceId) {
	XImage_pooling_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XImage_pooling_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XImage_pooling_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

