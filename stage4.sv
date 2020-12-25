`timescale 1ns/1ns
module Stage4(clk, rst, sigI, data1, data2, data3, sigO, out1, out2, out3);
   input clk, rst;
   input[1:0] sigI;
   input[31:0]data1, data2;
   input[4:0]data3;

   output reg[1:0] sigO;
   output reg[31:0]out1, out2;
   output reg[4:0]out3;

   always@(posedge clk, posedge rst) begin
      if(rst) begin
         sigO <= 2'b0;
         out1 <= 32'b0;
         out2 <= 32'b0;
         out3 <= 5'b0;
      end
      else begin
         sigO <= sigI;
         out1 <= data1;
         out2 <= data2;
         out3 <= data3;
      end
   end
endmodule
