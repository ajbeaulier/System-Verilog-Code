// pmodSSD_Interface.sv - 7 Segment Problem Controller
//
// Author:	 Alex Beaulier(beaulier@pdx.edu) 
// Date:	24-May-2020
// Last modified: 
//
// Description:
// ------------
// Implements homework 3 problem 3, 7 segment converter function 
// and correctly uses PmodSSD interface provided.
//
// Note: original version by Alex Beaulier.
//
////////////////////////////////////////////////////////////////

//**
// Function used in tb_hw3_prob3 for interfacing to PMOD. TB connects to PmodSSD_emu
// Uses decoder in pmodSSD_interface for output
// Has step 3 within the emu
//**
module pmodSSD_Interfaces
#(
	parameter SIMULATE = 1 	// set to 1 for this project, else it will take
							// 100’s of thousand cycles of simulation time
							// for each digit change.
)
(
	input logic clk, reset, // clock and reset signals
	input logic[4:0] digit1, digit0, // digit character codes
	output logic 	SSD_AG, SSD_AF, // Anode segment drivers
					SSD_AE, SSD_AD,
					SSD_AC, SSD_AB, SSD_AA,
	output logic SSD_C // Common cathode "digit enable"
);


timeunit 1ns/1ns;


//Internal Params
logic tick_120HZ; 			//Clock tick from divider
logic tick_60Hz; 			//60Hz to drive each cathode digit



//Create the clock for the SSD_Interface
clk_divider #(
	.CLK_INPUT_FREQ_HZ(100_000_000), 
	.TICK_OUT_FREQ_HZ(120), 
	.SIMULATE(SIMULATE) 
) clockSSD(
	.clk(clk),
	.reset(reset),
	.tick_out(tick_120Hz)
)
;

//Step 4 - Drive Cathode pulse using 50% duty cycle to drive digit enable. 
//Use later in MUX block to select digit 0 or digit 1.
always_ff @(posedge clk) begin: digit_enable
if (reset)
	tick_60Hz <= 1'b0;
else if (tick_120Hz) // 2x the frequency for 50% on / 50% off
	tick_60Hz <= ~tick_60Hz;
else
	tick_60Hz <= tick_60Hz;
end: digit_enable

//Continuously assign SSD_C
assign SSD_C = tick_60Hz; //SSD_C assigned to digit enable in TB. 


//** Seven Seg Decoder Converter **
//Dig2Seg takes in 5 digit binary and converts to 7 bit segment output
//Call with ccd1 or ccd2
function logic [6:0] Dig2Seg( input logic [4:0] binaryvalues );
	case(binaryvalues)  
	
		// hex digits 0-9				//DEC //Hex
		5'b00000: Dig2Seg = 7'b1111110;  //0   //00
		5'b00001: Dig2Seg = 7'b0000110;  //1   //01
		5'b00010: Dig2Seg = 7'b1101101;  //2   //02
		5'b00011: Dig2Seg = 7'b1111001;  //3   //03
		5'b00100: Dig2Seg = 7'b0110011;  //4   //04
		5'b00101: Dig2Seg = 7'b1011011;  //5   //05
		5'b00110: Dig2Seg = 7'b1011111;  //6   //06
		5'b00111: Dig2Seg = 7'b1110000;  //7   //07
		5'b01000: Dig2Seg = 7'b1111111;  //8   //08
		5'b01001: Dig2Seg = 7'b1111011;  //9   //09
									   
		// hex digits A - F             
		5'b01010: Dig2Seg = 7'b1110111;  //10   //0A
		5'b01011: Dig2Seg = 7'b0011111;  //11   //0B
		5'b01100: Dig2Seg = 7'b1001110;  //12   //0C
		5'b01101: Dig2Seg = 7'b0111101;  //13   //0D
		5'b01110: Dig2Seg = 7'b1001111;  //14   //0E
		5'b01111: Dig2Seg = 7'b1000111;  //15   //0F
									    
		// individual segments          
		5'b10000: Dig2Seg = 7'b1000000;  //16   //10 	//segment a
		5'b00001: Dig2Seg = 7'b0100000;  //17   //11 	//segment b
		5'b10010: Dig2Seg = 7'b0010000;  //18   //12 	//segment c
		5'b10011: Dig2Seg = 7'b0001000;  //19   //13 	//segment d
		5'b10100: Dig2Seg = 7'b0000100;  //20   //14 	//segment e
		5'b10101: Dig2Seg = 7'b0000010;  //21   //15 	//segment f
		5'b10110: Dig2Seg = 7'b0000001;  //22   //16 	//segment g

		// blank (all digits off) - implemented as a caret so that it consumes a position
		5'b10111: Dig2Seg = 7'b0000000;  //23   //17 	//BLANK
	
		// Special characters         
		5'b11000: Dig2Seg = 7'b0110111;  //24   //18	//upper case H
		5'b11001: Dig2Seg = 7'b0001110;  //25   //19	//upper case L       
		5'b11010: Dig2Seg = 7'b1110111;	 //26   //1A	//upper case R (same as Upper Case A)
		5'b11011: Dig2Seg = 7'b0000110;	 //27   //1B	//lower case L (l)
		5'b11100: Dig2Seg = 7'b0000101;  //28   //1C	//lower case R (r)
		//Extra                          
		5'b11101: Dig2Seg = 7'b0000000;  //29   //1D	//BLANK
		5'b11110: Dig2Seg = 7'b0000000;  //30   //1E	//BLANK
		5'b11111: Dig2Seg = 7'b0000000;  //31   //1F	//BLANK
		
		// All combinations present
	endcase
endfunction: Dig2Seg  // Dig2Seg
//** EO Seven Seg Decoder Converter **

//Mux the signals together
//Assign segments
always_comb begin: MuxSignals
	//Modify the segments based on the cathode being digit 1 or digit 2. SSDC being assigned 
	//With 50% duty cycle should shift on and off between the two evenly for "Visible" always on state.
	if (SSD_C)
		{SSD_AA, SSD_AB, SSD_AC, SSD_AD,SSD_AE, SSD_AF, SSD_AG} = Dig2Seg(digit1); //Digit for C1
	else
		{SSD_AA, SSD_AB, SSD_AC, SSD_AD,SSD_AE, SSD_AF, SSD_AG} = Dig2Seg(digit0); //Digit for C2
end : MuxSignals

endmodule: pmodSSD_Interfaces	
	