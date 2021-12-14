//////////////////////////////////////////////////////////////////////////////
// alu_regfile_defs.sv - Global definitions for ALU/Register File problem
//
// Author:	Roy Kravitz (roy.kravitz@pdx.edu)
// Date:	28-Apr-2020 (modified 29-Apr-2021)
//
// Contains the global typedefs, const, enum, structs, etc. for the ALU/Register
// Files problem
/////////////////////////////////////////////////////////////////////////////
package ALU_REGFILE_defs;

timeunit 1ns/1ns;

// define the register file parameters
parameter REGFILE_SIZE = 32;
parameter REGFILE_WIDTH = 16;
parameter REGFILE_ADDR_WIDTH = 5;

// define the ALU parameters
parameter ALU_INPUT_WIDTH = 8;
parameter ALU_OUTPUT_WIDTH = 9;

// define the ALU opcodes
typedef enum logic[2:0] {
	ADD_OP = 0,
	SUB_OP = 1,
	SUBA_OP = 2,
	ORAB_OP = 3,
	ANDAB_OP = 4,
	NOTAB_OP = 5,
	EXOR_OP = 6,
	EXNOR_OP = 7
} aluop_t;

endpackage: ALU_REGFILE_defs