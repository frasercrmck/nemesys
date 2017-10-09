`include "defines.vh"

module pc_cntrl_testbench;

reg reset = 0;

reg take_br = 0;
reg [31:0] branch_addr = 0;

initial begin
  $dumpfile("pc_cntrl_tb.vcd");
  $dumpvars(0, pc_cntrl_testbench);

  #1
  reset = 1;
  #1
  reset = 0;

  #11
  take_br = 1;
  branch_addr = 3;

  #1
  take_br = 0;

  #10
  $finish;
end

wire [31:0] pc;

reg clk = 0;
always #1 clk = !clk;

wire enable = 1;
wire is_relative_branch = 0;

pc_cntrl cntrl
(
  clk,
  reset,
  enable,
  take_br,
  is_relative_branch,
  branch_addr,
  pc
);

endmodule // pc_cntrl_testbench;
