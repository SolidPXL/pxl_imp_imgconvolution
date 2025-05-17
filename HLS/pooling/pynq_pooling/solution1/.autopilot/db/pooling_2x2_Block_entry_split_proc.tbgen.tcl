set moduleName pooling_2x2_Block_entry_split_proc
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {pooling_2x2_Block_entry.split_proc}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ window_0_0_0_0_0_0_val int 8 regular  }
	{ window_0_1_0_0_0_0_val int 8 regular  }
	{ window_1_0_0_0_0_0_val int 8 regular  }
	{ window_1_1_0_0_0_0_val int 8 regular  }
	{ max_val int 8 regular {pointer 1}  }
	{ min_val int 8 regular {pointer 1}  }
}
set hasAXIMCache 0
set hasAXIML2Cache 0
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "window_0_0_0_0_0_0_val", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "window_0_1_0_0_0_0_val", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "window_1_0_0_0_0_0_val", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "window_1_1_0_0_0_0_val", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "max_val", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "min_val", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 15
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ window_0_0_0_0_0_0_val sc_in sc_lv 8 signal 0 } 
	{ window_0_1_0_0_0_0_val sc_in sc_lv 8 signal 1 } 
	{ window_1_0_0_0_0_0_val sc_in sc_lv 8 signal 2 } 
	{ window_1_1_0_0_0_0_val sc_in sc_lv 8 signal 3 } 
	{ max_val sc_out sc_lv 8 signal 4 } 
	{ max_val_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ min_val sc_out sc_lv 8 signal 5 } 
	{ min_val_ap_vld sc_out sc_logic 1 outvld 5 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "window_0_0_0_0_0_0_val", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "window_0_0_0_0_0_0_val", "role": "default" }} , 
 	{ "name": "window_0_1_0_0_0_0_val", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "window_0_1_0_0_0_0_val", "role": "default" }} , 
 	{ "name": "window_1_0_0_0_0_0_val", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "window_1_0_0_0_0_0_val", "role": "default" }} , 
 	{ "name": "window_1_1_0_0_0_0_val", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "window_1_1_0_0_0_0_val", "role": "default" }} , 
 	{ "name": "max_val", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "max_val", "role": "default" }} , 
 	{ "name": "max_val_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "max_val", "role": "ap_vld" }} , 
 	{ "name": "min_val", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "min_val", "role": "default" }} , 
 	{ "name": "min_val_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "min_val", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "pooling_2x2_Block_entry_split_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "1", "EstimateLatencyMax" : "1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "window_0_0_0_0_0_0_val", "Type" : "None", "Direction" : "I"},
			{"Name" : "window_0_1_0_0_0_0_val", "Type" : "None", "Direction" : "I"},
			{"Name" : "window_1_0_0_0_0_0_val", "Type" : "None", "Direction" : "I"},
			{"Name" : "window_1_1_0_0_0_0_val", "Type" : "None", "Direction" : "I"},
			{"Name" : "max_val", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "min_val", "Type" : "Vld", "Direction" : "O"}]}]}


set ArgLastReadFirstWriteLatency {
	pooling_2x2_Block_entry_split_proc {
		window_0_0_0_0_0_0_val {Type I LastRead 0 FirstWrite -1}
		window_0_1_0_0_0_0_val {Type I LastRead 0 FirstWrite -1}
		window_1_0_0_0_0_0_val {Type I LastRead 0 FirstWrite -1}
		window_1_1_0_0_0_0_val {Type I LastRead 0 FirstWrite -1}
		max_val {Type O LastRead -1 FirstWrite 1}
		min_val {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "1"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	window_0_0_0_0_0_0_val { ap_none {  { window_0_0_0_0_0_0_val in_data 0 8 } } }
	window_0_1_0_0_0_0_val { ap_none {  { window_0_1_0_0_0_0_val in_data 0 8 } } }
	window_1_0_0_0_0_0_val { ap_none {  { window_1_0_0_0_0_0_val in_data 0 8 } } }
	window_1_1_0_0_0_0_val { ap_none {  { window_1_1_0_0_0_0_val in_data 0 8 } } }
	max_val { ap_vld {  { max_val out_data 1 8 }  { max_val_ap_vld out_vld 1 1 } } }
	min_val { ap_vld {  { min_val out_data 1 8 }  { min_val_ap_vld out_vld 1 1 } } }
}
