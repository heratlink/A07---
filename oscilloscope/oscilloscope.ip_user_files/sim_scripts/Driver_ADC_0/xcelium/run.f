-makelib xcelium_lib/xil_defaultlib -sv \
  "E:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "E:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_2 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../oscilloscope.srcs/sources_1/ip/Driver_ADC_0/src/Wave_Ram/sim/Wave_Ram.v" \
  "../../../../oscilloscope.srcs/sources_1/ip/Driver_ADC_0/sim/Clk_Division.v" \
  "../../../../oscilloscope.srcs/sources_1/ip/Driver_ADC_0/sim/Freq_Cal.v" \
  "../../../../oscilloscope.srcs/sources_1/ip/Driver_ADC_0/sim/Driver_ADC.v" \
  "../../../../oscilloscope.srcs/sources_1/ip/Driver_ADC_0/sim/Driver_ADC_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

