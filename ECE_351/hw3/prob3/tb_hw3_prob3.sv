// tb_hw3_prob3.sv - testbench for the PmodSSD homework problem
//
// Author:	Roy Kravitz (roy.kravitz@pdx.edu) 
// Date:	15-May-2020
// Last modified: 13-May-2021
//
// Description:
// ------------
// Implements a test bench for the PmodSSD homework problem.  Connects the
// student's PmodSSD interface with the PmodSSD display simulator.  
// Tries combinations of digits. You can check the ASCII character codes to see
// that your PmodSSD Interface is working correctly.
//
// Note: original version by Roy Kravitz, circa 2012.  Updated to SystemVerilog
//
// Note:  adds the code to display the name, email address, and working directory
// for your simulation.  You should edit the code to replace <your name> (<your email address>)
// with your information.
////////////////////////////////////////////////////////////////
module tb_hw3_prob3;

timeunit 1ns/1ns;

// make use of the SystemVerilog C programming interface
// https://stackoverflow.com/questions/33394999/how-can-i-know-my-current-path-in-system-verilog
import "DPI-C" function string getenv(input string env_name);

// define stimulus interval
localparam IVL = 100;

// internal signals
logic			sysclk, sysreset;			// system clock and reset
logic	[4:0]	ccd1, ccd0;					// character codes for digit 1 and digit 0
logic			segg, segf, sege, segd,		// segments signals for PmodSSD
				segc, segb, sega;
logic			dig_enable, dig_enable_n;	// digit enable cathode signal to display
logic	[6:0]	dig1_segs, dig0_segs;		// digit 1 and digit 0 segment drivers
logic	[15:0]	disply;						// ASCII version of display digits

// instantiate your PmodSSD interface
pmodSSD_Interfaces
#(
	.SIMULATE(1)
) PMODSSDIF
(
	.clk(sysclk),
	.reset(sysreset),	
	.digit1(ccd1),
	.digit0(ccd0),
	.SSD_AG(segg),
	.SSD_AF(segf),
	.SSD_AE(sege),
	.SSD_AD(segd),
	.SSD_AC(segc),
	.SSD_AB(segb),
	.SSD_AA(sega),
	.SSD_C(dig_enable)
);

// instantiate the PmodSSD emulator
pmodSSD_emu PMODSSD
(
	.AG(segg),
	.AF(segf),
	.AE(sege),
	.AD(segd),
	.AC(segc),
	.AB(segb),
	.AA(sega),
	.CAT(dig_enable),
	.dig1_segs(dig1_segs),
	.dig0_segs(dig0_segs),	
	.dsply_digits(disply)
);

// generate the system clock
initial sysclk = 1'b0;
always #5 sysclk = ~sysclk;


// Monitor the outputs 
initial begin
	$monitor($time, "\tdig1 cc=%h\tdig0 cc=%x\tdig enable=%b\tdisplay=%s\t\tdig1 segs=%b\tdig0 segs=%b\t\t[%s]", ccd1, ccd0, dig_enable, disply, dig1_segs, dig0_segs, disply);
end

// test vectors
logic [4:0]	cc;		// character code

// generate display enable for digit 0 (used in waveform)
assign dig_enable_n = ~dig_enable;

// Apply the test vectors
initial begin: stimulus
    $display("synchronous counter problem - <Alex Beaulier> (beaulier@pdx.edu)");
    $display("Sources: %s\n", getenv("PWD"));
    
	$display("Reset the system ");
			sysreset = 1'b0;
	#10		sysreset = 1'b1;
	#10		sysreset = 1'b0;
	$display("Test digits by walking digit0 up and digit 1 down");
	$display("Digit 1 (leftmost) should only change when dig_enable is asserted high (not the edge, the level)");
	$display("Digit 0 (rightmost) should only change when dig_enable is asserted low (not the edge, the level");
	$display("This is because the display is multiplexed.  On live hardware you would");
	$display("not notice this because the display would be updating @ 60Hz and your");
	$display("brain would average the results");
	cc = 5'd0;
	repeat(32) begin
		#IVL	ccd0 = cc;  ccd1 = 5'h1F - cc;
				cc = cc + 1;
	end
	#IVL
    $display("End simulation of synchronous counter problem - <Alex Beaulier> (beaulier@pdx.edu)\n");
	$stop;
end: stimulus

endmodule: tb_hw3_prob3


