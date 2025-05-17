set SynModuleInfo {
  {SRCNAME pooling_2x2_Block_entry.split_proc MODELNAME pooling_2x2_Block_entry_split_proc RTLNAME image_pooling_pooling_2x2_Block_entry_split_proc}
  {SRCNAME pooling_2x2 MODELNAME pooling_2x2 RTLNAME image_pooling_pooling_2x2}
  {SRCNAME image_pooling MODELNAME image_pooling RTLNAME image_pooling IS_TOP 1
    SUBMODULES {
      {MODELNAME image_pooling_linebuf_RAM_AUTO_1R1W RTLNAME image_pooling_linebuf_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME image_pooling_linebuf_1_RAM_AUTO_1R1W RTLNAME image_pooling_linebuf_1_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME image_pooling_gmem_m_axi RTLNAME image_pooling_gmem_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME image_pooling_control_s_axi RTLNAME image_pooling_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
