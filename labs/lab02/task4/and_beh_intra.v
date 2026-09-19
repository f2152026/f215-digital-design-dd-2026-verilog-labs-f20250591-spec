module and_beh_intra (
  input  a,
  input  b,
  output reg y
);
  always @(*) begin
    // Intra-assignment delay (Evaluate immediately, delay write)
    y = #1 (a & b);
  end
endmodule