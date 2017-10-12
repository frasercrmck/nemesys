`include "defines.vh"

module alu_testbench;

reg [4:0]  opcode;
reg [31:0] data_a;
reg [31:0] data_b;

reg [2:0] cc;

initial begin
  $dumpfile("alu_tb.vcd");
  $dumpvars(0, alu_testbench);

  data_b = 1;

  #3
    opcode = `ADD;
    data_a = 1;
    data_b = 5;
  #4
    data_a = -5;
    data_b = 8;
  #4
    opcode = `SUB;
    data_a = 8;
    data_b = 3;
  #4
    data_a = 0;
  #4
    opcode = `MPY;
    data_a = 8;
    data_b = 7;
  #4
    opcode = `AND;
    data_a = 18;
    data_b = 7;
  #4
    opcode = `OR;
    data_a = 8;
    data_b = 1;
  #4
    opcode = `XOR;
    data_a = 9;
    data_b = 15;
  #4
    opcode = `SHL;
    data_a = 7;
    data_b = 3;
  #4
    data_a = -4;
    data_b = 2;
  #4
    opcode = `SRL;
    data_a = 34;
    data_b = 4;
  #4
    data_a = -200;
  #4
    opcode = `SRA;
    data_a = 34;
    data_b = 2;
  #4
    data_a = -200;
  #4
    data_b = 255;
  #4
    opcode = `CMP;
    cc = `EQ;
    data_a = 4;
    data_b = 5;
  #1
    data_a = -15;
    data_b = -15;
  #1
    data_a = -5;
    data_b = 0;
  #1
    data_a = 0;
    data_b = 0;
  #1
    cc = `NE;
    data_a = 6;
    data_b = -42;
  #1
    data_a = 0;
    data_b = 0;
  #1
    data_a = 128;
    data_b = 126;
  #1
    data_a = -5;
    data_b = -5;
  #1
    cc = `LT;
    data_a = 7;
    data_b = 6;
  #1
    data_a = 6;
    data_b = 7;
  #1
    data_a = -1;
    data_b = 88;
  #1
    data_a = -2;
    data_b = -9;
  #1
    data_a = 14;
    data_b = 14;
  #1
    cc = `LE;
    data_a = 7;
    data_b = 6;
  #1
    data_a = 6;
    data_b = 7;
  #1
    data_a = -1;
    data_b = 88;
  #1
    data_a = -2;
    data_b = -9;
  #1
    data_a = 14;
    data_b = 14;
  #1
    cc = `ULT;
    data_a = 5;
    data_b = 6;
  #1
    data_a = 6;
    data_b = 5;
  #1
    data_a = -1;
    data_b = 88;
  #1
    data_a = 100;
    data_b = -156;
  #1
    data_a = 5;
    data_b = 5;
  #1
    data_a = -99;
    data_b = -99;
  #1
    cc = `ULE;
    data_a = 5;
    data_b = 6;
  #1
    data_a = 6;
    data_b = 5;
  #1
    data_a = -1;
    data_b = 88;
  #1
    data_a = 100;
    data_b = -156;
  #1
    data_a = 5;
    data_b = 5;
  #1
    data_a = -99;
    data_b = -99;
  #20 $finish;
end

wire [31:0] data_out;

alu a(
  opcode,
  cc,
  data_a,
  data_b,
  data_out
);

endmodule // alu_testbench
