`timescale 1ns / 1ps

module ALU(
    input [63:0] a,
    input [63:0] b,
    input [3:0] alu_op,
    output reg [63:0] res,
    output reg zero, 
    output reg smaller_signed, 
    output reg bigger_signed, 
    output reg smaller_unsigned, 
    output reg bigger_unsigned 
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
        else if (alu_op == ADDW) begin 
            res = a + b; 
            res = {{32{res[31]}}, res[31:0]}; 
        end 
        else res = 0;
        if (res == 0) zero = 1; else zero = 0;  
        smaller_signed = $signed(a) < $signed(b); 
        bigger_signed = $signed(a) > $signed(b); 
        smaller_unsigned = $unsigned(a) < $unsigned(b); 
        bigger_unsigned = $unsigned(a) > $unsigned(b); 
    end 
endmodule
