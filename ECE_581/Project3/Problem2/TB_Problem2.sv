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
logic [4:0] Greyout;
logic [3:0] graycode1;
logic [3:0] graycode2;

stimulus tb(.*);
Problem2 dut(.*);
endmodule: top


module stimulus
(
output logic [3:0] graycode1,
output logic [3:0] graycode2,
input logic [4:0] Greyout

);

	//Timescale for module
	timeunit 1ns/1ns;
	
	initial begin:testgen
	$display("Greyout %5b", dut.Greyout);
	
	graycode1 = 4'b0000;
	graycode2 = 4'b0001;
	$display("Greyout %5b", dut.Greyout);
	#5;
	
	graycode1 = 4'b0011;
	graycode2 = 4'b0010;
	$display("Greyout %5b", dut.Greyout);
	#5;
	
	graycode1 = 4'b1111;
	graycode2 = 4'b1111;
	$display("Greyout %5b", dut.Greyout);
	end:testgen
endmodule: stimulus