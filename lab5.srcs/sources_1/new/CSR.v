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
    output reg [63:0] csr_out, 
    output [63:0] satp_out
);

    reg [63:0] stvec, sepc, sstatus, scause, satp; 
    
    assign satp_out = satp; 
    
    always @(*) begin
        if (csr_reg == 12'h100) csr_out = sstatus; 
        else if (csr_reg == 12'h105) csr_out = stvec; 
        else if (csr_reg == 12'h141) csr_out = sepc; 
        else if (csr_reg == 12'h142) csr_out = scause;
        else if (csr_reg == 12'h180) csr_out = satp;   
    end
    
    always @(negedge clk or posedge rst) begin
        if (rst == 1) begin
            stvec = 0; 
            sepc = 0; 
            sstatus = 0; 
            scause = 0; 
            satp = 0; 
        end 
        else begin 
            if (we == 1) begin
                if (write_addr == 12'h100) sstatus = write_data; 
                else if (write_addr == 12'h105) stvec = write_data; 
                else if (write_addr == 12'h141) sepc = write_data; 
                else if (write_addr == 12'h142) scause = write_data; 
                else if (write_addr == 12'h180) satp = write_data; 
            end 
            if (ecall == 1) scause = 64'd11; 
            else if (illegal == 1) scause = 64'd2; 
        end
    end 

endmodule
