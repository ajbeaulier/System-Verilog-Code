//////////////////////////////////////////////////////////////
// Problem2.sv
// ECE 581 Project3
// Author: Alex Beaulier (beaulier@pdx.edu)
// Date: 7-29-2021
// Description:
// ------------/
// This function is a 4-bit gray code adder. Has two 4-bit gray to binary converters, 
// a 4-bit binary adder
// one 5-bit binary to gray code convertor
////////////////////////////////////////////////////////////////


module Problem2(
output logic [4:0] Greyout,
input logic [3:0] graycode1,
input logic [3:0] graycode2
);

logic [3:0] bin1;
logic [3:0] bin2;

logic [4:0] bin5bit;

logic [3:0] sumout;
logic [3:0] Carryout;
logic [3:0] Carryin;


always_comb begin
	//Convert Gray code to binary for both sets
	bin1[0] = graycode1[0] ^ graycode1[1] ^ graycode1[2] ^ graycode1[3];
	bin1[1] = graycode1[3] ^ graycode1[2] ^ graycode1[1];
	bin1[2] = graycode1[3] ^ graycode1[2];
	bin1[3] = graycode1[3];
	bin2[0] = graycode2[0] ^ graycode2[1] ^ graycode2[2] ^ graycode2[3];
	bin2[1] = graycode2[3] ^ graycode2[2] ^ graycode2[1];
	bin2[2] = graycode2[3] ^ graycode2[2];
	bin2[3] = graycode2[3];
	
	
	//4 Bit Binary Addition of both sets, full adder
	
	Carryout[0] = (bin1[0] & bin2[0]) | (bin1[0] & 0) | (bin2[0] & 0);
	Carryout[1] = (bin1[1] & bin2[1]) | (bin1[1] & Carryin[0]) | (bin2[1] & Carryin[0]);
	Carryout[2] = (bin1[2] & bin2[2]) | (bin1[2] & Carryin[1]) | (bin2[2] & Carryin[1]);
	Carryout[3] = (bin1[3] & bin2[3]) | (bin1[3] & Carryin[2]) | (bin2[3] & Carryin[2]);
	
	sumout[0] = bin1[0] ^ bin2[0] ^ 0;
	sumout[1] = bin1[1] ^ bin2[1] ^ Carryout[0];
	sumout[2] = bin1[2] ^ bin2[2] ^ Carryin[1];
	sumout[3] = bin1[3] ^ bin2[3] ^ Carryin[2];
	
	//Set to the bin5bit
	bin5bit[0] = sumout[0];
	bin5bit[1] = sumout[1];
	bin5bit[2] = sumout[2];
	bin5bit[3] = sumout[3];
	bin5bit[4] = Carryout[3];
	
	//5 Bit Binary-to-Gray code converter, output is the 5 bits
	Greyout[4] = bin5bit[4];
	Greyout[3] = bin5bit[4] ^ bin5bit[3];
	Greyout[2] = bin5bit[3] ^ bin5bit[2];
	Greyout[1] = bin5bit[2] ^ bin5bit[1];
	Greyout[0] = bin5bit[1] ^ bin5bit[0];
end

endmodule: Problem2