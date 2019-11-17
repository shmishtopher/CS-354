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


module OneBitFullAdderDirectTest;

  reg cin;
  reg lhs;
  reg rhs;
  wire sum;
  wire cout;

  OneBitFullAdderDirect oneBitFullAdderDirect(lhs, rhs, cin, sum, cout);

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

endmodule // OneBitFullAdderDirectTest