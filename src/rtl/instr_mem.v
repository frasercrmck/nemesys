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
            // MOV #0, R0
    mem[0] = {`MOV, 6'd0, 5'd0, 16'd0};
            // MOV #1, R1
    mem[1] = {`MOV, 6'd0, 5'd1, 16'd1};
            // MOV #6, R2
    mem[2] = {`MOV, 6'd0, 5'd2, 16'd6};
            // ADD R0, R1, R0
    mem[3] = {`ADD, 6'd0, 5'd0, 6'd0, 5'd0, 5'd1};
            // CMP R0 {LT} R2, P0
    mem[4] = {`CMP, 6'd0, 5'd0, 3'd0, `LT, 5'd0, 5'd2};
            // BR  #-2
    mem[5] = {`BR,  6'd0, 5'd0, 16'hFFFE};
end

endmodule // instr_mem
