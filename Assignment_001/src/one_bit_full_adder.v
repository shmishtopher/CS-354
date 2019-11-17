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


module OneBitFullAdder(
  input wire cin,
  input wire lhs,
  input wire rhs,
  output wire sum,
  output wire cout
);

  // Initilize two half-adders
  OneBitHalfAdder halfAdderA(lhs, rhs, buffer, carry_left);
  OneBitHalfAdder halfAdderB(buffer, cin, sum, carry_right);

  // Compute the carry
  or(cout, carry_left, carry_right);

endmodule // OneBitFullAdder


module OneBitFullAdderTest;

  reg cin;
  reg lhs;
  reg rhs;
  wire sum;
  wire cout;

  OneBitFullAdder oneBitFullAdder(cin, lhs, rhs, sum, cout);

  initial begin
    $monitor("cin = %d, lhs = %d, rhs = %d, sum = %d, cout = %d", cin, lhs, rhs, sum, cout);
    cin = 0; lhs = 0; rhs = 0;
    #20; cin = 0; lhs = 0; rhs = 1;
    #20; cin = 0; lhs = 1; rhs = 0;
    #20; cin = 0; lhs = 1; rhs = 1;
    #20; cin = 1; lhs = 0; rhs = 0;
    #20; cin = 1; lhs = 0; rhs = 1;
    #20; cin = 1; lhs = 1; rhs = 0;
    #20; cin = 1; lhs = 1; rhs = 1;
  end

endmodule // OneBitFullAdderTest