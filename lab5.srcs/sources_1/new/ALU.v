`timescale 1ns / 1ps

module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_op,
    output reg [31:0] res,
    output reg zero, 
    output reg smaller, 
    output reg bigger 
);
    `include "AluOp.vh"
    always @(*) begin 
        if (alu_op == ADD) res = a + b; 
        else if (alu_op == SUB) res = a - b; 
        else if (alu_op == SLL) res = a << b;
        else if (alu_op == SLT) res = $signed(a) < $signed(b);
        else if (alu_op == SLTU) res = a < b;
        else if (alu_op == XOR) res = a ^ b; 
        else if (alu_op == SRL) res = a >> b;
        else if (alu_op == SRA) res = a >>> b;
        else if (alu_op == OR) res = a | b; 
        else if (alu_op == AND) res = a & b;
        else res = 0;
        if (res == 0) zero = 1; else zero = 0;  
        if (res[31] == 1) smaller = 1; else smaller = 0; 
        if (res[31] == 0 && zero == 0) bigger = 1; else bigger = 0; 
    end 
endmodule
