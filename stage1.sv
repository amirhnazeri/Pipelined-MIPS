`timescale 1ns/1ns

module Stage1(clk, rst,flush, load, PcPIn, InstIn, PcPOut, InstOut);
   input clk, rst, flush, load;
   input[15:0] PcPIn;
   input[31:0] InstIn;
   output reg[15:0] PcPOut;
   output reg[31:0] InstOut;

   always@(posedge clk, posedge rst) begin
      if(rst) begin
         PcPOut <= 16'b0;
         InstOut <= 16'b0;
      end
      else if(flush) begin
         PcPOut <= 16'b0;
         InstOut <= 16'b0;
      end
      else if(load) begin
         PcPOut <= PcPIn;
         InstOut <= InstIn;
      end
      else begin
         PcPOut <= PcPOut;
         InstOut <= InstOut;
      end
   end
endmodule
