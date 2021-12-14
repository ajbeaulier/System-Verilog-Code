module test();
reg Clock, Clear, DA0, DB0, S1, S2, S3, S4, S5;
wire SW1, SW2, SW3;


  
parameter TRUE   = 1'b1;
parameter FALSE  = 1'b0;
parameter CLOCK_CYCLE  = 20;
parameter CLOCK_WIDTH  = CLOCK_CYCLE/2;
parameter IDLE_CLOCKS  = 2;



ECEAssignment1 ControllerInputs(.Clock(Clock), .Clear(Clear), .DA0(DA0), .DB0(DB0), .S1(S1), .S2(S2), .S3(S3), .S4(S4), .S5(S5), .SW1(SW1), .SW2(SW2), .SW3(SW3));

initial begin 
  $dumpfile("dumps.vcd");
  $dumpvars;
end  

  
//
// set up monitor
//

initial
begin
  $display("                Time Clear DA0  DB0  S1  S2  S3  S4  S5  SW1 SW2 SW3\n");
  $monitor($time, "   %b    %b    %b    %b   %b   %b   %b   %b   %b   %b   %b",Clear,DA0,DB0,S1,S2,S3,S4,S5,SW1,SW2,SW3);
end



//
// Create free running clock
//
initial
begin
Clock = FALSE;
forever #CLOCK_WIDTH Clock = ~Clock;
end


//
// Generate Clear signal for two cycles
//
initial
begin
Clear = TRUE;
repeat (IDLE_CLOCKS) @(negedge Clock);
Clear = FALSE;
end




//
// Generate stimulus after waiting for reset
//

initial
begin
  S1=1'b0; S2=1'b0; S3=1'b0; S4=1'b0; S5=1'b0;
  // simple sensor tests from ABCOMMON
  
  //Initiate Acommon
  repeat (6) @(negedge Clock); {S1, S2, S3, S4, S5} = 5'b10000;
  
  //Initiate BStop
  repeat (6) @(negedge Clock); {S1, S2, S3, S4, S5} = 5'b01000;
  
  //Initiate BCommon
  repeat (6) @(negedge Clock); {S1, S2, S3, S4, S5} = 5'b01010;
  
  //Initiate ABOUTSIDE
  repeat (6) @(negedge Clock); {S1, S2, S3, S4, S5} = 5'b00100;
  
  //Initiate BCommon
  repeat (6) @(negedge Clock); {S1, S2, S3, S4, S5} = 5'b01000;
  
  //Initiate AStop
  repeat (6) @(negedge Clock); {S1, S2, S3, S4, S5} = 5'b11000;
  
  //Initiate ACommon
  repeat (6) @(negedge Clock); {S1, S2, S3, S4, S5} = 5'b10000;
  
  //Initiate ABOUTSIDE
  repeat (6) @(negedge Clock); {S1, S2, S3, S4, S5} = 5'b00010;
  
$stop;
end
endmodule