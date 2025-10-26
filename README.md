# verilog101
Verilog/SystemVerilog implementations of fundamental combinational and sequential circuits (with testbenches)

## About
Starting out with Verilog during my first digital systems design class, I couldn't find a comprehensive Verilog guide with multiple examples all in one resource. So I decided to create this reference repository consolidating all my Verilog code as I progressed in class and my own study. It includes the dataflow, structural, and behavioral modeling of Verilog code for a broad range of fundamental combinational and sequential circuits, complete with corresponding testbenches.

Update: I've also added some more parameterized advanced circuits from a FPGA System Design class I took.

## Projects (Combinational)
### Adders and Subtractors
1. Half Adder
2. Full Adder
3. Half Subtractor
4. Full Subtractor
5. Ripple Carry Adder
### Advanced Adders
1. Carry Look Ahead Adder
2. Carry Save Adder
3. Carry Select Adder
4. Combined Adder Subtractor
5. Serial Adder using FSM
### Decoders/Encoders
1. Decoder (2:4)
2. Decoder (3:8)
3. Encoder (4:2)
4. Encoder (Octal:Binary)
6. Priority Encoder (4:2)
### Multiplexers/Demultiplexers
1. Multiplexer (4:1)
2. Demultiplexer (1:8)
### Multipliers
1. Array Multiplier
2. Booth Multiplier
3. LUT Multiplier 
### Misc
1. Basic Gates
2. Magnitude Comparator
3. Binary to Gray Code
4. Gray Code to Binary
5. Tri-State Buffers
6. Sign-Extender(9 to 16)
7. Switch-Level-Modeled Basic Gates
8. Reversible Full Adder
9. Parity Gen/Check

## Projects (Sequential)
### Latches
1. SR Latch
2. D Latch
### Flip-Flops
1. SR Flip-FLop
2. D Flip-Flop
3. JK Flip-Flop
4. T Flip-Flop
### Registers
1. SISO
2. SIPO
3. PISO
4. PIPO
### Counters
1. Asynchronous Counter
2. Synchronous Counter
3. Ring Counter
4. Johnson Counter
5. Gray Counter
### Finite State Machines
1. FSM Examples
2. Moore Sequence Detector
3. Mealy Sequence Detector
### Memory
1. ROM
2. RAM
3. FIFO

## Random Notes
### Choosing modeling style
• Boolean Expression &rarr; Dataflow\
• Logic Diagram &rarr; Structural\
• Truth Table &rarr; Behavioral
### EDAPlayground Settings
[EDAPlayground](http://www.edaplayground.com) is an application that includes an online IDE to simulate Verilog programs and a community project hub\
• Compiler: Icarus Verilog 0.9.7  
• To open EPWave after run, include the lines ```$dumpfile("dump.vcd"); $dumpvars;``` at the start of the testbenches' inital block
### Errors/Updates/Contact
<p align="left">
    <a href="https://discordapp.com/users/705711221780905995">
    <img src="https://img.shields.io/badge/Discord-blue?style=for-the-badge&logo=discord&logoColor=white&color=black"></a>
    <a href="mailto:nikhilrout97@gmail.com">
    <img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white"></a>
    <a href="https://www.linkedin.com/in/nikhil-rout">
    <img src="https://img.shields.io/badge/LinkedIn-white?style=for-the-badge&logo=linkedin&logoColor=blue"></a>
</p>
