module OneBitFullAdderDirect(
  input wire lhs,
  input wire rhs,
  input wire cin,
  output wire sum,
  output wire cout
);

  // Invert inputs
  not(lhs_, lhs);
  not(rhs_, rhs);
  not(cin_, cin);

  // Compute sum products
  and(lhs_rhs_, lhs_, rhs_);
  and(lhs_cin_, lhs_, cin_);
  and(rhs_cin_, rhs_, cin_);
  and(rhslhs, rhs, lhs);

  and(lhs_rhs_cin, lhs_rhs_, cin);
  and(lhs_cin_rhs, lhs_cin_, rhs);
  and(rhs_cin_lhs, rhs_cin_, lhs);
  and(rhslhscin, rhslhs, cin);

  // Compute cout products
  and(rhs_and_cin, rhs, cin);
  and(lhs_and_cin, lhs, cin);
  and(lhs_and_rhs, lhs, rhs);

  // Compute sum sums
  or(left_sum_buffer, lhs_rhs_cin, lhs_cin_rhs);
  or(right_sum_buffer, rhs_cin_lhs, rhslhscin);
  or(sum, left_sum_buffer, right_sum_buffer);

  // Compute cout sums
  or(cout_buffer, rhs_and_cin, lhs_and_cin);
  or(cout, cout_buffer, lhs_and_rhs);

endmodule // OneBitFullAdderDirect


module FourBitAdder(
  input wire operation,
  input wire [3:0] lhs,
  input wire [3:0] rhs,
  output wire [3:0] sum,
  output wire cout,
  output wire overflow
);

  // Carry wires
  wire c0;
  wire c1;
  wire c2;

  // XOR the right hand side with the operation
  xor(rhs_0, rhs[0], operation);
  xor(rhs_1, rhs[1], operation);
  xor(rhs_2, rhs[2], operation);
  xor(rhs_3, rhs[3], operation);

  // Full adder modules
  OneBitFullAdderDirect adder_0(lhs[0], rhs_0, operation, sum[0], c0);
  OneBitFullAdderDirect adder_1(lhs[1], rhs_1, c0, sum[1], c1);
  OneBitFullAdderDirect adder_2(lhs[2], rhs_2, c1, sum[2], c2);
  OneBitFullAdderDirect adder_3(lhs[3], rhs_3, c2, sum[3], cout);

  // Compute overflow
  xor(overflow, cout, c2);

endmodule // FourBitAdder


module FourBitAdderTest;

  reg operation;
  reg signed [3:0] lhs;
  reg signed [3:0] rhs;
  wire signed [3:0] sum;
  wire cout;
  wire overflow;

  FourBitAdder fourBitAdder(operation, lhs, rhs, sum, cout, overflow);

  initial begin
    $monitor("op = %d, lhs = %d, rhs = %d, sum = %d, cout = %d, overflow = %d", operation, lhs, rhs, sum, cout, overflow);
    operation = 0; lhs = 5; rhs = 3;
    #20; operation = 0; lhs = 5; rhs = 0;
    #20; operation = 0; lhs = 5; rhs = -6;
    #20; operation = 1; lhs = 3; rhs = -3;
    #20; operation = 1; lhs = 4; rhs = 2;
    #20; operation = 0; lhs = 6; rhs = 7;
    #20; operation = 0; lhs = 0; rhs = 0;
    #20; operation = 1; lhs = 0; rhs = 0;
  end

endmodule // FourBitAdderTest