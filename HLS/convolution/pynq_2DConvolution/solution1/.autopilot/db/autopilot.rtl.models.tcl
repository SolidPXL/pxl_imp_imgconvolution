set SynModuleInfo {
  {SRCNAME conv2d_edge MODELNAME conv2d_edge RTLNAME conv2d_edge IS_TOP 1
    SUBMODULES {
      {MODELNAME conv2d_edge_linebuf_RAM_AUTO_1R1W RTLNAME conv2d_edge_linebuf_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME conv2d_edge_linebuf_1_RAM_1WNR_AUTO_1R1W RTLNAME conv2d_edge_linebuf_1_RAM_1WNR_AUTO_1R1W BINDTYPE storage TYPE ram_1wnr IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME conv2d_edge_gmem0_m_axi RTLNAME conv2d_edge_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME conv2d_edge_gmem1_m_axi RTLNAME conv2d_edge_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME conv2d_edge_control_s_axi RTLNAME conv2d_edge_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
      {MODELNAME conv2d_edge_flow_control_loop_delay_pipe RTLNAME conv2d_edge_flow_control_loop_delay_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME conv2d_edge_flow_control_loop_delay_pipe_U}
    }
  }
}
