`timescale 1ns / 1ps

module immgen(
    input [31:0] inst, 
    output [31:0] imm
);
    
    wire R_type, I_type, S_type, B_type, J_type, U_type, CSR_type; 
    assign R_type = (inst[6:0] == 7'b0110011);
    assign I_type = (inst[6:0] == 7'b0010011) || (inst[6:0] == 7'b0000011) || (inst[6:0] == 7'b1100111);
    assign S_type = (inst[6:0] == 7'b0100011);
    assign B_type = (inst[6:0] == 7'b1100011);
    assign J_type = (inst[6:0] == 7'b1101111); 
    assign U_type = (inst[6:0] == 7'b0110111) || (inst[6:0] == 7'b0010111);
    assign CSR_type = (inst[6:0] == 7'b1110011 && (inst[14:12] == 3'b001 || inst[14:12] == 3'b010 || inst[14:12] == 3'b011 || inst[14:12] == 3'b101 || inst[14:12] == 3'b110 || inst[14:12] == 3'b111));
        
    wire [31:0] I_imm, S_imm, B_imm, J_imm, U_imm, CSR_imm; 
    assign I_imm = {{20{inst[31]}}, inst[31:20]};
    assign S_imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
    assign B_imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8],1'b0};
    assign J_imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21],1'b0};
    assign U_imm = {inst[31:12], 12'b0};
    assign CSR_imm = {27'b0, inst[19:15]}; 
    assign imm = I_type ? I_imm : S_type ? S_imm : B_type ? B_imm : J_type ? J_imm : U_type ? U_imm : CSR_type ? CSR_imm : 32'b0;
    
endmodule
