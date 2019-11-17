module Inverter(
  input wire lhs,
  input wire rhs,
  output wire out
);

  // Invert left and right hand sides
  not(lhs_prime, lhs);
  not(rhs_prime, rhs);

  // Compute products
  and(left, lhs_prime, rhs);
  and(right, lhs, rhs_prime);

  // Compute sum
  or(out, left, right);

endmodule // Inverter



module InverterTest;

  reg lhs;
  reg rhs;
  wire out;

  Inverter inverter(lhs, rhs, out);

  initial begin
    $monitor("lhs = %d, rhs = %d, out = %d", lhs, rhs, out);
    lhs = 0; rhs = 0;
    #20; lhs = 0; rhs = 1;
    #20; lhs = 1; rhs = 0;
    #20; lhs = 1; rhs = 1;
  end

endmodule // InverterTest