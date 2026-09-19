// tb.v
// Self-checking testbench for 2-bit comparator

module tb;
  reg [1:0] t_a, t_b;
  wire t_gt, t_lt, t_eq;
  
  reg exp_gt, exp_lt, exp_eq;
  integer i, j;
  integer errors = 0;
  integer total = 0;

  // Instantiate the buggy comparator
  comp2 DUT (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  initial begin
    // Loop through all 16 combinations
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i[1:0]; 
        t_b = j[1:0];
        #5;
        
        // Independently calculate expected outputs
        exp_gt = (t_a > t_b);
        exp_lt = (t_a < t_b);
        exp_eq = (t_a == t_b);
        
        total = total + 1;
        
        // Self-checking assertion
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end
    
    // Print summary line
    $display("Summary: %0d out of %0d passed.", (total - errors), total);
    $finish;
  end
endmodule