/////////////////////////////////////////////////////////////////////////////////////////
// Authors - Alex Beaulier, Amrutha Anil
// statistics.v - Statistics Module 
//
// Reference: https://github.com/RahulMarathe94
/////////////////////////////////////////////////////////////////////////////////////////
module statistics(
  // Inputs
  input logic print,
  input logic [31:0] ins_reads,
  input logic [31:0] ins_hit,
  input logic [31:0] ins_miss, 
  input logic [31:0] data_reads,
  input logic [31:0] data_writes,
  input logic [31:0] data_hit,
  input logic [31:0] data_miss
);

  always @(posedge print) begin
    $display("==============STATISTICS================");
	  $display("--------------Data Cache----------------");
	  $display(" Data Reads      = %d", data_reads );
	  $display(" Data Writes 	   = %d", data_writes);
    $display(" Hits Data Cache = %d", data_hit);
	  $display(" Miss Data Cache = %d", data_miss);
	  $display("----------------------------------------");
	  $display(" Hit Ratio Data Cache= %.1f%%", (data_reads + data_writes) == 0 ?
        0 : 100.0*(data_hit )/(data_reads + data_writes));
	  $display("----------------------------------------");
	  $display("--------Instruction Cache---------------");
	  $display(" Instruction Reads      = %d", ins_reads );
    $display(" Hits Instruction Cache = %d", ins_hit);
    $display(" Miss Instruction Cache = %d", ins_miss);
	  $display("----------------------------------------");
	  $display(" Hit Ratio Instruction Cache= %.1f%%", ( ins_reads ) == 0 ?
        0 : 100.0*(ins_hit)/(ins_reads));
	  $display("----------------------------------------");    
  end
endmodule

