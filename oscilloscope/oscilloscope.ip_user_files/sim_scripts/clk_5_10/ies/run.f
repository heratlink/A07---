-makelib ies_lib/xil_defaultlib -sv \
  "E:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "E:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../oscilloscope.srcs/sources_1/ip/clk_5_10/clk_5_10_clk_wiz.v" \
  "../../../../oscilloscope.srcs/sources_1/ip/clk_5_10/clk_5_10.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

