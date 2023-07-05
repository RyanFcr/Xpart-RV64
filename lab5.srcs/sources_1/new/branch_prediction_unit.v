`timescale 1ns / 1ps

module branch_prediction(
    input clk, 
    input branch, 
    input we, 
    input real_taken, //是否真的taken
    input [11:0] branch_address, //修改用的address
    input [63:0] branch_pc, //target的pc
    input [63:0] pc_out, 
    output reg [11:0] stored_address, 
    output reg [63:0] stored_pc, 
    output reg [63:0] target_address, 
    output reg is_taken //是否预测taken
);
    
    reg [63:0] BTB[0:16383];
    reg [1:0] BHT[0:16383]; 
    integer i;
    
    initial begin
        for (i = 0; i <= 16383; i = i + 1) begin 
            BHT[i] = 2'b00; 
        end
    end
    
    always @(*) begin 
        is_taken <= 0; 
        if (branch == 1'b1) begin
            stored_address <= pc_out[11:0];
            if (BHT[pc_out[11:0]] == 2'b10 || BHT[pc_out[11:0]] == 2'b11) begin
                stored_pc <= pc_out + 4;
                target_address <= BTB[pc_out[11:0]]; 
                is_taken <= 1; 
            end 
        end 
        else stored_address <= stored_address; 
    end 
    
    always @(negedge clk) begin 
        if (we == 1'b1) begin 
            if (real_taken == 1'b1) begin
                if (BHT[branch_address] == 2'b00) BHT[branch_address] <= 2'b01; 
                else if (BHT[branch_address] == 2'b01) begin 
                    BHT[branch_address] <= 2'b10; 
                    BTB[branch_address] <= branch_pc; 
                end 
                else if (BHT[branch_address] == 2'b10) BHT[branch_address] <= 2'b11;
                else BHT[branch_address] <= 2'b11;
            end
            else begin
                if (BHT[branch_address] == 2'b11) BHT[branch_address] <= 2'b10; 
                else if (BHT[branch_address] == 2'b10) BHT[branch_address] <= 2'b01; 
                else if (BHT[branch_address] == 2'b01) BHT[branch_address] <= 2'b00; 
                else BHT[branch_address] <= 2'b00; 
            end
        end
    end

endmodule
