module decode #(
    parameter WIDTH = 32
) (
    dec_ex_if.decode        pipe,
    input logic [WIDTH-1:0] instr
);

    always_ff @(posedge pipe.clk) begin
        if (!pipe.stall) begin
            pipe.op       <= instr[1:0];
            pipe.rd_addr  <= instr[6:2];
            pipe.rs1_data <= WIDTH'(instr[11:7]);  // toy example assume rs fields are imm
            pipe.rs2_data <= WIDTH'(instr[16:12]);
            pipe.valid    <= 1'b1;
        end
    end

endmodule