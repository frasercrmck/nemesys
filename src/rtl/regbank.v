`include "defines.vh"

module regbank
(
  input wire clk,
  input wire reset,
  input wire write_enable,
  input wire [(`REG_SEL - 1):0] addr_a,
  input wire [(`REG_SEL - 1):0] addr_b,
  input wire [(`REG_SEL - 1):0] addr_z,
  output reg [(`WIDTH - 1):0] data_a,
  output reg [(`WIDTH - 1):0] data_b,
  input  wire [(`WIDTH - 1):0] data_z,
  input wire a_regbank_sel,
  input wire b_regbank_sel,
  input wire z_regbank_sel
);

reg [(`WIDTH - 1):0] s_regfile [(`NUM_REGS - 1):0];
reg                  p_regfile [(`NUM_PRED_REGS - 1):0];

task reset_registers;
  integer i;
begin
  for (i = 0; i < `NUM_REGS; i = i + 1)
    s_regfile[i] <= 0;
  for (i = 0; i < `NUM_PRED_REGS; i = i + 1)
    p_regfile[i] <= 0;
end
endtask // reset_registers

initial begin
  reset_registers();
end

function [(`WIDTH - 1):0] register_value
(
  input regbank_sel,
  // Use a large address and only access the relevant bits
  input [(`WIDTH - 1):0] regbank_addr
);
begin
  case (regbank_sel)
    default:
      register_value = 0;
    `S_REGS:
      register_value = s_regfile[regbank_addr[0 +: `REG_SEL]];
    `P_REGS:
      register_value = p_regfile[regbank_addr[0 +: `PRED_REG_SEL]];
  endcase
end
endfunction // register_value

always @(*) begin
  data_a <= register_value(a_regbank_sel, addr_a);
  data_b <= register_value(b_regbank_sel, addr_b);
end

always @(posedge clk) begin
  if (reset)
    reset_registers();
  else
    if (write_enable) begin
      case (z_regbank_sel)
        default:
        begin
          // Do nothing
        end
        `S_REGS:
          s_regfile[addr_z[0 +: `REG_SEL]] <= data_z;
        `P_REGS:
          p_regfile[addr_z[0 +: `PRED_REG_SEL]] <= data_z[0];
      endcase
    end
end

endmodule // regbank
