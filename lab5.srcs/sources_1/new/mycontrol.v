`timescale 1ns / 1ps

module mycontrol(
    input stall, 
    input flush, 
    input ecall, 
    input mret, 
    input [11:0] csr_reg, 
    input [6:0] op_code, 
    input [2:0] funct3, 
    input [6:0] funct7, 
    output reg[1:0] pc_src, 
    output reg reg_write, 
    output reg alu_src_b, 
    output reg[3:0] alu_op, 
    output reg[1:0] mem_to_reg, 
    output reg mem_write, 
    output reg branch, 
    output reg[2:0] b_type, 
    output reg mem_read, 
    output reg csr_write, 
    output reg illegal 
);
    `include "AluOp.vh"

    always @(*) begin 
        if (stall || flush) begin
            mem_read = 0;
            pc_src = 0;
            reg_write = 0; 
            mem_to_reg = 0; 
            mem_write = 0; 
            branch = 0; 
        end 
        else begin
        
            if (op_code == 7'b0000011) mem_read = 1; else mem_read = 0; 
            
            if (op_code == 7'b1100111) pc_src = 2'b01; 
            else if (op_code == 7'b1101111 || op_code == 7'b1100011) pc_src = 2'b10;
            else pc_src = 2'b00; 
            
            if (op_code == 7'b0110011 || op_code == 7'b0010011 || op_code == 7'b0000011 || op_code == 7'b1101111 || op_code == 7'b1100111 || op_code == 7'b0110111 || op_code == 7'b0010111) reg_write = 1; 
            else if (op_code == 7'b1110011 && (funct3 == 3'b001 || funct3 == 3'b010 || funct3 == 3'b011 || funct3 == 3'b101 || funct3 == 3'b110 || funct3 == 3'b111)) reg_write = 1; 
            else reg_write = 0; 
            
            if (op_code == 7'b0010011 || op_code == 7'b0000011 || op_code == 7'b0100011 || op_code == 7'b0010111) alu_src_b = 1;
            else alu_src_b = 0;
            
            if (op_code == 7'b0110011) begin 
                if (funct3 == 3'b000 && funct7[5] == 0) alu_op = ADD;
                else if (funct3 == 3'b000 && funct7[5] == 1) alu_op = SUB;
                else if (funct3 == 3'b001) alu_op = SLL;
                else if (funct3 == 3'b010) alu_op = SLT;
                else if (funct3 == 3'b011) alu_op = SLTU;
                else if (funct3 == 3'b100) alu_op = XOR;
                else if (funct3 == 3'b101 && funct7[5] == 0) alu_op = SRL;
                else if (funct3 == 3'b101 && funct7[5] == 1) alu_op = SRA;
                else if (funct3 == 3'b110) alu_op = OR;
                else if (funct3 == 3'b111) alu_op = AND;
            end 
            else if (op_code == 7'b1100011) alu_op = SUB;
            else if (op_code == 7'b1110011) begin 
                if (funct3 == 3'b001 || funct3 == 3'b010) alu_op = ADD; 
                else if (funct3 == 3'b011 || funct3 == 3'b101) alu_op = OR; 
                else if (funct3 == 3'b110 || funct3 == 3'b111) alu_op = AND; 
            end 
            else if (op_code == 7'b0010011) begin 
                if (funct3 == 3'b000) alu_op = ADD; 
                else if (funct3 == 3'b001) alu_op = SLL;
                else if (funct3 == 3'b010) alu_op = SLT;
                else if (funct3 == 3'b011) alu_op = SLTU;
                else if (funct3 == 3'b100) alu_op = XOR;
                else if (funct3 == 3'b101 && funct7[5] == 0) alu_op = SRL;
                else if (funct3 == 3'b101 && funct7[5] == 1) alu_op = SRA;
                else if (funct3 == 3'b110) alu_op = OR;
                else if (funct3 == 3'b111) alu_op = AND;
             end
             else alu_op = ADD;
             
             if (op_code == 7'b0110011 || op_code == 7'b0010011 || op_code == 7'b0010111 || op_code == 7'b0100011) mem_to_reg = 2'b00; 
             else if (op_code == 7'b0110111) mem_to_reg = 2'b01;
             else if (op_code == 7'b1101111 || op_code == 7'b1100111) mem_to_reg = 2'b10; 
             else if (op_code == 7'b0000011) mem_to_reg = 2'b11;
             
             if (op_code == 7'b0100011) mem_write = 1; 
             else if (op_code == 7'b0000011) mem_write = 0;
             else mem_write = 0;
                     
             if (op_code == 7'b1100011) branch = 1; else branch = 0;
                     
             b_type = funct3; 
             
             if (op_code == 7'b1110011 && (funct3 == 3'b001 || funct3 == 3'b010 || funct3 == 3'b011 || funct3 == 3'b101 || funct3 == 3'b110 || funct3 == 3'b111)) csr_write = 1; 
             else csr_write = 0; 
            
            if (op_code == 7'b0110011) begin
                if (funct7 == 7'b0000000 || funct7 == 7'b0100000) illegal = 0; 
                else illegal = 1; 
            end
            else if (op_code == 7'b0010011) begin
                illegal = 0; 
            end 
            else if (op_code == 7'b0000011) begin
                if (funct3 == 3'b000 || funct3 == 3'b001 || funct3 == 3'b010 || funct3 == 3'b100 || funct3 == 3'b101) illegal = 0; 
                else illegal = 1; 
            end
            else if (op_code == 7'b0100011) begin 
                if (funct3 == 3'b000 || funct3 == 3'b001 || funct3 == 3'b010) illegal = 0; 
                else illegal = 1; 
            end 
            else if (op_code == 7'b1100011) begin 
                if (funct3 == 3'b010 || funct3 == 3'b011) illegal = 1; 
                else illegal = 0; 
            end
            else if (op_code == 7'b1101111 || op_code == 7'b0110111 || op_code == 7'b0010111) begin
                illegal = 0; 
            end
            else if (op_code == 7'b1100111) begin
                if (funct3 == 3'b000) illegal = 0; 
                else illegal = 1; 
            end 
            else if (op_code == 7'b1110011) begin
                if (ecall || mret) illegal = 0; 
                else begin
                    if (csr_reg == 12'h300 || csr_reg == 12'h305 || csr_reg == 12'h341 || csr_reg == 12'h342) illegal = 0; 
                    else illegal = 1; 
                end 
            end 
            else illegal = 1; 
        end 
    end
        
endmodule
