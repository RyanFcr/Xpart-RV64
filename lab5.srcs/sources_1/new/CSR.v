`timescale 1ns / 1ps

module CSR(
    input clk,
    input rst,
    input ecall, 
    input illegal, 
    input we,
    input [11:0] csr_reg, 
    input [11:0] write_addr, 
    input [63:0] write_data,
    output reg [63:0] csr_out 
);

    reg [63:0] mtvec, mepc, mstatus, mcause; 
    
    always @(*) begin
        if (csr_reg == 12'h300) csr_out = mstatus; 
        else if (csr_reg == 12'h305) csr_out = mtvec; 
        else if (csr_reg == 12'h341) csr_out = mepc; 
        else if (csr_reg == 12'h342) csr_out = mcause; 
    end
    
    always @(negedge clk or posedge rst) begin
        if (rst == 1) begin
            mtvec = 0; 
            mepc = 0; 
            mstatus = 0; 
            mcause = 0; 
        end 
        else begin 
            if (we == 1) begin
                if (write_addr == 12'h300) mstatus = write_data; 
                else if (write_addr == 12'h305) mtvec = write_data; 
                else if (write_addr == 12'h341) mepc = write_data; 
                else if (csr_reg == 12'h342) mcause = write_data; 
            end 
            if (ecall == 1) mcause = 64'd11; 
            else if (illegal == 1) mcause = 64'd2; 
        end
    end 

endmodule
