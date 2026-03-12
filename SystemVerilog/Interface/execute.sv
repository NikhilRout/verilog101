module execute #(
    parameter WIDTH = 32
) (
    dec_ex_if.execute                pipe,
    output logic [WIDTH-1:0]         rd_data,
    output logic [$clog2(WIDTH)-1:0] rd_addr,
    output logic                     rd_valid
);

    always_ff @(posedge pipe.clk) begin
        rd_valid   <= '0;
        pipe.stall <= '0;

        if (pipe.valid) begin
            rd_addr  <= pipe.rd_addr;
            rd_valid <= '1;
            // opcodes: 2'b00=ADD, 2'b01=SUB, 2'b10=AND, 2'b11=OR
            case (pipe.op)
                2'b00: rd_data <= pipe.rs1_data + pipe.rs2_data;
                2'b01: rd_data <= pipe.rs1_data - pipe.rs2_data;
                2'b10: rd_data <= pipe.rs1_data & pipe.rs2_data;
                2'b11: rd_data <= pipe.rs1_data | pipe.rs2_data;
            endcase
        end
    end

endmodule