`timescale 1ns/1ns

module Main(clk, rst, instMemory, regMem);
   input clk, rst;
   input reg [31:0] instMemory[0:65535];
   input reg [31:0] regMem[0:31];
   reg zero, Szero, PCWrite, IFIDWrite, normalS, PCSrcS, FlushS,
    CompBranchPrediction, jumpS;
   reg[8:0] sigT, SsigT, sigTFinal;
   reg[3:0] S2sigT;
   reg[1:0] S3sigT, frwrdASel, frwrdBSel;

   reg[15:0] PCIn, PCOut, PlussedPC, SPlussedPC, PCSrc1, SPCSrc1, S2PlussedPC, PrePCIn;
   reg[31:0] InstMemOut, SInstMemOut, regDataIn, regDataOut1, regDataOut2,
    extAdr, SregDataOut1, SregDataOut2, SextAdr;
   reg[31:0] aluSrcA, aluSrcB, aluOut, SaluOut, S2regDataOut2, dataMemOut, SdataMemOut,
    S2aluOut, aluSrcBb;
   reg[4:0] Sreg1, Sreg2, Sreg3, regDst, SregDst, S2regDst;

   PC pc(clk, rst, PCWrite, PCIn, PCOut);
   always@(instMemory[PCOut])begin
    InstMemOut = instMemory[PCOut];
  end
   always@(PCOut)begin
    PlussedPC = PCOut + 1;
  end
   always@(PCSrcS,PCSrc1,PlussedPC)begin
    PrePCIn = PCSrcS ? PCSrc1 : PlussedPC;
  end
   always@(jumpS,extAdr,PrePCIn)begin
    PCIn = jumpS ? extAdr : PrePCIn;
  end

   Stage1 stage1(clk, rst, FlushS, IFIDWrite, PlussedPC, InstMemOut,
    SPlussedPC, SInstMemOut);

   RegisterFile regFile(clk, rst, regMem, S3sigT[1], SInstMemOut[25:21],
                           SInstMemOut[20:16], S2regDst, regDataIn, regDataOut1, regDataOut2);
   always@(regDataOut1,regDataOut2)begin
    CompBranchPrediction = (regDataOut1 == regDataOut2);
  end
   Extend1632 extAddress(SInstMemOut[15:0], extAdr);
   always@(SPlussedPC,extAdr)begin
    PCSrc1 = SPlussedPC + extAdr;
  end
   Hazard hazard(SsigT[3], Sreg2, SInstMemOut[25:21], SInstMemOut[20:16],
    PCWrite, IFIDWrite, normalS);
   always@(normalS,sigT)begin
    sigTFinal = normalS ? sigT : 9'b0;
  end
   
   ControllerUnit cu(zero, SInstMemOut[31:26], SInstMemOut[5:0], sigT[8:6],
    sigT[5], sigT[4], sigT[3], sigT[2], sigT[1], sigT[0]);
    
   BranchPrediction branchPrediction(SInstMemOut[31:26], CompBranchPrediction,
    PCSrcS, FlushS, jumpS);
    
   Stage2 stage2(clk, rst, sigTFinal, SPlussedPC, regDataOut1, regDataOut2,
    extAdr, SInstMemOut[25:21], SInstMemOut[20:16], SInstMemOut[15:11],
                     SsigT, S2PlussedPC, SregDataOut1, SregDataOut2, SextAdr,
                      Sreg1, Sreg2, Sreg3);
   
   ForwardingUnit forwarding(Sreg1, Sreg2, S2sigT[1], SregDst, S3sigT[1], S2regDst, frwrdASel, frwrdBSel);

   always@(frwrdBSel,SregDataOut2,SaluOut,regDataIn)begin
    aluSrcBb = (frwrdBSel == 2'b00) ? SregDataOut2 : (frwrdBSel == 2'b01) ? SaluOut : regDataIn;
  end

   always@(SsigT[4],SextAdr,aluSrcBb)begin
    aluSrcB = SsigT[4] ? SextAdr : aluSrcBb;
  end

   always@(frwrdASel,SregDataOut1,SaluOut,regDataIn)begin
    aluSrcA = (frwrdASel == 2'b00) ? SregDataOut1: (frwrdASel == 2'b01) ? SaluOut : regDataIn;
  end

   ALU alu(SsigT[8:6], aluSrcA, aluSrcB, aluOut, zero);
   always@(SsigT[5],Sreg3,Sreg2)begin
    regDst = SsigT[5] ? Sreg3 : Sreg2;
  end

   
   Stage3 stage3(clk, rst, SsigT[3:0], zero, aluOut, SregDataOut2, regDst,
                     S2sigT, Szero, SaluOut, S2regDataOut2, SregDst);
   
   DataMemory dataMemory(clk, rst, S2sigT[2], SaluOut[15:0], S2regDataOut2, dataMemOut);

   Stage4 stage4(clk, rst, S2sigT[1:0], dataMemOut, SaluOut, SregDst,
                     S3sigT, SdataMemOut, S2aluOut, S2regDst);
   
   always@(S3sigT[0],SdataMemOut,S2aluOut)begin
    regDataIn = S3sigT[0] ? SdataMemOut : S2aluOut;
  end

endmodule
   


   



