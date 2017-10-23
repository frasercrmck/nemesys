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

wire take_branch = (decoder.is_branch &&
                     (decoder.is_negated_branch && !regs.a_data[0] ||
                     !decoder.is_negated_branch &&  regs.a_data[0])) ||
                    decoder.is_call || decoder.is_ret;

wire write_enable = state == `WRITE_BACK && !decoder.is_branch;

//==------------------------------------------------------------------------==//
// Unit Instantiations
//==------------------------------------------------------------------------==//

instr_mem i
(
  .clk (clk),
  .pc  (pc_cntrl.pc_out)
);

decoder_unit decoder
(
  .inst (i.inst)
);

pc_cntrl pc_cntrl
(
  .clk                (clk),
  .reset              (reset),
  .enable             (pc_cntrl_enable),
  .take_branch        (take_branch),
  .is_relative_branch (!decoder.is_ret), // TODO: Absolute branches and calls
  .branch_addr        (decoder.is_ret ? regs.a_data : decoder.a_data) // Branch addresses are taken from instruction; returns from the link register
);

alu_unit alu
(
  .opcode (decoder.opcode),
  .cc     (decoder.cc),
  .a_data (decoder.a_from_regbank ? regs.a_data : decoder.a_data),
  .b_data (decoder.b_from_regbank ? regs.b_data : decoder.b_data)
);

regbank regs
(
  .clk            (clk),
  .reset          (reset),
  .write_enable   (write_enable),
  .a_regbank_addr (decoder.a_regbank_addr),
  .b_regbank_addr (decoder.b_regbank_addr),
  .z_regbank_addr (decoder.z_regbank_addr),
  .z_data         (decoder.is_call ? pc_cntrl.pc_out + 1 : alu.z_data),
  .a_regbank_sel  (decoder.a_regbank_sel),
  .b_regbank_sel  (decoder.b_regbank_sel),
  .z_regbank_sel  (decoder.z_regbank_sel)
);

always @(posedge clk) begin
  if (!decoder.halted) begin
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
