`timescale 1ns/1ns
module PC(clk, rst, PCWrite, parallelIn, out);
  input clk, rst, PCWrite;
  input[15:0] parallelIn;
  output reg[15:0] out;
  
  always@(posedge clk, posedge rst) begin
    if(rst) out <= 16'b0;
    else if(PCWrite) out <= parallelIn;
    else out <= out;
  end
endmodule