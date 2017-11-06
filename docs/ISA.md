ISA
===

### ALU

#### Syntax

```
OP rA, rB, rZ
OP rA, #I, rZ
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

If the `I` bit is set, operand `B` is treated as an immediate value. In which
case, bit `S` determines whether `B` is sign-extended (`1`) or zero-extended
(`0`) to 32-bits.

#### Encoding

```
OOOOOISX|XXXZZZZZ|XXXXXXAA|AAABBBBB
```

### CMP

Integer comparisons.

#### Syntax

```
CMP rA <CC> rB, pZ
CMP rA <CC> #I, pZ
```

#### Notes

Operand `B` may be treated as a signed- or unsigned-immediate with the same
mechanism as for other ALU instructions, above.

`CC` is the condition code, and `pZ` is a predicate register.

Comparison codes are: `NE`, `EQ`, `LT`, `LE`, `ULT`, `ULE`

Codes `GE` and `GT` can be achieved by re-ordering the operands and using `LT`
and `LE` operands, respectively. Same goes for the corresponding unsigned
comparisons. This doesn't currently work for immediate comparisons as the
immediate operands are always on the RHS.

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
OOOOOISX|XXXXXZZZ|XXXCCCAA|AAABBBBB
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
BR [!]pA, #IMM
```

#### Notes

* Branch target `#IMM` is relative offset.
* Branch target `#IMM` is sign-extended to 32-bits
* If bit `N` is not set, the branch is taken if predicate `pA` is set; if bit
  `N` is set, the branch is taken is `pA` is not set.

#### Encoding

```
OOOOOXXX|XXXXNPPP|IIIIIIII|IIIIIIII
```

### CALL

#### Syntax

```
CALL #IMM
```

#### Notes

* Call target `#IMM` is relative offset.
* Call target `#IMM` is sign-extended to 32-bits
* Sets the link register (`r31`) with PC + 1

#### Encoding

```
OOOOOXXX|XXXXXXXX|IIIIIIII|IIIIIIII
```

### RET

```
RET
```

#### Notes

Jumps to the contents of the link register (`r31`)

#### Encoding

```
OOOOOXXX|XXXXXXXX|XXXXXXXX|XXXXXXXX
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
