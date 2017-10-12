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
    mem[0] = {`MOV, 6'd0, `R0, 16'd0};
            // MOV #1, R1
    mem[1] = {`MOV, 6'd0, `R1, 16'd1};

            // LOOP:
            // MPY R1, #2, R1
    mem[2] = {`MPY, 2'b10, 4'd0, `R1, 6'd0, `R1, 5'd2};
            // ADD R0, #1, R0
    mem[3] = {`ADD, 2'b10, 4'd0, `R0, 6'd0, `R0, 5'd1};
            // CMP R0 {LT} #6, P5
    mem[4] = {`CMP, 2'b10, 6'd0, `P5, 3'd0, `LT, `R0, 5'd6};
            // BR  P5, #LOOP (-3)
    mem[5] = {`BR,  7'd0, 1'b0, `P5, 16'hFFFD};

            // HALT
    mem[6] = {`HALT,  27'd0};
end

endmodule // instr_mem
