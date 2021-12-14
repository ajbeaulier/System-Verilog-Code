module Problem2(
output logic out,	   //output, prints mismatch for 0, or match for 1
input logic Datain,  //Input bit
input logic clk, reset //Timer
);

//STATES
enum logic [3:0] {S01,S02,S03,S04,S05,S06,S17,S08}current_state, next_state;



always_ff @(posedge clk) begin: seqblock
	if(reset) 
		current_state <= S01;
	else 
		current_state <= next_state;
end: seqblock

//CHECKS STUDENT ID 01 BCD -> 0100_0000
//Only transmits if bad bit for mismatch print in TB
//If sequence is correct, continues to next state until final sequence is made. 
//Doesn't use overlap. Single bit check each time. 
//next_state Function Mealy Machine
//References state diagram for movement
always_comb begin: next_stateassign
	next_state = current_state;
	unique case(current_state)
		S01 : begin	
			if(Datain == 1'b0)begin
				next_state = S02; 
				$display("Path01");
				end
			else begin
				next_state = S01; 
				out = 0;
				$display("Mismatch01");
			end
		end			
		S02 : begin	
			if(Datain == 1'b0)begin
				next_state = S03; 
				$display("Path02");
				end
			else begin
				next_state = S01; 
				out = 0;
				$display("Mismatch02");
			end
		end		
		S03 : begin	
			if(Datain == 1'b0)begin
				next_state = S04; 
				$display("Path03");
				end
			else begin
				next_state = S01; 
				out = 0;
				$display("Mismatch03");
			end
		end
		S04 : begin	
			if(Datain == 1'b0)begin 
				next_state = S05; 
				$display("Path04");
				end
			else begin
				next_state = S01; 
				out = 0;
				$display("Mismatch04");
			end
		end
		S05 : begin	
			if(Datain == 1'b0)begin
				$display("Path05");
				next_state = S06; 
				end
			else begin
				next_state = S01; 
				out = 0;
				$display("Mismatch05");
			end
		end
		S06 : begin	
			if(Datain == 1'b0)begin 
				next_state = S17; 
				$display("Path06");
				end
			else begin
				next_state = S01; 
				out = 0;
				$display("Mismatch06");
			end
		end
		S17 : begin	
			if(Datain == 1'b1) begin
			
				out = 1;
				next_state = S08; 
				end
			else begin
				next_state = S01; 
				out = 0;
				$display("Mismatch07");
			end
		end
		S08 : begin	
			if(Datain == 1'b0) begin
				$display("Match");
				next_state = S01;
				$display("Path08");
				end
			else begin
				next_state = S01; 
				out = 0;
				$display("Mismatch08");
			end
		end
		default : begin next_state = S01; 
	end
	endcase
end: next_stateassign

endmodule