`timescale 1ns / 1ps

module extend(
    input [24:0] imm,    //立即数位段
    input Sign,          //扩展符号控制信号
    input [2:0] ExtSel,  //立即数拼接方式
    output reg [31:0] extend //扩展完成立即数
);
    
endmodule
