`timescale 1ns/1ps

module FSM_Controller_TB;

reg clk, rst, P_EN, V_INPUT;
wire Start_Bit, Serial_start, Serial_load, Stop_Bit, busy, Enable;
wire [1:0] sel;

FSM_Controller dut ( .clk(clk), .rst(rst), .P_EN(P_EN), .V_INPUT(V_INPUT), .Start_Bit(Start_Bit), .Serial_start(Serial_start), .Serial_load(Serial_load),
					.Stop_Bit(Stop_Bit), .busy(busy), .Enable(Enable), .sel(sel) );

integer i;

always #10 clk = ~clk;

initial
begin
	$dumpfile ("FSM_Controller_TB.dmp");
	$dumpvars (0, FSM_Controller_TB);
	
	clk = 0;
	rst = 1;
	P_EN = 0;
	V_INPUT = 0;
	
	#20;
	rst = 0;
	#20;
	rst = 1;
	#20;
	
	for (i = 0 ; i < 4 ; i = i + 1)
	begin
		
		{P_EN, V_INPUT} = i;
		
		repeat (12)
		begin
				$display ("P_EN = %b, V_INPUT = %b, Start_Bit = %b, Serial_start = %b, Serial_load = %b, Stop_Bit = %b, busy = %b, Enable = %b, sel = %d",
							P_EN, V_INPUT, Start_Bit, Serial_start, Serial_load, Stop_Bit, busy, Enable, sel); 
				#20;
		end
		
		$display("End of Case");
	end
$stop;
end
endmodule