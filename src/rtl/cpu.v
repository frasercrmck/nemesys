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

//==------------------------------------------------------------------------==//
// Decoding logic
//==------------------------------------------------------------------------==//

wire take_branch = d.is_branch && regs.data_a == 1'b1;

wire write_enable = state == `WRITE_BACK && !d.is_branch;

//==------------------------------------------------------------------------==//
// Unit Instantiations
//==------------------------------------------------------------------------==//

instr_mem i
(
  .clk  (clk),
  .pc   (pc_cntrl.pc_out)
);

decoder d
(
  .inst           (i.inst),
  .is_branch      (is_branch)
);

pc_cntrl pc_cntrl
(
  .clk                (clk),
  .reset              (reset),
  .enable             (pc_cntrl_enable),
  .take_branch        (take_branch),
  .is_relative_branch (take_branch), // TODO: Absolute branches
  .branch_addr        (d.a_data) // Branch addresses are taken from instruction
);

alu a
(
  .opcode (d.opcode),
  .cc     (d.cc),
  .data_a (d.a_from_regbank ? regs.data_a : d.a_data),
  .data_b (d.b_from_regbank ? regs.data_b : d.b_data)
);

regbank regs
(
  .clk           (clk),
  .reset         (reset),
  .write_enable  (write_enable),
  .addr_a        (d.a_regbank_addr),
  .addr_b        (d.b_regbank_addr),
  .addr_z        (d.z_regbank_addr),
  .data_z        (a.data_z),
  .a_regbank_sel (d.a_regbank_sel),
  .b_regbank_sel (d.b_regbank_sel),
  .z_regbank_sel (d.z_regbank_sel)
);

always @(posedge clk) begin
  if (!d.halted) begin
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
