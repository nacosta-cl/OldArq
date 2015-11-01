# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/HA.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/FA.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/ADD16b.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/XOR16b.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/SUS16b.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/ShiftR16b.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/ShiftL16b.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/OR16b.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/NOT16b.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/AND16b.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/CU.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/ROM.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/reg_3b.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/Reg.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/RAM.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/PC.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/MUX_2b_12d.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/MUX.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/Led_Driver.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/Clock_Divider.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/ALU.vhd}
  {C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/sources_1/new/Basys3.vhd}
}
read_xdc {{C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/constrs_1/new/Basys3.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Nacosta/Documents/DEV/Arqui/ArquiProyectos/Entrega 3/Proyecto Base.srcs/constrs_1/new/Basys3.xdc}}]

synth_design -top Basys3 -part xc7a35tcpg236-1
write_checkpoint -noxdef Basys3.dcp
catch { report_utilization -file Basys3_utilization_synth.rpt -pb Basys3_utilization_synth.pb }
