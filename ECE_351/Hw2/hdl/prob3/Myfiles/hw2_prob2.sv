//////////////////////////////////////////////////////////////////////////////
// hw2_prob2.sv
//
// Author:	Alex Beaulier (beaulier@pdx.edu)
// Date:	9-5-2020 (modified 9-5-2021)
//
// Contains model for problem 2 hw2 ECE 351
// 
/////////////////////////////////////////////////////////////////////////////

 module hw2_prob2 (
	input logic in1,in2,in3,in4,in5,enableN
	output logic tri_outN
);

//Intermediate wires
wire in1in2out, in345out, nor12345out

//Part A - Write schematic with always_comb block and tri-state buffer
always_comb
begin
	AND(in1in2out,in1,in2);
	AND(in345out,in3,in4,in5);
	XNOR(nor12345out,in1in2out,in345out);
	tri_outN = enableN ?  nor12345out : 1'bZ; 
end

endmodule: hw2_prob1