module ExampleTop (
    input clock,
    input reset,
    input in,
    output [3:0] out
);

  shift example(clock, reset, in, out);

endmodule
