module ECEAssignment1(Clock, Clear, DA0, DB0, S1, S2, S3, S4, S5, SW1, SW2, SW3);
  input Clock, Clear, S1, S2, S3, S4, S5;
  output  SW1, SW2, SW3, DA0, DB0;
  reg SW1, SW2, SW3, DA0, DB0;
  //DA0 = Train A movement
  //DB0 = Train B movement
  //S1-S5 = Sensor triggers
  //SW1-SW3 = Switches
  
  
  //USER PARAMETERS
  parameter ON  = 1'b1;
  parameter OFF = 1'b0;
  parameter INSIDE  = 1'b1;
  parameter OUTSIDE = 1'b0;
  //EO USER PARAMETERS
  
  
// define states using same names and state assignments as state diagram and table
// Using one-hot method, we have one bit per state
parameter
	ABOUTSIDE  = 5'b00001,
	BSTOP      = 5'b00010,
	ASTOP      = 5'b00100,
	BCOMMON    = 5'b01000,
	ACOMMON    = 5'b10000;

  
reg [5:0]State,NextState; 
  
//
// Update state or reset on every + clock edge, non-blocking assignment
//
always @(posedge Clock)
begin
  if (Clear)
	State <= ABOUTSIDE;
else
	State <= NextState;
end
  
  //
  // Outputs depend only upon state (Moore machine)
  //
  always @(State)
  begin
  case (State)
      ABOUTSIDE:	begin
          DA0 = ON;
          DB0 = ON;
          SW1 = OUTSIDE;
          SW2 = OUTSIDE;
          SW3 = OUTSIDE;
          end

      ACOMMON:	begin
          DA0 = ON;
          //DB0 = OFF or ON;
          SW1 = OUTSIDE;
          SW2 = OUTSIDE;
          SW3 = OUTSIDE;
          end

      BCOMMON:	begin
          //DA0 = ON or OFF;
          DB0 = OFF or ON;
          SW1 = INSIDE;
          SW2 = INSIDE;
          SW3 = OUTSIDE;
          end

      ASTOP:	begin
          DA0 = OFF;
          DB0 = ON;
          SW1 = INSIDE;
          SW2 = INSIDE;
          SW3 = OUTSIDE;
          end

      BSTOP:	begin
          DA0 = ON;
          DB0 = OFF;
          SW1 = OUTSIDE;
          SW2 = OUTSIDE;
          SW3 = OUTSIDE;
          end
  endcase
  end
  
  
  
  //STATE GENERATION LOGIC
  always @(State or S1 or S2 or S3 or S4)
  begin
  case(State)
    
    ABOUTSIDE:begin
      if(S1 && !S2)
        NextState = ACOMMON;
        
      else if(!S1 && S2)
        NextState = BCOMMON;
        
      else
        NextState = ABOUTSIDE;
        
      end
     
        
    ACOMMON:begin
      if(S4 && !S2)
        NextState = ABOUTSIDE;
        
      else if(S2 && !S4)
        NextState = BSTOP;
        
      else
        NextState = ACOMMON;
        
      end
        
        
    BCOMMON:begin
      if(S3 && !S1)
        NextState = ABOUTSIDE;
        
      else if(S1 && !S3)
        NextState = ASTOP;
        
      else
        NextState = BCOMMON;
        
      end
     
        
    ASTOP:begin
      if(S3)
        NextState = ACOMMON;
        
      else
        NextState = ASTOP;
        
      end
        
        
    BSTOP:begin
      if(S4)
        NextState = BCOMMON;
    	
      else
        NextState = BSTOP;
        
      end
  endcase 
end
endmodule