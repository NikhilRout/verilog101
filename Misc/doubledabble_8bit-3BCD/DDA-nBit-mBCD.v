module DDA_nBit_mBCD #(parameter N = 12, M = 16)( //N must be a multiple of 4
  input [N-1:0] in_nBit,
  output [M-1:0] out_mBCD
);
  integer i, j;
  reg [N+M-1:0] shift_reg;
  always @(*) begin
    shift_reg[N-1:0] = in_nBit;
    shift_reg[N+M-1:N] = 0;
    for(i = 0; i<N; i= i+1) begin
      for(j = N; j<(N+M-4); j = j+4) begin
        if(shift_reg[j+:4] > 4)
          shift_reg[j+:4] = shift_reg[j+:4] + 3;
      end
      shift_reg = shift_reg << 1;
    end
  end
  assign out_mBCD = shift_reg[M+N-1:N];
endmodule
