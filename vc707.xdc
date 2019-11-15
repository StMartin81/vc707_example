set_property BITSTREAM.CONFIG.BPI_SYNC_MODE DISABLE [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DISABLE [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]
set_property CONFIG_MODE BPI16 [current_design]
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

# Constraints for XDMA
set_property IOSTANDARD LVCMOS18 [get_ports pcie_perst_ls]
set_property PULLUP true [get_ports pcie_perst_ls]
set_property PACKAGE_PIN AV35 [get_ports pcie_perst_ls]

# Constraints for sysclk
set_property PACKAGE_PIN E19 [get_ports sys_clock_clk_p]
set_property PACKAGE_PIN E18 [get_ports sys_clock_clk_n]

# CPU Reset Pushbutton Switch
set_property PACKAGE_PIN AV40 [get_ports ext_reset_in]
set_property IOSTANDARD LVCMOS18 [get_ports ext_reset_in]

# FMC2
set_property IOSTANDARD LVDS [get_ports {spi_sclk_p[0]}]
set_property PACKAGE_PIN AB33 [get_ports {spi_sclk_p[0]}]
set_property IOSTANDARD LVDS [get_ports {spi_mosi_p[0]}]
set_property PACKAGE_PIN AC30 [get_ports {spi_mosi_p[0]}]
set_property IOSTANDARD LVDS [get_ports {spi_miso_p[0]}]
set_property PACKAGE_PIN AD32 [get_ports {spi_miso_p[0]}]
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[0]}];
set_property PACKAGE_PIN AF31 [get_ports {spi_cs_p[0]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[1]}];
set_property PACKAGE_PIN R33 [get_ports {spi_cs_p[1]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[2]}];
set_property PACKAGE_PIN U34 [get_ports {spi_cs_p[2]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[3]}];
set_property PACKAGE_PIN AB36 [get_ports {spi_cs_p[3]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[4]}];
set_property PACKAGE_PIN AB31 [get_ports {spi_cs_p[4]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[5]}];
set_property PACKAGE_PIN AC31 [get_ports {spi_cs_p[5]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[6]}];
set_property PACKAGE_PIN AB41 [get_ports {spi_cs_p[6]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[7]}];
set_property PACKAGE_PIN W40 [get_ports {spi_cs_p[7]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[8]}];
set_property PACKAGE_PIN AG36 [get_ports {spi_cs_p[8]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[9]}];
set_property PACKAGE_PIN AE37 [get_ports {spi_cs_p[9]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[10]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_n[10]}];
set_property PACKAGE_PIN AJ40 [get_ports {spi_cs_p[10]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[11]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_n[11]}];
set_property PACKAGE_PIN Y42 [get_ports {spi_cs_p[11]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[12]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_n[12]}];
set_property PACKAGE_PIN AF35 [get_ports {spi_cs_p[12]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[13]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_n[13]}];
set_property PACKAGE_PIN AC34 [get_ports {spi_cs_p[13]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[14]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_n[14]}];
set_property PACKAGE_PIN Y39 [get_ports {spi_cs_p[14]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_p[15]}];
set_property IOSTANDARD LVDS [get_ports {spi_cs_n[15]}];
set_property PACKAGE_PIN AE32 [get_ports {spi_cs_p[15]}];

# Create clocks for design
# XDMA clock (100 MHz)
create_clock -period 10.000 -name sys_clk [get_ports {pcie_clk_qo_clk_p[0]}]

set_property PACKAGE_PIN AB8 [get_ports {pcie_clk_qo_clk_p[0]}]
set_false_path -from [get_ports pcie_perst_ls]
