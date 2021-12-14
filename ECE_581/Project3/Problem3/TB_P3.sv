//////////////////////////////////////////////////////////////
// TB_Problem1.sv - S1 Circuit
//
// Author: Alex Beaulier (beaulier@pdx.edu)
// Date: 7-24-2021
// Description:
// ------------/
// This testbench function is problem 1
////////////////////////////////////////////////////////////////
module TB_FSMS;
  logic DATAOUT;
  logic [8:0] X;
  logic clk,reset;
  
  timeunit 1ns/1ns;
  
//Run MOORE
stimulus 	TESTGENMOORE 	(.*);
Problem1 	DUTMOORE 	(.*);

initial begin
	clk = 0;
	reset = 0;
	reset <= #1 1;
	reset <= #6 0;
	
	forever #5 clk = ~clk; //Clock to run while asserting reset
end

endmodule: TB_FSMS



program stimulus
(	
	input  logic clk,
	output  logic [8:0]X
);

//Timescale for module
timeunit 1ns/1ns;
	
initial begin: AllTestCases  
		//$monitor($time, " X = %d, Dataout = %4b CurrentState = %s, Next_State = %s, Reset = %d", X, DUTMOORE.Dataout, DUTMOORE.current_state,DUTMOORE.next_state,DUTMOORE.reset);
		$monitor($time, "COUT:%d, X%9b, DATAOUT = %4b CurrentState = %s, Next_State = %s, Reset = %d",DUTMOORE.COUT,X,DUTMOORE.DATAOUT, DUTMOORE.current_state,DUTMOORE.next_state,DUTMOORE.reset);
		
		#5 X <= '0;
		@(posedge clk); 
		//S0000
		
		#5 X <= 9'b111111111;
		@(posedge clk); 
		//S1000
		
		#5 X <= 9'b111111111;
		@(posedge clk); 
		//S1100
		
		#5 X <= 9'b111111111;
		@(posedge clk); 
		//S1110
		
		#5 X <= 9'b111111111;
		@(posedge clk); 
		//S1111
		
		#5 X <= '0;
		@(posedge clk);		
		//S0111
		
		#5 X <= '0;
		@(posedge clk); 
		//S0011
		
		#5 X <= '0;
		@(posedge clk); 
		//S0001
		
		#5 X <= 9'b111111111;
		@(posedge clk); 
		//S1000
		
		#5 X <= '0;
		@(posedge clk); 
		//S0100
		
		#5 X <= '0;
		@(posedge clk); 
		//S0010
		
		#5 X <= 9'b111111111;
		@(posedge clk); 
		//S1001
		
		#5 X <= '0;
		@(posedge clk); 
		//S0100
		
		#5 X <= 9'b111111111;
		@(posedge clk); 
		//S1010
		
		#5 X <= 9'b111111111;
		@(posedge clk); 
		//S1101
		
		#5 X <= '0;
		@(posedge clk); 
		//S0110
		
		#5 X <= 9'b111111111;
		@(posedge clk); 
		//S1011
		
		#5 X <= '0;
		@(posedge clk); 
		//S0101
		$display("\n Circuit State TEST - <Alex Beaulier> (<Beaulier@pdx.edu>)");
		#10 $stop;
end: AllTestCases
endprogram: stimulus
