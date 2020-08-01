vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../../oscilloscope.srcs/sources_1/ip/Driver_UART_0/sim/Clk_Division.v" \
"../../../../oscilloscope.srcs/sources_1/ip/Driver_UART_0/sim/Driver_UART.v" \
"../../../../oscilloscope.srcs/sources_1/ip/Driver_UART_0/sim/Driver_UART_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

