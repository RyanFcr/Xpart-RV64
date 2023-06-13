`timescale 1ns / 1ps

module forwarding_unit(
    input [6:0] forwarding_op_code, 
    input forwarding_reg_write_EX_MEM, 
    input [4:0] forwarding_rd_EX_MEM, 
    input [4:0] forwarding_rs1_ID_EX, 
    input [4:0] forwarding_rs2_ID_EX, 
    input forwarding_reg_write_MEM_WB, 
    input [4:0] forwarding_rd_MEM_WB, 
    output reg [1:0] forwarding_a, 
    output reg [1:0] forwarding_b 
);
    
    always @(*) begin 
        forwarding_a = 2'b00; 
        forwarding_b = 2'b00; 
        
        if (forwarding_op_code == 7'b0110111 || forwarding_op_code == 7'b0010111 || forwarding_op_code == 7'b1101111) forwarding_a = 0; 
        else begin 
            if (forwarding_reg_write_EX_MEM && (forwarding_rd_EX_MEM != 5'b00000) && (forwarding_rd_EX_MEM == forwarding_rs1_ID_EX)) begin
                forwarding_a = 2'b10; 
            end
            else if (forwarding_reg_write_MEM_WB && (forwarding_rd_MEM_WB != 5'b00000) && (forwarding_rd_MEM_WB == forwarding_rs1_ID_EX)) begin
                forwarding_a = 2'b01;
            end
        end 
        
        if (forwarding_op_code == 7'b0110111 || forwarding_op_code == 7'b0010111 || forwarding_op_code == 7'b1101111 || forwarding_op_code == 7'b0010011) forwarding_b = 0; 
        else begin 
            if (forwarding_reg_write_EX_MEM && (forwarding_rd_EX_MEM != 5'b00000) && (forwarding_rd_EX_MEM == forwarding_rs2_ID_EX)) begin
                forwarding_b = 2'b10; 
            end
            else if (forwarding_reg_write_MEM_WB && (forwarding_rd_MEM_WB != 5'b00000) && (forwarding_rd_MEM_WB == forwarding_rs2_ID_EX)) begin
                forwarding_b = 2'b01; 
            end
        end 
        
    end    
    
endmodule
