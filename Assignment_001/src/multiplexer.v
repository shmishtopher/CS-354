module Multiplexer(
  input wire a,
  input wire b,
  input wire c,
  output wire out
);

  // Invert control input
  not(c_prime, c);

  // Compute products
  and(left, a, c_prime);
  and(right, b, c);

  // Compute sum
  or(out, left, right);

endmodule // Multiplexer



module MultiplexerTest;

  reg a;
  reg b;
  reg c;
  wire out;

  Multiplexer multiplexer(a, b, c, out);

  initial begin
    $monitor("a = %d, b = %d, c = %d, out = %d", a, b, c, out);
    a = 0; b = 0; c = 0;
    #20; a = 0; b = 0; c = 1;
    #20; a = 0; b = 1; c = 0;
    #20; a = 0; b = 1; c = 1;
    #20; a = 1; b = 0; c = 0;
    #20; a = 1; b = 0; c = 1;
    #20; a = 1; b = 1; c = 0;
    #20; a = 1; b = 1; c = 1;
  end

endmodule // MultiplexerTest