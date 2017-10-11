ISA
===

### ALU

#### Syntax

OP A, B, Z

#### Notes

OP is instruction opcode. Can be one of:

| Encoding | Mnemonic |
| -------- | -------- |
| 0        | add      |
| 1        | sub      |
| 2        | mpy      |
| 5        | and      |
| 6        | or       |
| 7        | xor      |
| 10       | shl      |
| 11       | sra      |
| 12       | srl      |

#### Encoding

OOOOOXXX|XXXZZZZZ|XXXXXXAA|AAABBBBB

### CMP

Integer comparisons. Not implemented.

#### Syntax

CMP A <CC> B, PZ

#### Notes

CC is the condition code, and PZ is a predicate register.

Possible alternative encoding: GE and GT can be achieved by re-rodering LT and
LE operands, respectively. Same goes for unsigned comparisons. In which case,
the 'N' bit is unused.

Comparison codes are: NE, EQ, LT, LE, ULT, ULE

| CC  |  C2 |  C1 |  C0 |
| --- | --- | --- | --- |
| NE  |  0  |  0  |  0  |
| EQ  |  0  |  0  |  1  |
| LT  |  0  |  1  |  0  |
| LE  |  0  |  1  |  1  |
| ULT |  1  |  0  |  0  |
| ULE |  1  |  0  |  1  |

Alternative verbose encoding; would allow use of GE, GT, UGE and UGT but costs
an extra bit and wastes more of them.

Comparison codes are: EQ, NE, LT, LE, GT, GE, ULT, ULE, UGT, UGE

| CC  |  N  |  C2 |  C1 |  C0 |
| --- | --- | --- | --- | --- |
| EQ  |  0  |  0  |  0  |  0  |
| LT  |  0  |  0  |  0  |  1  |
| LE  |  0  |  0  |  1  |  0  |
| ULT |  0  |  0  |  1  |  1  |
| ULE |  0  |  1  |  0  |  0  |
| XXX |  0  |  1  |  0  |  1  |
| XXX |  0  |  1  |  1  |  0  |
| XXX |  0  |  1  |  1  |  1  |
| NE  |  1  |  0  |  0  |  0  |
| GE  |  1  |  0  |  0  |  1  |
| GT  |  1  |  0  |  1  |  0  |
| UGE |  1  |  0  |  1  |  1  |
| UGT |  1  |  1  |  0  |  0  |
| XXX |  1  |  1  |  0  |  1  |
| XXX |  1  |  1  |  1  |  0  |
| XXX |  1  |  1  |  1  |  0  |

#### Encoding

OOOOOXXX|XXXZZZZZ|XXNCCCAA|AAABBBBB

### ALU SMALL_IMM

Not implemented

#### Encoding

OOOOOXXX|XXXZZZZZ|XXXXXXAA|AAAIIIII

### LARGE_IMM

#### Syntax

MOV #IMM, Z

#### Notes

Immediate field #IMM is currently always sign-extended to 32 bits.

#### Encoding

OOOOOXXX|XXXZZZZZ|IIIIIIII|IIIIIIII

### MEM

Not implemented

#### Encoding

OOOOOXXX|XXXXXXXX|XXXXXXXX|XXXXXXXX

### BRANCH

#### Syntax

BR #IMM

#### Notes

Branch target #IMM is relative offset.
Branch target #IMM is sign-extended to 32-bits
Branch is always taken

#### Encoding

OOOOOXXX|XXXXXXXX|IIIIIIII|IIIIIIII
