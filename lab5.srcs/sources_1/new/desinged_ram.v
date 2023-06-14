`timescale 1ns / 1ps

module desinged_ram(
    input clka, 
    input wea, 
    input [63:0] addra, 
    input [63:0] dina, 
    output reg [63:0] douta, 
    input [1:0] memoryAccessByte 
);
    
    Ram ram_unit (
        .clka(clka),  // 时钟
        .wea(wea),   // 是否写入数据
        .addra(addra), // 地址输入 
        .dina(dina),  // 数据输入
        .douta(douta)  // 数据输出
    );
    
    always @(*) begin
        if (memoryAccessByte == 2'b00) douta = {56'b0, douta[7:0]}; // 1 byte  
        else if (memoryAccessByte == 2'b01) douta = {32'b0, douta[31:0]}; // 4 byte 
        else if (memoryAccessByte == 2'b10) douta = douta; 
    end
    
endmodule
