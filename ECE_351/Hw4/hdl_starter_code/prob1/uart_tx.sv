//////////////////////////////////////////////////////////////
// uart_tx.sv - UART Transmitter (starter code)
//
// Author:	<Alex Beaulier> (<Beaulier@pdx.edu>)
// Date:	<6/1/2021>
//
// Description:
// ------------
// Serializes a data packet, adds the start and stop bits and transmits the
// data packed on bit at a time on the tx signal.
//
////////////////////////////////////////////////////////////////
module uart_tx
(
	input  logic clk, reset,            // system clock and reset (reset asserted high)
	input  logic tx_start, s_tick,      // tx_start tells the transmitter to transmit a serial data packet
	input  logic [7:0] din,             // parallel data in
    output logic tx_done_tick,          // packet transmission done pulse

	output logic tx,                    // serial transmit line
    //debug
    output logic xmit_tick              // debug signal for when bit is transmitt3ed
);


// ADD YOUR CODE HERE

// uart Transmitter FSM declarations
typedef enum logic [3:0] {IDLE, START, DB_[1:8], STOP, DONE} FSM_STATE_t;
FSM_STATE_t state_reg, state_next;


//@@@@@@@@@@@@@@@@@@	Sample Bit Counter
logic [3:0] sbc_counter;            // sample tick counter for each of the tx bits
logic sbc_clr, sbc_inc;             // sample tick counter control signals
logic sbc_tick08, sbc_tick16;       // sample tick status signals

always_ff @(posedge clk) begin: sbc_logic
    if (reset)
        sbc_counter <= '0;
    else if (sbc_clr)
        sbc_counter <= '0;
    else if (sbc_inc)
        sbc_counter <= sbc_counter + 1;
    else
        sbc_counter <= sbc_counter;
end: sbc_logic

assign sbc_tick08 = sbc_counter == 4'b0111;
assign sbc_tick16 = sbc_counter == 4'b1111;
//@@@@@@@@@@@@@@@@@@@	EO Sample Bit Counter

// uart TX Data register
logic [7:0] tx_data_reg;                       		// uart tx data register
logic tx_data_reg_load, tx_data_reg_shift;       	// uart tx data register control
logic tx_next;

