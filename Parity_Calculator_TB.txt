`timescale 1ns/1ps

module Parity_Bit_Calculator_TB;

reg [7:0] P_INPUT;
reg Enable, P_BIT;
wire P_out;

Parity_Bit_Calculator dut ( .P_INPUT(P_INPUT), .Enable(Enable), .P_BIT(P_BIT), .P_out(P_out) );

integer i, j;


function check;
input [7:0] P_INPUTch;
input Enablech, chP_BIT;
reg compare;

begin
		compare = 0;
		
		if (Enablech)
		begin
			for (i = 0 ; i < 8 ; i = i + 1)
			begin
				compare = compare ^ P_INPUTch[i];
			end
		end
			
	if (chP_BIT) check = compare;
	else check = !compare;
end
endfunction

initial
begin
	$dumpfile ("Parity_Bit_Calculator_TB.dmp");
	$dumpvars (0, Parity_Bit_Calculator_TB);
	
	for (j = 0 ; j < 4 ; j = j + 1)
	begin
		#40;
		
		{Enable, P_BIT} = j;
		P_INPUT = $random % 256;

		#5;
		
		if (P_out == check(P_INPUT, Enable, P_BIT) && Enable)	
		begin
			$display("Correct P_EN = %d, P_BIT = %d, P_INPUT = %b, out = %b", Enable, P_BIT, P_INPUT, P_out);
		end
		
		else if (!Enable)
		begin
			$display("Ignored P_EN = %d, P_BIT = %d, P_INPUT = %b, out = %b", Enable, P_BIT, P_INPUT, P_out);
		end
		
		else 
		begin
			$error ("Wrong P_EN = %d, P_BIT = %d, P_INPUT = %b, out = %b", Enable, P_BIT, P_INPUT, P_out);
		end
	end
$stop;
end
endmodule