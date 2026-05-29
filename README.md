# 12x12 Hybrid Multiplier

Verilog implementation of a 12x12-bit multiplier using a hybrid adder architecture combining Carry Save Adder (CSA) for the lower half and Carry Select Adder (CSLA) for the upper half, optimized for speed and power efficiency.

## Overview

A 12x12 multiplier generates 12 partial products which are summed using a hybrid adder strategy:

- **Lower half (CSA)** - Carry Save Adder avoids immediate carry propagation, reducing delay
- **Upper half (CSLA)** - Carry Select Adder precomputes results for both carry-in cases, improving speed

This hybrid approach balances speed, power, and area efficiency over traditional ripple carry or carry look-ahead designs.

## Modules

| Module | Description |
|---|---|
| `HybridArrayMul` | Top-level 12x12 multiplier |
| `CSA_nbit` | Parameterized N-bit Carry Save Adder |
| `CSelectA_M_N` | Parameterized Carry Select Adder |
| `RCA_nBit` | Parameterized Ripple Carry Adder |
| `FullAdder` | 1-bit Full Adder |
| `sumMUX` / `carryMUX` | MUX helpers for CSLA stage selection |
| `HybridArrayMul_tb` | Testbench |

## Tools Used

- **Verilog HDL** - RTL design
- **ModelSim** - Functional simulation and testbench verification
- **Quartus Prime** - Synthesis and synthesis report generation

## Simulation

Functional simulation was carried out in ModelSim using `HybridArrayMul_tb.v`. The testbench covers 6 test cases including small values, medium values, maximum values (4095 x 4095), zero operand, and random patterns.

## Synthesis

Synthesis was performed using Quartus Prime. The synthesis report includes resource utilization, and logic element usage for the hybrid multiplier design.
