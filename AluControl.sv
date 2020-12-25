module AluController(input [7:0] funct,input [2:0] aluOP,output reg[2:0] aluControl);
  parameter[3:0] need_add = 0, need_sub = 1, need_and = 2, need_or = 3, need_func = 4, need_xor = 5, need_mult = 6,need_mfhi = 7, need_mflo =8;
  parameter[3:0] xor_ = 0, add = 1, sub2 = 2, and_ = 3, or_ = 4, not_ = 5, slt = 6, sub1 = 7 , mult=8, mflo=9, mfhi=10;
  always@(funct, aluOP) begin
    case(aluOP)
      need_add:begin  
        aluControl = add;
      end
      need_sub:begin 
        aluControl = sub2;
      end
      need_and:begin
        aluControl = and_;
      end
      need_or:begin
        aluControl = or_;
      end
      need_xor:begin
        aluControl = xor_;
      end
      need_mult:begin  
        aluControl = mult;
      end
      need_mfhi:begin
        aluControl = mfhi;
      end
      need_mflo:begin
        aluControl = mflo;
      end
      need_func: begin
        if(funct == 8'b 00000001)
          aluControl = xor_;
        else if(funct == 8'b 00000010)
          aluControl = add;
        else if(funct == 8'b 00000100)
          aluControl = sub1;
        else if(funct == 8'b 00001000)
          aluControl = and_;
        else if(funct == 8'b 00010000)
          aluControl = or_;
        else if(funct == 8'b 00100000)
          aluControl = not_;
        else if(funct == 8'b 01000000)
          aluControl = slt;
        else if(funct == 8'b 10000000)
          aluControl = mult;
        else if(funct == 8'b 00000011)
          aluControl = mfhi;
        else if(funct == 8'b 01000111)
          aluControl = mflo;
      end
    endcase
  end
endmodule
