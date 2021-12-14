// hw3_prob1.sv - Hardware Portion
//
// Author:	 Alex Beaulier(beaulier@pdx.edu) 
// Date:	24-May-2020
// Last modified: 
//
// Description:
// ------------
// Implements homework 3 problem 1, a mux and flip flop x4.  
// Feeds flip flop value to the right if serial in is 1
// Note: original version by Alex Beaulier.
//
////////////////////////////////////////////////////////////////

module hw3_prob1(
input logic SerialIn, SHIFT, CLK, CLR,
output logic Q3, Q2, Q1, Q0
);


timeunit 1ns/1ns;

//Variables & Wires**
wire Q3out, Q2out, Q1out, Q0out;
wire MuxFlip0, MuxFlip1, MuxFlip2, MuxFlip3;
//**


//MUX 3
hw3_prob1_MUX MUX3( .MuxOutput(MuxFlip3), .Inzero(Q3out), .Inone(SerialIn), .Shift(Shift) );
hw3_prob1_FlipFlop Flip3( .Q(Q3out), .RST(CLR), .CLK(CLK), .D(MuxFlip3) );

//MUX 2
hw3_prob1_MUX MUX2( .MuxOutput(MuxFlip2), .Inzero(Q2out), .Inone(Q3out),    .Shift(Shift) );
hw3_prob1_FlipFlop Flip2( .Q(Q2out), .RST(CLR), .CLK(CLK), .D(MuxFlip2) );

//MUX 1
hw3_prob1_MUX MUX1( .MuxOutput(MuxFlip1), .Inzero(Q1out), .Inone(Q2out),    .Shift(Shift) );
hw3_prob1_FlipFlop Flip1( .Q(Q1out), .RST(CLR), .CLK(CLK), .D(MuxFlip1) );

//MUX 0
hw3_prob1_MUX MUX0( .MuxOutput(MuxFlip0), .Inzero(Q0out), .Inone(Q0out),    .Shift(Shift) );
hw3_prob1_FlipFlop Flip0( .Q(Q0out), .RST(CLR), .CLK(CLK), .D(MuxFlip0) );


//Q assignments
assign Q3 = Q3out;
assign Q2 = Q2out;
assign Q1 = Q1out;
assign Q0 = Q0out;


endmodule: hw3_prob1

//____________________SUB FUNCTIONS__________________

//Mux block which uses 2 values and SHIFT input
module hw3_prob1_MUX(
output logic MuxOutput,
input logic Inzero, Inone, Shift
);
always @(Inzero, Inone, Shift) begin : Mux
if(Shift == 0)
	MuxOutput = Inzero;
else if(Shift == 1)
	MuxOutput = Inone;
end: Mux

endmodule



module hw3_prob1_FlipFlop(
output logic Q,
input logic RST,CLK,D
);

//Simple D flip flop
always_ff @(posedge CLK) begin: Dflipflop
if(~RST)
	Q <= D;
else
	Q <= 0;
end: Dflipflop

endmodule


