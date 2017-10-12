`include "defines.vh"

module cpu
(
  input wire clk,
  input wire reset
);

reg [1:0] state;
reg [1:0] next_state;

initial begin
  state = `FETCH;
  next_state = `FETCH;
end

wire pc_cntrl_enable = state == `WRITE_BACK;

wire [(`WIDTH - 1):0] reg_data_a;
wire [(`WIDTH - 1):0] reg_data_b;
wire [(`WIDTH - 1):0] reg_data_z = alu_data_z;

//==------------------------------------------------------------------------==//
// Decoding logic
//==------------------------------------------------------------------------==//

wire [(`WIDTH - 1):0] inst;

wire [4:0] opcode = inst[31:27];

wire is_mov    = opcode == `MOV;
wire is_branch = opcode == `BR;
wire is_cmp    = opcode == `CMP;
wire take_branch = is_branch && reg_data_a == 1'b1;

wire halted = opcode == `HALT;

// Branches read from predicate registers
wire a_regbank_sel = is_branch ? `P_REGS : `S_REGS;
wire b_regbank_sel = 0;
// Comparisons write to predicate registers
wire z_regbank_sel = is_cmp ? `P_REGS : `S_REGS;

wire has_large_imm = is_mov || is_branch;
// TODO: ALU instruction format bits?
wire is_alu_inst = (opcode == `ADD ||
                    opcode == `SUB ||
                    opcode == `MPY ||
                    opcode == `AND ||
                    opcode == `OR  ||
                    opcode == `XOR ||
                    opcode == `SHL ||
                    opcode == `SRL ||
                    opcode == `SRA);
wire has_small_imm = is_alu_inst && inst[26] == 1'b1;
wire is_b_sext = has_small_imm && inst[25] == 1'b1;

wire write_enable = state == `WRITE_BACK && !is_branch;

// TODO: Not always sign-extended???
wire [(`WIDTH - 1):0] alu_data_a = !has_large_imm ? reg_data_a
                                                  : {{16{inst[15]}}, inst[15:0] };
wire [(`WIDTH - 1):0] alu_data_b =
  has_large_imm ? 0
  : has_small_imm ?
      (!is_b_sext ? addr_b : {{27{addr_b[(`REG_SEL - 1)]}}, addr_b})
      : reg_data_b;

wire [(`WIDTH - 1):0] alu_data_z;

wire [(`REG_SEL - 1):0] addr_a = is_branch ? inst[19:16]
                                           : (has_large_imm ? 0 : inst[9:5]);
wire [(`REG_SEL - 1):0] addr_b = has_large_imm ? 0 : inst[4:0];
wire [(`REG_SEL - 1):0] addr_z = is_branch     ? 0 : inst[20:16];

wire [31:0] branch_addr = is_branch ? alu_data_a : 0;

wire [2:0] cc = is_cmp ? inst[12:10] : 0;

wire [31:0] pc;

//==------------------------------------------------------------------------==//
// Unit Instantiations
//==------------------------------------------------------------------------==//

instr_mem i
(
  .clk  (clk),
  .pc   (pc),
  .inst (inst)
);

pc_cntrl pc_cntrl
(
  .clk                (clk),
  .reset              (reset),
  .enable             (pc_cntrl_enable),
  .take_branch        (take_branch),
  .is_relative_branch (take_branch), // TODO: Absolute branches
  .branch_addr        (branch_addr),
  .pc_out             (pc)
);

alu a
(
  .opcode (opcode),
  .cc     (cc),
  .data_a (alu_data_a),
  .data_b (alu_data_b),
  .data_z (alu_data_z)
);

regbank regs
(
  .clk           (clk),
  .reset         (reset),
  .write_enable  (write_enable),
  .addr_a        (addr_a),
  .addr_b        (addr_b),
  .addr_z        (addr_z),
  .data_a        (reg_data_a),
  .data_b        (reg_data_b),
  .data_z        (reg_data_z),
  .a_regbank_sel (a_regbank_sel),
  .b_regbank_sel (b_regbank_sel),
  .z_regbank_sel (z_regbank_sel)
);

always @(posedge clk) begin
  if (!halted) begin
    state <= next_state;
    next_state <= next_state + 1;
  end
end

always @(posedge clk) begin
  case (state)
    `FETCH:
    begin
      // nothing
    end
    `DECODE:
    begin
      // nothing
    end
    `EXECUTE:
    begin
      // nothing
    end
    `WRITE_BACK:
    begin
      // nothing
    end
  endcase
end

endmodule // cpu
