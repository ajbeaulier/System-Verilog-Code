//////////////////////////////////////////////////////////////////////////////
// hw2_prob1.sv
//
// Author:	Alex Beaulier (beaulier@pdx.edu)
// Date:	9-5-2020 (modified 9-5-2021)
//
// Contains  problem 1 hw2 for ECE 351. 
// 
/////////////////////////////////////////////////////////////////////////////

 module hw2_prob1 (
	input logic A, B, C, D,
	output logic Y
);

//Intermediate wires
wire orgateout;
wire inverttop;
wire invertbottom;
wire andbottom;

//Part A - Write schematic with continuous assignments, no delay
//wire invertbottom: invert D 
//wire andbottom: And -> B C inverted D 
//wire orgateout: OR A and D, 
//wire inverttop: Invert output of or
//AND wire inverttop, wire andbottom -> Y

assign orgateout = A | D;
assign inverttop = ~orgateout; 
assign invertbottom = ~D;
assign andbottom = invertbottom & B & C;
assign Y = inverttop & andbottom;

endmodule: hw2_prob1
