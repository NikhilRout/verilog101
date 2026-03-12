// fpu_rtl.sv — Toy single-precision FPU RTL (the DUT)
// wrong on purpose to demonstrate DPI golden model testing

module fpu_rtl (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        valid_in,
    input  logic [1:0]  opcode,
    input  logic [31:0] operand_a,   // IEEE-754 SP
    input  logic [31:0] operand_b,   // IEEE-754 SP
    output logic [31:0] result,      // IEEE-754 SP
    output logic        valid_out
);

    logic [31:0] comb_result;

    always_comb begin
        case (opcode)
            2'b00:   comb_result = operand_a + operand_b;  // integer ADD
            2'b01:   comb_result = operand_a - operand_b;  // integer SUB
            2'b10:   comb_result = operand_a * operand_b;  // integer MUL
            2'b11:   comb_result = operand_a / operand_b;  // integer DIV
            default: comb_result = '0;
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result    <= '0;
            valid_out <= 1'b0;
        end else begin
            result    <= comb_result;
            valid_out <= valid_in;
        end
    end

endmodule
