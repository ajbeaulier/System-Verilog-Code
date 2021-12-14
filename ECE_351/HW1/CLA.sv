//////////////////////////////////////////////////////////////
// CLA.sv - Carry Lookahead Adder
//
// Author: Alex Beaulier (beaulier@pdx.edu)
// Date: 4-25-2021
//
// Description:
// ------------/
// This function performs the Carry Lookahead Adder Operation for bit sizes 4 and 8.
// Carry bits calculated one or more before calculating sum. Reduces wait time to calculate larger bits.
////////////////////////////////////////////////////////////////


//Full Adder/No Carryout
module CLA_FA_ONEBIT(
	input logic A, B, CI,	// a, b, and carry_in inputs
	output logic S			// sum
	);
assign S = A ^ B ^ CI;

endmodule: CLA_FA_ONEBIT



// 4 bit carry lookahead. Uses one 4 CLA modules.
module CLA4Bit(
	input logic [3:0] ain, bin, // A and B inputs to the adder
	input logic cin, // carry-in input to the adder
	output logic [3:0] sum, // 4-bit sum
	output logic cout // carry out
	);

wire[3:0] P,G; //Propogate, generate
wire[4:0] C;   //carry



//GENERAL CASES
assign P = ain ^ bin;
assign G = ain & bin;
//assign sum = ain ^ bin ^ cin;
assign cout = C[4];

CLA_FA_ONEBIT BIT0(.A(ain[0]), .B(bin[0]), .CI(cin),  .S(sum[0]));
CLA_FA_ONEBIT BIT1(.A(ain[1]), .B(bin[1]), .CI(C[1]), .S(sum[1]));
CLA_FA_ONEBIT BIT2(.A(ain[2]), .B(bin[2]), .CI(C[2]), .S(sum[2]));
CLA_FA_ONEBIT BIT3(.A(ain[3]), .B(bin[3]), .CI(C[3]), .S(sum[3]));

//CARRY LOGIC EQUATIONS
assign C[0] = cin;
assign C[1] = C[0] & P[0] | G[0];
assign C[2] = (C[1] & P[0] | G[0]) & P[1] | G[1];
assign C[3] = (C[1] & P[1] | G[1]) & P[2] | G[2];
assign C[4] = (C[0] & P[0] & P[1] & P[2] & P[3])  |  (P[3] & P[2] & P[1] & G[0])  |  (P[3] & P[2] & G[1])  |  (G[2] & P[3])  |  G[3]; //C4 is equivalent to Carry out resultant

endmodule: CLA4Bit




// 8 bit carry lookahead. Uses two 4 CLA modules. Is not exactly 8 bit due to not generating simultaneous carry for all 8. 
// Could implement simulatenous carryout for all 8 later. 
module CLA8Bit(
	input logic [7:0] ain, bin, // A and B inputs to the adder
	input logic cin, // carry-in input to the adder
	output logic [7:0] sum, // 4-bit sum
	output logic cout // carry out
	);
	
logic contb40;

CLA4Bit BIT03( .ain(ain[3:0]), .bin(bin[3:0]), .cin(cin)    , .sum(sum[3:0]), .cout(coutb40));
CLA4Bit BIT47( .ain(ain[7:4]), .bin(bin[7:4]), .cin(coutb40), .sum(sum[7:4]), .cout(cout)   );

endmodule: CLA8Bit
