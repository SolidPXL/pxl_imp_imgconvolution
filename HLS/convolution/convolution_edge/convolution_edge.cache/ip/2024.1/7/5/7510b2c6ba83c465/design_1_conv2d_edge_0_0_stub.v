// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Sat May 10 14:18:00 2025
// Host        : 5CD322B22T running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_conv2d_edge_0_0_stub.v
// Design      : design_1_conv2d_edge_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "conv2d_edge,Vivado 2024.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_control_ARADDR, 
  s_axi_control_ARREADY, s_axi_control_ARVALID, s_axi_control_AWADDR, 
  s_axi_control_AWREADY, s_axi_control_AWVALID, s_axi_control_BREADY, 
  s_axi_control_BRESP, s_axi_control_BVALID, s_axi_control_RDATA, s_axi_control_RREADY, 
  s_axi_control_RRESP, s_axi_control_RVALID, s_axi_control_WDATA, s_axi_control_WREADY, 
  s_axi_control_WSTRB, s_axi_control_WVALID, ap_clk, ap_rst_n, interrupt, m_axi_gmem0_ARADDR, 
  m_axi_gmem0_ARBURST, m_axi_gmem0_ARCACHE, m_axi_gmem0_ARID, m_axi_gmem0_ARLEN, 
  m_axi_gmem0_ARLOCK, m_axi_gmem0_ARPROT, m_axi_gmem0_ARQOS, m_axi_gmem0_ARREADY, 
  m_axi_gmem0_ARREGION, m_axi_gmem0_ARSIZE, m_axi_gmem0_ARVALID, m_axi_gmem0_AWADDR, 
  m_axi_gmem0_AWBURST, m_axi_gmem0_AWCACHE, m_axi_gmem0_AWID, m_axi_gmem0_AWLEN, 
  m_axi_gmem0_AWLOCK, m_axi_gmem0_AWPROT, m_axi_gmem0_AWQOS, m_axi_gmem0_AWREADY, 
  m_axi_gmem0_AWREGION, m_axi_gmem0_AWSIZE, m_axi_gmem0_AWVALID, m_axi_gmem0_BID, 
  m_axi_gmem0_BREADY, m_axi_gmem0_BRESP, m_axi_gmem0_BVALID, m_axi_gmem0_RDATA, 
  m_axi_gmem0_RID, m_axi_gmem0_RLAST, m_axi_gmem0_RREADY, m_axi_gmem0_RRESP, 
  m_axi_gmem0_RVALID, m_axi_gmem0_WDATA, m_axi_gmem0_WID, m_axi_gmem0_WLAST, 
  m_axi_gmem0_WREADY, m_axi_gmem0_WSTRB, m_axi_gmem0_WVALID, m_axi_gmem1_ARADDR, 
  m_axi_gmem1_ARBURST, m_axi_gmem1_ARCACHE, m_axi_gmem1_ARID, m_axi_gmem1_ARLEN, 
  m_axi_gmem1_ARLOCK, m_axi_gmem1_ARPROT, m_axi_gmem1_ARQOS, m_axi_gmem1_ARREADY, 
  m_axi_gmem1_ARREGION, m_axi_gmem1_ARSIZE, m_axi_gmem1_ARVALID, m_axi_gmem1_AWADDR, 
  m_axi_gmem1_AWBURST, m_axi_gmem1_AWCACHE, m_axi_gmem1_AWID, m_axi_gmem1_AWLEN, 
  m_axi_gmem1_AWLOCK, m_axi_gmem1_AWPROT, m_axi_gmem1_AWQOS, m_axi_gmem1_AWREADY, 
  m_axi_gmem1_AWREGION, m_axi_gmem1_AWSIZE, m_axi_gmem1_AWVALID, m_axi_gmem1_BID, 
  m_axi_gmem1_BREADY, m_axi_gmem1_BRESP, m_axi_gmem1_BVALID, m_axi_gmem1_RDATA, 
  m_axi_gmem1_RID, m_axi_gmem1_RLAST, m_axi_gmem1_RREADY, m_axi_gmem1_RRESP, 
  m_axi_gmem1_RVALID, m_axi_gmem1_WDATA, m_axi_gmem1_WID, m_axi_gmem1_WLAST, 
  m_axi_gmem1_WREADY, m_axi_gmem1_WSTRB, m_axi_gmem1_WVALID)
