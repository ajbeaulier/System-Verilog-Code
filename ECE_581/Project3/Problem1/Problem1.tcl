# Fill with your directory path and library 
lappend search_path "your file directory path"
set target_library "target library"
set link_library "link Library"


link

read_file -format sverilog Problem1.sv
current_design Problem1_A
compile
report_area
report_cell
report_power
write -format Verilog -hierarchy -output Problem1.netlist
link
