module shift(
    input clock,
    input reset,
    input in,
    output [3:0] out
);

  reg [3:0] out;
  always@(posedge clock) begin
    if (reset) out <= 4'b0;
    else out <= {out[2:0], out[3] ^ in};
  end

endmodule
