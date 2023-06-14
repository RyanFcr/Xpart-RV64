`timescale 1ns / 1ps

module ID_EX_reg(
    input clk, 
    input flush, 
    input stall, 
    input [63:0] rs1, 
    input [63:0] rs2, 
    input [31:0] inst, 
    input [31:0] pc_IF_ID, 
    input [1:0] pc_src_IF_ID, 
    input reg_write_IF_ID, 
    input alu_src_b_IF_ID, 
    input [3:0] alu_op_IF_ID, 
    input [1:0] mem_to_reg_IF_ID, 
    input mem_write_IF_ID, 
    input branch_IF_ID, 
    input [2:0] b_type_IF_ID, 
    input [63:0] imm_IF_ID, 
    input mem_read_IF_ID, 
    input csr_write_IF_ID, 
    input [63:0] csr_out_IF_ID, 
    input ecall_IF_ID, 
    input mret_IF_ID, 
    input illegal_IF_ID, 
    input [11:0] stored_address_IF_ID, 
    input is_taken_IF_ID, 
    input [63:0] stored_pc_IF_ID, 
    input [1:0] memoryAccessByte_IF_ID, 
    output reg [63:0] data1, 
    output reg [63:0] data2, 
    output reg [31:0] inst_ID_EX, 
    output reg [63:0] pc_ID_EX, 
    output reg [1:0] pc_src_ID_EX, 
    output reg reg_write_ID_EX, 
    output reg alu_src_b_ID_EX, 
    output reg [3:0] alu_op_ID_EX, 
    output reg [1:0] mem_to_reg_ID_EX, 
    output reg mem_write_ID_EX, 
    output reg branch_ID_EX, 
    output reg [2:0] b_type_ID_EX, 
    output reg [63:0] imm_ID_EX, 
    output reg mem_read_ID_EX, 
    output reg csr_write_ID_EX, 
    output reg [63:0] csr_out_ID_EX, 
    output reg ecall_ID_EX, 
    output reg mret_ID_EX, 
    output reg illegal_ID_EX, 
    output reg [11:0] stored_address_ID_EX, 
    output reg is_taken_ID_EX, 
    output reg [63:0] stored_pc_ID_EX, 
    output reg [1:0] memoryAccessByte_ID_EX 
);

    always @(posedge clk) begin 
        if (flush || stall) begin 
            inst_ID_EX = 32'h00000013; 
            reg_write_ID_EX = 0;
            mem_to_reg_ID_EX = 0;
            mem_write_ID_EX = 0; 
            mem_read_ID_EX = 0; 
            branch_ID_EX = 0; 
            pc_src_ID_EX = 0; 
            csr_write_ID_EX = 0; 
            ecall_ID_EX = 0;
            mret_ID_EX = 0; 
            illegal_ID_EX = 0; 
            is_taken_ID_EX = 0; 
        end 
        else begin 
            data1 = rs1; 
            data2 = rs2;
            inst_ID_EX = inst; 
            pc_ID_EX = pc_IF_ID; 
            pc_src_ID_EX = pc_src_IF_ID; 
            reg_write_ID_EX = reg_write_IF_ID; 
            alu_src_b_ID_EX = alu_src_b_IF_ID; 
            mem_to_reg_ID_EX = mem_to_reg_IF_ID; 
            mem_write_ID_EX = mem_write_IF_ID;
            branch_ID_EX = branch_IF_ID; 
            b_type_ID_EX = b_type_IF_ID; 
            imm_ID_EX = imm_IF_ID;
            alu_op_ID_EX = alu_op_IF_ID; 
            mem_read_ID_EX = mem_read_IF_ID; 
            csr_write_ID_EX = csr_write_IF_ID; 
            csr_out_ID_EX = csr_out_IF_ID; 
            ecall_ID_EX = ecall_IF_ID; 
            mret_ID_EX = mret_IF_ID; 
            illegal_ID_EX = illegal_IF_ID; 
            stored_address_ID_EX = stored_address_IF_ID; 
            is_taken_ID_EX = is_taken_IF_ID; 
            stored_pc_ID_EX = stored_pc_IF_ID; 
            memoryAccessByte_ID_EX = memoryAccessByte_IF_ID; 
        end 
    end 
    
endmodule
