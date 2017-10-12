`ifndef _defines_vh_
`define _defines_vh_

`define FETCH      2'b00
`define DECODE     2'b01
`define EXECUTE    2'b10
`define WRITE_BACK 2'b11

`define WIDTH 32
`define BITSIZE 5

`define NUM_REGS 32
`define NUM_PRED_REGS 8
`define REG_SEL 5
`define PRED_REG_SEL 3

`define ADD 5'd0
`define SUB 5'd1
`define MPY 5'd2

`define AND 5'd5
`define OR  5'd6
`define XOR 5'd7

`define SHL 5'd10
`define SRL 5'd11
`define SRA 5'd12

`define CMP 5'd13

`define MOV 5'd15

`define BR  5'd19

`define EQ  3'b000
`define NE  3'b001
`define LT  3'b010
`define LE  3'b011
`define ULT 3'b100
`define ULE 3'b101

`endif // _defines_vh_
