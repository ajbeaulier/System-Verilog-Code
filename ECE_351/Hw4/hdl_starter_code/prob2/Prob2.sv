//////////////////////////////////////////////////////////////////////////////
// Prob2Tb.sv - Implicit FSM
//
// Author:	Alex Beaulier (beaulier@pdx.edu)
// Date:	6/2/2020 
//
// Description:
// ------------
//
// Generates all states from S0 to S4 from carwash hw2. 
////////////////////////////////////////////////////////////////////////////
module top; // used in testbench chapter
    logic clk, CLR; // clock and reset signal. CLR is asserted high
	// to reset the FSM
	logic TOKEN; // customer inserted a token. Asserted high
	logic START; // customer pressed the START button. Asserted high
	logic T1DONE; // spray time has expired. Asserted high
	logic T2DONE; // rinse time (after soap) has expired. Asserted
	logic CLRT1; // clear the spray timer. Assert high
	logic CLRT2; // clear the rinse timer. Assert high
	logic SOAP; // apply soap. Assert high
	logic SPRAY; // turn on the spray. Assert high

	timeunit 1ns/1ns;
	
	import "DPI-C" function string getenv(input string env_name);
	
carwash_fsm dut(.*);
tBench tb(.*);
initial begin: I
	$monitor($time, " Current State = %s, Next_State = %s", dut.current_state,dut.next_state);
	clk = 0;
	CLR = 0;
	CLR <= #1 1; //Reset low to 1 for 1 cycle later.
	CLR <= #6 0; //Reset low to 1 for 1 cycle later.
	
	forever #5 clk = ~clk; //Clock to run while asserting reset
end: I
endmodule: top


program tBench (
	input logic clk, 
	output logic TOKEN, START, T1DONE, T2DONE
);

timeunit 1ns/1ns;

initial begin: IMPLICITFSM // the implicit FSM
	//Go to S0
	TOKEN <= 0;	
	START <= 0;	
	T1DONE <= 0;
	T2DONE <= 1;
	@(posedge clk); 
	
		//Repeat S0
	TOKEN <= 0;	
	@(posedge clk); 
	
	//Go to S1
	TOKEN <= 1;	
	@(posedge clk); 
	
		//Repeat S1
	TOKEN <= 0;
	START <= 0;
	@(posedge clk); 
	
	//Go to S2
	TOKEN <= 1;	
	@(posedge clk); 
	
		//Repeat S2
	TOKEN <= 0;	
	START <= 0;	
	T1DONE <= 0;
	@(posedge clk); 
	
	//Go to S3
	T1DONE <= 1;
	@(posedge clk); 
	
		//Repeat S3
	T2DONE <= 0;
	T1DONE <= 0;
	@(posedge clk); 
	
	//Go to S4
	T2DONE <= 1;
	@(posedge clk); 
	
		//Repeat S4
	T1DONE <= 0;
	T2DONE <= 0;
	@(posedge clk); 
	
	//Go to S0
	T1DONE <= 1;
	@(posedge clk); 
	
	//Go to S1
	T1DONE <= 0;
	TOKEN <= 1;	
	@(posedge clk); 
	
	//Go to S4
	TOKEN <= 0;	
	START <= 1;
	@(posedge clk); 
	
	//Successfully taken all transit loops and repeat loops
	$display("\nUART Loopback Test - <Alex Beaulier> (<Beaulier@pdx.edu>)");
    $display("Sources: %s\n", getenv("PWD"));
	#1000 $stop;
end: IMPLICITFSM
endprogram: tBench