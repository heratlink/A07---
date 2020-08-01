# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7s15ftgb196-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir E:/2018.3/vivado_program/oscilloscope/oscilloscope.cache/wt [current_project]
set_property parent.project_path E:/2018.3/vivado_program/oscilloscope/oscilloscope.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths {
  e:/2018.3/IP_Core/ADC-IP
  e:/2018.3/IP_Core/DAC-IP
  e:/2018.3/IP_Core/UART-IP
} [current_project]
update_ip_catalog
set_property ip_output_repo e:/2018.3/vivado_program/oscilloscope/oscilloscope.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_DAC_0/src/Sin_Wave_Rom.coe
add_files E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_DAC_0/src/Square_Wave_Rom.coe
add_files E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_DAC_0/src/Triangle_Wave_Rom.coe
read_verilog -library xil_defaultlib {
  E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/new/UART_Send0.v
  E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/new/oscilloscope.v
}
read_ip -quiet E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/clk_5_10/clk_5_10.xci
set_property used_in_implementation false [get_files -all e:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/clk_5_10/clk_5_10_board.xdc]
set_property used_in_implementation false [get_files -all e:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/clk_5_10/clk_5_10.xdc]
set_property used_in_implementation false [get_files -all e:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/clk_5_10/clk_5_10_ooc.xdc]

read_ip -quiet E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_ADC_0/Driver_ADC_0.xci
set_property used_in_implementation false [get_files -all e:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_ADC_0/src/Wave_Ram/Wave_Ram_ooc.xdc]

read_ip -quiet E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_DAC_0/Driver_DAC_0.xci
set_property used_in_implementation false [get_files -all e:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_DAC_0/src/Sin_Rom/Sin_Rom_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_DAC_0/src/Square_Rom/Square_Rom_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_DAC_0/src/Triangle_Rom/Triangle_Rom_ooc.xdc]

read_ip -quiet E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_UART_0/Driver_UART_0.xci

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/constrs_1/new/system.xdc
set_property used_in_implementation false [get_files E:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/constrs_1/new/system.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top oscilloscope -part xc7s15ftgb196-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef oscilloscope.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file oscilloscope_utilization_synth.rpt -pb oscilloscope_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
