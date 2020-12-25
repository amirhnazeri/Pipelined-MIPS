`timescale 1ns/1ns
module Stage3(clk, rst, sigI, data2, data3, data4, data5, sigO, out2, out3, out4, out5);
   input clk, rst, data2;
   input[4:0] sigI;
   input[31:0] data3, data4;
   input[4:0] data5;

   output reg[4:0] sigO;
   output reg out2;
   output reg[31:0] out3, out4;
   output reg[4:0] out5;

   always@(posedge clk, posedge rst) begin
      if(rst) begin
         sigO <= 5'b0;
         out2 <= 1'b0;
         out3 <= 32'b0;
         out4 <= 32'b0;
         out5 <= 5'b0;
      end
      else begin
         sigO <= sigI;
         out2 <= data2;
         out3 <= data3;
         out4 <= data4;
         out5 <= data5;
      end
   end
endmodule
