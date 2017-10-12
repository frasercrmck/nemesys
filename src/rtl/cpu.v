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

wire [4:0] opcode;
wire [(`WIDTH - 1):0] inst;

wire is_branch, halted;
wire a_regbank_sel, b_regbank_sel, z_regbank_sel;

wire take_branch = is_branch && reg_data_a == 1'b1;

wire write_enable = state == `WRITE_BACK && !is_branch;

wire a_from_regbank, b_from_regbank;
wire [(`WIDTH - 1):0] a_data, b_data;

wire [(`WIDTH - 1):0] alu_data_z;
wire [(`REG_SEL - 1):0] addr_a, addr_b, addr_z;

wire [2:0] cc;
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

decoder d
(
  .inst           (inst),
  .opcode         (opcode),
  .is_branch      (is_branch),
  .halted         (halted),
  .cc             (cc),
  .a_regbank_sel  (a_regbank_sel),
  .a_from_regbank (a_from_regbank),
  .a_data         (a_data),
  .a_regbank_addr (addr_a),
  .b_regbank_sel  (b_regbank_sel),
  .b_from_regbank (b_from_regbank),
  .b_data         (b_data),
  .b_regbank_addr (addr_b),
  .z_regbank_sel  (z_regbank_sel),
  .z_regbank_addr (addr_z)
);

pc_cntrl pc_cntrl
(
  .clk                (clk),
  .reset              (reset),
  .enable             (pc_cntrl_enable),
  .take_branch        (take_branch),
  .is_relative_branch (take_branch), // TODO: Absolute branches
  .branch_addr        (a_data), // Branch addresses are taken from instruction
  .pc_out             (pc)
);

alu a
(
  .opcode (opcode),
  .cc     (cc),
  .data_a (a_from_regbank ? reg_data_a : a_data),
  .data_b (b_from_regbank ? reg_data_b : b_data),
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
