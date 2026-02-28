

## Lab 1: Design and verification of control-driven switching and arithmetic circuits using hierarchical VHDL modeling.

Q1: Design and implementation of a 2×2 digital switch using control-driven combinational logic.

Q2: Design and verification of a configurable 16-bit arithmetic circuit (add, subtract, increment, decrement) using multi-adder and single-adder architectures.

Q3: Design and verification of an 8-bit signed saturation adder with overflow detection and output clamping.

## Lab 2: Design and implementation of a sequence detection FSM using behavioral and structural VHDL modeling.
Q1 (Behavioral): Implementation of a Moore machine FSM that detects four consecutive identical inputs (four 1s or four 0s) using a process-based behavioral description with nine states (S0–S8), overlapping sequence detection, and synchronous clocked state transitions.

Q2 (Structural): Structural realization of the same FSM using one-hot state encoding, a bank of nine D flip-flops with asynchronous active-high reset, and explicit combinational next-state and output logic equations derived from the one-hot state variables.

## Lab 3: Modeling and simulation of memory components using behavioral VHDL.
Q1: Behavioral VHDL model of the 6116 2K×8 static CMOS RAM, implementing active-low chip select, output enable, and write enable control signals with accurate read/write timing (tAA = 45 ns, tWP = 25 ns) and tri-state bidirectional I/O.

Q2: Behavioral VHDL model of a 4 KB Extended Data Out (EDO) DRAM with multiplexed row/column addressing, RAS/CAS strobes, and an output latch that holds data valid after CAS deasserts — demonstrating the ~36% burst-read bandwidth improvement over standard Fast Page Mode DRAM.

Q3: Behavioral VHDL model of a 4 KB SDRAM with a Moore-type FSM controller implementing synchronous clocked operation, CAS latency of 2 clock cycles, byte-level write enables (nLBE), and a data transfer acknowledge signal (nDTACK).

Q4: Behavioral VHDL model of an arithmetic mean unit that reads 13 eight-bit samples from an internal register file, accumulates their sum over consecutive clock cycles, and computes the integer floor mean using a four-state FSM (IDLE → READ_SUM → DIVIDE → DONE) with start/ready handshaking.
