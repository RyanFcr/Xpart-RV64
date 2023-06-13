`timescale 1ns / 1ps

module EX_MEM_reg(
    input clk, 
    input [31:0] imm_ID_EX, 
    input pc_change_ID_EX, 
    input [31:0] res_ID_EX,
    input [31:0] pc_ID_EX, 
    input [31:0] adderoutput_ID_EX, 
    input [31:0] inst_ID_EX, 
    input [1:0] pc_src_ID_EX, 
    input reg_write_ID_EX, 
    input [1:0] mem_to_reg_ID_EX, 
    input mem_write_ID_EX, 
    input [31:0] data2, 
    input [31:0] csr_out_ID_EX, 
    input csr_write_ID_EX, 
    input ecall_ID_EX, 
    input illegal_ID_EX, 
    output reg [31:0] res_EX_MEM, 
    output reg [31:0] pc_EX_MEM, 
    output reg [31:0] adderoutput_EX_MEM, 
    output reg [31:0] inst_EX_MEM, 
    output reg [1:0] pc_src_EX_MEM, 
    output reg reg_write_EX_MEM, 
    output reg [1:0] mem_to_reg_EX_MEM, 
    output reg mem_write_EX_MEM, 
    output reg [31:0] data_EX_MEM, 
    output reg pc_change_EX_MEM, 
    output reg [31:0] imm_EX_MEM, 
    output reg [31:0] csr_out_EX_MEM, 
    output reg csr_write_EX_MEM, 
    output reg ecall_EX_MEM, 
    output reg illegal_EX_MEM 
);

    always @(posedge clk) begin 
        res_EX_MEM = res_ID_EX; 
        pc_EX_MEM = pc_ID_EX; 
        adderoutput_EX_MEM = adderoutput_ID_EX; 
        inst_EX_MEM = inst_ID_EX; 
        pc_src_EX_MEM = pc_src_ID_EX; 
        reg_write_EX_MEM = reg_write_ID_EX; 
        mem_to_reg_EX_MEM = mem_to_reg_ID_EX; 
        mem_write_EX_MEM = mem_write_ID_EX;
        data_EX_MEM = data2; 
        pc_change_EX_MEM = pc_change_ID_EX; 
        imm_EX_MEM = imm_ID_EX; 
        csr_out_EX_MEM = csr_out_ID_EX; 
        csr_write_EX_MEM = csr_write_ID_EX; 
        ecall_EX_MEM = ecall_ID_EX;
        illegal_EX_MEM = illegal_ID_EX; 
    end 
    
endmodule
