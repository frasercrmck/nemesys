`include "defines.vh"

module cpu_testbench;

reg reset = 0;

initial begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars(0, cpu_testbench);
  $dumpvars(0, c.regs.s_regfile[0]);
  $dumpvars(0, c.regs.s_regfile[1]);
  $dumpvars(0, c.regs.s_regfile[2]);
  $dumpvars(0, c.regs.p_regfile[0]);
  $dumpvars(0, c.regs.s_regfile[31]);
  $readmemb("program.bin", c.i.mem);

  #1
  reset = 1;
  #1
  reset = 0;

  #400
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
