module UART_TX (
input [7:0] P_INPUT,
input V_INPUT, clk, rst, P_EN, P_BIT,
output TX_OUTPUT, BUSY
);

wire [1:0] sel;
wire Start_Bit, Serial_start, Serial_load, Stop_Bit, Enable, Out1, Pout;

FSM_Controller FSMC ( .V_INPUT(V_INPUT), .clk(clk), .rst(rst), .P_EN(P_EN), .Start_Bit(Start_Bit), .Serial_start(Serial_start),
					.Serial_load(Serial_load), .Stop_Bit(Stop_Bit), .Enable(Enable), .sel(sel), .busy(BUSY) );
					
Serializer Serial ( .P_INPUT(P_INPUT), .clk(clk), .rst(rst), .start(Serial_start), .load(Serial_load), .out(Out1) );

Parity_Bit_Calculator Parity ( .P_INPUT(P_INPUT), .Enable(Enable), .P_BIT(P_BIT), .P_out(Pout) );

mux mux42 ( .start(Start_Bit), .inbits(Out1), .parity(Pout), .stop(Stop_Bit), .sel(sel), .out(TX_OUTPUT) );

endmodule