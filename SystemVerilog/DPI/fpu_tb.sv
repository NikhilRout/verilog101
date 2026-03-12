// fpu_tb.sv — Testbench: drives DUT, compares against C reference via DPI
//
// Key DPI testbench patterns demonstrated:
//   1. Calling imported C functions to get reference results
//   2. Bit-exact comparison of IEEE-754 results (no epsilon — DPI gives the
//      same bit pattern the RTL must produce for correct rounding)
//   3. $bitstoreal / $realtobits for human-readable display

`timescale 1ns/1ps

import fpu_dpi_pkg::*;   // brings in fpu_add, fpu_sub, fpu_mul, fpu_div

module fpu_tb;

    // ── Clock & reset ──
    logic clk = 0;
    always #5 clk = ~clk;   // 100 MHz

    logic rst_n;
    initial begin
        rst_n = 0;
        repeat(4) @(posedge clk);
        rst_n = 1;
    end

    // ── DUT instantiation ──
    logic        valid_in;
    logic [1:0]  opcode;
    logic [31:0] op_a, op_b;
    logic [31:0] dut_result;
    logic        valid_out;

    fpu_rtl dut (
        .clk       (clk),
        .rst_n     (rst_n),
        .valid_in  (valid_in),
        .opcode    (opcode),
        .operand_a (op_a),
        .operand_b (op_b),
        .result    (dut_result),
        .valid_out (valid_out)
    );

    // ── Test ──
    int pass_cnt = 0, fail_cnt = 0;
    task automatic run_op(
        input logic [1:0]  op,
        input logic [31:0] a,
        input logic [31:0] b
    );
        // DPI call looks exactly like a normal SV function call
        // simulator links to fpu.so at elaboration time
        logic [31:0] ref_result;

        case (op)
            2'b00: ref_result = fpu_add(a, b);
            2'b01: ref_result = fpu_sub(a, b);
            2'b10: ref_result = fpu_mul(a, b);
            2'b11: ref_result = fpu_div(a, b);
        endcase

        // Drive DUT
        @(posedge clk);
        valid_in <= 1'b1;
        opcode   <= op;
        op_a     <= a;
        op_b     <= b;

        @(posedge clk);
        valid_in <= 1'b0;

        // Wait for valid_out (1-cycle latency here)
        @(posedge clk iff valid_out);

        // Bit-exact comparision
        if (dut_result === ref_result) begin
            pass_cnt++;
            $display("[PASS] op=%0b  a=%h  b=%h  result=%h (%0f)",
                op, a, b, dut_result, $bitstoshortreal(dut_result));
        end else begin
            fail_cnt++;
            $display("[FAIL] op=%0b  a=%h  b=%h  dut=%h  ref=%h  (dut=%0f ref=%0f)",
                op, a, b, dut_result, ref_result, $bitstoshortreal(dut_result), $bitstoshortreal(ref_result));
        end
    endtask

    // Helper to convert real literal to its IEEE-754 SP bit pattern
    function automatic logic [31:0] f(real v);
        return $shortrealtobits(shortreal'(v));
    endfunction

    // ── Stimulus ──
    initial begin
        valid_in = 0; opcode = 0; op_a = 0; op_b = 0;

        @(posedge rst_n);
        repeat(2) @(posedge clk);

        $display("\n=== FPU DPI Testbench ===\n");

        // ADD tests
        run_op(2'b00, f(1.5),   f(2.5));    // 4.0
        run_op(2'b00, f(-3.0),  f(1.0));    // -2.0
        run_op(2'b00, f(0.1),   f(0.2));    // 0.3

        // SUB tests
        run_op(2'b01, f(5.0),   f(3.0));    // 2.0
        run_op(2'b01, f(1.0),   f(1.0));    // 0.0

        // MUL tests
        run_op(2'b10, f(2.0),   f(3.5));    // 7.0
        run_op(2'b10, f(-2.0),  f(4.0));    // -8.0

        // DIV tests
        run_op(2'b11, f(10.0),  f(4.0));    // 2.5
        run_op(2'b11, f(1.0),   f(0.0));    // +Inf (IEEE-754 div-by-zero)

        // Edge cases: denormals, overflow
        run_op(2'b10, 32'h00800000, 32'h3F800000);   // min normal * 1.0
        run_op(2'b00, 32'h7F7FFFFF, 32'h7F7FFFFF);   // max float + max float = +Inf

        repeat(4) @(posedge clk);
        $display("\n=== Results: %0d passed, %0d failed ===\n", pass_cnt, fail_cnt);
        $finish;
    end

    // Timeout
    initial begin
        #100000;
        $display("TIMEOUT");
        $finish;
    end

endmodule
