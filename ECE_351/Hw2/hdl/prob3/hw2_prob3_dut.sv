//////////////////////////////////////////////////////////////////////////////
// hw2_prob3_dut.sv
//
// Author:	Alex Beaulier (Beaulier@pdx.edu)
// Date:	9-5-2020 (modified 9-5-2021)
//
// Contains instantiation of top level model ALU and includes register file. 
// Instantiates two ALUs and regfile.
/////////////////////////////////////////////////////////////////////////////

module hw2_prob3_dut
import ALU_REGFILE_defs::*;
(
// register file interface
input logic [REGFILE_ADDR_WIDTH-1:0] 	Read_Addr_1, 	// read port addresses
					Read_Addr_2,
input logic [REGFILE_ADDR_WIDTH-1:0] 	Write_Addr, 	// write port address
input logic 				Write_enable, 				// write enable (1 to
														// write)
input logic [REGFILE_WIDTH-1:0] 	Write_data, 		// data to write into the
														// register file

// ALU interface. Data to the ALU comes from the register file
input logic 				Carry_In, 				// Carry In
input aluop_t 				Opcode, 				// operation to perform
output logic [ALU_OUTPUT_WIDTH-1:0] 	ALU_Out, 	// ALU result

// system-wide signals
input logic 				Clock					// system clock
);
//End of Ports

timeunit 1ns/1ns;

//A_In and B_In in diagram. Data is size of ALU
logic [7:0] A_In, B_In;
logic [15:0] Data_Out_1, Data_Out_2;

//Create Regfile
register_file REG1(
		.Data_Out_1(Data_Out_1), 		// dual read port outputs from the register file
		.Data_Out_2(Data_Out_2),		// dual read port outputs from the register file
		.Data_In(Write_data),			// single write port input to the register file from ALU 
		.Read_Addr_1(Read_Addr_1), 		// read port addresses
		.Read_Addr_2(Read_Addr_2),		// read port addresses
		.Write_Addr(Write_Addr),		// address to write Data_In to
		.Write_enable(Write_enable),	// write enable (1 to write)
		.Clock(Clock)					//System Clock
);

//Diagram to ALU uses 7:0 for ALU
assign A_In = Data_Out_1[7:0];
assign B_In = Data_Out_2[7:0];

//Create ALU
hw2_prob3_alu ALU_INST(
	.A_In(A_In),
	.B_In(B_In),
	.Carry_In(Carry_In),
	.Opcode(Opcode),
	.ALU_Out(ALU_Out[ALU_OUTPUT_WIDTH-1:0])
);


endmodule: hw2_prob3_dut