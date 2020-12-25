`timescale 1ns/1ns
module ALU(aluControl, input1, input2, aluOUT, zero);
  input [2:0]aluControl;
  input signed [31:0] input1;
  input signed [31:0] input2;
  output reg [31:0] aluOUT;
  output reg zero;
  parameter[2:0] add_ = 0, sub_ = 1, and_ = 2, or_ = 3, lt_ = 4, xor_ = 5;

  always@(input1, input2, aluControl) begin
    case(aluControl)
    add_: aluOUT = input1 + input2;
    sub_: aluOUT = input1 - input2;
    and_: aluOUT = input1 & input2;
    or_: aluOUT = input1 | input2;
    lt_: aluOUT = (input1 < input2) ? {31'b0, 1'b1} : 32'b0;
    xor_: aluOUT = input1 ^ input2;
    default: aluOUT = input1;
    endcase
  end

  assign zero = !aluOUT? 1'b1 : 1'b0;
endmodule