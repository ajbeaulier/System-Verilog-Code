/////////////////////////////////////////////////////////////////////////////////////////
// Authors - Alex Beaulier, Amrutha Anil
// instruction_cache.v - Simulates a L1-Instruction Cache using MESI protocol
//
// Reference: https://github.com/RahulMarathe94
/////////////////////////////////////////////////////////////////////////////////////////

module instruction_cache(
  // Outputs from the cache
  output logic [31:0] hit     	    = 32'b0,  		// to statistics module
  output logic [31:0] miss    	    = 32'b0,  		// to statistics module
  output logic [31:0] reads   	    = 32'b0,    	// to statistics module
  output logic [25:0] addr_to_L2    = 26'bZ,  		// to next-level shared L2 cache 
  													// index+tag bit backup
  output logic [1:0]  command_to_L2 = 2'b00,    	// to next-level shared L2 cache
  
  // Inputs to the cache
  input logic [3:0]  n,           					// from trace file
  input logic [31:0] address_in,  					// from trace file
  input logic Clock,
  input logic mode									// from command line 
);
  
  `include "lru_next_instruction.sv"
  localparam Sets 		= 2**14;
  localparam Ways 		= 4;
  localparam Index_Bits = 14;
  localparam Tag_Bits 	= 12;

  localparam TRUE       = 1'b1;
  localparam FALSE      = 1'b0;
  
  // Valid MESI states for instruction cache
  // Modified is not required as instruction does not write
  localparam EXCLUSIVE	= 2'd2;
  localparam SHARED		= 2'd1;
  localparam INVALID 	= 2'd0;
  
  // Valid commands for instruction cache
  localparam Reset        		 = 4'd8;
  localparam Instruction_Fetch   = 4'd2;
  localparam Print       		 = 4'd9;
  
 // Instruction cache sends following commands to next-level cache
  localparam Read_In     = 2'b01;
  localparam NOP         = 2'b00;
  
  // 12 Tagbits per way in each set
  logic [Tag_Bits-1:0] Tag [Sets-1:0][Ways-1:0];
    
  // 2 MESI bits per way in each set (4 ways)
  logic [1:0] MESI [Sets-1:0] [Ways-1:0]; 
  
  // 2 bits per set LRU bit for instruction cache
  logic [1:0]   LRU [Sets-1:0][Ways-1:0];
  // 2-bit Variables to get output from lru_next task
  logic [1:0] lrubits0, lrubits1, lrubits2, lrubits3;
  // Used to set the values of LRU bits during Reset 
  logic [1:0] count = 2'd3;

  // Loop counters
  integer index_counter, way_counter;
   
  // To know the task is complete
  logic Finish = 1'b0;
  
  // Bit-selecting tag and index bits from input address 
  wire [11:0] current_tag   = address_in[31:20];
  wire [13:0] current_index = address_in[19:6];

  always @(posedge Clock) begin  
	addr_to_L2 = 26'bZ;  
	command_to_L2 = NOP;    
	Finish    = FALSE;  
   
		case(n)
		  // Set MESI state to Invalid
		  // Set LRU to 7 down to 0
			Reset: begin
				hit    = 32'b0;
				miss   = 32'b0;
				reads  = 32'b0;
            	for (index_counter = 0; index_counter < Sets; index_counter++) begin
					for (way_counter = 0; way_counter < Ways; way_counter++)  begin
						Tag    [index_counter][way_counter]  = '0;
						MESI  [index_counter][way_counter]   = INVALID;
                      	LRU [index_counter][way_counter] = count;
                        count = count - 2'd1;
					end
				end
			end
      
			Instruction_Fetch:
			begin
				// increment the number of total reads
				reads = reads + 1'b1; 
				// search the ways within the set, if there is a hit update the LRU bits of  
				// and increment the hit counter
				for (way_counter = 0; way_counter < Ways; way_counter = way_counter + 1'b1) begin
					if (Finish == FALSE) begin
						if (Tag[current_index][way_counter] == current_tag && 
							(MESI[current_index][way_counter]== SHARED ||
							MESI[current_index][way_counter]== EXCLUSIVE)) begin
							
							lru_next_instruction(lrubits0, lrubits1, lrubits2, lrubits3,
							LRU[current_index][0],LRU[current_index][1], LRU[current_index][2],LRU[current_index][3],
							way_counter[1:0]);

							LRU[current_index][0] = lrubits0;
                            LRU[current_index][1] = lrubits1; 
                            LRU[current_index][2] = lrubits2;
                            LRU[current_index][3] = lrubits3;
								
							hit             	= hit + 1'b1;

							if(MESI[current_index][way_counter] == EXCLUSIVE) begin
                                MESI[current_index][way_counter] = SHARED;
                            end else begin
                                MESI[current_index][way_counter] =  MESI[current_index][way_counter];
                            end

							Finish              = TRUE;
						end
					end 
			end
        
			// If there was no hit, increment the miss counter
			if (Finish == FALSE)
				miss = miss + 1'b1;
        
			// If  there was no hit, check to see if there is an invalid way in the set
			for (way_counter = 0; way_counter < Ways; way_counter++) begin
				if (Finish == FALSE)
					if (MESI[current_index][way_counter]== INVALID) begin
						addr_to_L2         = address_in[31:6]; 
						command_to_L2      = Read_In;    
						if(mode==1)
							$display("Read from L2 %8h",address_in);

						lru_next_instruction(lrubits0, lrubits1, lrubits2, lrubits3,
							LRU[current_index][0],LRU[current_index][1], LRU[current_index][2],LRU[current_index][3],
							way_counter[1:0]);

						LRU[current_index][0] = lrubits0;
                        LRU[current_index][1] = lrubits1; 
                        LRU[current_index][2] = lrubits2;
                        LRU[current_index][3] = lrubits3;
						
						Tag[current_index][way_counter] 	= current_tag;
						MESI[current_index][way_counter]    = EXCLUSIVE;
						Finish                           	= TRUE;
					end
			end
        
			// If there was no invalid way, evict the LRU way
			// No need for write back the line
			if (Finish == FALSE)
			begin
				for (way_counter = 0; way_counter < Ways; way_counter++)begin
					if(Finish == FALSE) begin
						addr_to_L2                   = address_in[31:6]; 
						command_to_L2                = Read_In; 
						if(mode==1)
							$display("Read from L2 %8h",address_in);

						if (LRU[current_index][way_counter]==2'd3) begin
							lru_next_instruction(lrubits0, lrubits1, lrubits2, lrubits3,
										LRU[current_index][0],LRU[current_index][1], LRU[current_index][2],LRU[current_index][3],
										way_counter[1:0]);

							LRU[current_index][0] = lrubits0;
                			LRU[current_index][1] = lrubits1; 
                			LRU[current_index][2] = lrubits2;
                			LRU[current_index][3] = lrubits3;

							Tag[current_index][way_counter]      	= current_tag;  
							MESI[current_index][way_counter]	 	= SHARED;
							Finish                                  = TRUE;
						end
					end
				end
			end
		end
    
		Print:
		begin   
			
			$display("\n==========INSTRUCTION CACHE CONTENTS========");
			for (index_counter = 0; index_counter < Sets; index_counter++) begin
				if (MESI[index_counter][0]!=INVALID)  begin
					$write(" SET:%4h\n LRU:%d WAY:1 ",index_counter[Index_Bits-1:0], LRU[index_counter][0]);
					if(MESI[index_counter][0]==1)
						$write("MESI: S ");
					else if(MESI[index_counter][0]==2)
						$write("MESI: E ");
                    $write(" TAG:%3h \n", MESI[index_counter][0]!=INVALID ? Tag[index_counter][0] : "");
					
				end else if (MESI[index_counter][0] == INVALID && Tag[index_counter][0] != '0)  begin
                    $write(" LRU:%d WAY:1 ", LRU[index_counter][0]);
                    $write("MESI: I ");
                    $write(" TAG:%3h \n", Tag[index_counter][0]);
				end
					   
				if(MESI[index_counter][1]!=INVALID) begin
                    $write(" LRU:%d WAY:2 ", LRU[index_counter][1]);
					if(MESI[index_counter][1]==1)
						$write("MESI: S ");
					else if(MESI[index_counter][1]==2)
						$write("MESI: E ");
                    $write(" TAG:%3h \n", MESI[index_counter][1]!=INVALID ? Tag[index_counter][1] : "");
					
				end else if (MESI[index_counter][1] == INVALID && Tag[index_counter][1] != '0)  begin
                    $write(" LRU:%d WAY:2 ", LRU[index_counter][1]);
                    $write("MESI: I ");
                    $write(" TAG:%3h \n", Tag[index_counter][1]);
				end

				if(MESI[index_counter][2]!=INVALID) begin
                    $write(" LRU:%d WAY:3 ", LRU[index_counter][2]);
				    if(MESI[index_counter][2]==1)
						$write("MESI: S ");
					else if(MESI[index_counter][2]==2)
						$write("MESI: E ");
					else if(MESI[index_counter][2]==3) 
						$write("MESI: M ");
                    $write(" TAG:%3h \n", MESI[index_counter][2]!=INVALID ? Tag[index_counter][2] :"");
					
				end else if (MESI[index_counter][2] == INVALID && Tag[index_counter][2] != '0)  begin
                    $write(" LRU:%d WAY:3 ", LRU[index_counter][2]);
                    $write("MESI: I ");
                    $write(" TAG:%3h \n", Tag[index_counter][2]);
				end
						
				if(MESI[index_counter][3]!=INVALID) begin
                    $write(" LRU:%d WAY:4 ", LRU[index_counter][3]);
					if(MESI[index_counter][3]==1)
						$write("MESI: S ");
					else if(MESI[index_counter][3]==2)
						$write("MESI: E ");
					else if(MESI[index_counter][3]==3)
						$write("MESI: M ");

                    $write(" TAG:%3h \n", MESI[index_counter][3]!=INVALID ? Tag[index_counter][3] : "");
                end else if (MESI[index_counter][3] == INVALID && Tag[index_counter][3] != '0)  begin
                       $write(" LRU:%d WAY:4 ", LRU[index_counter][3]);
                       $write("MESI: I ");
                       $write(" TAG:%3h \n", Tag[index_counter][3]);
				end	
			end
			$display("\n======END OF INSTRUCTION CACHE CONTENTS========\n");
		end
      
		default:;
	endcase
  end    
  
endmodule
