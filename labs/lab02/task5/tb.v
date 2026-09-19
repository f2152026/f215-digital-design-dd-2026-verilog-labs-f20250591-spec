// tb.v
// Self-checking testbench for 4-bit ALU

module tb;
  reg [3:0] t_a, t_b;
  reg t_op;
  wire [3:0] t_result;
  
  reg [3:0] exp_result;
  integer i, j, k;
  integer errors = 0;
  integer total = 0;

  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  initial begin
    // Loop through both operations (add/sub)
    for (k = 0; k < 2; k = k + 1) begin
      // Loop through all 16 values for A
      for (i = 0; i < 16; i = i + 1) begin
        // Loop through all 16 values for B
        for (j = 0; j < 16; j = j + 1) begin
          t_op = k[0];
          t_a  = i[3:0];
          t_b  = j[3:0];
          #5;
          
          // Calculate expected (4-bit truncation handles overflow identically)
          if (t_op == 1'b0)
            exp_result = t_a + t_b;
          else
            exp_result = t_a - t_b;
            
          total = total + 1;
          
          // Self-check
          if (t_result !== exp_result) begin
            $display("FAIL at %0t: op=%b a=%d b=%d | got=%d expected=%d",
                     $time, t_op, t_a, t_b, t_result, exp_result);
            errors = errors + 1;
          end
        end
      end
    end
    
    $display("Summary: %0d out of %0d passed.", (total - errors), total);
    $finish;
  end

endmodule