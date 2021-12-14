/////////////////////////////////////////////////////////////////////////////////////////
// Authors - Alex Beaulier, Amrutha Anil
// top_level_integration.v - Integrates all modules
//
/////////////////////////////////////////////////////////////////////////////////////////
`include "data_cache.sv"
`include "instruction_cache.sv"
`include "statistics.sv"

module top_level_integration(
 // Outputs
  output logic [25:0] addr_to_L2,
  output logic [1:0]  command_to_L2,
  input logic mode, 
  
  // Inputs
  input logic Clock, 
  input logic clear, 
  input logic [3:0] n, 
  input logic [31:0] address_in,
  input logic Finish);  
  
  // For statistics module
  logic [31:0] data_hit;
  logic [31:0] data_miss;
  logic [31:0] data_reads;
  logic [31:0] data_writes;
  logic [31:0] instr_hit; 
  logic [31:0] instr_miss;  
  logic [31:0] instr_reads;
  
  // Commands from tracefile
  localparam Reset       = 4'd8;
  localparam Invalidate  = 4'd3;
  localparam Read        = 4'd0;
  localparam Write       = 4'd1;
  localparam Instruction_Fetch 	= 4'd2;
  localparam Print       = 4'd9;
  localparam Snoop         =4'd4;
  
  // Communication between L1 and L2 caches
  logic [1:0]   l2_i_cmd, l2_d_cmd;
  logic [25:0]  l2_i_add,  l2_d_add;
  
  // signals from file to caches
  logic [31:0] i_add, d_add;
  
  assign i_add = address_in;
  assign d_add = address_in;

  //Mux the commands accordingly to L2 cache
  always @(n)
  begin
		if(n == Instruction_Fetch)
		begin
			addr_to_L2 = l2_i_add;
			command_to_L2 = l2_i_cmd;
		end
		else
		begin
			addr_to_L2 = l2_d_add;
			command_to_L2 = l2_d_cmd;
		end
	end

	data_cache data_cache (
		.n(n), 
		.address_in(address_in), 
		.Clock(Clock), 
		.addr_to_L2(l2_d_add), 
		.command_to_L2(l2_d_cmd), 
		.hit(data_hit), 
		.miss(data_miss), 
		.reads(data_reads), 
		.writes(data_writes),
		.mode(mode)); 
		
	instruction_cache instr_cache (
	.Clock(Clock), 
		.n(n), 
		.address_in(address_in), 
		.addr_to_L2(l2_i_add),  
		.command_to_L2(l2_i_cmd),  
		.hit(instr_hit), 
		.miss(instr_miss),
		.reads(instr_reads),
		.mode(mode)); 

	statistics stats(
		.print(Finish),
		.ins_reads(instr_reads),
		.ins_hit(instr_hit),
		.ins_miss(instr_miss),
		.data_reads(data_reads),
		.data_writes(data_writes),
		.data_hit(data_hit),
		.data_miss(data_miss)
		);

endmodule
