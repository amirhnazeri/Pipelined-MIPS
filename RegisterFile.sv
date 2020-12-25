`timescale 1ns/1ns

module RegisterFile(clk, rst,regMem, writeS, address1, address2, address3, writeData, data1, data2);
   input clk, rst, writeS;
   input reg [31:0] regMem[0:31];
   input[4:0] address1, address2, address3;
   input[31:0] writeData;
   output reg [31:0] data1, data2;
   
   reg[31:0] memory[0:31];
   integer i;
   always@(negedge clk, posedge rst) begin
      if(rst) begin
         for(i=0; i<32; i=i+1) memory[i] <= regMem[i];
      end
      else if(writeS && address3 != 5'b00000) memory[address3] <= writeData;
   end
   always@(memory[address1])begin
    data1 = memory[address1];
  end
   always@(memory[address2])begin
    data2 = memory[address2];
  end
endmodule
