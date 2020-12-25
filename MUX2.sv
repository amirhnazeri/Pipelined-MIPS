`timescale 1ns/1ns
module MUX2(input[15:0] input0 ,input1,input sel,output [15:0] out);
  assign out = sel? input1 : input0;
endmodule

module MUX210(input[9:0] input0, input1,input sel,output [9:0] out);
  assign out = sel? input1 : input0;
endmodule
























module DataPath(input [19:0]x,y,input [8:0]count,input logic en,input clk,rst,input ldx,ldy,initsumxx,ldsumxy,initsumxy,initsumy,initsumx,ldsumx,ldsumy,ldsumxx,output logic[19:0]b0,b1);
  logic [39:0]sumxreg,sumyreg;
  logic [79:0]sumxyreg,sumxxreg;
  logic [19:0]xreg,yreg;
  wire [39:0]sumxwire,sumywire;
  wire [79:0]sumxywire,sumxxwire;
  wire [19:0]xwire,ywire;
  logic [179:0]ssxy,ssxx;
  logic [39:0]bb0,bb1;
  always@(posedge clk,posedge rst)begin
    if(rst) xreg <= 20'b0; else begin
      if(ldx) xreg <= x;
    end
  end
  always@(posedge clk,posedge rst)begin
    if(rst) yreg <= 20'b0; else begin
      if(ldy) yreg <= y;
    end
  end
  always@(posedge clk, posedge rst)begin
    if(rst|initsumx) sumxreg <= 40'b0; else if(ldsumx) sumxreg <= sumxwire;
  end
  always@(posedge clk, posedge rst)begin
    if(rst|initsumy) sumyreg <= 40'b0; else if(ldsumy) sumyreg <= sumywire;
  end
  always@(posedge clk, posedge rst)begin
    if(rst|initsumxx) sumxxreg <= 40'b0; else if(ldsumxx) sumxxreg <= sumxxwire;
  end
  always@(posedge clk, posedge rst)begin
    if(rst|initsumxy) sumxyreg <= 40'b0; else if(ldsumxy) sumxyreg <= sumxywire;
  end
  assign sumxwire= xreg + sumxreg;
  assign sumywire= yreg + sumyreg;
  assign sumxxwire = xreg*xreg + sumxxreg;
  assign sumxywire= xreg*yreg + sumxyreg;
  assign ssxy = sumxyreg - sumxreg*sumyreg/150;
  assign ssxx = sumxxreg - sumxreg*sumxreg/150;
  assign bb1 = (ssxy<<10)/ssxx;
  assign bb0 = sumyreg/150 - b1*sumxreg/(150*1024);
  assign b1 = bb1[19:0];
  assign b0 = bb0[19:0];
endmodule