`timescale 1ns / 1ps

module mmu(
    input clk,
    input memory_access_start, 
    input [63:0] va,
    input [63:0] satp,
    input [63:0] mem_pa, 
    output reg [2:0] cnt, 
    output [63:0] output_pa, 
    output reg mmu_stall,
    input process_switch, // 新增输入信号，表示进程切换
    input tlb_flush // 新增输入信号，表示强制刷新TLB 
);
    // TLB相关定义
    reg [63:0] tlb_vpn [15:0]; // 虚拟页号
    reg [63:0] tlb_ppn [15:0]; // 物理页号
    reg tlb_valid [15:0]; // 有效位

    wire [8:0] vpn1, vpn2, vpn3;
    wire [19:0] temp;
    wire [31:0] ppn_base;
    reg [31:0] ppn;
    reg [63:0] pa;
    reg [31:0] temp_pa;
    reg tlb_miss; // 表示TLB未命中
    integer i; // 用于循环
    
    assign vpn1=va[38:30];
    assign vpn2=va[29:21];
    assign vpn3=va[21:12];
    assign temp[19:0]=satp[19:0];
    assign ppn_base={temp[19:0],12'b0};
    
// 在时钟上升沿检查TLB
    always @(posedge clk) begin
        tlb_miss = 1;
        if (memory_access_start && !tlb_flush) begin
            for (i = 0; i < 16; i = i + 1) begin
                if (tlb_valid[i] && tlb_va[i][63:12] == va[63:12]) begin
                    // TLB命中
                    tlb_miss = 0;
                    pa = {tlb_pa[i][63:12], va[11:0]};
                    mmu_stall = 1'b0;
                    cnt = 3'b000;
                    break;
                end
            end
        end

        // TLB刷新
        if (process_switch || tlb_flush) begin
            for (i = 0; i < 16; i = i + 1) begin
                tlb_valid[i] = 0;
            end
        end
    end

    // 如果TLB未命中，则执行原有的MMU代码逻辑
    always @(negedge clk) begin
        if (memory_access_start && tlb_miss) begin
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
    end

    // 更新TLB
    always @(posedge clk) begin
        if (memory_access_start && cnt == 3'b100 && tlb_miss) begin
            // 寻找一个无效的TLB条目或替换一个现有的
            for (i = 0; i < 16; i = i + 1) begin
                if (!tlb_valid[i]) begin
                    tlb_va[i][63:12] = va[63:12];
                    tlb_pa[i][63:12] = pa[63:12];
                    tlb_valid[i] = 1;
                    break;
                end
            end
        end
    end

    assign output_pa = pa;


    
    
endmodule