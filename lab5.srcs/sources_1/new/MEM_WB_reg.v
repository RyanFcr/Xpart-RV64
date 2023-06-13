`timescale 1ns / 1ps

module MEM_WB_reg(
    input clk, 
    input [31:0] pc_EX_MEM, 
    input [31:0] imm_EX_MEM, 
    input [31:0] res_EX_MEM, 
    input [31:0] data_in, 
    input [1:0] mem_to_reg_EX_MEM, 
    input [31:0] pc_src_EX_MEM, 
    input [31:0] inst_EX_MEM, 
    input reg_write_EX_MEM, 
    input [31:0] csr_out_EX_MEM, 
    input csr_write_EX_MEM, 
    input ecall_EX_MEM, 
    input illegal_EX_MEM, 
    output reg [31:0] res_MEM_WB, 
    output reg [31:0] data_in_MEM_WB, 
    output reg [1:0] mem_to_reg_MEM_WB, 
    output reg [31:0] pc_src_MEM_WB, 
    output reg [31:0] inst_MEM_WB, 
    output reg reg_write_MEM_WB, 
    output reg [31:0] imm_MEM_WB, 
    output reg [31:0] pc_MEM_WB, 
    output reg [31:0] csr_out_MEM_WB, 
    output reg csr_write_MEM_WB, 
    output reg ecall_MEM_WB, 
    output reg illegal_MEM_WB 
);
    
    always @(posedge clk) begin 
        res_MEM_WB = res_EX_MEM; 
        data_in_MEM_WB = data_in; 
        mem_to_reg_MEM_WB = mem_to_reg_EX_MEM;
        pc_src_MEM_WB = pc_src_EX_MEM;
        inst_MEM_WB = inst_EX_MEM;
        reg_write_MEM_WB = reg_write_EX_MEM; 
        imm_MEM_WB = imm_EX_MEM; 
        pc_MEM_WB = pc_EX_MEM; 
        csr_out_MEM_WB = csr_out_EX_MEM; 
        csr_write_MEM_WB = csr_write_EX_MEM; 
        ecall_MEM_WB = ecall_EX_MEM; 
        illegal_MEM_WB = illegal_EX_MEM; 
    end 
    
endmodule
