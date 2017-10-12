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
`define REG_SEL $clog2(`NUM_REGS)
`define PRED_REG_SEL $clog2(`NUM_PRED_REGS)

`define S_REGS 1'b0
`define P_REGS 1'b1

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
`define HALT 5'd20

`define EQ  3'b000
`define NE  3'b001
`define LT  3'b010
`define LE  3'b011
`define ULT 3'b100
`define ULE 3'b101

`define  R0 5'd0
`define  R1 5'd1
`define  R2 5'd2
`define  R3 5'd3
`define  R4 5'd4
`define  R5 5'd5
`define  R6 5'd6
`define  R7 5'd7
`define  R8 5'd8
`define  R9 5'd9
`define R10 5'd10
`define R11 5'd11
`define R12 5'd12
`define R13 5'd13
`define R14 5'd14
`define R15 5'd15
`define R16 5'd16
`define R17 5'd17
`define R18 5'd18
`define R19 5'd19
`define R20 5'd20
`define R21 5'd21
`define R22 5'd22
`define R23 5'd23
`define R24 5'd24
`define R25 5'd25
`define R26 5'd26
`define R27 5'd27
`define R28 5'd28
`define R29 5'd29
`define R30 5'd30
`define R31 5'd31

`define P0 3'd0
`define P1 3'd1
`define P2 3'd2
`define P3 3'd3
`define P4 3'd4
`define P5 3'd5
`define P6 3'd6
`define P7 3'd7

`endif // _defines_vh_
