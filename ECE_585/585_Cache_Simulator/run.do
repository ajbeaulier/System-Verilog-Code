vlog lru_next.sv lru_next_instruction.sv statistics.sv instruction_cache.sv data_cache.sv top_level_integration.sv testbench.sv
vsim -c +Trace=trace.txt +mode=1 testbench 
run -all