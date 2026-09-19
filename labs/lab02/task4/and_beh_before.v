module and_beh_before (
  input  a,
  input  b,
  output reg y
);
  always @(*) begin
    // Delay BEFORE evaluation
    #1 y = a & b;
  end
endmodule