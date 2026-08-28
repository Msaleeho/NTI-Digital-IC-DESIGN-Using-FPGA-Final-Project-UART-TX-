module Parity_Bit_Calculator (
input [7:0] P_INPUT,
input Enable, P_BIT,
output reg P_out	
);

reg compare;

always @(*)
begin
	compare = P_INPUT[0] ^ P_INPUT[1] ^ P_INPUT[2] ^ P_INPUT[3] ^ P_INPUT[4] ^ P_INPUT[5] ^ P_INPUT[6] ^ P_INPUT[7];
	if (Enable)
	begin
		if (P_BIT)
		begin
			P_out = compare;
		end
		else
		begin
			P_out = !compare;
		end
	end
	else 
	begin
		P_out = 0;
	end
	
end
endmodule