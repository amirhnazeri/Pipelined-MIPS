`timescale 1ns/1ns
module BranchPrediction(opCode, compResult, PCSrcS, FlushS, jumpS);
   input[5:0] opCode;
   input compResult;
   output reg PCSrcS, FlushS, jumpS;
   
   always@(opCode, compResult) begin
      {PCSrcS, FlushS, jumpS} = 3'b000;
      if(opCode == 4 && compResult)
         {PCSrcS,FlushS} = 2'b11;
      else if(opCode == 5 && ~compResult)
         {PCSrcS,FlushS} = 2'b11;
      else if(opCode == 2)
         {jumpS,FlushS} = 2'b11;   
   end
endmodule
