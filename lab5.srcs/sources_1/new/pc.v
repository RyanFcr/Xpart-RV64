`timescale 1ns / 1ps

module pc(
    input clk, 
    input rst, 
    input stall, 
    input pc_change,
    input csr_stall,  
    input is_taken, 
    input [63:0] target_address, 
    input [63:0] adderoutput, 
    output reg[63:0] curpc 
    );
    
    always @(posedge clk or posedge rst) begin 
        if (rst) curpc = 0; 
        else begin 
            if (pc_change == 1) curpc = adderoutput;
            else if (stall || csr_stall) curpc = curpc; 
            else if (is_taken) curpc = target_address; 
            else curpc = curpc + 4; 
        end 
    end 
    
endmodule
