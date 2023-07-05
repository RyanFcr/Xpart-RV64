`timescale 1ns / 1ps

module IF_ID_reg(
    input clk, 
    input [31:0] inst, 
    input [63:0] pc, 
    input stall, 
    input csr_stall, 
    input flush, 
    input [11:0] stored_address_IF, 
    input [63:0] stored_pc_IF, 
    input is_taken_IF, 
    input mmu_stall, 
    output reg[31:0] inst_IF_ID, 
    output reg[63:0] pc_IF_ID, 
    output reg[11:0] stored_address_IF_ID, 
    output reg[63:0] stored_pc_IF_ID, 
    output reg is_taken_IF_ID 
);

    always @(posedge clk) begin 
        if (stall || mmu_stall) begin 
            inst_IF_ID = inst_IF_ID; 
            pc_IF_ID = pc_IF_ID; 
            stored_address_IF_ID = stored_address_IF_ID; 
            stored_pc_IF_ID = stored_pc_IF_ID; 
            is_taken_IF_ID = is_taken_IF_ID; 
        end
        else if (flush || csr_stall) inst_IF_ID = 32'h00000013; 
        else begin 
            inst_IF_ID = inst; 
            pc_IF_ID = pc;
            if (inst_IF_ID == 32'h00000000) inst_IF_ID = 32'h00000013; 
            stored_address_IF_ID = stored_address_IF;
            stored_pc_IF_ID = stored_pc_IF;
            is_taken_IF_ID = is_taken_IF;
        end 
    end 
    
endmodule