/* synthesis syn_black_box black_box_pad_pin="s_axi_control_ARADDR[5:0],s_axi_control_ARREADY,s_axi_control_ARVALID,s_axi_control_AWADDR[5:0],s_axi_control_AWREADY,s_axi_control_AWVALID,s_axi_control_BREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_RDATA[31:0],s_axi_control_RREADY,s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_WDATA[31:0],s_axi_control_WREADY,s_axi_control_WSTRB[3:0],s_axi_control_WVALID,ap_rst_n,interrupt,m_axi_gmem0_ARADDR[63:0],m_axi_gmem0_ARBURST[1:0],m_axi_gmem0_ARCACHE[3:0],m_axi_gmem0_ARID[0:0],m_axi_gmem0_ARLEN[7:0],m_axi_gmem0_ARLOCK[1:0],m_axi_gmem0_ARPROT[2:0],m_axi_gmem0_ARQOS[3:0],m_axi_gmem0_ARREADY,m_axi_gmem0_ARREGION[3:0],m_axi_gmem0_ARSIZE[2:0],m_axi_gmem0_ARVALID,m_axi_gmem0_AWADDR[63:0],m_axi_gmem0_AWBURST[1:0],m_axi_gmem0_AWCACHE[3:0],m_axi_gmem0_AWID[0:0],m_axi_gmem0_AWLEN[7:0],m_axi_gmem0_AWLOCK[1:0],m_axi_gmem0_AWPROT[2:0],m_axi_gmem0_AWQOS[3:0],m_axi_gmem0_AWREADY,m_axi_gmem0_AWREGION[3:0],m_axi_gmem0_AWSIZE[2:0],m_axi_gmem0_AWVALID,m_axi_gmem0_BID[0:0],m_axi_gmem0_BREADY,m_axi_gmem0_BRESP[1:0],m_axi_gmem0_BVALID,m_axi_gmem0_RDATA[31:0],m_axi_gmem0_RID[0:0],m_axi_gmem0_RLAST,m_axi_gmem0_RREADY,m_axi_gmem0_RRESP[1:0],m_axi_gmem0_RVALID,m_axi_gmem0_WDATA[31:0],m_axi_gmem0_WID[0:0],m_axi_gmem0_WLAST,m_axi_gmem0_WREADY,m_axi_gmem0_WSTRB[3:0],m_axi_gmem0_WVALID,m_axi_gmem1_ARADDR[63:0],m_axi_gmem1_ARBURST[1:0],m_axi_gmem1_ARCACHE[3:0],m_axi_gmem1_ARID[0:0],m_axi_gmem1_ARLEN[7:0],m_axi_gmem1_ARLOCK[1:0],m_axi_gmem1_ARPROT[2:0],m_axi_gmem1_ARQOS[3:0],m_axi_gmem1_ARREADY,m_axi_gmem1_ARREGION[3:0],m_axi_gmem1_ARSIZE[2:0],m_axi_gmem1_ARVALID,m_axi_gmem1_AWADDR[63:0],m_axi_gmem1_AWBURST[1:0],m_axi_gmem1_AWCACHE[3:0],m_axi_gmem1_AWID[0:0],m_axi_gmem1_AWLEN[7:0],m_axi_gmem1_AWLOCK[1:0],m_axi_gmem1_AWPROT[2:0],m_axi_gmem1_AWQOS[3:0],m_axi_gmem1_AWREADY,m_axi_gmem1_AWREGION[3:0],m_axi_gmem1_AWSIZE[2:0],m_axi_gmem1_AWVALID,m_axi_gmem1_BID[0:0],m_axi_gmem1_BREADY,m_axi_gmem1_BRESP[1:0],m_axi_gmem1_BVALID,m_axi_gmem1_RDATA[31:0],m_axi_gmem1_RID[0:0],m_axi_gmem1_RLAST,m_axi_gmem1_RREADY,m_axi_gmem1_RRESP[1:0],m_axi_gmem1_RVALID,m_axi_gmem1_WDATA[31:0],m_axi_gmem1_WID[0:0],m_axi_gmem1_WLAST,m_axi_gmem1_WREADY,m_axi_gmem1_WSTRB[3:0],m_axi_gmem1_WVALID" */
/* synthesis syn_force_seq_prim="ap_clk" */;
  input [5:0]s_axi_control_ARADDR;
  output s_axi_control_ARREADY;
  input s_axi_control_ARVALID;
  input [5:0]s_axi_control_AWADDR;
  output s_axi_control_AWREADY;
  input s_axi_control_AWVALID;
  input s_axi_control_BREADY;
  output [1:0]s_axi_control_BRESP;
  output s_axi_control_BVALID;
  output [31:0]s_axi_control_RDATA;
  input s_axi_control_RREADY;
  output [1:0]s_axi_control_RRESP;
  output s_axi_control_RVALID;
  input [31:0]s_axi_control_WDATA;
  output s_axi_control_WREADY;
  input [3:0]s_axi_control_WSTRB;
  input s_axi_control_WVALID;
  input ap_clk /* synthesis syn_isclock = 1 */;
  input ap_rst_n;
  output interrupt;
  output [63:0]m_axi_gmem0_ARADDR;
  output [1:0]m_axi_gmem0_ARBURST;
  output [3:0]m_axi_gmem0_ARCACHE;
  output [0:0]m_axi_gmem0_ARID;
  output [7:0]m_axi_gmem0_ARLEN;
  output [1:0]m_axi_gmem0_ARLOCK;
  output [2:0]m_axi_gmem0_ARPROT;
  output [3:0]m_axi_gmem0_ARQOS;
  input m_axi_gmem0_ARREADY;
  output [3:0]m_axi_gmem0_ARREGION;
  output [2:0]m_axi_gmem0_ARSIZE;
  output m_axi_gmem0_ARVALID;
  output [63:0]m_axi_gmem0_AWADDR;
  output [1:0]m_axi_gmem0_AWBURST;
  output [3:0]m_axi_gmem0_AWCACHE;
  output [0:0]m_axi_gmem0_AWID;
  output [7:0]m_axi_gmem0_AWLEN;
  output [1:0]m_axi_gmem0_AWLOCK;
  output [2:0]m_axi_gmem0_AWPROT;
  output [3:0]m_axi_gmem0_AWQOS;
  input m_axi_gmem0_AWREADY;
  output [3:0]m_axi_gmem0_AWREGION;
  output [2:0]m_axi_gmem0_AWSIZE;
  output m_axi_gmem0_AWVALID;
  input [0:0]m_axi_gmem0_BID;
  output m_axi_gmem0_BREADY;
  input [1:0]m_axi_gmem0_BRESP;
  input m_axi_gmem0_BVALID;
  input [31:0]m_axi_gmem0_RDATA;
  input [0:0]m_axi_gmem0_RID;
  input m_axi_gmem0_RLAST;
  output m_axi_gmem0_RREADY;
  input [1:0]m_axi_gmem0_RRESP;
  input m_axi_gmem0_RVALID;
  output [31:0]m_axi_gmem0_WDATA;
  output [0:0]m_axi_gmem0_WID;
  output m_axi_gmem0_WLAST;
  input m_axi_gmem0_WREADY;
  output [3:0]m_axi_gmem0_WSTRB;
  output m_axi_gmem0_WVALID;
  output [63:0]m_axi_gmem1_ARADDR;
  output [1:0]m_axi_gmem1_ARBURST;
  output [3:0]m_axi_gmem1_ARCACHE;
  output [0:0]m_axi_gmem1_ARID;
  output [7:0]m_axi_gmem1_ARLEN;
  output [1:0]m_axi_gmem1_ARLOCK;
  output [2:0]m_axi_gmem1_ARPROT;
  output [3:0]m_axi_gmem1_ARQOS;
  input m_axi_gmem1_ARREADY;
  output [3:0]m_axi_gmem1_ARREGION;
  output [2:0]m_axi_gmem1_ARSIZE;
  output m_axi_gmem1_ARVALID;
  output [63:0]m_axi_gmem1_AWADDR;
  output [1:0]m_axi_gmem1_AWBURST;
  output [3:0]m_axi_gmem1_AWCACHE;
  output [0:0]m_axi_gmem1_AWID;
  output [7:0]m_axi_gmem1_AWLEN;
  output [1:0]m_axi_gmem1_AWLOCK;
  output [2:0]m_axi_gmem1_AWPROT;
  output [3:0]m_axi_gmem1_AWQOS;
  input m_axi_gmem1_AWREADY;
  output [3:0]m_axi_gmem1_AWREGION;
  output [2:0]m_axi_gmem1_AWSIZE;
  output m_axi_gmem1_AWVALID;
  input [0:0]m_axi_gmem1_BID;
  output m_axi_gmem1_BREADY;
  input [1:0]m_axi_gmem1_BRESP;
  input m_axi_gmem1_BVALID;
  input [31:0]m_axi_gmem1_RDATA;
  input [0:0]m_axi_gmem1_RID;
  input m_axi_gmem1_RLAST;
  output m_axi_gmem1_RREADY;
  input [1:0]m_axi_gmem1_RRESP;
  input m_axi_gmem1_RVALID;
  output [31:0]m_axi_gmem1_WDATA;
  output [0:0]m_axi_gmem1_WID;
  output m_axi_gmem1_WLAST;
  input m_axi_gmem1_WREADY;
  output [3:0]m_axi_gmem1_WSTRB;
  output m_axi_gmem1_WVALID;
endmodule
