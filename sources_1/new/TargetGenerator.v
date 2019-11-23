`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2019 14:50:36
// Design Name: 
// Module Name: TargetGenerator
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


module TargetGenerator(
    input CLK,
    input RESET,
    input REACHED,
    input [1:0] M_STATE,
    output reg [6:0] TARGET_V,
    output reg [7:0] TARGET_H
    );
    
    reg [7:0] horz_target;
    reg [6:0] vert_target;
    
    reg new_h;
    reg new_v;
    
    always@(posedge CLK) begin
        new_h = horz_target[7] ^~ horz_target[5] ^~ horz_target[4] ^~ horz_target[3];
        horz_target = {horz_target[6:0], new_h};
        new_v = vert_target[6] ^~ vert_target[5];
        vert_target = {vert_target[5:0], new_v};
    end
    
    always@(posedge CLK) begin
        if (RESET) begin
            TARGET_V <= 0;
            TARGET_H <= 0;
        end
        else if (REACHED || M_STATE == 0) begin
            TARGET_V <= vert_target % 120;
            TARGET_H <= horz_target % 160;
        end
    end
    
endmodule
