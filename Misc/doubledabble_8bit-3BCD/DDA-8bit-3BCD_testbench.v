module DDA_8Bit_3BCD_testbench;
  reg [7:0] in_8bit;
  wire [11:0] out_3BCD;
  DDA_8Bit_3BCD uut(.in_8bit(in_8bit), .out_3BCD(out_3BCD));
  initial begin
    $monitor("8-Bit Input: %b, BCD Output: %d%d%d", in_8bit, out_3BCD[11:8], out_3BCD[7:4], out_3BCD[3:0]);
    in_8bit = 8'b10101101;
    #100;
    $stop;
  end
endmodule
