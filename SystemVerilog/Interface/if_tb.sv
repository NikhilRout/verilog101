module if_tb;

    localparam WIDTH = 32;

    logic clk = 0;
    always #5 clk = ~clk;

    dec_ex_if #(.WIDTH(WIDTH)) pipe (.clk(clk));

    logic [WIDTH-1:0] instr = '0;

    decode  #(.WIDTH(WIDTH)) u_dec (.pipe(pipe.decode), .instr(instr));
    execute #(.WIDTH(WIDTH)) u_ex  (.pipe(pipe.execute), .rd_data(), .rd_addr(), .rd_valid());

    // drives signals via clocking block, so no race conditions
    task send_instr(
        input logic [1:0]                op,
        input logic [$clog2(WIDTH)-1:0]  rd, rs1, rs2
    );
        pipe.cb.op       <= op;
        pipe.cb.rd_addr  <= rd;
        pipe.cb.rs1_data <= WIDTH'(rs1);
        pipe.cb.rs2_data <= WIDTH'(rs2);
        pipe.cb.valid    <= 1'b1;
        @(pipe.cb);                       // wait for next clock edge
        pipe.cb.valid    <= 1'b0;
    endtask

    initial begin
        pipe.cb.valid <= '0;
        repeat(2) @(pipe.cb);

        $display("-- ADD r3 = 10 + 5 --");
        send_instr(2'b00, 5'd3, 5'd10, 5'd5);

        @(pipe.cb iff !pipe.cb.stall);

        $display("-- SUB r4 = 5 - 10 --");
        send_instr(2'b01, 5'd4, 5'd5, 5'd10);

        repeat(3) @(pipe.cb);
        $finish;
    end

endmodule
