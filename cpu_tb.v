`include "defines.vh"

module cpu_testbench;

reg reset = 0;

initial begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars(0, cpu_testbench);

  #1
  reset = 1;
  #1
  reset = 0;

  #50
  $finish;
end

reg clk = 0;
always #1 clk = !clk;

cpu c
(
  clk,
  reset
);

endmodule // cpu_testbench
