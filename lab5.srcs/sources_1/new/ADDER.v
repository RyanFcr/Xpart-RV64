`timescale 1ns / 1ps

module ADDER(
    input [31:0] a, 
    input [31:0] b, 
    output [31:0] res 
);
    assign res = a + b;
endmodule
