`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2019 12:25:37
// Design Name: 
// Module Name: SnakeSim
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


module SnakeSim(

    );
    
    reg clk;
    wire reached;
    wire [11:0] colour;
    wire hit;
    
    initial begin
         clk = 0;
        #10;
        forever #20 clk = ~clk;
    end
    
    SnakeControl uut (
        .CLK(clk),
        .RESET(0),
        .ADDR_H(100),
        .ADDR_V(100),
        .M_STATE(1),
        .DIR(0),
        .TARGET_H(0),
        .TARGET_V(0),
        .REACHED(reached),
        .COLOUR(colour),
        .HIT(hit)
    );
        
endmodule
