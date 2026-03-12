interface dec_ex_if #(
    parameter WIDTH = 32
) (
    input logic clk
);

    logic [1:0]                 op;
    logic [$clog2(WIDTH)-1:0]   rd_addr;
    logic [WIDTH-1:0]           rs1_data, rs2_data;
    logic                       valid;
    logic                       stall;

    modport decode (
        input  clk, stall,
        output op, rd_addr, rs1_data, rs2_data, valid
    );

    modport execute (
        input  clk, op, rd_addr, rs1_data, rs2_data, valid,
        output stall
    );

    // TB drives: the instruction fields (standing in for fetch)
    // TB reads:  stall (to know if execute is busy)
    // #1step: sample stall just BEFORE posedge → read settled RTL value
    // #1:     drive outputs 1 unit AFTER posedge → DUT sees stable inputs
    clocking cb @(posedge clk);
        default input #1step output #1;
        output op, rd_addr, rs1_data, rs2_data, valid;
        input  stall;
    endclocking

    modport tb (clocking cb, input clk);

endinterface
