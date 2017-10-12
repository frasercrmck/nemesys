ISA
===

### ALU

#### Syntax

```
OP A, B, Z
```

#### Notes

`OP` is the instruction opcode. Can be one of:

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
| 13       | cmp      |

#### Encoding

```
OOOOOXXX|XXXZZZZZ|XXXXXXAA|AAABBBBB
```

### CMP

Integer comparisons.

#### Syntax

```
CMP A <CC> B, PZ
```

#### Notes

`CC` is the condition code, and `PZ` is a predicate register.

Comparison codes are: `NE`, `EQ`, `LT`, `LE`, `ULT`, `ULE`

Codes `GE` and `GT` can be achieved by re-ordering the operands and using `LT`
and `LE` operands, respectively. Same goes for the corresponding unsigned
comparisons.


| CC  |  C2 |  C1 |  C0 |
| --- | --- | --- | --- |
| EQ  |  0  |  0  |  0  |
| NE  |  0  |  0  |  1  |
| LT  |  0  |  1  |  0  |
| LE  |  0  |  1  |  1  |
| ULT |  1  |  0  |  0  |
| ULE |  1  |  0  |  1  |

#### Encoding

```
OOOOOXXX|XXXZZZZZ|XXXCCCAA|AAABBBBB
```

### ALU SMALL_IMM

Not implemented

#### Encoding

```
OOOOOXXX|XXXZZZZZ|XXXXXXAA|AAAIIIII
```

### LARGE_IMM

#### Syntax

```
MOV #IMM, Z
```

#### Notes

Immediate field `#IMM` is currently always sign-extended to 32 bits.

#### Encoding

```
OOOOOXXX|XXXZZZZZ|IIIIIIII|IIIIIIII
```

### MEM

Not implemented

#### Encoding

```
OOOOOXXX|XXXXXXXX|XXXXXXXX|XXXXXXXX
```

### BRANCH

#### Syntax

```
BR PA, #IMM
```

#### Notes

Branch target `#IMM` is relative offset.
Branch target `#IMM` is sign-extended to 32-bits
Branch is taken if predicate `PA` is set to "true".

#### Encoding

```
OOOOOXXX|XXXXXPPP|IIIIIIII|IIIIIIII
```

### HALT

#### Syntax

```
HALT
```

#### Notes

Immediately halts the processor, pausing further execution.

#### Encoding

```
OOOOOXXX|XXXXXXXX|XXXXXXXX|XXXXXXXX
```
