module SevenSegment(
  input wire x,
  input wire y,
  input wire z,
  output wire a,
  output wire b,
  output wire c,
  output wire d,
  output wire e,
  output wire f,
  output wire g
);

  // Invert inputs
  not(x_, x);
  not(y_, y);
  not(z_, z);

  // Compute minimum products
  and(x_Az_, x_, z_);
  and(xAz, x, z);
  and(x_Ay, x_, y);
  and(xAy_Az, xAz, y_);
  and(yAz_, y, z_);
  and(x_Ay_Az_, x_Az_, y_);
  and(x_AyAz, x_Ay, z);
  and(xAyAz_, x, yAz_);
  and(xAy_, x, y_);

  // Compute a
  or(a_buffer_0, x_Az_, xAz);
  or(a, a_buffer_0, y);

  // Compute b
  or(b, y_, xAz);

  // Compute c
  or(c_buffer_0, y_, x);
  or(c, c_buffer_0, z_);

  // Compute d
  or(d_buffer_0, x_Az_, xAy_Az);
  or(d_buffer_1, d_buffer_0, x_Ay);
  or(d, d_buffer_1, yAz_);

  // Compute e
  or(e_buffer_0, x_Ay_Az_, x_AyAz);
  or(e, e_buffer_0, xAyAz_);

  // Compute f
  or(f_buffer_0, x_Ay, xAy_);
  or(f, f_buffer_0, z_);

  // Compute g
  or(g_buffer_0, x_Ay, yAz_);
  or(g, g_buffer_0, xAy_);

endmodule // SevenSegment


module SevenSegmentTest;

  reg x;
  reg y;
  reg z;
  wire a;
  wire b;
  wire c;
  wire d;
  wire e;
  wire f;
  wire g;

  SevenSegment sevenSegment(x, y, z, a, b, c, d, e, f, g);

  initial begin
    $monitor("x = %d, y = %d, z = %d, a = %d, b = %d, c = %d, d = %d, e = %d, f = %d, g = %d", x, y, z, a, b, c, d, e, f, g);
    x = 0; y = 0; z = 0;
    #20; x = 0; y = 0; z = 1;
    #20; x = 0; y = 1; z = 0;
    #20; x = 0; y = 1; z = 1;
    #20; x = 1; y = 0; z = 0;
    #20; x = 1; y = 0; z = 1;
    #20; x = 1; y = 1; z = 0;
    #20; x = 1; y = 1; z = 1;
  end

endmodule // SevenSegmentTest