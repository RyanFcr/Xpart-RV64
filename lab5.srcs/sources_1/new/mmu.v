`timescale 1ns / 1ps

module mmu(
    input clk,
    input memory_access_start, 
    input [63:0] va,
    input [63:0] satp,
    input [63:0] mem_pa, 
    output reg [2:0] cnt, 
    output [63:0] output_pa, 
    output reg mmu_stall 
);
    wire [8:0] vpn1,vpn2,vpn3;
    wire [19:0] temp;
    wire [31:0] ppn_base;
    reg [31:0]ppn;
    reg [63:0] pa;
    reg [31:0] temp_pa;
    
    assign vpn1=va[38:30];
    assign vpn2=va[29:21];
    assign vpn3=va[21:12];
    assign temp[19:0]=satp[19:0];
    assign ppn_base={temp[19:0],12'b0};
    
//    always @(negedge clk) begin
//        if (memory_access_start) begin
//            if(cnt==2'b00) begin
//                pa={32'b0, ppn_base+(vpn1<<3)};
//                cnt=2'b01;
//                mmu_stall = 1'b1; 
//            end
//            else if(cnt==2'b01) begin
//                temp_pa[31:0]={mem_pa[29:10],12'b0};
//                pa={32'b0,temp_pa+(vpn2<<3)};
//                cnt=2'b10;
//                mmu_stall = 1'b1; 
//            end
//            else if(cnt==2'b10) begin
//                temp_pa[31:0]={mem_pa[29:10],12'b0};
//                pa={32'b0,temp_pa+(vpn3<<3)};
//                cnt=2'b11;
//                mmu_stall = 1'b1; 
//            end
//            else if(cnt==2'b11) begin
//                pa={8'b0,mem_pa[53:10],va[11:0]};
//                cnt=2'b00;
//                mmu_stall = 1'b0; 
//            end
//            else cnt = 2'b00; 
//        end
//        else cnt = 2'b00; 
//    end

    always @(negedge clk) begin
        if (memory_access_start) begin
            if(cnt==3'b000) begin
                cnt=3'b001;
                mmu_stall = 1'b1; 
            end
            else if(cnt==3'b001) begin
                cnt=3'b010;
                mmu_stall = 1'b1; 
            end
            else if(cnt==3'b010) begin
                cnt=3'b011;
                mmu_stall = 1'b1; 
            end
            else if(cnt==3'b011) begin
                cnt=3'b100;
                mmu_stall = 1'b1; 
            end
            else if (cnt == 3'b100) begin 
                cnt = 3'b000; 
                mmu_stall = 1'b0;
            end
            else cnt = 3'b000; 
        end
        else cnt = 3'b000; 
    end
    
    always @(posedge clk) begin
        if (memory_access_start) begin 
            if (cnt == 3'b001) begin
                pa={32'b0, ppn_base+(vpn1<<3)};
            end
            else if (cnt == 3'b010) begin
                temp_pa[31:0]={mem_pa[29:10],12'b0};
                pa={32'b0,temp_pa+(vpn2<<3)};
            end
            else if (cnt == 3'b011) begin
                temp_pa[31:0]={mem_pa[29:10],12'b0};
                pa={32'b0,temp_pa+(vpn3<<3)};
            end
            else if (cnt == 3'b100) begin
                pa={8'b0,mem_pa[53:10],va[11:0]};
            end
        end
    end
    
    assign output_pa = pa; 
    
endmodule