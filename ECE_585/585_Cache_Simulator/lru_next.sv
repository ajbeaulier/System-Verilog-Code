/////////////////////////////////////////////////////////////////////////////////////////
// Authors - Alex Beaulier, Amrutha Anil
// lru_next.v - A task has been defined to compute the LRU bits of L1 Data Cache
//
// Reference: https://github.com/RahulMarathe94
/////////////////////////////////////////////////////////////////////////////////////////

task lru_next(output logic  [2:0] lru_bits0, lru_bits1, lru_bits2, lru_bits3, lru_bits4, lru_bits5, lru_bits6, lru_bits7,
 			    input logic [2:0] lrubits0, lrubits1, lrubits2, lrubits3, lrubits4, lrubits5, lrubits6, lrubits7,
				input logic [2:0] way_cnt);
	case(way_cnt)
		3'd0: begin
			if(lrubits1<lrubits0)begin
				lru_bits1=lrubits1+1'b1;
				
				end
			else begin
				lru_bits1=lrubits1;
				
				end
			if(lrubits2<lrubits0) begin
				lru_bits2=lrubits2+1'b1;
				
				end
			else begin
				lru_bits2=lrubits2;
				
				end
			if(lrubits3<lrubits0) begin
				lru_bits3=lrubits3+1'b1;
				
				end
			else begin
				lru_bits3=lrubits3;
				
				end
			if(lrubits4<lrubits0) begin
				lru_bits4=lrubits4+1'b1;
				
				end
			else begin
				lru_bits4=lrubits4;
				
				end
			if(lrubits5<lrubits0) begin
				lru_bits5=lrubits5+1'b1;
				
				end
			else begin
				lru_bits5=lrubits5;
				
				end
			if(lrubits6<lrubits0) begin
				lru_bits6=lrubits6+1'b1;
				
				end
			else begin
				lru_bits6=lrubits6;
				
				end
			if(lrubits7<lrubits0) begin
				lru_bits7=lrubits7+1'b1;
				
				end
			else begin
				lru_bits7=lrubits7;
				
				end
		  lru_bits0='0;
        end

		3'd1: begin
			if(lrubits0<lrubits1)begin
				lru_bits0=lrubits0+1'b1;
				
				end
			else begin
				lru_bits0=lrubits0;
				
				end
			if(lrubits2<lrubits1) begin
				lru_bits2=lrubits2+1'b1;
				
				end
			else begin
				lru_bits2=lrubits2;
				
				end
			if(lrubits3<lrubits1) begin
				lru_bits3=lrubits3+1'b1;
				
				end
			else begin
				lru_bits3=lrubits3;
				
			end
			if(lrubits4<lrubits1) begin
				lru_bits4=lrubits4+1'b1;
				
				end
			else begin
				lru_bits4=lrubits4;
				
			end
			if(lrubits5<lrubits1) begin
				lru_bits5=lrubits5+1'b1;
				
				end
			else begin
				lru_bits5=lrubits5;
				
			end
			if(lrubits6<lrubits1) begin
				lru_bits6=lrubits6+1'b1;
				
				end
			else begin
				lru_bits6=lrubits6;
				
			end
			if(lrubits7<lrubits1) begin
				lru_bits7=lrubits7+1'b1;
				
				end
			else begin
				lru_bits7=lrubits7;
				
			end
			lru_bits1='0;
        end

		3'd2: begin
			if(lrubits0<lrubits2)begin
				lru_bits0=lrubits0+1'b1;
				
				end
			else begin
				lru_bits0=lrubits0;
				
				end
			if(lrubits1<lrubits2) begin
				lru_bits1=lrubits1+1'b1;
				
				end
			else begin
				lru_bits1=lrubits1;
				
				end
			if(lrubits3<lrubits2) begin
				lru_bits3=lrubits3+1'b1;
				
				end
			else begin
				lru_bits3=lrubits3;
				
			end
			if(lrubits4<lrubits2) begin
				lru_bits4=lrubits4+1'b1;
				
				end
			else begin
				lru_bits4=lrubits4;
				
			end
			if(lrubits5<lrubits2) begin
				lru_bits5=lrubits5+1'b1;
				
				end
			else begin
				lru_bits5=lrubits5;
				
			end
			if(lrubits6<lrubits2) begin
				lru_bits6=lrubits6+1'b1;
				
				end
			else begin
				lru_bits6=lrubits6;
				
			end
			if(lrubits7<lrubits2) begin
				lru_bits7=lrubits7+1'b1;
				
				end
			else begin
				lru_bits7=lrubits7;
				
			end
			lru_bits2='0;
        end

		3'd3: begin
			if(lrubits0<lrubits3)begin
				lru_bits0=lrubits0+1'b1;
				
				end
			else begin
				lru_bits0=lrubits0;
				
				end
				
			if(lrubits1<lrubits3) begin
				lru_bits1=lrubits1+1'b1;
				
				end
			else begin
				lru_bits1=lrubits1;
				
			end
			if(lrubits2<lrubits3) begin
				lru_bits2=lrubits2+1'b1;
				
				end
			else begin
				lru_bits2=lrubits2;
				
				end

			if(lrubits4<lrubits3) begin
				lru_bits4=lrubits4+1'b1;
				
				end
			else begin
				lru_bits4=lrubits4;
				
				end
			if(lrubits5<lrubits3) begin
				lru_bits5=lrubits5+1'b1;
				
				end
			else begin
				lru_bits5=lrubits5;
				
				end
			if(lrubits6<lrubits3) begin
				lru_bits6=lrubits6+1'b1;
				
				end
			else begin
				lru_bits6=lrubits6;
				
				end
			if(lrubits7<lrubits3) begin
				lru_bits7=lrubits7+1'b1;
				
				end
			else begin
				lru_bits7=lrubits7;
				
				end
			lru_bits3='0;
        end

		3'd4: begin
			if(lrubits0<lrubits4)begin
				lru_bits0=lrubits0+1'b1;
				
			end
			else begin
				lru_bits0=lrubits0;
				
			end
				
			if(lrubits1<lrubits4) begin
				lru_bits1=lrubits1+1'b1;
				
			end
			else begin
				lru_bits1=lrubits1;
				
			end
			if(lrubits2<lrubits4) begin
				lru_bits2=lrubits2+1'b1;
				
			end
			else begin
				lru_bits2=lrubits2;
				
			end
			if(lrubits3<lrubits4) begin
				lru_bits3=lrubits3+1'b1;
				
			end
			else begin
				lru_bits3=lrubits3;
				
			end
			if(lrubits5<lrubits4) begin
				lru_bits5=lrubits5+1'b1;
				
			end
			else begin
				lru_bits5=lrubits5;
				
			end
			if(lrubits6<lrubits4) begin
				lru_bits6=lrubits6+1'b1;
				
			end
			else begin
				lru_bits6=lrubits6;
				
			end
			if(lrubits7<lrubits4) begin
				lru_bits7=lrubits7+1'b1;
				
			end
			else begin
				lru_bits7=lrubits7;
				
			end
			lru_bits4='0;
		end

		3'd5: begin
			if(lrubits0<lrubits5)begin
				lru_bits0=lrubits0+1'b1;
				
			end
			else begin
				lru_bits0=lrubits0;
				
			end
				
			if(lrubits1<lrubits5) begin
				lru_bits1=lrubits1+1'b1;
				
			end
			else begin
				lru_bits1=lrubits1;
				
			end
			if(lrubits2<lrubits5) begin
				lru_bits2=lrubits2+1'b1;
				
			end
			else begin
				lru_bits2=lrubits2;
				
			end
			if(lrubits3<lrubits5) begin
				lru_bits3=lrubits3+1'b1;
				
			end
			else begin
				lru_bits3=lrubits3;
				
			end
			if(lrubits4<lrubits5) begin
				lru_bits4=lrubits4+1'b1;
				
			end
			else begin
				lru_bits4=lrubits4;
				
			end
			if(lrubits6<lrubits5) begin
				lru_bits6=lrubits6+1'b1;
				
			end
			else begin
				lru_bits6=lrubits6;
				
			end
			if(lrubits7<lrubits5) begin
				lru_bits7=lrubits7+1'b1;
				
			end
			else begin
				lru_bits7=lrubits7;
				
			end
			lru_bits5='0;
        end

		3'd6: begin
			if(lrubits0<lrubits6)begin
				lru_bits0=lrubits0+1'b1;
				
				end
			else begin
				lru_bits0=lrubits0;
				
				end
			if(lrubits1<lrubits6) begin
				lru_bits1=lrubits1+1'b1;
				
				end
			else begin
				lru_bits1=lrubits1;
				
				end
			if(lrubits2<lrubits6) begin
				lru_bits2=lrubits2+1'b1;
				
				end
			else begin
				lru_bits2=lrubits2;
				
			end
			if(lrubits3<lrubits6)begin
				lru_bits3=lrubits3+1'b1;
				
				end
			else begin
				lru_bits3=lrubits3;
				
				end
			if(lrubits4<lrubits6)begin
				lru_bits4=lrubits4+1'b1;
				
				end
			else begin
				lru_bits4=lrubits4;
				
				end
			if(lrubits5<lrubits6)begin
				lru_bits5=lrubits5+1'b1;
				
				end
			else begin
				lru_bits5=lrubits5;
				
				end
			if(lrubits7<lrubits6)begin
				lru_bits7=lrubits7+1'b1;
				
				end
			else begin
				lru_bits7=lrubits7;
				
				end
			lru_bits6='0;
		end
		3'd7: begin
			if(lrubits0<lrubits7)begin
				lru_bits0=lrubits0+1'b1;
				
				end
			else begin
				lru_bits0=lrubits0;
				
				end
			if(lrubits1<lrubits7) begin
				lru_bits1=lrubits1+1'b1;
				
				end
			else begin
				lru_bits1=lrubits1;
				
				end
			if(lrubits2<lrubits7) begin
				lru_bits2=lrubits2+1'b1;
				
				end
			else begin
				lru_bits2=lrubits2;
				
			end
			if(lrubits3<lrubits7)begin
				lru_bits3=lrubits3+1'b1;
				
				end
			else begin
				lru_bits3=lrubits3;
				
				end
			if(lrubits4<lrubits7)begin
				lru_bits4=lrubits4+1'b1;
				
				end
			else begin
				lru_bits4=lrubits4;
				
				end
			if(lrubits5<lrubits7)begin
				lru_bits5=lrubits5+1'b1;
				
				end
			else begin
				lru_bits5=lrubits5;
				
				end
			if(lrubits6<lrubits7)begin
				lru_bits6=lrubits6+1'b1;
				
				end
			else begin
				lru_bits6=lrubits6;
				
				end
			lru_bits7='0;
          end
	endcase			
endtask			
				