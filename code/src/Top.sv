`timescale 1ns / 1ps

module Top(
    input          clk,
    input          resetn,
    input  [31:0]  switch, 
    input  [ 4:0]  button,  
    
    output [31:0]  led,
    output [ 2:0]  rgb1,
    output [ 2:0]  rgb2,
    output [ 7:0]  num_csn,
    output [ 7:0]  num_an
);
    logic aresetn;
    logic step;

    logic [63:0] address;
    logic [63:0] data_out;
    logic [63:0] data_in;

    logic [63:0] chip_debug_in;
    logic [63:0] chip_debug_out0;
    logic [63:0] chip_debug_out1;
    logic [63:0] chip_debug_out2;
    logic [63:0] chip_debug_out3;

    Core chip_inst(
        .clk(clk),
        .aresetn(aresetn),
        .step(step),
        .debug_mode(switch[31]),
        .debug_reg_addr(switch[11:7]),
        .address(address),
        .data_out(data_out),
        .data_in(data_in),
        .chip_debug_in(chip_debug_in),
        .chip_debug_out0(chip_debug_out0),
        .chip_debug_out1(chip_debug_out1),
        .chip_debug_out2(chip_debug_out2),
        .chip_debug_out3(chip_debug_out3)
    );

    IO_Manager io_manager_inst(
        .clk(clk),
        .resetn(resetn),

        // to chip
        .aresetn(aresetn),
        .step(step),
        .address(address),
        .data_out(data_out),
        .data_in(data_in),
        .chip_debug_in(chip_debug_in),
        
        // to gpio
        .switch(switch),
        .button(button),
        .led(led),
        .num_csn(num_csn),
        .num_an(num_an),
        .rgb1(rgb1),
        .rgb2(rgb2),
        
        // debug
        .debug0(64'h8888888888888888),
        .debug1({32'b0, switch[31:0]}),
        .debug2({20'b0, 3'b0, button[4], 3'b0, button[3], 3'b0, button[2], 3'b0, button[1], 3'b0, button[0]}),
        .debug3(64'h1234567812345678),
        .debug4(chip_debug_out0),
        .debug5(chip_debug_out1),
        .debug6(chip_debug_out2),
        .debug7(chip_debug_out3)
    );
endmodule