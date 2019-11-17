module Majority(
  input wire a,
  input wire b,
  input wire c,
  output wire sum
);

  // Compute the products
  and(a_and_b, a, b);
  and(a_and_c, a, c);
  and(b_and_c, b, c);

  // Cascade the OR
  or(buffer, a_and_b, a_and_c);
  or(sum, buffer, b_and_c);

endmodule // Majority



module MajorityTest;

  reg a;
  reg b;
  reg c;
  wire sum;

  Majority majority(a, b, c, sum);

  initial begin
    $monitor("a = %d, b = %d, c = %d, sum = %d", a, b, c, sum);
    a = 0; b = 0; c = 0;
    #20; a = 0; b = 0; c = 1;
    #20; a = 0; b = 1; c = 0;
    #20; a = 0; b = 1; c = 1;
    #20; a = 1; b = 0; c = 0;
    #20; a = 1; b = 0; c = 1;
    #20; a = 1; b = 1; c = 0;
    #20; a = 1; b = 1; c = 1;
  end

endmodule // MajorityTest