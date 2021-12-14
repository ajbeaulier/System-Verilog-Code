module TB_Problem2;
 logic out;	   //output, prints mismatch for 0, or match for 1
 logic Datain;  //Input bit
 logic clk;
 logic reset; //Timer

 timeunit 1ns/1ns;
 
 
stimulus TESTGENERATOR (.*);
Problem2 DUT(.*);


initial begin
	clk = 0;
	reset = 0;
	reset <= #1 1;
	reset <= #6 0;
	forever #5 clk = ~clk; //Clock to run while asserting reset
end

endmodule: TB_Problem2



program stimulus
(
		output logic Datain,
		input logic clk
);

timeunit 1ns/1ns;

initial begin
	$monitor("Datain:%d,Current_state:%s,Next_state%s\n",Datain,DUT.current_state,DUT.next_state);
	Datain = '0;
	#5 Datain = '1; //Reset to State 0
	@(posedge clk);
	
	//S01
	#5 Datain = '0; //Go State 2
	@(posedge clk);
	
	//S02
	#5 Datain = '0; //Go State 3
	@(posedge clk);
	
	//S03
	#5 Datain = '0; //Go State 4
	@(posedge clk);

	//S04
	#5 Datain = '0; //Go State 5
	@(posedge clk);

	//S05
	#5 Datain = '0; //Go State 6
	@(posedge clk);

	//S06
	#5 Datain = '0; //Go State 7
	@(posedge clk);
	
	//S17
	#5 Datain = '1; //Go State 8
	@(posedge clk);

	//S08
	#5 Datain = '0; //Go State 1
	@(posedge clk);

	//S01
	#5 Datain = '0; //Go State 2
	@(posedge clk);
	$stop;
	
end
endprogram: stimulus