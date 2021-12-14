// hw3_prob2.sv - Hardware Portion
//
// Author:	 Alex Beaulier(beaulier@pdx.edu) 
// Date:	24-May-2020
// Last modified: 
//
// Description:
// ------------
// Implements homework 3 problem 2, finite state machine.
//
// Note: original version by Alex Beaulier.
//
////////////////////////////////////////////////////////////////


module carwash_fsm (
	input logic clk, CLR, // clock and reset signal. CLR is asserted high
	// to reset the FSM
	input logic TOKEN, // customer inserted a token. Asserted high
	input logic START, // customer pressed the START button. Asserted high
	input logic T1DONE, // spray time has expired. Asserted high
	input logic T2DONE, // rinse time (after soap) has expired. Asserted
	// high
	output logic CLRT1, // clear the spray timer. Assert high
	output logic CLRT2, // clear the rinse timer. Assert high
	output logic SOAP, // apply soap. Assert high
	output logic SPRAY // turn on the spray. Assert high
);


timeunit 1ns/1ns;

//One Hot Encoded States
enum logic [4:0]{
	S0 = 5'b00001 << 0,
	S1 = 5'b00001 << 1,
	S2 = 5'b00001 << 2,
	S3 = 5'b00001 << 3,
	S4 = 5'b00001 << 4
} current_state, next_state;

//Initial States SEQUENTIAL BLOCK
always_ff@(posedge clk) begin: seqblock
	if(CLR) 
		current_state <= S0; //Reset to initial state if reset is asserted
	else 	
		current_state <= next_state; //Otherwise assign the next state
end: seqblock



//Outputs for each state
always_comb begin: outputstates
	{CLRT1, CLRT2, SOAP, SPRAY} = '0; //RESET ALL SIGNALS UPON RETURN TO CASE SELECTION
	unique case(1'b1) //DEFAULT
		current_state[0] : begin 						end
		current_state[1] : begin CLRT1 = '1;			end
		current_state[2] : begin {SPRAY, CLRT2} = '1; 	end
		current_state[3] : begin {SOAP, CLRT1} = '1; 	end
		current_state[4] : begin SPRAY = '1; 			end
	endcase
end: outputstates



//next_state Function Moore Machine
//References state diagram given in problem statement two to determine movement 
//Each state represented by S0 to S4. This segment controls state value by input tokens and start value.
//TB needs to decrement token and start value. Verilog doesn't allow reassigning of these values inside the block.
always_comb begin: nextstateassign
	next_state = current_state; //Always assign to the next state, then evaluate decision.
	unique case(1'b1) //DEFAULT
		current_state[0] : 	begin
								if(CLR == 1 || TOKEN == 0)			next_state = S0;
								else if(TOKEN == 1) 				next_state = S1;
							end
							
		current_state[1] : 	begin
								if(TOKEN == 0 && START == 0)			next_state = S1; 
								else if(TOKEN == 1 && START ==1)		next_state = S2;
								else if(START ==1)				next_state = S4;
							end
							
		current_state[2] : 	begin
								if(T1DONE == 0)					next_state = S2;
								else if(T1DONE == 1) 				next_state = S3;
							end
							
		current_state[3] : 	begin
								if(T2DONE == 0)					next_state = S3;
								else if(T2DONE == 1) 				next_state = S4;
							end
							
		current_state[4] : 	begin
								if(T1DONE == 0)						next_state = S4;
								else if(T1DONE == 1) 				next_state = S0;
							end
	endcase
end: nextstateassign


endmodule: carwash_fsm	