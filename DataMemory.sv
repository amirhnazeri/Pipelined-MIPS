`timescale 1ns/1ns

module DataMemory(clk, rst, writeS, address, dataIn, dataOut);
  input clk, rst, writeS;
  input[15:0] address;
  input[31:0] dataIn;
  output reg [31:0] dataOut;
  
  reg[31:0]memory[0:65535];
  integer i;
  always@(posedge clk, posedge rst) begin
    if(rst) begin
      for(i=0; i< 65536; i=i+1) memory[i] <= 32'b0;
    end
    else if(writeS) memory[address] <= dataIn;
  end
  always@(memory[address])begin
   dataOut = memory[address];
 end
endmodule
