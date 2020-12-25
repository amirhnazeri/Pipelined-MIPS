`timescale 1ns/1ns
module Stage2(clk, rst, sigI, data1, data2, data3, data4, data5, data6, data7, sigO, out1, out2, out3, out4, out5, out6, out7);
   input clk, rst;
   input[8:0] sigI;
   input[15:0] data1;
   input[31:0] data2, data3, data4;
   input[4:0] data5, data6, data7;
   output reg[8:0] sigO;
   output reg[15:0] out1;
   output reg[31:0] out2, out3, out4;
   output reg[4:0] out5, out6, out7;

   always@(posedge clk, posedge rst) begin
      if(rst) begin
         sigO <= 9'b0;
         out1 <= 16'b0;
         out2 <= 32'b0;
         out3 <= 32'b0;
         out4 <= 32'b0;
         out5 <= 5'b0;
         out6 <= 5'b0;
         out7 <= 5'b0;
      end
      else begin
         sigO <= sigI;
         out1 <= data1;
         out2 <= data2;
         out3 <= data3;
         out4 <= data4;
         out5 <= data5;
         out6 <= data6;
         out7 <= data7;
      end
   end
endmodule