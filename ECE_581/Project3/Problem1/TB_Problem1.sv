//////////////////////////////////////////////////////////////////////////////
// Problem1_Tb.sv - FSM
//
// Author:	Alex Beaulier (beaulier@pdx.edu)
// Date:	6/2/2020 
//
// Description:
// ------------
//
// Generates all states from S0 to S4 from carwash hw2. 
////////////////////////////////////////////////////////////////////////////
module top;
	logic [7:0]DATAOUTA;
	logic [7:0]DATAOUTB;
	logic [7:0]DATAOUTC;
	logic DATAIN;
	logic CLK, RESET; // clock and reset signal
	timeunit 1ns/1ns;
	
Problem1_A dutA(.*, .DATAOUT(DATAOUTA));
Problem1_B dutB(.*, .DATAOUT(DATAOUTB));
Problem1_C dutC(.*, .DATAOUT(DATAOUTC));
tBench tb(.*);

initial begin: I
	CLK = 0;
	RESET = 0;
	RESET <= #1 1; //Reset low to 1 for 1 cycle later.
	RESET <= #6 0; //Reset low to 1 for 1 cycle later.
	
	forever #5 CLK = ~CLK; //Clock to run while asserting reset
end: I
endmodule: top


module tBench (
	input logic CLK,RESET, 
	output logic DATAIN
);

timeunit 1ns/1ns;

initial begin: FSM
	$monitor($time, " DOUT:%7b Current State = %s, Next_State = %s", dutA.DATAOUT,dutA.current_state,dutA.next_state);
	$monitor($time, " DOUT:%7b Current State = %s, Next_State = %s", dutB.DATAOUT,dutB.current_state,dutB.next_state);
	$monitor($time, " DOUT:%7b Current State = %s, Next_State = %s", dutC.DATAOUT,dutC.current_state,dutC.next_state);
	
	//Go to S1
	DATAIN = 1;
	@(posedge CLK); 
	
	//Repeat S1
	DATAIN = 0;	
	@(posedge CLK); 
	
	//Go to S2
	DATAIN = 1;
	@(posedge CLK); 
	
	//Repeat S2
	DATAIN = 0;	
	@(posedge CLK); 
	
	//Go to S3
	DATAIN = 1;
	@(posedge CLK); 
	
	//Repeat S3
	DATAIN = 0;	
	@(posedge CLK); 
	
	//Go to S4
	DATAIN = 1;
	@(posedge CLK); 
	
	//Repeat S4
	DATAIN = 0;
	@(posedge CLK); 
	
	//Go to S5
	DATAIN = 1;
	@(posedge CLK); 
	
	//Repeat S5
	DATAIN = 0;	
	@(posedge CLK); 
	
	//Go to S6
	DATAIN = 1;
	@(posedge CLK); 
	
	//Repeat S6
	DATAIN = 0;	
	@(posedge CLK); 
	
	//Go to S7
	DATAIN = 1;
	@(posedge CLK); 
	
	//Repeat S7
	DATAIN = 0;	
	@(posedge CLK); 

	//Go to S8
	DATAIN = 1;
	@(posedge CLK); 
	
	//Repeat S8
	DATAIN = 0;	
	@(posedge CLK); 
	
	//Successfully taken all transit loops and repeat loops
	$display("\nState Machine Complete - <Alex Beaulier> (<Beaulier@pdx.edu>)");
	#100 $stop;
end: FSM
endmodule: tBench