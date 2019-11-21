`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2019 14:06:02
// Design Name: 
// Module Name: Colour_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Colour_wrapper(
    input CLK,
    input [1:0] M_STATE,
    input [11:0] COLOUR_IN,
    output [11:0] COLOUR_OUT,
    output HS,
    output VS,
    output [8:0] ADDR_V,
    output [9:0] ADDR_H
    );
    
    wire [11:0] control_colour_out;
    
    wire [9:0] horz_address;
    wire [8:0] vert_address;
    
    
    VGA_Interface vga (
        .CLK(CLK),
        .COLOUR_IN(control_colour_out),
        .ADDR_H(horz_address),
        .ADDR_V(vert_address),
        .COLOUR_OUT(COLOUR_OUT),
        .HS(HS),
        .VS(VS)
    );
    
    Colour_control control (
        .vert_address(vert_address),
        .horz_address(horz_address),
        .COLOUR_IN(COLOUR_IN),
        .M_STATE(M_STATE),
        .CLK(CLK),
        .COLOUR_OUT(control_colour_out)
    );
    
    assign ADDR_V = vert_address;
    assign ADDR_H = horz_address;
              
endmodule
