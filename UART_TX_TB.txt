`timescale 1ns/1ps

module UART_TX_TB;

reg [7:0] P_INPUT;
reg V_INPUT, clk, rst, P_EN, P_BIT;
wire TX_OUTPUT, BUSY;

UART_TX dut ( .P_INPUT(P_INPUT), .V_INPUT(V_INPUT), .clk(clk), .rst(rst), .P_EN(P_EN), .P_BIT(P_BIT), .TX_OUTPUT(TX_OUTPUT), .BUSY(BUSY) );

integer i;

always #10 clk = ~clk;

initial
begin
	$dumpfile ("UART_TX_TB.dmp");
	$dumpvars (0, UART_TX_TB);
	
	clk = 0;
	rst = 1;
	P_EN = 0;
	V_INPUT = 0;
	P_BIT = 0;
	
	#20;
	
	for (i = 0 ; i < 8 ; i = i + 1)
	begin
		@(posedge clk);
		#1;
		{P_EN, P_BIT, V_INPUT} = i;
		P_INPUT = $random % 256;
		
		repeat (12)
		begin
			@(posedge clk);
			#1;
			$display ("P_EN = %b, P_BIT = %b, V_INPUT = %b, Busy = %b, P_INPUT = %b, Out = %b", P_EN, P_BIT, V_INPUT, BUSY, P_INPUT, TX_OUTPUT); 
		end
		
		rst = 0;
		V_INPUT = 0;
		#20;
		rst = 1;
		
		$display("End of Case");
	end
$stop;
end
endmodule