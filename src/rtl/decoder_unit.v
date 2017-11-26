`include "defines.vh"

module decoder_unit
(
  input wire [(`WIDTH - 1):0] inst,
  output wire [4:0] opcode,
  output wire is_branch,
  output wire is_negated_branch,
  output wire is_call,
  output wire is_ret,
  output wire halted,
  output wire [3:0] cc,
  // 'A' Data
  output wire a_regbank_sel,
  output wire a_from_regbank,
  output wire [(`WIDTH - 1):0] a_data,
  output wire [(`REG_SEL - 1):0] a_regbank_addr,
  // 'B' Data
  output wire b_regbank_sel,
  output wire b_from_regbank,
  output wire [(`WIDTH - 1):0] b_data,
  output wire [(`REG_SEL - 1):0] b_regbank_addr,
  // 'Z' Data
  output wire z_regbank_sel,
  output wire [(`REG_SEL - 1):0] z_regbank_addr
);

assign opcode = inst[31:27];

// TODO: ALU instruction format bits?
wire is_alu_inst = (opcode == `ADD ||
                    opcode == `SUB ||
                    opcode == `MPY ||
                    opcode == `AND ||
                    opcode == `OR  ||
                    opcode == `XOR ||
                    opcode == `SHL ||
                    opcode == `SRL ||
                    opcode == `SRA ||
                    opcode == `CMP);

assign is_mov    = opcode == `MOV || opcode == `MOVH;
assign is_branch = opcode == `BR;
assign is_call   = opcode == `CALL;
assign is_ret    = opcode == `RET;
assign is_cmp    = opcode == `CMP;
assign halted    = opcode == `HALT;

assign is_negated_branch = is_branch && inst[19];

assign cc = is_cmp ? inst[13:10] : 4'bz;

// Input B is always a scalar register (if any)
assign b_regbank_sel = `S_REGS;
// Branches read from predicate registers
assign a_regbank_sel = is_branch ? `P_REGS : `S_REGS;
// Comparisons write to predicate registers
assign z_regbank_sel = is_cmp ? `P_REGS : `S_REGS;

assign has_large_imm = is_mov || is_branch || is_call;

assign has_small_imm = is_alu_inst && inst[26] == 1'b1;

assign is_a_sext = !is_mov;

assign a_regbank_addr = is_branch ? inst[18:16] : is_ret ? `R31 : has_large_imm ? 0 : inst[9:5];
assign b_regbank_addr = has_large_imm ? 0 : inst[4:0];
assign z_regbank_addr = is_branch ? 0 : is_call ? `R31 : inst[20:16];

assign a_from_regbank = !has_large_imm;
assign a_data = !is_a_sext ? inst[15:0] : {{16{inst[15]}}, inst[15:0]};

assign b_from_regbank = !has_large_imm && !has_small_imm;

assign b_data = !has_small_imm ? inst[4:0] : {{27{inst[25]}}, inst[4:0]};

endmodule // decoder_unit
