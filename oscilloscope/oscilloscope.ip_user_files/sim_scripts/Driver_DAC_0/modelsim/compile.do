vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/blk_mem_gen_v8_4_2

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm
vmap blk_mem_gen_v8_4_2 modelsim_lib/msim/blk_mem_gen_v8_4_2

vlog -work xil_defaultlib -64 -incr -sv \
"E:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"E:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_4_2 -64 -incr \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr \
"../../../../oscilloscope.srcs/sources_1/ip/Driver_DAC_0/src/Sin_Rom/sim/Sin_Rom.v" \
"../../../../oscilloscope.srcs/sources_1/ip/Driver_DAC_0/src/Square_Rom/sim/Square_Rom.v" \
"../../../../oscilloscope.srcs/sources_1/ip/Driver_DAC_0/src/Triangle_Rom/sim/Triangle_Rom.v" \
"../../../../oscilloscope.srcs/sources_1/ip/Driver_DAC_0/sim/Clk_Division.v" \
"../../../../oscilloscope.srcs/sources_1/ip/Driver_DAC_0/sim/DDS_Addr_Generator.v" \
"../../../../oscilloscope.srcs/sources_1/ip/Driver_DAC_0/sim/Driver_DAC.v" \
"../../../../oscilloscope.srcs/sources_1/ip/Driver_DAC_0/sim/Driver_DAC_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

