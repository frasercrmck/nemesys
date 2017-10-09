`include "defines.vh"

`define MEM_SIZE 15

module instr_mem
(
  input wire clk,
  input wire [31:0] pc,
  output wire [(`WIDTH - 1):0] inst
);


reg [(`WIDTH - 1):0] mem [`MEM_SIZE:0];

assign inst = mem[pc];

initial begin
               // MOV        R0        0
    mem[0] = {5'd`MOV, 6'd0, 5'd0, 16'd0};
               // MOV        R1        1
    mem[1] = {5'd`MOV, 6'd0, 5'd1, 16'd1};
               // ADD        R0          R1    R0
    mem[2] = {5'd`ADD, 6'd0, 5'd0, 6'd0, 5'd1, 5'd0};
               // BR                   -1
    mem[3] = {5'd`BR,  6'd0, 5'd0, 16'hFFFF};
end

endmodule // instr_mem
