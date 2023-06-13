`timescale 1ns / 1ps

module hazard_detection_unit(
    input hazard_mem_read_ID_EX, 
    input [4:0] hazard_rd_ID_EX, 
    input hazard_stall, 
    input [31:0] inst_IF_ID, 
    input pc_change, 
    output reg stall,
    output reg flush 
);

    reg [4:0] rs1_IF_ID, rs2_IF_ID;
    reg alu_src_b;  

    always @(*) begin 
        if (inst_IF_ID[6:0] == 7'b0010011 || inst_IF_ID[6:0] == 7'b0000011 || inst_IF_ID[6:0] == 7'b0100011) alu_src_b = 1;
        else alu_src_b = 0;
    
        rs1_IF_ID = inst_IF_ID[19:15]; 
        rs2_IF_ID = inst_IF_ID[24:20]; 
        
        //if (hazard_mem_read_ID_EX && ((hazard_rd_ID_EX == rs1_IF_ID) || ((hazard_rd_ID_EX == rs2_IF_ID) && (alu_src_b == 0)))) stall = 1; 
        //else stall = 0; 
        if (hazard_stall == 1) stall = 1; else stall = 0;  
        
        if (pc_change == 1) flush = 1; else flush = 0; 
    end
    

endmodule
