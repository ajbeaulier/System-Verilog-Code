//////////////////////////////////////////////////////////////////////////////
// tb_hw3_prob1.sv 

// Author:	Alex Beaulier (beaulier@pdx.edu)
// Date:	6/2/2020 
//
// Description:
// ------------
//
// Test bench for parallel serial register problem
////////////////////////////////////////////////////////////////////////////
module top; // used in testbench chapter
	logic SerialIn, SHIFT, CLK, CLR,
	logic Q3, Q2, Q1, Q0

	timeunit 1ns/1ns;
	
	import "DPI-C" function string getenv(input string env_name);
	
hw3_prob1 dut(.*);
tBench tb(.*);
initial begin: I
	$monitor($time, " Current State = %s, Next_State = %s", dut.current_state,dut.next_state);
	CLK = 0;
	CLR = 0;
	CLR <= #1 1; //Reset low to 1 for 1 cycle later.
	CLR <= #6 0; //Reset low to 1 for 1 cycle later.
	
	forever #5 CLK = ~CLK; //Clock to run while asserting reset
end: I
endmodule: top


program tBench (
	input logic CLK, 
	output logic TOKEN, START, T1DONE, T2DONE
);

timeunit 1ns/1ns;

task MatchData(input logic[4:0] Q, output logic match);
	Out = {QsimData};
	match = Q == QsimData;	// see if the data bits match
	if (match)
		$display("MATCH"};
	else begin
		$display("MISMATCH"};
	end;
endtask: MatchData

initial begin: OnFlyTest 
	repeat (25) @(negedge clock); SerialIn = 1'b0;
	repeat (25) @(posedge clock); Shift = 1'b1;
	MatchData(Q,  
	#1 repeat (25) @(negedge clock); SerialIn = ~SerialIn;
	#25 repeat (25) @(posedge clock); SerialIn = ~SerialIn;
	#25 repeat (25) @(posedge clock); Shift = 1'b0;
	
	
	//Successfully taken all transit loops and repeat loops
	$display("\nUART Loopback Test - <Alex Beaulier> (<Beaulier@pdx.edu>)");
    $display("Sources: %s\n", getenv("PWD"));
	#1000 $stop;
end: OnFlyTest
endprogram: tBench