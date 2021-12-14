 /////////////////////////////////////////////////////////////////////////////////////////
// Authors - Alex Beaulier, Amrutha Anil
// File: testbench.v
// Description: This is a testbench for the cache module.
//				To run the simulator add
//				 +mode=0 or 1 +Trace=FileName.Ext to the compile options
// Reference: https://github.com/RahulMarathe94
/////////////////////////////////////////////////////////////////////////////////////////

module testbench();
 
  localparam clock_period  = 20;
  localparam half_period  = clock_period/2;
  
  localparam TRUE   = 1'b1;
  localparam FALSE  = 1'b0;

  logic Clock;
  integer file;     
  logic  Finish;
  
  logic  [3:0]        command;
  logic  [31:0]       address;
  logic  [9000:0]     filename;
  logic  [25:0]       addr_to_L2;
  logic  [1:0]        command_to_L2;
  logic        		  mode;


  top_level_integration project(
	  .Clock(Clock),
	  .clear(clear),
	  .n(command),
	  .address_in(address),
	  .Finish(Finish),
	  .addr_to_L2(addr_to_L2),
	  .command_to_L2(command_to_L2),
	  .mode(mode)); 
 

  initial begin
	 Clock=FALSE;
	 Finish=FALSE;
	 
	 if ($value$plusargs("Trace=%s", filename) == FALSE)   begin        
	   $display("Error: No tracefile provided");        
	   $stop;
	 end
	 
	if ($value$plusargs("mode=%d", mode) == TRUE) begin
	   $display("Mode is %d", mode);
	end

    file = $fopen(filename, "r");
	
	#half_period Clock = FALSE; 
	command = 4'd8;  
	#half_period Clock = TRUE; 

	// read the trace file
	while (!$feof(file))  begin
		#half_period Clock = FALSE;
		$fscanf (file, "%d", command);
		$fscanf (file, "%h", address);
		$display();
		#half_period Clock= TRUE;
	end
	$fclose(file);
	Finish = TRUE;
  end 
endmodule
