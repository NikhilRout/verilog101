module DDA_8Bit_3BCD(
  input [7:0] in_8bit,
  output [11:0] out_3BCD
);
  integer i;
  reg [19:0] shift_reg;
  always @(*) begin
    shift_reg[7:0] = in_8bit;
    shift_reg[19:8] = 0;
    for (i = 0; i<8; i=i+1) begin
      if(shift_reg[11:8] > 4)
        shift_reg[11:8] = shift_reg[11:8] + 3;
      if(shift_reg[15:12] > 4)
        shift_reg[15:12] = shift_reg[15:12] + 3;
      if(shift_reg[19:16] > 4)
        shift_reg[19:16] = shift_reg[19:16] + 3;
      shift_reg = shift_reg << 1;
    end
   end
   assign out_3BCD = shift_reg[19:8];
endmodule
