`timescale 1ns/1ps

module Serializer_TB;

reg [7:0] P_INPUT;
reg clk, rst, start, load;
wire out;

Serializer dut ( .P_INPUT(P_INPUT), .clk(clk), .rst(rst), .start(start), .load(load), .out(out) );

integer i, j;

always #10 clk = ~clk;

task check;
input [7:0] P_INPUTch;

begin
	for (i = 0 ; i < 8 ; i = i + 1)
	begin
		if (out != P_INPUTch[i])
		begin
			$error ("Wrong Out = %d, P_INPUT[%d] = %d, P_INPUT = %b, Load = %b, Start = %b", out, i, P_INPUTch[i], P_INPUT, load, start);
		end
		
		else 
		begin
			$display("Correct Out = %d, P_INPUT[%d] = %d, P_INPUT = %b, Load = %b, Start = %b", out, i, P_INPUTch[i], P_INPUT, load, start);
		end
		#20;
	end
end
endtask

initial
begin
	$dumpfile ("Serializer_TB.dmp");
	$dumpvars (0, Serializer_TB);
	
	clk = 0;
	rst = 1;
	start = 0;
	load = 0;
	P_INPUT = 0;
	
	#40;
	rst = 0;
	#40;
	rst = 1;
	
	for (j = 0 ; j < 4 ; j = j + 1)
	begin
		#20;
		
		load = 1; start = 0;
		P_INPUT = $random % 256;
		
		#20;
		
		{load, start} = j;
		
		#20;
		
		load = 0; start = 0;
		
		check(P_INPUT);
		$display ("end of case");
	end
	#40;
	$stop;
end
endmodule