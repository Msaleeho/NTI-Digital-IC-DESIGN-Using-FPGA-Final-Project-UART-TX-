module Serializer (
input [7:0] P_INPUT,
input clk, rst, start, load, 
output reg out
);

reg [2:0] counter;
reg [7:0] temp_input;
reg busy;

always @(posedge clk or negedge rst)
begin
	if (!rst)
	begin
		temp_input <= 0;
		busy <= 0;
		out <= 0;
		counter <= 3'd0;
	end
	
	else if (load && !busy)
	begin
		temp_input <= P_INPUT;
		counter <= 3'd0;
	end
		
	else if (start && !busy)
	begin
		busy <= 1;
		counter <= 3'd1;
		out <= temp_input[0];
	end
	
	else if (busy)
	begin
		out <= temp_input[counter];
		counter <= counter + 3'd1;
		
		if (counter == 3'd7)
		begin
			busy <= 0;
		end
	end
end
endmodule