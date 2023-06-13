`timescale 1ns / 1ps

module Core(
    input  wire        clk,
    input  wire        aresetn,
    input  wire        step,
    input  wire        debug_mode,
    input  wire [4:0]  debug_reg_addr, // register address

    output wire [31:0] address,
    output wire [31:0] data_out,
    input  wire [31:0] data_in,
    
    input  wire [31:0] chip_debug_in,
    output wire [31:0] chip_debug_out0,
    output wire [31:0] chip_debug_out1,
    output wire [31:0] chip_debug_out2,
    output wire [31:0] chip_debug_out3 
);
    wire rst, mem_write, mem_clk, cpu_clk;
    wire [31:0] inst, core_data_in, addr_out, core_data_out, pc_out, debug_reg_addr_out;
    reg  [31:0] clk_div;
    
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
        .debug_reg_addr_out(debug_reg_addr_out) 
    );
    
    always @(posedge clk) begin
        if(rst) clk_div <= 0;
        else clk_div <= clk_div + 1;
    end
    assign mem_clk = ~clk_div[0]; // 50mhz
    assign cpu_clk = debug_mode ? clk_div[0] : step;
    
    // TODO: 连接Instruction Memory
    Rom rom_unit (
        .a(pc_out >> 2),  // 地址输入
        .spo(inst) // 读数据输�?
    );
    /*
    myRom rom_unit(
        .address(pc_out[12:2]),
        .out(inst)
    );
    */
        
    // TODO: 连接Data Memory
    Ram ram_unit (
        .clka(mem_clk),  // 时钟
        .wea(mem_write),   // 是否写数�?
        .addra(addr_out), // 地址输入 
        .dina(core_data_out),  // 写数据输�?
        .douta(core_data_in)  // 读数据输�?
    );
    /*
    myRam ram_unit (
        .clk(mem_clk), 
        .we(mem_write), 
        .write_data(core_data_out), 
        .address(addr_out[12:0]), 
        .read_data(core_data_in) 
    );
    */
    
    // TODO: 添加32个寄存器组的输出    
    assign chip_debug_out0 = pc_out;
    assign chip_debug_out1 = addr_out;
    assign chip_debug_out2 = debug_reg_addr_out;
    assign chip_debug_out3 = core_data_out;
endmodule
