`timescale 1ns / 1ps

module Core(
    input  wire            clk,
    input  wire            aresetn,
    input  wire            step,
    input  wire            debug_mode,
    input  wire  [4:0]     debug_reg_addr, // register address

    output wire [63:0]     address,
    output wire [63:0]     data_out,
    input  wire [63:0]     data_in,
    
    input  wire [63:0]     chip_debug_in,
    output wire [63:0]     chip_debug_out0,
    output wire [63:0]     chip_debug_out1,
    output wire [63:0]     chip_debug_out2,
    output wire [63:0]     chip_debug_out3 
);
    wire rst, mem_write, mem_clk, cpu_clk;
    wire [63:0] inst;
    wire [63:0] pc_out,core_data_in, addr_out, core_data_out,debug_reg_addr_out;
    reg  [63:0] clk_div;
    wire [1:0] memoryAccessByte; 
    
    assign rst = ~aresetn;
    SCPU cpu(
        .clk(cpu_clk),
        .rst(rst),
        .inst(inst),
        .data_in(core_data_in),      // data from data memory
        .debug_reg_addr(debug_reg_addr), 
        .addr_out(addr_out),         // data memory address
        .data_out(core_data_out),    // data to data memory
        .pc_out(pc_out),             // connect to instruction memory
        .mem_write(mem_write), 
        .debug_reg_addr_out(debug_reg_addr_out), 
        .memoryAccessByte(memoryAccessByte) 
    );
    
    always @(posedge clk) begin
        if(rst) clk_div <= 0;
        else clk_div <= clk_div + 1;
    end
    assign mem_clk = ~clk_div[0]; // 50mhz
    assign cpu_clk = debug_mode ? clk_div[0] : step;
    
    // TODO: ���� Instruction Memory
    Rom rom_unit (
        .a(pc_out >> 2),  // ��ַ����
        .spo(inst) // �������
    );
        
    // TODO: ���� Data Memory
    designed_ram my_ram_unit (
        .clka(mem_clk),  // ʱ��
        .wea(mem_write),   // �Ƿ�д������
        .addra(addr_out), // ��ַ���� 
        .dina(core_data_out),  // ��������
        .douta(core_data_in),  // �������
        .memoryAccessByte(memoryAccessByte) // byte length 
    );
    
    // TODO: ��� 64 λ���ԼĴ��������    
    assign chip_debug_out0 = pc_out;
    assign chip_debug_out1 = addr_out;
    assign chip_debug_out2 = debug_reg_addr_out;
    assign chip_debug_out3 = core_data_out;
endmodule