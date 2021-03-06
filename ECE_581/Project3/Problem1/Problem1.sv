//////////////////////////////////////////////////////////////
// Problem1.sv - S1 Circuit
// ECE 581 Project3
// Author: Alex Beaulier (beaulier@pdx.edu)
// Date: 7-29-2021
// Description:
// ------------/
// This function is problem 1 Binary, One hot and Reversed One-Hot Encoding
////////////////////////////////////////////////////////////////


/*
//BINARY ENCODING
module Problem1_A(
output logic [7:0]DATAOUT,
input logic  DATAIN,
input logic  CLK,RESET
);

//PROBLEM A IS BINARY STATE ENCODING
enum logic [7:0] {
	S1 = 8'b0000000, 
	S2 = 8'b0000001,
	S3 = 8'b0000010,
	S4 = 8'b0000011,
	S5 = 8'b0000100,
	S6 = 8'b0000101,
	S7 = 8'b0000110,
	S8 = 8'b0000111
}current_state, next_state;

//S1 STATE MACHINE
always_ff @(posedge CLK) begin: seqblock
	if(RESET) 
		current_state <= S1;
	else 
		current_state <= next_state;
end: seqblock

//References state diagram given in problem statement two to determine movement 
always_comb begin: next_stateassign
	next_state = current_state;
	unique case(current_state)
		S1 : begin next_state = (DATAIN) ? S2 : S1 ; end
		S2 : begin next_state = (DATAIN) ? S3 : S2 ; end
		S3 : begin next_state = (DATAIN) ? S4 : S3 ; end
		S4 : begin next_state = (DATAIN) ? S5 : S4 ; end
		S5 : begin next_state = (DATAIN) ? S6 : S5 ; end
		S6 : begin next_state = (DATAIN) ? S7 : S6 ; end
		S7 : begin next_state = (DATAIN) ? S8 : S7 ; end
		S8 : begin next_state = (DATAIN) ? S1 : S8 ; end
	default : next_state = S1;
	endcase
end: next_stateassign

assign DATAOUT = current_state;

endmodule : Problem1_A




//One-hote
module Problem1_B(
output logic [7:0]DATAOUT,
input logic  DATAIN,
input logic  CLK,RESET
);

//PROBLEM B IS ONE HOT
enum logic [7:0] {
	S1 = 8'b00000001, 
	S2 = 8'b00000010,
	S3 = 8'b00000100,
	S4 = 8'b00001000,
	S5 = 8'b00010000,
	S6 = 8'b00100000,
	S7 = 8'b01000000,
	S8 = 8'b10000000
}current_state, next_state;

//S1 STATE MACHINE
always_ff @(posedge CLK) begin: seqblock
	if(RESET) 
		current_state <= S1;
	else 
		current_state <= next_state;
end: seqblock

//References state diagram given in problem statement two to determine movement 
always_comb begin: next_stateassign
	next_state = current_state;
	unique case(current_state)
		S1: begin next_state = (DATAIN) ? S2 : S1 ; end
		S2: begin next_state = (DATAIN) ? S3 : S2 ; end
		S3: begin next_state = (DATAIN) ? S4 : S3 ; end
		S4: begin next_state = (DATAIN) ? S5 : S4 ; end
		S5: begin next_state = (DATAIN) ? S6 : S5 ; end
		S6: begin next_state = (DATAIN) ? S7 : S6 ; end
		S7: begin next_state = (DATAIN) ? S8 : S7 ; end
		S8: begin next_state = (DATAIN) ? S1 : S8 ; end
	default : next_state = S1;
	endcase
end: next_stateassign

assign DATAOUT = current_state;

endmodule : Problem1_B


*/

//Reversed One Hot Encoding
module Problem1_C(
output logic [7:0]DATAOUT,
input logic  DATAIN,
input logic  CLK,RESET
);

//PROBLEM C is Reversed One Hot Enoding

enum {
	S1_bit = 0, 
	S2_bit = 1,
	S3_bit = 2,
	S4_bit = 3,
	S5_bit = 4,
	S6_bit = 5,
	S7_bit = 6,
	S8_bit = 7 
}state_bit;

enum logic [7:0] {
	S1 = 8'b00000001<<S1_bit,
	S2 = 8'b00000001<<S2_bit,
	S3 = 8'b00000001<<S3_bit,
	S4 = 8'b00000001<<S4_bit,
	S5 = 8'b00000001<<S5_bit,
	S6 = 8'b00000001<<S6_bit,
	S7 = 8'b00000001<<S7_bit,
	S8 = 8'b00000001<<S8_bit
}current_state, next_state;

//S1 STATE MACHINE
always_ff @(posedge CLK) begin: seqblock
	if(RESET) 
		current_state <= S1;
	else 
		current_state <= next_state;
end: seqblock

//References state diagram given in problem statement two to determine movement 
always_comb begin: next_stateassign
	next_state = current_state;
	unique case(1'b1)
		current_state[S1_bit] : begin next_state = (DATAIN) ? S2 : S1 ; end
		current_state[S2_bit] : begin next_state = (DATAIN) ? S3 : S2 ; end
		current_state[S3_bit] : begin next_state = (DATAIN) ? S4 : S3 ; end
		current_state[S4_bit] : begin next_state = (DATAIN) ? S5 : S4 ; end
		current_state[S5_bit] : begin next_state = (DATAIN) ? S6 : S5 ; end
		current_state[S6_bit] : begin next_state = (DATAIN) ? S7 : S6 ; end
		current_state[S7_bit] : begin next_state = (DATAIN) ? S8 : S7 ; end
		current_state[S8_bit] : begin next_state = (DATAIN) ? S1 : S8 ; end
	endcase
end: next_stateassign

//Outputs
always_comb begin: set_outputs
DATAOUT = 8'b00000000;
unique case(1'b1) //Reverse case
    current_state[S1_bit] : DATAOUT = current_state;
    current_state[S2_bit] : DATAOUT = current_state;
    current_state[S3_bit] : DATAOUT = current_state;
    current_state[S4_bit] : DATAOUT = current_state;
    current_state[S5_bit] : DATAOUT = current_state;
    current_state[S6_bit] : DATAOUT = current_state;
    current_state[S7_bit] : DATAOUT = current_state;
    current_state[S8_bit] : DATAOUT = current_state;
endcase
end:set_outputs
endmodule: Problem1_C