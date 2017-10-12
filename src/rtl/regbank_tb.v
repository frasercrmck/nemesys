`include "defines.vh"

module regbank_testbench;

wire [(`WIDTH - 1):0] data_a;
wire [(`WIDTH - 1):0] data_b;
reg [(`WIDTH - 1):0]  data_z;

reg [(`REG_SEL - 1):0] addr_a;
reg [(`REG_SEL - 1):0] addr_b;
reg [(`REG_SEL - 1):0] addr_z;

reg reset = 0;
reg write_enable = 0;

reg a_regbank_sel = 0;
reg b_regbank_sel = 0;
reg z_regbank_sel = 0;

initial begin
  $dumpfile("regbank_tb.vcd");
  $dumpvars(0, regbank_testbench);
  $dumpvars(0, regs.s_regfile[0]);
  $dumpvars(0, regs.p_regfile[0]);

  #1
  reset = 1;

  #3
  reset = 0;
  addr_a = 0;
  addr_b = 1;

  #1
  addr_z = 0;
  data_z = 4;
  write_enable = 1;

  #1
  data_z = 7;
  addr_z = 1;
  write_enable = 0;

  #1
  addr_a = 1;
  addr_b = 0;

  #1
  // Shouldn't do anything as clock is low
  write_enable = 1;
  #1
  write_enable = 0;
  #1
  write_enable = 1;
  #2
  write_enable = 0;

  #3
  reset = 1;

  #1
  reset = 0;
  write_enable = 1;
  z_regbank_sel = 1;
  addr_z = 0;
  data_z = 1;

  #2
  write_enable = 1;
  z_regbank_sel = 1;
  addr_z = 5'b10000;
  data_z = 0;

  #5
  $finish;
end

reg clk = 0;
always #1 clk = !clk;

regbank regs(
  clk,
  reset,
  write_enable,
  addr_a,
  addr_b,
  addr_z,
  data_a,
  data_b,
  data_z,
  a_regbank_sel,
  b_regbank_sel,
  z_regbank_sel
);

endmodule // regbank_testbench

