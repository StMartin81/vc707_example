
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7vx485tffg1761-2
   set_property BOARD_PART xilinx.com:vc707:part0:1.3 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:mig_7series:4.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:xdma:4.1\
xilinx.com:ip:axi_emc:3.0\
xilinx.com:ip:axi_quad_spi:3.2\
xilinx.com:ip:axi_uartlite:2.0\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:lmb_v10:3.0\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}


##################################################################
# MIG PRJ FILE TCL PROCs
##################################################################

proc write_mig_file_design_1_mig_7series_0 { str_mig_prj_filepath } {

   file mkdir [ file dirname "$str_mig_prj_filepath" ]
   set mig_prj_file [open $str_mig_prj_filepath  w+]

   puts $mig_prj_file {<?xml version='1.0' encoding='UTF-8'?>}
   puts $mig_prj_file {<!-- IMPORTANT: This is an internal file that has been generated by the MIG software. Any direct editing or changes made to this file may result in unpredictable behavior or data corruption. It is strongly advised that users do not edit the contents of this file. Re-run the MIG GUI with the required settings if any of the options provided below need to be altered. -->}
   puts $mig_prj_file {<Project NoOfControllers="1" >}
   puts $mig_prj_file {    <ModuleName>design_1_mig_7series_0_0</ModuleName>}
   puts $mig_prj_file {    <dci_inouts_inputs>1</dci_inouts_inputs>}
   puts $mig_prj_file {    <dci_inputs>1</dci_inputs>}
   puts $mig_prj_file {    <Debug_En>OFF</Debug_En>}
   puts $mig_prj_file {    <DataDepth_En>1024</DataDepth_En>}
   puts $mig_prj_file {    <LowPower_En>ON</LowPower_En>}
   puts $mig_prj_file {    <XADC_En>Enabled</XADC_En>}
   puts $mig_prj_file {    <TargetFPGA>xc7vx485t-ffg1761/-2</TargetFPGA>}
   puts $mig_prj_file {    <Version>4.1</Version>}
   puts $mig_prj_file {    <SystemClock>Differential</SystemClock>}
   puts $mig_prj_file {    <ReferenceClock>Use System Clock</ReferenceClock>}
   puts $mig_prj_file {    <SysResetPolarity>ACTIVE HIGH</SysResetPolarity>}
   puts $mig_prj_file {    <BankSelectionFlag>FALSE</BankSelectionFlag>}
   puts $mig_prj_file {    <InternalVref>0</InternalVref>}
   puts $mig_prj_file {    <dci_hr_inouts_inputs>50 Ohms</dci_hr_inouts_inputs>}
   puts $mig_prj_file {    <dci_cascade>0</dci_cascade>}
   puts $mig_prj_file {    <Controller number="0" >}
   puts $mig_prj_file {        <MemoryDevice>DDR3_SDRAM/sodimms/MT8JTF12864HZ-1G6</MemoryDevice>}
   puts $mig_prj_file {        <TimePeriod>1250</TimePeriod>}
   puts $mig_prj_file {        <VccAuxIO>2.0V</VccAuxIO>}
   puts $mig_prj_file {        <PHYRatio>4:1</PHYRatio>}
   puts $mig_prj_file {        <InputClkFreq>200</InputClkFreq>}
   puts $mig_prj_file {        <UIExtraClocks>0</UIExtraClocks>}
   puts $mig_prj_file {        <MMCM_VCO>800</MMCM_VCO>}
   puts $mig_prj_file {        <MMCMClkOut0> 2.500</MMCMClkOut0>}
   puts $mig_prj_file {        <MMCMClkOut1>1</MMCMClkOut1>}
   puts $mig_prj_file {        <MMCMClkOut2>1</MMCMClkOut2>}
   puts $mig_prj_file {        <MMCMClkOut3>1</MMCMClkOut3>}
   puts $mig_prj_file {        <MMCMClkOut4>1</MMCMClkOut4>}
   puts $mig_prj_file {        <DataWidth>64</DataWidth>}
   puts $mig_prj_file {        <DeepMemory>1</DeepMemory>}
   puts $mig_prj_file {        <DataMask>1</DataMask>}
   puts $mig_prj_file {        <ECC>Disabled</ECC>}
   puts $mig_prj_file {        <Ordering>Normal</Ordering>}
   puts $mig_prj_file {        <BankMachineCnt>4</BankMachineCnt>}
   puts $mig_prj_file {        <CustomPart>FALSE</CustomPart>}
   puts $mig_prj_file {        <NewPartName></NewPartName>}
   puts $mig_prj_file {        <RowAddress>14</RowAddress>}
   puts $mig_prj_file {        <ColAddress>10</ColAddress>}
   puts $mig_prj_file {        <BankAddress>3</BankAddress>}
   puts $mig_prj_file {        <MemoryVoltage>1.5V</MemoryVoltage>}
   puts $mig_prj_file {        <C0_MEM_SIZE>1073741824</C0_MEM_SIZE>}
   puts $mig_prj_file {        <UserMemoryAddressMap>ROW_BANK_COLUMN</UserMemoryAddressMap>}
   puts $mig_prj_file {        <PinSelection>}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="A20" SLEW="" name="ddr3_addr[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="B21" SLEW="" name="ddr3_addr[10]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="B17" SLEW="" name="ddr3_addr[11]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="A15" SLEW="" name="ddr3_addr[12]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="A21" SLEW="" name="ddr3_addr[13]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="B19" SLEW="" name="ddr3_addr[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="C20" SLEW="" name="ddr3_addr[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="A19" SLEW="" name="ddr3_addr[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="A17" SLEW="" name="ddr3_addr[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="A16" SLEW="" name="ddr3_addr[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="D20" SLEW="" name="ddr3_addr[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="C18" SLEW="" name="ddr3_addr[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="D17" SLEW="" name="ddr3_addr[8]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="C19" SLEW="" name="ddr3_addr[9]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="D21" SLEW="" name="ddr3_ba[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="C21" SLEW="" name="ddr3_ba[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="D18" SLEW="" name="ddr3_ba[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="K17" SLEW="" name="ddr3_cas_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15" PADName="G18" SLEW="" name="ddr3_ck_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15" PADName="H19" SLEW="" name="ddr3_ck_p[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="K19" SLEW="" name="ddr3_cke[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="J17" SLEW="" name="ddr3_cs_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="M13" SLEW="" name="ddr3_dm[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="K15" SLEW="" name="ddr3_dm[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="F12" SLEW="" name="ddr3_dm[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="A14" SLEW="" name="ddr3_dm[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="C23" SLEW="" name="ddr3_dm[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="D25" SLEW="" name="ddr3_dm[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="C31" SLEW="" name="ddr3_dm[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="F31" SLEW="" name="ddr3_dm[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="N14" SLEW="" name="ddr3_dq[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="H13" SLEW="" name="ddr3_dq[10]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="J13" SLEW="" name="ddr3_dq[11]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="L16" SLEW="" name="ddr3_dq[12]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="L15" SLEW="" name="ddr3_dq[13]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="H14" SLEW="" name="ddr3_dq[14]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="J15" SLEW="" name="ddr3_dq[15]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="E15" SLEW="" name="ddr3_dq[16]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="E13" SLEW="" name="ddr3_dq[17]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="F15" SLEW="" name="ddr3_dq[18]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="E14" SLEW="" name="ddr3_dq[19]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="N13" SLEW="" name="ddr3_dq[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="G13" SLEW="" name="ddr3_dq[20]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="G12" SLEW="" name="ddr3_dq[21]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="F14" SLEW="" name="ddr3_dq[22]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="G14" SLEW="" name="ddr3_dq[23]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="B14" SLEW="" name="ddr3_dq[24]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="C13" SLEW="" name="ddr3_dq[25]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="B16" SLEW="" name="ddr3_dq[26]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="D15" SLEW="" name="ddr3_dq[27]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="D13" SLEW="" name="ddr3_dq[28]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="E12" SLEW="" name="ddr3_dq[29]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="L14" SLEW="" name="ddr3_dq[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="C16" SLEW="" name="ddr3_dq[30]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="D16" SLEW="" name="ddr3_dq[31]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="A24" SLEW="" name="ddr3_dq[32]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="B23" SLEW="" name="ddr3_dq[33]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="B27" SLEW="" name="ddr3_dq[34]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="B26" SLEW="" name="ddr3_dq[35]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="A22" SLEW="" name="ddr3_dq[36]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="B22" SLEW="" name="ddr3_dq[37]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="A25" SLEW="" name="ddr3_dq[38]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="C24" SLEW="" name="ddr3_dq[39]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="M14" SLEW="" name="ddr3_dq[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="E24" SLEW="" name="ddr3_dq[40]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="D23" SLEW="" name="ddr3_dq[41]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="D26" SLEW="" name="ddr3_dq[42]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="C25" SLEW="" name="ddr3_dq[43]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="E23" SLEW="" name="ddr3_dq[44]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="D22" SLEW="" name="ddr3_dq[45]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="F22" SLEW="" name="ddr3_dq[46]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="E22" SLEW="" name="ddr3_dq[47]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="A30" SLEW="" name="ddr3_dq[48]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="D27" SLEW="" name="ddr3_dq[49]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="M12" SLEW="" name="ddr3_dq[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="A29" SLEW="" name="ddr3_dq[50]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="C28" SLEW="" name="ddr3_dq[51]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="D28" SLEW="" name="ddr3_dq[52]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="B31" SLEW="" name="ddr3_dq[53]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="A31" SLEW="" name="ddr3_dq[54]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="A32" SLEW="" name="ddr3_dq[55]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="E30" SLEW="" name="ddr3_dq[56]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="F29" SLEW="" name="ddr3_dq[57]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="F30" SLEW="" name="ddr3_dq[58]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="F27" SLEW="" name="ddr3_dq[59]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="N15" SLEW="" name="ddr3_dq[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="C30" SLEW="" name="ddr3_dq[60]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="E29" SLEW="" name="ddr3_dq[61]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="F26" SLEW="" name="ddr3_dq[62]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="D30" SLEW="" name="ddr3_dq[63]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="M11" SLEW="" name="ddr3_dq[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="L12" SLEW="" name="ddr3_dq[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="K14" SLEW="" name="ddr3_dq[8]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15_T_DCI" PADName="K13" SLEW="" name="ddr3_dq[9]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="M16" SLEW="" name="ddr3_dqs_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="J12" SLEW="" name="ddr3_dqs_n[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="G16" SLEW="" name="ddr3_dqs_n[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="C14" SLEW="" name="ddr3_dqs_n[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="A27" SLEW="" name="ddr3_dqs_n[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="E25" SLEW="" name="ddr3_dqs_n[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="B29" SLEW="" name="ddr3_dqs_n[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="E28" SLEW="" name="ddr3_dqs_n[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="N16" SLEW="" name="ddr3_dqs_p[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="K12" SLEW="" name="ddr3_dqs_p[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="H16" SLEW="" name="ddr3_dqs_p[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="C15" SLEW="" name="ddr3_dqs_p[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="A26" SLEW="" name="ddr3_dqs_p[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="F25" SLEW="" name="ddr3_dqs_p[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="B28" SLEW="" name="ddr3_dqs_p[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="E27" SLEW="" name="ddr3_dqs_p[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="H20" SLEW="" name="ddr3_odt[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="E20" SLEW="" name="ddr3_ras_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="LVCMOS15" PADName="C29" SLEW="" name="ddr3_reset_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="HIGH" IOSTANDARD="SSTL15" PADName="F20" SLEW="" name="ddr3_we_n" IN_TERM="" />}
   puts $mig_prj_file {        </PinSelection>}
   puts $mig_prj_file {        <System_Clock>}
   puts $mig_prj_file {            <Pin PADName="E19/E18(CC_P/N)" Bank="38" name="sys_clk_p/n" />}
   puts $mig_prj_file {        </System_Clock>}
   puts $mig_prj_file {        <System_Control>}
   puts $mig_prj_file {            <Pin PADName="AV40(MRCC_P)" Bank="15" name="sys_rst" />}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="init_calib_complete" />}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="tg_compare_error" />}
   puts $mig_prj_file {        </System_Control>}
   puts $mig_prj_file {        <TimingParameters>}
   puts $mig_prj_file {            <Parameters twtr="7.5" trrd="6" trefi="7.8" tfaw="30" trtp="7.5" tcke="5" trfc="110" trp="13.75" tras="35" trcd="13.75" />}
   puts $mig_prj_file {        </TimingParameters>}
   puts $mig_prj_file {        <mrBurstLength name="Burst Length" >8 - Fixed</mrBurstLength>}
   puts $mig_prj_file {        <mrBurstType name="Read Burst Type and Length" >Sequential</mrBurstType>}
   puts $mig_prj_file {        <mrCasLatency name="CAS Latency" >11</mrCasLatency>}
   puts $mig_prj_file {        <mrMode name="Mode" >Normal</mrMode>}
   puts $mig_prj_file {        <mrDllReset name="DLL Reset" >No</mrDllReset>}
   puts $mig_prj_file {        <mrPdMode name="DLL control for precharge PD" >Slow Exit</mrPdMode>}
   puts $mig_prj_file {        <emrDllEnable name="DLL Enable" >Enable</emrDllEnable>}
   puts $mig_prj_file {        <emrOutputDriveStrength name="Output Driver Impedance Control" >RZQ/7</emrOutputDriveStrength>}
   puts $mig_prj_file {        <emrMirrorSelection name="Address Mirroring" >Disable</emrMirrorSelection>}
   puts $mig_prj_file {        <emrCSSelection name="Controller Chip Select Pin" >Enable</emrCSSelection>}
   puts $mig_prj_file {        <emrRTT name="RTT (nominal) - On Die Termination (ODT)" >RZQ/6</emrRTT>}
   puts $mig_prj_file {        <emrPosted name="Additive Latency (AL)" >0</emrPosted>}
   puts $mig_prj_file {        <emrOCD name="Write Leveling Enable" >Disabled</emrOCD>}
   puts $mig_prj_file {        <emrDQS name="TDQS enable" >Enabled</emrDQS>}
   puts $mig_prj_file {        <emrRDQS name="Qoff" >Output Buffer Enabled</emrRDQS>}
   puts $mig_prj_file {        <mr2PartialArraySelfRefresh name="Partial-Array Self Refresh" >Full Array</mr2PartialArraySelfRefresh>}
   puts $mig_prj_file {        <mr2CasWriteLatency name="CAS write latency" >8</mr2CasWriteLatency>}
   puts $mig_prj_file {        <mr2AutoSelfRefresh name="Auto Self Refresh" >Enabled</mr2AutoSelfRefresh>}
   puts $mig_prj_file {        <mr2SelfRefreshTempRange name="High Temparature Self Refresh Rate" >Normal</mr2SelfRefreshTempRange>}
   puts $mig_prj_file {        <mr2RTTWR name="RTT_WR - Dynamic On Die Termination (ODT)" >Dynamic ODT off</mr2RTTWR>}
   puts $mig_prj_file {        <PortInterface>AXI</PortInterface>}
   puts $mig_prj_file {        <AXIParameters>}
   puts $mig_prj_file {            <C0_C_RD_WR_ARB_ALGORITHM>RD_PRI_REG</C0_C_RD_WR_ARB_ALGORITHM>}
   puts $mig_prj_file {            <C0_S_AXI_ADDR_WIDTH>30</C0_S_AXI_ADDR_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_DATA_WIDTH>512</C0_S_AXI_DATA_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_ID_WIDTH>1</C0_S_AXI_ID_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_SUPPORTS_NARROW_BURST>0</C0_S_AXI_SUPPORTS_NARROW_BURST>}
   puts $mig_prj_file {        </AXIParameters>}
   puts $mig_prj_file {    </Controller>}
   puts $mig_prj_file {</Project>}

   close $mig_prj_file
}
# End of write_mig_file_design_1_mig_7series_0()



##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_memory
proc create_hier_cell_microblaze_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_microblaze_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 dlmb

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ilmb


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rst

  # Create instance: axi_lmb_bram, and set properties
  set axi_lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_lmb_bram ]
  set_property -dict [ list \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Use_RSTB_Pin {false} \
 ] $axi_lmb_bram

  # Create instance: dlmb, and set properties
  set dlmb [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb ]

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]

  # Create instance: ilmb, and set properties
  set ilmb [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]

  # Create interface connections
  connect_bd_intf_net -intf_net dlmb [get_bd_intf_pins dlmb] [get_bd_intf_pins dlmb/LMB_M]
  connect_bd_intf_net -intf_net dlmb_0 [get_bd_intf_pins dlmb/LMB_Sl_0] [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB]
  connect_bd_intf_net -intf_net dlmb_bram [get_bd_intf_pins axi_lmb_bram/BRAM_PORTB] [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT]
  connect_bd_intf_net -intf_net ilmb [get_bd_intf_pins ilmb] [get_bd_intf_pins ilmb/LMB_M]
  connect_bd_intf_net -intf_net ilmb_0 [get_bd_intf_pins ilmb/LMB_Sl_0] [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB]
  connect_bd_intf_net -intf_net ilmb_bram [get_bd_intf_pins axi_lmb_bram/BRAM_PORTA] [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT]

  # Create port connections
  connect_bd_net -net clk [get_bd_pins clk] [get_bd_pins dlmb/LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk]
  connect_bd_net -net rst [get_bd_pins rst] [get_bd_pins dlmb/SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: peripheral_subsystem
proc create_hier_cell_peripheral_subsystem { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_peripheral_subsystem() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 linear_flash

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 rs232_uart

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_emc

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_quad_spi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_uart


  # Create pins
  create_bd_pin -dir I -type clk ddr_ui_clk
  create_bd_pin -dir O -type intr o_axi_uartlite_irq
  create_bd_pin -dir O -type intr o_quad_spi_irq
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir IO -from 15 -to 0 spi_cs_n
  create_bd_pin -dir IO -from 15 -to 0 spi_cs_p
  create_bd_pin -dir IO -from 0 -to 0 spi_miso_n
  create_bd_pin -dir IO -from 0 -to 0 spi_miso_p
  create_bd_pin -dir IO -from 0 -to 0 spi_mosi_n
  create_bd_pin -dir IO -from 0 -to 0 spi_mosi_p
  create_bd_pin -dir IO -from 0 -to 0 spi_sclk_n
  create_bd_pin -dir IO -from 0 -to 0 spi_sclk_p

  # Create instance: axi_emc, and set properties
  set axi_emc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 axi_emc ]
  set_property -dict [ list \
   CONFIG.C_MEM0_TYPE {2} \
   CONFIG.C_TAVDV_PS_MEM_0 {130000} \
   CONFIG.C_TCEDV_PS_MEM_0 {130000} \
   CONFIG.C_THZCE_PS_MEM_0 {35000} \
   CONFIG.C_THZOE_PS_MEM_0 {7000} \
   CONFIG.C_TLZWE_PS_MEM_0 {35000} \
   CONFIG.C_TWC_PS_MEM_0 {13000} \
   CONFIG.C_TWPH_PS_MEM_0 {12000} \
   CONFIG.C_TWP_PS_MEM_0 {70000} \
   CONFIG.C_WR_REC_TIME_MEM_0 {100000} \
   CONFIG.EMC_BOARD_INTERFACE {linear_flash} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_emc

  # Create instance: axi_quad_spi, and set properties
  set axi_quad_spi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi ]
  set_property -dict [ list \
   CONFIG.C_FIFO_DEPTH {256} \
   CONFIG.C_NUM_SS_BITS {16} \
   CONFIG.C_SCK_RATIO {16} \
   CONFIG.C_TYPE_OF_AXI4_INTERFACE {0} \
   CONFIG.C_USE_STARTUP {0} \
   CONFIG.C_USE_STARTUP_INT {0} \
   CONFIG.C_XIP_MODE {0} \
   CONFIG.Master_mode {1} \
   CONFIG.Multiples16 {8} \
 ] $axi_quad_spi

  # Create instance: axi_uartlite, and set properties
  set axi_uartlite [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite ]
  set_property -dict [ list \
   CONFIG.C_BAUDRATE {115200} \
   CONFIG.C_S_AXI_ACLK_FREQ_HZ {200000000} \
   CONFIG.UARTLITE_BOARD_INTERFACE {rs232_uart} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_uartlite

  # Create instance: spi_cs, and set properties
  set spi_cs [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 spi_cs ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IOBUFDS} \
   CONFIG.C_SIZE {16} \
 ] $spi_cs

  # Create instance: spi_miso, and set properties
  set spi_miso [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 spi_miso ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IOBUFDS} \
 ] $spi_miso

  # Create instance: spi_mosi, and set properties
  set spi_mosi [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 spi_mosi ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IOBUFDS} \
 ] $spi_mosi

  # Create instance: spi_sclk, and set properties
  set spi_sclk [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 spi_sclk ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IOBUFDS} \
 ] $spi_sclk

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {16} \
 ] $xlconcat_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_quad_spi [get_bd_intf_pins s_axi_quad_spi] [get_bd_intf_pins axi_quad_spi/AXI_LITE]
  connect_bd_intf_net -intf_net microblaze_processor_system_linear_flash [get_bd_intf_pins linear_flash] [get_bd_intf_pins axi_emc/EMC_INTF]
  connect_bd_intf_net -intf_net microblaze_processor_system_rs232_uart [get_bd_intf_pins rs232_uart] [get_bd_intf_pins axi_uartlite/UART]
  connect_bd_intf_net -intf_net s_axi_emc [get_bd_intf_pins s_axi_emc] [get_bd_intf_pins axi_emc/S_AXI_MEM]
  connect_bd_intf_net -intf_net s_axi_uart [get_bd_intf_pins s_axi_uart] [get_bd_intf_pins axi_uartlite/S_AXI]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins spi_mosi_p] [get_bd_pins spi_mosi/IOBUF_DS_P]
  connect_bd_net -net Net1 [get_bd_pins spi_mosi_n] [get_bd_pins spi_mosi/IOBUF_DS_N]
  connect_bd_net -net Net2 [get_bd_pins spi_miso_p] [get_bd_pins spi_miso/IOBUF_DS_P]
  connect_bd_net -net Net3 [get_bd_pins spi_miso_n] [get_bd_pins spi_miso/IOBUF_DS_N]
  connect_bd_net -net Net4 [get_bd_pins spi_sclk_p] [get_bd_pins spi_sclk/IOBUF_DS_P]
  connect_bd_net -net Net5 [get_bd_pins spi_sclk_n] [get_bd_pins spi_sclk/IOBUF_DS_N]
  connect_bd_net -net Net6 [get_bd_pins spi_cs_p] [get_bd_pins spi_cs/IOBUF_DS_P]
  connect_bd_net -net Net7 [get_bd_pins spi_cs_n] [get_bd_pins spi_cs/IOBUF_DS_N]
  connect_bd_net -net axi_quad_spi_0_io0_o [get_bd_pins axi_quad_spi/io0_o] [get_bd_pins spi_mosi/IOBUF_IO_I]
  connect_bd_net -net axi_quad_spi_0_io0_t [get_bd_pins axi_quad_spi/io0_t] [get_bd_pins spi_mosi/IOBUF_IO_T]
  connect_bd_net -net axi_quad_spi_0_io1_o [get_bd_pins axi_quad_spi/io1_o] [get_bd_pins spi_miso/IOBUF_IO_I]
  connect_bd_net -net axi_quad_spi_0_io1_t [get_bd_pins axi_quad_spi/io1_t] [get_bd_pins spi_miso/IOBUF_IO_T]
  connect_bd_net -net axi_quad_spi_0_sck_o [get_bd_pins axi_quad_spi/sck_o] [get_bd_pins spi_sclk/IOBUF_IO_I]
  connect_bd_net -net axi_quad_spi_0_sck_t [get_bd_pins axi_quad_spi/sck_t] [get_bd_pins spi_sclk/IOBUF_IO_T]
  connect_bd_net -net axi_quad_spi_0_ss_o [get_bd_pins axi_quad_spi/ss_o] [get_bd_pins spi_cs/IOBUF_IO_I]
  connect_bd_net -net axi_quad_spi_0_ss_t [get_bd_pins axi_quad_spi/ss_t] [get_bd_pins xlconcat_0/In0] [get_bd_pins xlconcat_0/In1] [get_bd_pins xlconcat_0/In2] [get_bd_pins xlconcat_0/In3] [get_bd_pins xlconcat_0/In4] [get_bd_pins xlconcat_0/In5] [get_bd_pins xlconcat_0/In6] [get_bd_pins xlconcat_0/In7] [get_bd_pins xlconcat_0/In8] [get_bd_pins xlconcat_0/In9] [get_bd_pins xlconcat_0/In10] [get_bd_pins xlconcat_0/In11] [get_bd_pins xlconcat_0/In12] [get_bd_pins xlconcat_0/In13] [get_bd_pins xlconcat_0/In14] [get_bd_pins xlconcat_0/In15]
  connect_bd_net -net axi_uartlite_irq [get_bd_pins o_axi_uartlite_irq] [get_bd_pins axi_uartlite/interrupt]
  connect_bd_net -net ddr_ui_clk [get_bd_pins ddr_ui_clk] [get_bd_pins axi_emc/rdclk] [get_bd_pins axi_emc/s_axi_aclk] [get_bd_pins axi_quad_spi/ext_spi_clk] [get_bd_pins axi_quad_spi/s_axi_aclk] [get_bd_pins axi_uartlite/s_axi_aclk]
  connect_bd_net -net quad_spi_irq [get_bd_pins o_quad_spi_irq] [get_bd_pins axi_quad_spi/ip2intc_irpt]
  connect_bd_net -net rst_xdma_0_125M_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_emc/s_axi_aresetn] [get_bd_pins axi_quad_spi/s_axi_aresetn] [get_bd_pins axi_uartlite/s_axi_aresetn]
  connect_bd_net -net util_ds_buf_0_IOBUF_IO_O [get_bd_pins axi_quad_spi/io0_i] [get_bd_pins spi_mosi/IOBUF_IO_O]
  connect_bd_net -net util_ds_buf_1_IOBUF_IO_O [get_bd_pins axi_quad_spi/io1_i] [get_bd_pins spi_miso/IOBUF_IO_O]
  connect_bd_net -net util_ds_buf_2_IOBUF_IO_O [get_bd_pins axi_quad_spi/sck_i] [get_bd_pins spi_sclk/IOBUF_IO_O]
  connect_bd_net -net util_ds_buf_2_IOBUF_IO_O1 [get_bd_pins axi_quad_spi/ss_i] [get_bd_pins spi_cs/IOBUF_IO_O]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins spi_cs/IOBUF_IO_T] [get_bd_pins xlconcat_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pcie_dma
proc create_hier_cell_pcie_dma { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_pcie_dma() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 i_pcie_clk_qo

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_pcie

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_pci_dma_axi_lite

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 o_pcie_7x_mgt_rtl


  # Create pins
  create_bd_pin -dir I -type rst i_pcie_perst_ls
  create_bd_pin -dir O -type clk o_axi_aclk
  create_bd_pin -dir O -type rst o_axi_aresetn
  create_bd_pin -dir O o_msix_enable

  # Create instance: pcie_refclk_ibuf, and set properties
  set pcie_refclk_ibuf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 pcie_refclk_ibuf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $pcie_refclk_ibuf

  # Create instance: pcie_xdma, and set properties
  set pcie_xdma [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 pcie_xdma ]
  set_property -dict [ list \
   CONFIG.PF0_DEVICE_ID_mqdma {9018} \
   CONFIG.PF2_DEVICE_ID_mqdma {9018} \
   CONFIG.PF3_DEVICE_ID_mqdma {9018} \
   CONFIG.SYS_RST_N_BOARD_INTERFACE {Custom} \
   CONFIG.axi_data_width {128_bit} \
   CONFIG.axil_master_64bit_en {false} \
   CONFIG.axilite_master_en {true} \
   CONFIG.axilite_master_scale {Kilobytes} \
   CONFIG.axilite_master_size {4} \
   CONFIG.axist_bypass_en {false} \
   CONFIG.axisten_freq {125} \
   CONFIG.cfg_mgmt_if {false} \
   CONFIG.enable_gen4 {false} \
   CONFIG.pciebar2axibar_axil_master {0x00000000} \
   CONFIG.pf0_device_id {7018} \
   CONFIG.pf0_interrupt_pin {NONE} \
   CONFIG.pf0_msi_enabled {false} \
   CONFIG.pf0_msix_cap_pba_bir {BAR_3:2} \
   CONFIG.pf0_msix_cap_pba_offset {00008FE0} \
   CONFIG.pf0_msix_cap_table_bir {BAR_3:2} \
   CONFIG.pf0_msix_cap_table_offset {00008000} \
   CONFIG.pf0_msix_cap_table_size {01F} \
   CONFIG.pf0_msix_enabled {true} \
   CONFIG.pf0_rbar_cap_bar0 {0xffffffffffff} \
   CONFIG.pf1_msix_cap_table_size {020} \
   CONFIG.pf1_rbar_cap_bar0 {0xffffffffffff} \
   CONFIG.pf2_rbar_cap_bar0 {0xffffffffffff} \
   CONFIG.pf3_rbar_cap_bar0 {0xffffffffffff} \
   CONFIG.pl_link_cap_max_link_speed {2.5_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X8} \
   CONFIG.plltype {CPLL} \
   CONFIG.ref_clk_freq {100_MHz} \
   CONFIG.xdma_num_usr_irq {1} \
   CONFIG.xdma_pcie_64bit_en {true} \
   CONFIG.xdma_rnum_chnl {1} \
 ] $pcie_xdma

  # Create interface connections
  connect_bd_intf_net -intf_net axi_pcie [get_bd_intf_pins m_axi_pcie] [get_bd_intf_pins pcie_xdma/M_AXI]
  connect_bd_intf_net -intf_net pci_dma_axi_lite [get_bd_intf_pins m_pci_dma_axi_lite] [get_bd_intf_pins pcie_xdma/M_AXI_LITE]
  connect_bd_intf_net -intf_net pcie_7x_mgt_rtl [get_bd_intf_pins o_pcie_7x_mgt_rtl] [get_bd_intf_pins pcie_xdma/pcie_mgt]
  connect_bd_intf_net -intf_net pcie_clk_qo_1 [get_bd_intf_pins i_pcie_clk_qo] [get_bd_intf_pins pcie_refclk_ibuf/CLK_IN_D]

  # Create port connections
  connect_bd_net -net pcie_perst_ls_1 [get_bd_pins i_pcie_perst_ls] [get_bd_pins pcie_xdma/sys_rst_n]
  connect_bd_net -net pcie_xdma_axi_aclk [get_bd_pins o_axi_aclk] [get_bd_pins pcie_xdma/axi_aclk]
  connect_bd_net -net pcie_xdma_axi_aresetn [get_bd_pins o_axi_aresetn] [get_bd_pins pcie_xdma/axi_aresetn]
  connect_bd_net -net pcie_xdma_msix_enable [get_bd_pins o_msix_enable] [get_bd_pins pcie_xdma/msix_enable]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins pcie_refclk_ibuf/IBUF_OUT] [get_bd_pins pcie_xdma/sys_clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: microblaze_processor_system
proc create_hier_cell_microblaze_processor_system { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_microblaze_processor_system() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_dc

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_dp

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_ic

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_mdm

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_microblaze_intc


  # Create pins
  create_bd_pin -dir I -type clk i_clk
  create_bd_pin -dir I -type rst i_mb_rst
  create_bd_pin -dir I -type rst i_peripheral_reset
  create_bd_pin -dir I -from 0 -to 0 -type intr i_quad_spi_irq
  create_bd_pin -dir I -from 0 -to 0 -type intr i_uartlite_irq
  create_bd_pin -dir O -type rst o_mb_debug_sys_rst
  create_bd_pin -dir I -type rst s_peripheral_aresetn

  # Create instance: mb_irqs, and set properties
  set mb_irqs [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 mb_irqs ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $mb_irqs

  # Create instance: mb_mdm, and set properties
  set mb_mdm [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mb_mdm ]
  set_property -dict [ list \
   CONFIG.C_ADDR_SIZE {32} \
   CONFIG.C_M_AXI_ADDR_WIDTH {32} \
   CONFIG.C_USE_UART {1} \
 ] $mb_mdm

  # Create instance: microblaze_axi_intc, and set properties
  set microblaze_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_axi_intc ]
  set_property -dict [ list \
   CONFIG.C_HAS_FAST {0} \
   CONFIG.C_HAS_IPR {1} \
   CONFIG.C_IRQ_IS_LEVEL {1} \
   CONFIG.C_MB_CLK_NOT_CONNECTED {1} \
 ] $microblaze_axi_intc

  # Create instance: microblaze_memory
  create_hier_cell_microblaze_memory $hier_obj microblaze_memory

  # Create instance: microblaze_processor, and set properties
  set microblaze_processor [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_processor ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {10} \
   CONFIG.C_ALLOW_DCACHE_WR {0} \
   CONFIG.C_ALLOW_ICACHE_WR {0} \
   CONFIG.C_CACHE_BYTE_SIZE {32768} \
   CONFIG.C_DCACHE_ADDR_TAG {10} \
   CONFIG.C_DCACHE_BYTE_SIZE {32768} \
   CONFIG.C_DCACHE_LINE_LEN {4} \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_ICACHE_LINE_LEN {4} \
   CONFIG.C_I_AXI {0} \
   CONFIG.C_I_LMB {1} \
   CONFIG.C_USE_DCACHE {1} \
   CONFIG.C_USE_ICACHE {1} \
 ] $microblaze_processor

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_mdm] [get_bd_intf_pins mb_mdm/S_AXI]
  connect_bd_intf_net -intf_net axi_dc [get_bd_intf_pins m_axi_dc] [get_bd_intf_pins microblaze_processor/M_AXI_DC]
  connect_bd_intf_net -intf_net axi_dp [get_bd_intf_pins m_axi_dp] [get_bd_intf_pins microblaze_processor/M_AXI_DP]
  connect_bd_intf_net -intf_net axi_ic [get_bd_intf_pins m_axi_ic] [get_bd_intf_pins microblaze_processor/M_AXI_IC]
  connect_bd_intf_net -intf_net dlmb [get_bd_intf_pins microblaze_memory/dlmb] [get_bd_intf_pins microblaze_processor/DLMB]
  connect_bd_intf_net -intf_net mb_intc_irq [get_bd_intf_pins microblaze_axi_intc/interrupt] [get_bd_intf_pins microblaze_processor/INTERRUPT]
  connect_bd_intf_net -intf_net mb_mdm [get_bd_intf_pins mb_mdm/MBDEBUG_0] [get_bd_intf_pins microblaze_processor/DEBUG]
  connect_bd_intf_net -intf_net microblaze_processor_ILMB [get_bd_intf_pins microblaze_memory/ilmb] [get_bd_intf_pins microblaze_processor/ILMB]
  connect_bd_intf_net -intf_net s_axi_microblaze_intc [get_bd_intf_pins s_axi_microblaze_intc] [get_bd_intf_pins microblaze_axi_intc/s_axi]

  # Create port connections
  connect_bd_net -net clk [get_bd_pins i_clk] [get_bd_pins mb_mdm/S_AXI_ACLK] [get_bd_pins microblaze_axi_intc/s_axi_aclk] [get_bd_pins microblaze_memory/clk] [get_bd_pins microblaze_processor/Clk]
  connect_bd_net -net mb_debug_sys_rst [get_bd_pins o_mb_debug_sys_rst] [get_bd_pins mb_mdm/Debug_SYS_Rst]
  connect_bd_net -net mb_irq [get_bd_pins mb_irqs/dout] [get_bd_pins microblaze_axi_intc/intr]
  connect_bd_net -net mb_mdm_irq [get_bd_pins mb_irqs/In3] [get_bd_pins mb_mdm/Interrupt]
  connect_bd_net -net mb_reset [get_bd_pins i_mb_rst] [get_bd_pins microblaze_processor/Reset]
  connect_bd_net -net peripheral_aresetn [get_bd_pins s_peripheral_aresetn] [get_bd_pins mb_mdm/S_AXI_ARESETN] [get_bd_pins microblaze_axi_intc/s_axi_aresetn]
  connect_bd_net -net quad_spi_irq [get_bd_pins i_quad_spi_irq] [get_bd_pins mb_irqs/In1]
  connect_bd_net -net rst_1 [get_bd_pins i_peripheral_reset] [get_bd_pins microblaze_memory/rst]
  connect_bd_net -net uartlite_irq [get_bd_pins i_uartlite_irq] [get_bd_pins mb_irqs/In2]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set ddr3_sdram [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 ddr3_sdram ]

  set linear_flash [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 linear_flash ]

  set pcie_7x_mgt_rtl [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_7x_mgt_rtl ]

  set pcie_clk_qo [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_clk_qo ]

  set rs232_uart [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 rs232_uart ]

  set sys_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $sys_clock


  # Create ports
  set ext_reset_in [ create_bd_port -dir I -type rst ext_reset_in ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $ext_reset_in
  set pcie_perst_ls [ create_bd_port -dir I -type rst pcie_perst_ls ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $pcie_perst_ls
  set spi_cs_n [ create_bd_port -dir IO -from 15 -to 0 spi_cs_n ]
  set spi_cs_p [ create_bd_port -dir IO -from 15 -to 0 spi_cs_p ]
  set spi_miso_n [ create_bd_port -dir IO -from 0 -to 0 spi_miso_n ]
  set spi_miso_p [ create_bd_port -dir IO -from 0 -to 0 spi_miso_p ]
  set spi_mosi_n [ create_bd_port -dir IO -from 0 -to 0 spi_mosi_n ]
  set spi_mosi_p [ create_bd_port -dir IO -from 0 -to 0 spi_mosi_p ]
  set spi_sclk_n [ create_bd_port -dir IO -from 0 -to 0 spi_sclk_n ]
  set spi_sclk_p [ create_bd_port -dir IO -from 0 -to 0 spi_sclk_p ]

  # Create instance: mb_dp_interconnect, and set properties
  set mb_dp_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 mb_dp_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {1} \
 ] $mb_dp_interconnect

  # Create instance: mb_emc_interconnect, and set properties
  set mb_emc_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 mb_emc_interconnect ]

  # Create instance: microblaze_processor_system
  create_hier_cell_microblaze_processor_system [current_bd_instance .] microblaze_processor_system

  # Create instance: mig_7series, and set properties
  set mig_7series [ create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series:4.2 mig_7series ]

  # Generate the PRJ File for MIG
  set str_mig_folder [get_property IP_DIR [ get_ips [ get_property CONFIG.Component_Name $mig_7series ] ] ]
  set str_mig_file_name mig_b.prj
  set str_mig_file_path ${str_mig_folder}/${str_mig_file_name}

  write_mig_file_design_1_mig_7series_0 $str_mig_file_path

  set_property -dict [ list \
   CONFIG.BOARD_MIG_PARAM {ddr3_sdram} \
   CONFIG.MIG_DONT_TOUCH_PARAM {Custom} \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.XML_INPUT_FILE {mig_b.prj} \
 ] $mig_7series

  # Create instance: pcie_dma
  create_hier_cell_pcie_dma [current_bd_instance .] pcie_dma

  # Create instance: peripheral_subsystem
  create_hier_cell_peripheral_subsystem [current_bd_instance .] peripheral_subsystem

  # Create instance: ram_interconnect, and set properties
  set ram_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 ram_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_CLKS {2} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
 ] $ram_interconnect

  # Create instance: system_reset, and set properties
  set system_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 system_reset ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {false} \
 ] $system_reset

  # Create interface connections
  connect_bd_intf_net -intf_net axi_ddr [get_bd_intf_pins mig_7series/S_AXI] [get_bd_intf_pins ram_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net axi_mb_dc [get_bd_intf_pins mb_emc_interconnect/S00_AXI] [get_bd_intf_pins microblaze_processor_system/m_axi_dc]
  connect_bd_intf_net -intf_net axi_mb_ic [get_bd_intf_pins mb_emc_interconnect/S01_AXI] [get_bd_intf_pins microblaze_processor_system/m_axi_ic]
  connect_bd_intf_net -intf_net axi_mb_intc [get_bd_intf_pins mb_dp_interconnect/M00_AXI] [get_bd_intf_pins microblaze_processor_system/s_axi_microblaze_intc]
  connect_bd_intf_net -intf_net axi_mb_mdm [get_bd_intf_pins mb_dp_interconnect/M01_AXI] [get_bd_intf_pins microblaze_processor_system/s_axi_mdm]
  connect_bd_intf_net -intf_net axi_mb_quad_spi [get_bd_intf_pins mb_dp_interconnect/M02_AXI] [get_bd_intf_pins peripheral_subsystem/s_axi_quad_spi]
  connect_bd_intf_net -intf_net axi_mb_uart [get_bd_intf_pins mb_dp_interconnect/M03_AXI] [get_bd_intf_pins peripheral_subsystem/s_axi_uart]
  connect_bd_intf_net -intf_net axi_pcie_dma [get_bd_intf_pins pcie_dma/m_axi_pcie] [get_bd_intf_pins ram_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net ddr3_sdram [get_bd_intf_ports ddr3_sdram] [get_bd_intf_pins mig_7series/DDR3]
  connect_bd_intf_net -intf_net linear_flash [get_bd_intf_ports linear_flash] [get_bd_intf_pins peripheral_subsystem/linear_flash]
  connect_bd_intf_net -intf_net mb_emc_interconnect_M00_AXI [get_bd_intf_pins mb_emc_interconnect/M00_AXI] [get_bd_intf_pins peripheral_subsystem/s_axi_emc]
  connect_bd_intf_net -intf_net microblaze_processor_system_m_axi_dp [get_bd_intf_pins mb_dp_interconnect/S00_AXI] [get_bd_intf_pins microblaze_processor_system/m_axi_dp]
  connect_bd_intf_net -intf_net pcie_7x_mgt_rtl [get_bd_intf_ports pcie_7x_mgt_rtl] [get_bd_intf_pins pcie_dma/o_pcie_7x_mgt_rtl]
  connect_bd_intf_net -intf_net pcie_clk_qo_1 [get_bd_intf_ports pcie_clk_qo] [get_bd_intf_pins pcie_dma/i_pcie_clk_qo]
  connect_bd_intf_net -intf_net rs232_uart [get_bd_intf_ports rs232_uart] [get_bd_intf_pins peripheral_subsystem/rs232_uart]
  connect_bd_intf_net -intf_net sys_clock [get_bd_intf_ports sys_clock] [get_bd_intf_pins mig_7series/SYS_CLK]

  # Create port connections
  connect_bd_net -net axi_uartlite_irq [get_bd_pins microblaze_processor_system/i_uartlite_irq] [get_bd_pins peripheral_subsystem/o_axi_uartlite_irq]
  connect_bd_net -net ddr_interconnect_aresetn [get_bd_pins mb_dp_interconnect/aresetn] [get_bd_pins mb_emc_interconnect/aresetn] [get_bd_pins ram_interconnect/aresetn] [get_bd_pins system_reset/interconnect_aresetn]
  connect_bd_net -net ddr_ui_clk [get_bd_pins mb_dp_interconnect/aclk] [get_bd_pins mb_emc_interconnect/aclk] [get_bd_pins microblaze_processor_system/i_clk] [get_bd_pins mig_7series/ui_clk] [get_bd_pins peripheral_subsystem/ddr_ui_clk] [get_bd_pins ram_interconnect/aclk] [get_bd_pins system_reset/slowest_sync_clk]
  connect_bd_net -net ext_reset_in [get_bd_ports ext_reset_in] [get_bd_pins mig_7series/sys_rst]
  connect_bd_net -net i_mb_rst_1 [get_bd_pins microblaze_processor_system/i_mb_rst] [get_bd_pins system_reset/mb_reset]
  connect_bd_net -net microblaze_processor_system_o_mb_debug_sys_rst [get_bd_pins microblaze_processor_system/o_mb_debug_sys_rst] [get_bd_pins system_reset/mb_debug_sys_rst]
  connect_bd_net -net mig_7series_mmcm_locked [get_bd_pins mig_7series/mmcm_locked] [get_bd_pins system_reset/dcm_locked]
  connect_bd_net -net pcie_dma_axi_aclk [get_bd_pins pcie_dma/o_axi_aclk] [get_bd_pins ram_interconnect/aclk1]
  connect_bd_net -net pcie_perst_ls [get_bd_ports pcie_perst_ls] [get_bd_pins pcie_dma/i_pcie_perst_ls]
  connect_bd_net -net peripheral_aresetn [get_bd_pins microblaze_processor_system/s_peripheral_aresetn] [get_bd_pins mig_7series/aresetn] [get_bd_pins peripheral_subsystem/s_axi_aresetn] [get_bd_pins system_reset/peripheral_aresetn]
  connect_bd_net -net peripheral_reset [get_bd_pins microblaze_processor_system/i_peripheral_reset] [get_bd_pins system_reset/peripheral_reset]
  connect_bd_net -net quad_spi_irq [get_bd_pins microblaze_processor_system/i_quad_spi_irq] [get_bd_pins peripheral_subsystem/o_quad_spi_irq]
  connect_bd_net -net spi_cs_n [get_bd_ports spi_cs_n] [get_bd_pins peripheral_subsystem/spi_cs_n]
  connect_bd_net -net spi_cs_p [get_bd_ports spi_cs_p] [get_bd_pins peripheral_subsystem/spi_cs_p]
  connect_bd_net -net spi_miso_n [get_bd_ports spi_miso_n] [get_bd_pins peripheral_subsystem/spi_miso_n]
  connect_bd_net -net spi_miso_p [get_bd_ports spi_miso_p] [get_bd_pins peripheral_subsystem/spi_miso_p]
  connect_bd_net -net spi_mosi_n [get_bd_ports spi_mosi_n] [get_bd_pins peripheral_subsystem/spi_mosi_n]
  connect_bd_net -net spi_mosi_p [get_bd_ports spi_mosi_p] [get_bd_pins peripheral_subsystem/spi_mosi_p]
  connect_bd_net -net spi_sclk_n [get_bd_ports spi_sclk_n] [get_bd_pins peripheral_subsystem/spi_sclk_n]
  connect_bd_net -net spi_sclk_p [get_bd_ports spi_sclk_p] [get_bd_pins peripheral_subsystem/spi_sclk_p]
  connect_bd_net -net ui_clk_sync_rst [get_bd_pins mig_7series/ui_clk_sync_rst] [get_bd_pins system_reset/ext_reset_in]

  # Create address segments
  assign_bd_address -offset 0x60000000 -range 0x02000000 -target_address_space [get_bd_addr_spaces microblaze_processor_system/microblaze_processor/Data] [get_bd_addr_segs peripheral_subsystem/axi_emc/S_AXI_MEM/Mem0] -force
  assign_bd_address -offset 0x60000000 -range 0x02000000 -target_address_space [get_bd_addr_spaces microblaze_processor_system/microblaze_processor/Instruction] [get_bd_addr_segs peripheral_subsystem/axi_emc/S_AXI_MEM/Mem0] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_processor_system/microblaze_processor/Data] [get_bd_addr_segs peripheral_subsystem/axi_quad_spi/AXI_LITE/Reg] -force
  assign_bd_address -offset 0x40600000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_processor_system/microblaze_processor/Data] [get_bd_addr_segs peripheral_subsystem/axi_uartlite/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_processor_system/microblaze_processor/Data] [get_bd_addr_segs microblaze_processor_system/microblaze_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_processor_system/microblaze_processor/Instruction] [get_bd_addr_segs microblaze_processor_system/microblaze_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x41400000 -range 0x00001000 -target_address_space [get_bd_addr_spaces microblaze_processor_system/microblaze_processor/Data] [get_bd_addr_segs microblaze_processor_system/mb_mdm/S_AXI/Reg] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_processor_system/microblaze_processor/Data] [get_bd_addr_segs microblaze_processor_system/microblaze_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces pcie_dma/pcie_xdma/M_AXI] [get_bd_addr_segs mig_7series/memmap/memaddr] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


common::send_msg_id "BD_TCL-1000" "WARNING" "This Tcl script was generated from a block design that has not been validated. It is possible that design <$design_name> may result in errors during validation."

