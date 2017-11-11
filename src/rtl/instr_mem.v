`include "defines.vh"

`define MEM_SIZE 15

module instr_mem
(
  input wire clk,
  input wire [31:0] pc,
  output wire [(`WIDTH - 1):0] inst
);


reg [(`WIDTH - 1):0] mem [`MEM_SIZE:0];

integer i;
assign inst = mem[pc];

initial begin
    for (i = 0; i < `MEM_SIZE; i = i + 1)
      mem[i] = 0;
end

endmodule // instr_mem
