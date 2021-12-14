//////////////////////////////////////////////////////////////////////////////
// hw2_prob1.sv
//
// Author:	Alex Beaulier (roy.kravitz@pdx.edu)
// Date:	9-5-2020 (modified 9-5-2021)
//
// Contains 
// 
/////////////////////////////////////////////////////////////////////////////
module tb_hw2_prob1
#(
 parameter DELAY = 5
)

(
	input logic A, B, C, D,
	output logic Y
);

timeunit 1ns/1ns;

//INSTANCE OF DUT
hw2_prob1 DUTPROB1(.A(.*),.B(.*),.C(.*),.D(.*),.Y(.*));

//test variables
logic exp_value;
logic act_value;
int i,j,k,l,test_count //One letter for each logic output
int errors;

initial begin: test_prob1
	$display("Start of Execution - Alex Beaulier (beaulier@pdx.edu), Sources: %s\n",getenv("PWD"));
	test_count = 0;
	$monitor("Monitor A:%d, B:%d, C:%d, D:%d, Y:%d",A,B,C,D,Y);
	repeat(2) begin: apply_all_test_cases
		for(i = 0; i < 1; i++) begin: Agen
            #5 A = i;
			for(j = 0; j < 1; j++) begin: Bgen
				#5 B = j;
				for(k = 0; k < 1; k++) begin: Cgen
					#5 C = k;
					for(l = 0; l < 1; l++) begin: Dgen
						test_count++;
						#5 D = l;
					end: Dgen
				end: Cgen
			end: Bgen 
		end: Agen
			
	end: apply_all_test_cases


end: test_prob1

end tb_hw2_prob1
