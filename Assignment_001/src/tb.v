`include "four_bit_adder.v"
`include "inverter.v"
`include "majority.v"
`include "multiplexer.v"
`include "one_bit_full_adder.v"


module TestBench;

  reg [3:0] lhs_4;
  reg [3:0] rhs_4;
  reg operation;
  reg lhs_1;
  reg rhs_1;
  reg cin_1;
  reg lhs_inverter;
  reg rhs_inverter;
  reg [2:0] majority_in;
  reg [2:0] multiplexer_in;


  wire [3:0] sum_4;
  wire cout_4;
  wire cout_1;
  wire sum_1;
  wire overflow;
  wire inverter_out;
  wire majority_out;
  wire multiplexer_out;


  FourBitAdder fourBitAdder(
    .lhs(lhs_4),
    .rhs(rhs_4),
    .operation(operation),
    .sum(sum_4),
    .cout(cout_4),
    .overflow(overflow)
  );


  Inverter inverter(
    .lhs(lhs_inverter),
    .rhs(rhs_inverter),
    .out(inverter_out)
  );


  Majority majority(
    .a(majority_in[0]),
    .b(majority_in[1]),
    .c(majority_in[2]),
    .sum(majority_out)
  );


  Multiplexer multiplexer(
    .a(multiplexer_in[0]),
    .b(multiplexer_in[1]),
    .c(multiplexer_in[2]),
    .out(multiplexer_out)
  );


  OneBitFullAdder oneBitFullAdder(
    .lhs(lhs_1),
    .rhs(rhs_1),
    .cin(cin_1),
    .sum(sum_1),
    .cout(cout_1)
  );


  initial begin
    $monitor("lhs = %d; rhs = %d; op = %d; sum = %d; carry = %d; overflow = %d", lhs_4, rhs_4, operation, sum_4, cout_4, overflow);
    $display("4 bit adder/subtractor");
    
    #20; lhs_4 = 5; rhs_4 = 5; operation = 0;
    #20; lhs_4 = 5; rhs_4 = 5; operation = 1;
    #20; lhs_4 = 1; rhs_4 = 4; operation = 0;
    #20; lhs_4 = 8; rhs_4 = 9; operation = 0;


    $monitor("lhs = %d; rhs = %d; out = %d", lhs_inverter, rhs_inverter, inverter_out);
    $display("Inverter");
    
    #20; lhs_inverter = 0; rhs_inverter = 0;
    #20; lhs_inverter = 0; rhs_inverter = 1;
    #20; lhs_inverter = 1; rhs_inverter = 0;
    #20; lhs_inverter = 1; rhs_inverter = 1;


    $monitor("a = %d; b = %d; c = %d; majority = %d", majority_in[0], majority_in[1], majority_in[2], majority_out);
    $display("Majority");

    #20; majority_in = 0;
    #20; majority_in = 1;
    #20; majority_in = 2;
    #20; majority_in = 3;
    #20; majority_in = 4;
    #20; majority_in = 5;
    #20; majority_in = 6;
    #20; majority_in = 7;


    $monitor("a = %d; b = %d; c = %d; passthrough = %d", multiplexer_in[0], multiplexer_in[1], multiplexer_in[2], multiplexer_out);
    $display("Multiplexer");

    #20; multiplexer_in = 0;
    #20; multiplexer_in = 1;
    #20; multiplexer_in = 2;
    #20; multiplexer_in = 3;
    #20; multiplexer_in = 4;
    #20; multiplexer_in = 5;
    #20; multiplexer_in = 6;
    #20; multiplexer_in = 7;


    $monitor("lhs = %d; rhs = %d; cin = %d; sum = %d; cout = %d", lhs_1, rhs_1, cin_1, sum_1, cout_1);
    $display("One bit full adder");

    #20; lhs_1 = 0; rhs_1 = 0; cin_1 = 0;
    #20; lhs_1 = 0; rhs_1 = 0; cin_1 = 1;
    #20; lhs_1 = 0; rhs_1 = 1; cin_1 = 0;
    #20; lhs_1 = 0; rhs_1 = 1; cin_1 = 1;
    #20; lhs_1 = 1; rhs_1 = 0; cin_1 = 0;
    #20; lhs_1 = 1; rhs_1 = 0; cin_1 = 1;
    #20; lhs_1 = 1; rhs_1 = 1; cin_1 = 0;
    #20; lhs_1 = 1; rhs_1 = 1; cin_1 = 1;
  end

endmodule // TestBench