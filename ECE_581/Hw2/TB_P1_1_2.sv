//////////////////////////////////////////////////////////////
// TB_FSMS.sv - 1 MOORE MACHINE 1 MEALY MACHINE
//
// Author: Alex Beaulier (beaulier@pdx.edu)
// Date: 7-21-2021
// Description:
// ------------/
// This testbench function is problem 1_1_2 MOORE MACHINE converted into SV
////////////////////////////////////////////////////////////////
module TB_FSMS;
  logic [3:0] Dataout;
  logic clk, reset;
  logic Datain;
  
  //Mealy logic
  logic [3:0] Dataout_Mealy;
  logic clk_Mealy, reset_Mealy;
  logic Datain_Mealy;
  
  timeunit 1ns/1ns;
  
//Run MOORE
stimulus 	TESTGENMOORE 	(.*);
MOOREMACHINE 	DUTMOORE 	(.*);
	
//Run MEALY
stimulus 	TESTGENMEALY 	(.clk(clk_Mealy),.Datain(Datain_Mealy));
MEALYMACHINE	DUTMEALY	(.Dataout(Dataout_Mealy), .clk(clk_Mealy), .reset(reset_Mealy), .Datain(Datain_Mealy));

initial begin
	clk = 0;
	reset = 0;
	reset <= #1 1;
	reset <= #6 0;
	
	forever #5 clk = ~clk; //Clock to run while asserting reset
end

initial begin
	clk_Mealy = 0;
	reset_Mealy = 0;
	reset_Mealy <= #1 1;
	reset_Mealy <= #6 0;
	
	forever #5 clk_Mealy = ~clk_Mealy; //Clock to run while asserting reset
end

endmodule: TB_FSMS



program stimulus
(	
	input  logic clk,
	output  logic Datain
);

//Timescale for module
timeunit 1ns/1ns;
	
initial begin: AllTestCases  
		//$monitor($time, " Datain = %d, Dataout = %4b CurrentState = %s, Next_State = %s, Reset = %d", Datain, DUTMOORE.Dataout, DUTMOORE.current_state,DUTMOORE.next_state,DUTMOORE.reset);
		$monitor($time, " Datain = %d, Dataout = %4b CurrentState = %s, Next_State = %s, Reset = %d", Datain, DUTMEALY.Dataout, DUTMEALY.current_state,DUTMEALY.next_state,DUTMEALY.reset);
	
		//S0
		#5 Datain <= '0;
		@(posedge clk); 
		
		//S1
		#5 Datain <= '1;
		#5 Datain <= '1;
		@(posedge clk); 
		
		//S2
		#5 Datain <= '0;
		@(posedge clk); 
		#5 Datain <= '0;
		@(posedge clk); 
		
		//S3
		#5 Datain <= '1;
		@(posedge clk); 
		#5 Datain <= '1;
		@(posedge clk); 
		
		//S0
		#5 Datain <= '0;
		@(posedge clk); 
		#5 Datain <= '0;
		@(posedge clk); 
		$display("\n MOORE TEST - <Alex Beaulier> (<Beaulier@pdx.edu>)");
		#10 $stop;
end: AllTestCases
endprogram: stimulus
