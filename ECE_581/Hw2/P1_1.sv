//////////////////////////////////////////////////////////////
// Problem1_1.sv - 1 MOORE MACHINE 1 MEALY MACHINE
//
// Author: Alex Beaulier (beaulier@pdx.edu)
// Date: 7-20-2021
// Description:
// ------------/
// This function is problem 1_1 MOORE MACHINE converted into SV
////////////////////////////////////////////////////////////////

module MOOREMACHINE(
output logic [3:0] Dataout,
input  logic clk, reset,
input  logic Datain
);

enum logic [3:0] {
	S0 = 4'b0000, 
	S1 = 4'b1001, 
	S2 = 4'b1100, 
	S3 = 4'b1111
}current_state, next_state;

always_ff @(posedge clk) begin: seqblock
	if(reset) 
		current_state <= S0;
	else 
		current_state <= next_state;
end: seqblock

/*
always_comb begin: outputstates
	unique case(current_state) //DEFAULT
		S0 : begin end
		S1 : begin end
		S2 : begin end
		S3 : begin end
	endcase
end: outputstates*/

//next_state Function Moore Machine
//References state diagram given in problem statement two to determine movement 
always_comb begin: next_stateassign
	next_state = current_state;
	unique case(current_state)
		S0 : begin	next_state = (Datain) ? S1 : S0; end
							
		S1 : begin	next_state = (Datain) ? S1 : S2; end
							
		S2 : begin	next_state = (Datain) ? S3 : S2; end
							
		S3 : begin	next_state = (Datain) ? S3 : S0; end
	default : ;
	endcase
end: next_stateassign

assign Dataout = current_state;

endmodule : MOOREMACHINE





module MEALYMACHINE(
output logic [3:0] Dataout,
input  logic clk, reset,
input  logic Datain
);

enum logic [3:0] {
	S0 = 4'b0000, 
	S1 = 4'b1001, 
	S2 = 4'b1100, 
	S3 = 4'b1111
}current_state, next_state;

always_ff @(posedge clk) begin: seqblock
	if(reset) 
		current_state <= S0;
	else 
		current_state <= next_state;
end: seqblock


always_comb begin: outputstates
	unique case(current_state) //DEFAULT
		S0 :  begin Dataout = (~Datain) ? current_state : Dataout;end
		S1 :  begin Dataout = (Datain) ? current_state : Dataout;end
		S2 :  begin Dataout = (~Datain) ? current_state : Dataout;end
		S3 :  begin Dataout = (Datain) ? current_state : Dataout;end
		default : begin Dataout = 'x;end
	endcase
end: outputstates

//next_state Function Mealy Machine
//References state diagram given in problem statement two to determine movement 
always_comb begin: next_stateassign
	next_state = current_state;
	unique case(current_state)
		S0 : begin	if(Datain)next_state = S1; 
				else next_state = S0; 
		end
							
		S1 : begin	if(Datain) next_state = S1;
				else next_state = S2; 
		end
							
		S2 : begin	if(Datain)next_state = S3;
				else next_state = S2; 
		end
							
		S3 : begin 	if(Datain) next_state = S3;
				else next_state = S0; 
		end
		default : begin next_state = S0; 
		end
	endcase
end: next_stateassign

endmodule : MEALYMACHINE