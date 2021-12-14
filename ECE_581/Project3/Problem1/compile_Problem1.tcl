# Fill with your directory path and library 
lappend search_path /u/beaulier/smb_files/ECE581/Project3
set target_library osu05_stdcells.db
set link_library [concat "*" $target_library]

link

read_file -format sverilog Problem1.sv
current_design Problem1
compile
report_area
report_cell
report_power
write -format Verilog -hierarchy -output Problem1.netlist
link
