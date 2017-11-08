Verilog
-------

- [x] predicates
- [x] comparisons
- [x] conditional branches
- [x] "small immediate" encodings
- [x] halting
- [x] comparisons w/ immediates
- [ ] reversible immediates: can't currently rA >= #imm, as #imm is always 'B'
- [ ] add/sub with carry
- [x] mov immediate hi/lo 16-bits
- [x] branch when predicate false
- [x] link register
- [x] call/return instructions
- [ ] conditional call/return instructions
- [ ] branch to register
- [ ] encode ret as branch-to-register (???)
- [ ] memory instructions
- [ ] select instructions
- [ ] remove hard-coded numbers; be as generic as possible

Misc
----

- [x] put testbenches into own directory

Software
--------

- [ ] simple LLVM TableGen description files
- [ ] assembly parser/printer
- [ ] object emitter
- [ ] simulator
