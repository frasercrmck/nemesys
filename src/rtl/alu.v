`include "defines.vh"

// TODO: Add & Sub with carry in/out

module alu
(
  input wire[4:0] opcode,
  input wire [(`WIDTH - 1):0] data_a,
  input wire [(`WIDTH - 1):0] data_b,
  output reg [(`WIDTH - 1):0] data_z
);

// Only shift by the lower 5-bits of input B
wire [(`BITSIZE - 1):0] shift_amount = data_b[(`BITSIZE - 1):0];

always @(*) begin
  case (opcode)
    default:
      data_z <= 0;
    `ADD:
      data_z <= data_a + data_b;
    `SUB:
      data_z <= data_a - data_b;
    `MPY:
      data_z <= data_a * data_b;
    `AND:
      data_z <= data_a & data_b;
    `OR:
      data_z <= data_a | data_b;
    `XOR:
      data_z <= data_a ^ data_b;
    `SHL:
      data_z <= data_a << shift_amount;
    `SRL:
      data_z <= data_a >> shift_amount;
    `SRA:
      data_z <= $signed(data_a) >>> shift_amount;
    `MOV:
      data_z <= data_a;
  endcase // opcode
end

endmodule // alu
