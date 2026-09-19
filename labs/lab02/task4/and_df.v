module and_df (
  input  a,
  input  b,
  output wire y
);
  // Continuous assignment delay (Inertial delay)
  assign #2 y = a & b;
endmodule