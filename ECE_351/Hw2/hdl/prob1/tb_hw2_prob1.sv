//////////////////////////////////////////////////////////////////////////////
// hw2_prob1.sv
//
// Author:	Alex Beaulier (Beaulier@pdx.edu)
// Date:	9-5-2020 (modified 9-5-2021)
//
// Contains test bench for problem 1 to test all variables.
// 
/////////////////////////////////////////////////////////////////////////////



module tb_hw2_prob1;

import "DPI-C" function string getenv(input string env_name); 

logic A, B, C, D;
logic Y;

parameter DELAY = 5;

timeunit 1ns/1ns;

//INSTANCE OF DUT
hw2_prob1 DUTPROB1(.*);

//test variables
int i,j,k,l;
initial begin: test_prob1
	$display("Start of Execution - Alex Beaulier (beaulier@pdx.edu), Sources: %s\n",getenv("PWD"));
	$monitor("Monitor A:%d, B:%d, C:%d, D:%d, Y:%d",A,B,C,D,Y);
	begin: apply_all_test_cases
		for(i = 0; i <= 1; i++) begin: Agen
            		#DELAY; 
			A = i;
			for(j = 0; j <= 1; j++) begin: Bgen
				#DELAY; 
				B = j;
				for(k = 0; k <= 1; k++) begin: Cgen
					#DELAY; 
					C = k;
					for(l = 0; l <= 1; l++) begin: Dgen
						#DELAY; 
						D = l;
					end: Dgen
				end: Cgen
			end: Bgen 
		end: Agen
	end: apply_all_test_cases
end: test_prob1

endmodule: tb_hw2_prob1
