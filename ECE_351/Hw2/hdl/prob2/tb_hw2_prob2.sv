//////////////////////////////////////////////////////////////////////////////
// tb_hw2_prob2.sv
//
// Author:	Alex Beaulier (Beaulier@pdx.edu)
// DATE:	9-5-2020 (modified 9-5-2021)
//
// Contains code to run Hw2_prob2 tri-state buffer n. 
// This is the testbench for the design 
/////////////////////////////////////////////////////////////////////////////
module tb_hw2_prob2;

import "DPI-C" function string getenv(input string env_name); 

logic in1,in2,in3,in4,in5,enableN;
logic tri_outN;

parameter DELAY = 5;

timeunit 1ns/1ns;

//INSTANTIATE DUT Problem2
hw2_prob2 DUTPROB2(.*);

//test variables
int i,j,k,l,m,n; //One letter for each logic output

initial begin: test_prob2
	$display("Start of Execution -  Alex beaulier (beaulier@pdx.edu), Sources: %s\n",getenv("PWD"));
	$monitor("Monitor in1:%d, in2:%d, in3:%d, in4:%d, in5:%d, enableN:%d, tri_outN:%d",in1,in2,in3,in4,in5,enableN,tri_outN);
	begin: apply_all_test_cases
		for(i = 0; i <= 1; i++) begin: in1gen
            		#5;
			in1 = i;
			for(j = 0; j <=1; j++) begin: in2gen
				#5; 
				in2 = j;
				for(k = 0; k <= 1; k++) begin: in3gen
					#5;
					in3 = k;
					for(l = 0; l <= 1; l++) begin: in4gen
						#5; 
						in4 = l;
						for(m = 0; m <= 1; m++) begin: in5gen
							#5; 
							in5 = m;
							for(n = 0; n <= 1; n++) begin: enableNa
								#5; 
								enableN = n;
							end: enableNa
						end: in5gen
					end: in4gen
				end: in3gen
			end: in2gen 
		end: in1gen
	end: apply_all_test_cases
end: test_prob2

endmodule: tb_hw2_prob2
