`include "defines.vh"

module pc_cntrl
(
  input wire clk,
  input wire reset,
  input wire enable,
  input wire take_branch,
  input wire is_relative_branch,
  input wire [31:0] branch_addr,
  output wire [31:0] pc_out
);

reg [31:0] pc;
assign pc_out = pc;

initial begin
  pc = 0;
end

always @(posedge clk) begin
  if (reset)
    pc <= 0;
  else if (!enable)
    pc <= pc;
  else if (take_branch)
    pc <= !is_relative_branch ? branch_addr : pc + branch_addr;
  else
    pc <= pc + 1;
end

endmodule // pc_cntrl
