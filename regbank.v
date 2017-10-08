`include "defines.vh"

module regbank
(
  input wire clk,
  input wire reset,
  input wire write_enable,
  input wire [(`REG_SEL - 1):0] addr_a,
  input wire [(`REG_SEL - 1):0] addr_b,
  input wire [(`REG_SEL - 1):0] addr_z,
  output wire [(`WIDTH - 1):0] data_a,
  output wire [(`WIDTH - 1):0] data_b,
  input  wire [(`WIDTH - 1):0] data_z
);

integer i;
reg [(`WIDTH - 1):0] registers [(`NUM_REGS - 1):0];

assign data_a = registers[addr_a];
assign data_b = registers[addr_b];

always @(posedge clk) begin
  if (reset)
    for (i = 0; i < `NUM_REGS; i = i + 1)
      registers[i] <= 0;
  else
    if (write_enable)
      registers[addr_z] <= data_z;
end

endmodule // regbank
