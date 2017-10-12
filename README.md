Arch Nemesys
============

`nemesys` is a project that aims to implement a simple CPU, simulator, its
tooling, and its documentation, all by sharing as much code as possible.

The goal is to generate the ISA portions of the verilog RTL, simulator,
assembly parser, binary encoder, disassembler, and eventually compiler, all
from a single definition file: probably in LLVM's `TableGen` format. This is to
reduce the overhead of implementing or experimenting with new iterations of the
CPU.

It is also a learning exercise in implementing a CPU with a hardware
description language.

So far an extremely basic non-pipelined CPU has been implemented and nothing is
auto-generated. Everything is is a work-in-progress. In the mean time, check
out the documentation for the ever-evolving instruction set.
