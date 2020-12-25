module ForwardingUnit(id_ex_rs, id_ex_rt, ex_mem_regWrite, ex_mem_rd, mem_wb_regWrite, mem_wb_rd, fwA, fwB);
//rs ---> source 1
//rt ---> source 2
//rd ---> destination
input[4:0] id_ex_rs, id_ex_rt, ex_mem_rd, mem_wb_rd;
input ex_mem_regWrite, mem_wb_regWrite;
output reg[1:0] fwA, fwB;
reg cond1_s = 0, cond1_t = 0, cond2_s = 0, cond2_t = 0;

always@(id_ex_rs, id_ex_rt, ex_mem_regWrite, ex_mem_rd, mem_wb_regWrite, mem_wb_rd) begin
    {fwA, fwB} = 4'b0000;
    cond1_s = ex_mem_regWrite && ex_mem_rd == id_ex_rs && ex_mem_rd != 5'b00000;
    cond1_t = ex_mem_regWrite && ex_mem_rd == id_ex_rt && ex_mem_rd != 5'b00000;

    cond2_s = mem_wb_regWrite && mem_wb_rd == id_ex_rs && mem_wb_rd != 5'b00000;
    cond2_t = mem_wb_regWrite && mem_wb_rd == id_ex_rt && mem_wb_rd != 5'b00000;

    if(cond1_s) begin
        fwA = 2'b01;
    end
    if(cond1_t) begin
        fwB = 2'b01;
    end

    if(~cond1_s && cond2_s) begin
        fwA = 2'b10;
    end

    if(~cond1_t && cond2_t) begin
        fwB = 2'b10;
    end
end
endmodule