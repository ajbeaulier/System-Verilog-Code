//////////////////////////////////////////////////////////////////////////////
// hw2_prob3_dut.sv
//
// Author:	Alex Beaulier (Beaulier@pdx.edu)
// Date:	9-5-2020 (modified 9-5-2021)
//
// Contains ALU module math. Gives output from ALU.
// 
/////////////////////////////////////////////////////////////////////////////

module hw2_prob3_alu
import ALU_REGFILE_defs::*;
(
	input logic [ALU_INPUT_WIDTH-1:0] 	A_In, B_In, 	// A and B operands
	input logic 				Carry_In, 				// Carry In
	input aluop_t 				Opcode, 				// operation to perform
	output logic [ALU_OUTPUT_WIDTH-1:0] 	ALU_Out 	// ALU result(extended by 1 bit
														// to preserve Carry_Out from
														// Sum/Diff)
);

timeunit 1ns/1ns;

always_comb begin: ALUMath
	case(Opcode)
		ADD_OP: ALU_Out = A_In + B_In + Carry_In     ;
		SUB_OP: ALU_Out = A_In + ~B_In + Carry_In    ;
		SUBA_OP: ALU_Out = ~A_In + B_In + ~Carry_In  ;
		ORAB_OP: ALU_Out = {1'b0, A_In | B_In}       ;			//Don't know what this means in function description
		ANDAB_OP: ALU_Out = {1'b0, A_In & B_In}      ;	
		NOTAB_OP: ALU_Out = {1'b0, ~A_In & B_In}     ;	
		EXOR_OP: ALU_Out = {1'b0, A_In ^ B_In}       ;		
		EXNOR_OP: ALU_Out = {1'b0, A_In ~^ B_In}     ;	
	endcase
end: ALUMath
endmodule: hw2_prob3_alu