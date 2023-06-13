`timescale 1ns / 1ps

module Datapath(
    input clk, 
    input rst, 
    input [1:0] pc_src, 
    input reg_write, 
    input alu_src_b, 
    input branch, 
    input b_type, 
    input [3:0] alu_op, 
    input [1:0] mem_to_reg, 
    input [31:0] inst, 
    input [31:0] data_in, 
    input [4:0] debug_reg_addr, 
    output [31:0] addr_out, 
    output [31:0] data_out, 
    output [31:0] pc_out,
    output [31:0] debug_reg_addr_out 
 );
 
    reg pc_change; 
    reg [31:0] adderoutput;
    
    
    
    
    
    
    
    
    
    
    
endmodule
