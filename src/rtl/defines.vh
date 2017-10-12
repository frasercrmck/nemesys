`ifndef _defines_vh_
`define _defines_vh_

`define FETCH      2'b00
`define DECODE     2'b01
`define EXECUTE    2'b10
`define WRITE_BACK 2'b11

`define WIDTH 32
`define BITSIZE 5

`define NUM_REGS 32
`define REG_SEL 5

`define ADD 0
`define SUB 1
`define MPY 2

`define AND 5
`define OR  6
`define XOR 7

`define SHL 10
`define SRL 11
`define SRA 12

`define CMP 13

`define MOV 15

`define BR 19

`define EQ  3'b000
`define NE  3'b001
`define LT  3'b010
`define LE  3'b011
`define ULT 3'b100
`define ULE 3'b101

`endif // _defines_vh_
