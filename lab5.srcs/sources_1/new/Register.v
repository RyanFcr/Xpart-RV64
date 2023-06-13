`timescale 1ns / 1ps

module Regs (
    input clk,
    input rst,
    input we,
    input [4:0] debug_reg_addr, 
    input [4:0] read_addr_1,
    input [4:0] read_addr_2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data_1,
    output [31:0] read_data_2, 
    output [31:0] debug_reg_addr_out
);

    integer i;
    reg [31:0] register [1:31]; // x1 - x31, x0 keeps zero
    
    assign read_data_1 = (read_addr_1 == 0) ? 0 : register[read_addr_1]; // read
    assign read_data_2 = (read_addr_2 == 0) ? 0 : register[read_addr_2]; // read
    assign debug_reg_addr_out = (debug_reg_addr == 0) ? 0 : register[debug_reg_addr];

    always @(negedge clk or posedge rst) begin //double bump 
        if (rst == 1) for (i = 1; i < 32; i = i + 1) register[i] <= 0; // reset
        else if (we == 1 && write_addr != 0) register[write_addr] <= write_data;
    end

endmodule
