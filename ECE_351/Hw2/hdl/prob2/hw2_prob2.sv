//////////////////////////////////////////////////////////////////////////////
// hw2_prob2.sv
//
// Author:	Alex Beaulier (beaulier@pdx.edu)
// Date:	9-5-2020 (modified 9-5-2021)
//
// Contains model for problem 2 hw2 ECE 351. An inverting tri-state buffer.
// 
/////////////////////////////////////////////////////////////////////////////

 module hw2_prob2 (
	input logic in1,in2,in3,in4,in5,enableN,
	output tri tri_outN
);

//Intermediate wires
logic in1in2out, in345out, nor12345out;

//Part A - Write schematic with always_comb block and tri-state buffer
always_comb
begin: math
	in1in2out = in1 & in2;
	in345out = in3 & in4 & in5;
	nor12345out = ~(in1in2out ^ in345out);
end: math

assign tri_outN = ~enableN ? nor12345out : 1'bZ; 

endmodule: hw2_prob2