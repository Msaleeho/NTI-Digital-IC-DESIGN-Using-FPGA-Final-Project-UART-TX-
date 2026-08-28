module FSM_Controller (
input clk, rst, P_EN, V_INPUT,
output reg Start_Bit, Serial_start, Serial_load, Stop_Bit, busy, Enable,
output reg [1:0] sel
);

reg [3:0] counter, current, next;

localparam S0 = 3'b000,
			S1 = 3'b001,
			S2 = 3'b010,
			S3 = 3'b011,
			S4 = 3'b100;
			
always @(posedge clk or negedge rst)
begin
	if (!rst)
	begin
		current <= S0;
		counter <= 4'd0;
	end
	
	else
	begin
		current <= next;
		
		if (current == S2)
		begin
			counter <= counter + 4'd1;
		end
		
		else
		begin
			counter <= 4'd0;
		end
	end
end

// start(0) b0 b1 b2 b3 b4 b5 b6 b7 stop(1)

always @(*)
begin
next = current;
Serial_load = 0;
Serial_start = 0;
Start_Bit = 0;
busy = 0;
Enable = 0;
Stop_Bit = 1;
sel = 2'b11;

	case (current)
	S0 : begin
			if (V_INPUT)
			begin
				next = S1;
				Serial_load = 1;
				busy = 1;
			end
			else
			begin
				sel = 2'b11;
				next = S0;
				Serial_load = 0;
				busy = 0;
			end
		end
		
	S1 : begin
			sel = 2'b00;
			next = S2;
			Serial_start = 1;
			busy = 1;
		end	
		
	S2 : begin
			sel = 2'b01;
			if (counter >= 4'd7)
			begin
				if (P_EN)
				begin
					next = S3;
					Enable = 1;
				end
				
				else 
				begin
					next = S4;
				end
			end
			
			else 
			begin
				next = S2;
			end
			busy = 1;
		end
	S3 : begin
			sel = 2'b10;
			Enable = 1;
			busy = 1;
			next = S4;
		end
		
	S4 : begin
			sel = 2'b11;
			next = S0;
		end	
		
	default : begin
				next = S0;
			end
	endcase
end

endmodule