//@@@@@@@@@@@@@@@@@@@@	UART Transfer Data Register
always_ff @(posedge clk) begin: uart_transmitter_data_register
	if (reset)
		tx_data_reg <= '0;

	else if (tx_data_reg_load)
		tx_data_reg <= din;

	else if (tx_data_reg_shift)
		tx_data_reg <= {1'b0, tx_data_reg[7:1]};

	else
		tx_data_reg <= tx_data_reg;

end: uart_transmitter_data_register
//@@@@@@@@@@@@@@@@@@@@	EO UART Transfer Data Register




//@@@@@@@@@@@@@@@@@@@@	UART Transmitter FSM Sequential
always_ff @(posedge clk) begin: uart_transmitter_FSM_SeqBlock
	if (reset)
		state_reg <= IDLE;
	else
		state_reg <= state_next;
end: uart_transmitter_FSM_SeqBlock
//@@@@@@@@@@@@@@@@@@@@	EO UART Transmitter FSM




//@@@@@@@@@@@@@@@@@@@@	UART Tx Combinational
always_comb begin: uart_transmitter_FSM_CombBlock
	{sbc_clr, sbc_inc} = 2'b00;
	{tx_data_reg_load, tx_data_reg_shift} = 2'b00;
	tx_done_tick = 1'b0;
	xmit_tick = 1'b0;

	unique case (state_reg)

		//IDLE
		IDLE: begin: wait_for_start_signal

			if (tx_start) begin
				//TX packet transmission
				state_next = START;
				tx_next = 1'b0;
			end
			else begin
				tx_next = 1'b1;
				state_next = IDLE;
			end
		end: wait_for_start_signal


		//START
		START: begin: transmit_start_bit			
			if (s_tick)
				if (sbc_tick16) begin
                    sbc_clr = 1'b1;
                    tx_data_reg_load = 1'b1;
                    state_next = DB_1;
                    xmit_tick = 1'b1;
                end else begin
					tx_next = 1'b0;
                    sbc_inc = 1'b1;
                    state_next = START;
					end
        	end

		//Send Data
		DB_1:  begin
			if (s_tick)
				
                if (sbc_tick16) begin
                    sbc_clr = 1'b1;
                    tx_data_reg_shift = 1'b1;
                    state_next = DB_2;
                    xmit_tick = 1'b1;
                end else begin
                    sbc_inc = 1'b1;
                    state_next = DB_1;
					tx_next = tx_data_reg[0];
					end
        	end

        DB_2:  begin
			if (s_tick)
                if (sbc_tick16) begin
                    sbc_clr = 1'b1;
                    tx_data_reg_shift = 1'b1;
                    state_next = DB_3;
                    xmit_tick = 1'b1;
                end else begin
					tx_next = tx_data_reg[0];
                    sbc_inc = 1'b1;
                    state_next = DB_2;
					end
        end

        DB_3:  begin
			if (s_tick)
                if (sbc_tick16) begin
                    sbc_clr = 1'b1;
                    tx_data_reg_shift = 1'b1;
                    state_next = DB_4;
                    xmit_tick = 1'b1;
                end else begin
					tx_next = tx_data_reg[0];
                    sbc_inc = 1'b1;
                    state_next = DB_3;
					end
        end

        DB_4:  begin
			if (s_tick)
			
                if (sbc_tick16) begin
                    sbc_clr = 1'b1;
                    tx_data_reg_shift = 1'b1;
                    state_next = DB_5;
                    xmit_tick = 1'b1;
                end else begin
					tx_next = tx_data_reg[0];
                    sbc_inc = 1'b1;
                    state_next = DB_4;
					end
        end

        DB_5:  begin
			if (s_tick)
                if (sbc_tick16) begin
                    sbc_clr = 1'b1;
                    tx_data_reg_shift = 1'b1;
                    state_next = DB_6;
                    xmit_tick = 1'b1;
                end else begin
					tx_next = tx_data_reg[0];
                    sbc_inc = 1'b1;
                    state_next = DB_5;
					end
        end

        DB_6:  begin
			if (s_tick)
                if (sbc_tick16) begin
                    sbc_clr = 1'b1;
                    tx_data_reg_shift = 1'b1;
                    state_next = DB_7;
                    xmit_tick = 1'b1;
                end else begin
					tx_next = tx_data_reg[0];
                    sbc_inc = 1'b1;
                    state_next = DB_6;
					end
        end

        DB_7:  begin
			if (s_tick)
                if (sbc_tick16) begin
                    sbc_clr = 1'b1;
                    tx_data_reg_shift = 1'b1;
                    state_next = DB_8;
                    xmit_tick = 1'b1;
                end else begin
					tx_next = tx_data_reg[0];
                    sbc_inc = 1'b1;
                    state_next = DB_7;
					end
        end

        DB_8:  begin
			if (s_tick)
                if (sbc_tick16) begin
                    sbc_clr = 1'b1;
                    tx_data_reg_shift = 1'b1;
                    state_next = STOP;
                    xmit_tick = 1'b1;
                end else begin
					tx_next = tx_data_reg[0];
                    sbc_inc = 1'b1;
                    state_next = DB_8;
					end
        end

		//Send Stop //Need 1, 1.5 or 2 stop bits through tx???
		STOP: begin
			tx_next = 1'b1; //STOP BIT to drive back to high
			if (s_tick)
                if (sbc_tick16) begin
                    sbc_clr = 1'b1;
                    state_next = DONE;
                    xmit_tick = 1'b1;
                end else begin
                    sbc_inc = 1'b1;
                    state_next = STOP;
					end
		end


		//Send Done
		DONE: begin
			tx_done_tick = 1'b1;
			state_next = IDLE;
			tx_next = 1'b1;
		end

		default : ;

	endcase
end: uart_transmitter_FSM_CombBlock
//@@@@@@@@@@@@@@@@@@@@	EO UART Tx Combinational



//@@@@@@@@@@@@@@@@@@@@	D Flip Flop
always_ff @(posedge clk) begin: DFlipFlop
	tx <= tx_next;
end: DFlipFlop
//@@@@@@@@@@@@@@@@@@@@	EO D FLIP FLOP


endmodule: uart_tx