`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2019 12:14:07
// Design Name: 
// Module Name: Game
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


module Game(
    input CLK,
    input RESET,
    input BTN_U,
    input BTN_D,
    input BTN_L,
    input BTN_R,
    output [11:0] COLOUR_OUT,
    output HS,
    output VS,
    output [3:0] SEG_SELECT,
    output [7:0] DEC_OUT
    );
    
    wire finished;
    wire [1:0] M_State;
    wire [1:0] direction;
    wire [11:0] snake_colour_out;
    wire [9:0] horz_address;
    wire [8:0] vert_address;
    wire reached_target;
    wire [6:0] vert_target;
    wire [7:0] horz_target;

    
    Master master (
        .FINISHED(finished),
        .RESET(RESET),
        .CLK(CLK),
        .BTN_D(BTN_D),
        .BTN_U(BTN_U),
        .BTN_L(BTN_L),
        .BTN_R(BTN_R),
        .STATE(M_State)
    );
    
    
    Navigation navigation (
        .RESET(RESET),
        .CLK(CLK),
        .BTN_D(BTN_D),
        .BTN_U(BTN_U),
        .BTN_L(BTN_L),
        .BTN_R(BTN_R),
        .DIR(direction)
    );
    
    Colour_wrapper (
        .CLK(CLK),
        .M_STATE(M_State),
        .COLOUR_IN(snake_colour_out),
        .COLOUR_OUT(COLOUR_OUT),
        .HS(HS),
        .VS(VS),
        .ADDR_H(horz_address),
        .ADDR_V(vert_address)
    );
    
    ScoreCounter score_count (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(reached_target),
        .SEG_SELECT(SEG_SELECT),
        .DEC_OUT(DEC_OUT),
        .FINISHED(finished)
    );
    
        
    SnakeControl snake (
        .CLK(CLK),
        .RESET(RESET),
        .ADDR_H(horz_address),
        .ADDR_V(vert_address),
        .M_STATE(M_State),
        .DIR(direction),
        .TARGET_V(vert_target),
        .TARGET_H(horz_target),
        .COLOUR(snake_colour_out),
        .REACHED(reached_target)
    );
    
    TargetGenerator target (
        .CLK(CLK),
        .RESET(RESET),
        .REACHED(reached_target),
        .M_STATE(M_State),
        .TARGET_V(vert_target),
        .TARGET_H(horz_target)
    );
           
endmodule
