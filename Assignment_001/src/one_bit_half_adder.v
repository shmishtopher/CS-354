module OneBitHalfAdder(
  input wire lhs,
  input wire rhs,
  output wire sum,
  output wire carry
);

  // Compute the sum
  xor(sum, lhs, rhs);

  // Compute the carry
  and(carry, lhs, rhs);

endmodule // OneBitHalfAdder


module OneBitHalfAdderTest;

  reg lhs;
  reg rhs;
  wire sum;
  wire carry;

  OneBitHalfAdder oneBitHalfAdder(lhs, rhs, sum, carry);

  initial begin
    $monitor("lhs = %d, rhs = %d, sum = %d, carry = %d", lhs, rhs, sum, carry);
    lhs = 0; rhs = 0;
    #20; lhs = 0; rhs = 1;
    #20; lhs = 1; rhs = 0;
    #20; lhs = 1; rhs = 1;
  end

endmodule // OneBitHalfAdderTest