############################################################
# Nexys A7 Traffic Light Controller
############################################################

############################################################
# 100 MHz Clock
############################################################

# Replace <CLOCK_PIN> with the correct Nexys A7 clock pin
# from the official Digilent Master XDC file.

#set_property PACKAGE_PIN <CLOCK_PIN> [get_ports clk]
#set_property IOSTANDARD LVCMOS33 [get_ports clk]
#create_clock -add -name sys_clk_pin -period 10.00 \
#    -waveform {0 5} [get_ports clk]


############################################################
# Reset Button
############################################################

# Replace <RESET_PIN> with the selected Nexys A7 button pin.

#set_property PACKAGE_PIN <RESET_PIN> [get_ports reset]
#set_property IOSTANDARD LVCMOS33 [get_ports reset]


############################################################
# North-South Traffic Lights
############################################################

# NS RED
#set_property PACKAGE_PIN <LED0_PIN> [get_ports ns_red]
#set_property IOSTANDARD LVCMOS33 [get_ports ns_red]

# NS YELLOW
#set_property PACKAGE_PIN <LED1_PIN> [get_ports ns_yellow]
#set_property IOSTANDARD LVCMOS33 [get_ports ns_yellow]

# NS GREEN
#set_property PACKAGE_PIN <LED2_PIN> [get_ports ns_green]
#set_property IOSTANDARD LVCMOS33 [get_ports ns_green]


############################################################
# East-West Traffic Lights
############################################################

# EW RED
#set_property PACKAGE_PIN <LED3_PIN> [get_ports ew_red]
#set_property IOSTANDARD LVCMOS33 [get_ports ew_red]

# EW YELLOW
#set_property PACKAGE_PIN <LED4_PIN> [get_ports ew_yellow]
#set_property IOSTANDARD LVCMOS33 [get_ports ew_yellow]

# EW GREEN
#set_property PACKAGE_PIN <LED5_PIN> [get_ports ew_green]
#set_property IOSTANDARD LVCMOS33 [get_ports ew_green]
