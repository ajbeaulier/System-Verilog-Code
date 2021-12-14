//////////////////////////////////////////////////////////////
// Problem1.sv - S1 Circuit
//
// Author: Alex Beaulier (beaulier@pdx.edu)
// Date: 7-24-2021
// Description:
// ------------/
// This function is problem 1 S1 circuit with C1 
////////////////////////////////////////////////////////////////

module Problem1(
output logic DATAOUT,
input logic [8:0] X,
input logic clk,reset
);

//local parameters
logic COUT;
logic Q1,Q2,Q3,Q4;

enum logic [4:0] {
	S0000,  
	S0001,
	S0010,
	S0011,
	S0100,
	S0101,
	S0110,
	S0111,
	S1000,
	S1001,
	S1010,
	S1011,
	S1100,
	S1101,
	S1110,
	S1111
}current_state, next_state;


//C1 combinatiopnal Circuit
always_comb begin
 COUT = X[8] & ( X[7] & ( X[6] & ( X[5] ^ ( X[4] ^ ( X[3] ~^ ( X[2] ~^ ( X[1] ~^ X[0])))))));
end


//S1 STATE MACHINE
always_ff @(posedge clk) begin: seqblock
	if(reset) 
		current_state <= S0000;
	else 
		current_state <= next_state;
end: seqblock

//next_state Function Moore Machine of 4 flip flops
//References state diagram given in problem statement two to determine movement 
always_comb begin: next_stateassign
	next_state = current_state;
	unique case(current_state)
		S0000 : begin next_state = (COUT) ? S1000 : S0000; end 
		S0001 : begin next_state = (COUT) ? S1000 : S0000; end 
		S0010 : begin next_state = (COUT) ? S1001 : S0001; end 
		S0011 : begin next_state = (COUT) ? S1001 : S0001; end 
		S0100 : begin next_state = (COUT) ? S1010 : S0010; end 
		S0101 : begin next_state = (COUT) ? S1010 : S0010; end 
		S0110 : begin next_state = (COUT) ? S1011 : S0011; end 
		S0111 : begin next_state = (COUT) ? S1011 : S0011; end 
		S1000 : begin next_state = (COUT) ? S1100 : S0100; end 
		S1001 : begin next_state = (COUT) ? S1100 : S0100; end 
		S1010 : begin next_state = (COUT) ? S1101 : S0101; end 
		S1011 : begin next_state = (COUT) ? S1101 : S0101; end 
		S1100 : begin next_state = (COUT) ? S1110 : S0110; end 
		S1101 : begin next_state = (COUT) ? S1110 : S0110; end 
		S1110 : begin next_state = (COUT) ? S1111 : S0111; end 
		S1111 : begin next_state = (COUT) ? S1111 : S0111; end 
	default : next_state = S0000;
	endcase
end: next_stateassign

assign DATAOUT = current_state;

endmodule : Problem1