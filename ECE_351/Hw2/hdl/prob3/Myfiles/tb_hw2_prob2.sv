//////////////////////////////////////////////////////////////////////////////
// hw2_prob1.sv
//
// Author:	Alex Beaulier (Beaulier@pdx.edu)
// DATE:	9-5-2020 (modified 9-5-2021)
//
// Contains 
// 
/////////////////////////////////////////////////////////////////////////////
module tb_hw2_prob2
#(
 parameter in4ELin1Y = 5
)

(
	input logic in1,in2,in3,in4,in5,enableN
	output logic tri_outN
);

timeunit 1ns/1ns;

//INSTANTIATE DUT Problem2
hw2_prob2 DUTPROB2(.in1(.*),.in2(.*),.in3(.*),.in4(.*),.in5(.*),.enableN(.*),.tri_outN(.*));

//test variables
int i,j,k,l,m,n,test_count //One letter for each logic output
int errors;

initial begin: test_prob2
	$display("Start of Execution -  Alex beaulier (beaulier@pdx.edu), Sources: %s\n",getenv("PWD"));
	test_count = 0;
	$monitor("Monitor in1:%d, in2:%d, in3:%d, in4:%d, in5:%d, enableN:%d, tri_outN:%d",in1,in2,in3,in4,in5,enableN,tri_outN);
	repeat(2) begin: apply_all_test_cases
		for(i = 0; i < 1; i++) begin: in1gen
            #5 in1 = i;
			for(j = 0; j < 1; j++) begin: in2gen
				#5 in2 = j;
				for(k = 0; k < 1; k++) begin: in3gen
					#5 in3 = k;
					for(l = 0; l < 1; l++) begin: in4gen
						#5 in4 = l;
						for(m = 0; m < 1; m++) begin: in5gen
							#5 in5 = m;
							for(n = 0; n < 1; n++) begin: enableN
								#5 enableN = n;
								test_count++;
							end: enableN
						end: in5gen
					end: in4gen
				end: in3gen
			end: in2gen 
		end: in1gen
			
	end: apply_all_test_cases


end: test_prob2
