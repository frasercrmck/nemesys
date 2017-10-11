OPCODES
=======

0  add
1  sub
2  mpy
3  XXX
4  XXX
5  and
6  or
7  xor
8  XXX
9  XXX
10 shl
11 sra
12 srl
13 XXX
14 cmp
15 mov

16 ld
17 st

19 br

INST FORMATS
============

ALU
ALU SMALL_IMM
ALU LARGE_IMM
BRANCH
MEM

ENCODINGS
=========

ALU
---

OOOOOXXX|XXXZZZZZ|XXXXXXAA|AAABBBBB

ALU SMALL_IMM
-------------

Not implemented

OOOOOXXX|XXXZZZZZ|XXXXXXAA|AAAIIIII

LARGE_IMM
---------

Currently always sign-extended to 32 bits

OOOOOXXX|XXXZZZZZ|IIIIIIII|IIIIIIII

MEM
---

Not implemented

OOOOOXXX|XXXXXXXX|XXXXXXXX|XXXXXXXX

BRANCH
------

Branch target is relative offset.
Branch target is sign-extended to 32-bits
Branch is always taken

OOOOOXXX|XXXXXXXX|IIIIIIII|IIIIIIII
