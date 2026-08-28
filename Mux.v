module mux (
input start, inbits, parity, stop,
input [1:0] sel,
output reg out
);

always @(*)
begin
	case (sel)
	2'b00 : out = start;
	2'b01 : out = inbits;
	2'b10 : out = parity;
	2'b11 : out = stop;
	endcase
end
endmodule 