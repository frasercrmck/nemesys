`include "defines.vh"

// TODO: Add & Sub with carry in/out

module alu_unit
(
  input wire[4:0] opcode,
  input wire[2:0] cc,
  input wire [(`WIDTH - 1):0] a_data,
  input wire [(`WIDTH - 1):0] b_data,
  output reg [(`WIDTH - 1):0] z_data
);

// Only shift by the lower 5-bits of input B
wire [(`BITSIZE - 1):0] shift_amount = b_data[(`BITSIZE - 1):0];

always @(*) begin
  case (opcode)
    default:
      z_data <= 0;
    `ADD:
      z_data <= a_data + b_data;
    `SUB:
      z_data <= a_data - b_data;
    `MPY:
      z_data <= a_data * b_data;
    `AND:
      z_data <= a_data & b_data;
    `OR:
      z_data <= a_data | b_data;
    `XOR:
      z_data <= a_data ^ b_data;
    `SHL:
      z_data <= a_data << shift_amount;
    `SRL:
      z_data <= a_data >> shift_amount;
    `SRA:
      z_data <= $signed(a_data) >>> shift_amount;
    `MOV:
      z_data <= a_data;
    `CMP:
    begin
      z_data[31:1] <= 0;
      case (cc)
        `EQ:
          z_data[0] <= a_data == b_data;
        `NE:
          z_data[0] <= a_data != b_data;
        `LT:
          z_data[0] <= $signed(a_data) < $signed(b_data);
        `LE:
          z_data[0] <= $signed(a_data) <= $signed(b_data);
        `ULT:
          z_data[0] <= $unsigned(a_data) < $unsigned(b_data);
        `ULE:
          z_data[0] <= $unsigned(a_data) <= $unsigned(b_data);
      endcase
    end
  endcase // opcode
end

endmodule // alu_unit
