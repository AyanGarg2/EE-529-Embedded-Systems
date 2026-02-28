

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

## Lab 4: FPGA realization of arithmetic circuits and I/O interfacing on the Digilent Zybo Z7 board.
Q1: Dataflow VHDL model of a half adder synthesized and deployed on FPGA with slide switch inputs and LED outputs; RTL and technology schematics analyzed to observe CLB mapping of XOR and AND gates.

Q2: Structural VHDL model of a full adder built from two half adder instances connected with an OR gate for carry-out, verified through RTL schematic on FPGA.

Q3: Structural VHDL models of a 4-bit Ripple Carry Adder (four cascaded full adders, O(n) carry delay) and a 4-bit Carry Look-Ahead Adder (parallel generate/propagate logic, O(log n) carry delay); technology schematics compared to infer the speed-versus-area trade-off between the serial carry chain of the RCA and the wide two-level AND-OR network of the CLA.

Q4: FPGA implementation of a BCD-to-seven-segment decoder that maps a 4-bit slide switch input to the seven segment display (digits 0–F) connected via the PMOD JA header on the Zybo Z7, with all 16 output states verified on hardware.

Q5: Re-implementation of the half adder from Q1 using push button switches as inputs instead of slide switches, achieved solely through a constraint file pin reassignment with no change to VHDL logic.

Q6: Structural VHDL model of a 4-bit adder-subtractor built by extending the RCA from Q3 with per-bit XOR gates controlled by a mode signal M, implementing two's complement subtraction (A − B = A + B̄ + 1) with borrow detection as the complement of carry-out.
