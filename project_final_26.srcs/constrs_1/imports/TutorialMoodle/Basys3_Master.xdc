set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
set_property PACKAGE_PIN K17 [get_ports {sensor[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor[0]}]

set_property PACKAGE_PIN M18 [get_ports {sensor[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor[1]}]

set_property PACKAGE_PIN N17 [get_ports {sensor[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor[2]}]

set_property PACKAGE_PIN V17 [get_ports {sw_sim[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_sim[0]}]

set_property PACKAGE_PIN V16 [get_ports {sw_sim[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_sim[1]}]

set_property PACKAGE_PIN W16 [get_ports {sw_sim[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_sim[2]}]

set_property PACKAGE_PIN R2 [get_ports modo_simulacion]
set_property IOSTANDARD LVCMOS33 [get_ports modo_simulacion]

set_property PACKAGE_PIN U18 [get_ports pulsador]
set_property IOSTANDARD LVCMOS33 [get_ports pulsador]

set_property PACKAGE_PIN J1 [get_ports altavoz]
set_property IOSTANDARD LVCMOS33 [get_ports altavoz]

set_property PACKAGE_PIN A14 [get_ports {led_rgb[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_rgb[0]}]
set_property PACKAGE_PIN A16 [get_ports {led_rgb[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_rgb[1]}]
set_property PACKAGE_PIN B15 [get_ports {led_rgb[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_rgb[2]}]

set_property PACKAGE_PIN G19 [get_ports {vgaRed[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[0]}]
set_property PACKAGE_PIN H19 [get_ports {vgaRed[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[1]}]
set_property PACKAGE_PIN J19 [get_ports {vgaRed[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[2]}]
set_property PACKAGE_PIN N19 [get_ports {vgaRed[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[3]}]

set_property PACKAGE_PIN N18 [get_ports {vgaBlue[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[0]}]
set_property PACKAGE_PIN L18 [get_ports {vgaBlue[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[1]}]
set_property PACKAGE_PIN K18 [get_ports {vgaBlue[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[2]}]
set_property PACKAGE_PIN J18 [get_ports {vgaBlue[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[3]}]

set_property PACKAGE_PIN J17 [get_ports {vgaGreen[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[0]}]
set_property PACKAGE_PIN H17 [get_ports {vgaGreen[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[1]}]
set_property PACKAGE_PIN G17 [get_ports {vgaGreen[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[2]}]
set_property PACKAGE_PIN D17 [get_ports {vgaGreen[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[3]}]

set_property PACKAGE_PIN P19 [get_ports Hsync]
set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
set_property PACKAGE_PIN R19 [get_ports Vsync]
set_property IOSTANDARD LVCMOS33 [get_ports Vsync]