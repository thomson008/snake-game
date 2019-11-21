`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2019 17:03:10
// Design Name: 
// Module Name: SnakeControl
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


module SnakeControl(
    input CLK,
    input RESET,
    input [9:0] ADDR_H,
    input [8:0] ADDR_V,
    input [1:0] M_STATE,
    input [1:0] DIR,
    input [6:0] TARGET_V,
    input [7:0] TARGET_H,
    output REACHED,
    output [11:0] COLOUR
    );
    
    parameter SnakeLength = 20;
    parameter MaxY = 119;
    parameter MaxX = 159;
    
    reg [7:0] SnakeState_X [0:SnakeLength - 1];
    reg [6:0] SnakeState_Y [0:SnakeLength - 1];
    
    wire [26:0] Counter;
    
    // Are we currently in the game state?
    reg right_state;
    
    // Set the value for right_state boolean
    always@(posedge CLK) begin
        if (M_STATE == 2'b01)
            right_state <= 1'b1;
        else
            right_state <= 1'b0;
    end
    
    // Count the clock cycles in order to move the snake every 1/20 second
    Generic_counter # (.COUNTER_MAX(3999999), .COUNTER_WIDTH(22))
        Move_Counter (
            .CLK(CLK),
            .ENABLE(right_state),
            .RESET(RESET),
            .COUNT(Counter)
        );
    
    genvar PixNo;
    
    generate
        for (PixNo=0; PixNo < SnakeLength - 1; PixNo = PixNo + 1)
        begin: PixShift
            always@(posedge CLK) begin
                if (RESET) begin
                    SnakeState_X[PixNo + 1] <= 80;
                    SnakeState_Y[PixNo + 1] <= 100;
                end
                else if (Counter == 0) begin
                    SnakeState_X[PixNo + 1] <= SnakeState_X[PixNo];
                    SnakeState_Y[PixNo + 1] <= SnakeState_Y[PixNo];
                end
            end
        end
    endgenerate
    
    
    always@(posedge CLK) begin
        if (RESET) begin
            SnakeState_Y[0] <= 100;
            SnakeState_X[0] <= 80;
        end
        else if (Counter == 0) begin
            case (DIR)
            
                2'b00: begin
                    if (SnakeState_Y[0] == 0)
                        SnakeState_Y[0] <= MaxY;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] - 1;
                end
                
                2'b01: begin
                    if (SnakeState_X[0] == MaxX)
                        SnakeState_X[0] <= 0;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] + 1;
                end
                
                2'b10: begin
                    if (SnakeState_Y[0] == MaxY)
                        SnakeState_Y[0] <= 0;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] + 1;
                end
                
                2'b11: begin
                    if (SnakeState_X[0] == 0)
                        SnakeState_X[0] <= MaxX;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] - 1;
                end
                
            endcase
        end
    end
    
    reg [11:0] colour_out;
    reg is_snake;
    reg reached;
    
    integer i;
    
    always@(posedge CLK) begin
        for (i = 0; i < SnakeLength; i = i + 1) begin
            if (ADDR_V[8:2] == SnakeState_Y[i] && ADDR_H[9:2] == SnakeState_X[i])
                is_snake <= 1;
        end
        
        if (is_snake)
            colour_out <= 12'h0FF;
        else if (ADDR_V[8:2] == TARGET_V && ADDR_H[9:2] == TARGET_H)
            colour_out <= 12'h00F;
        else 
            colour_out <= 12'hF00;
            
        is_snake = 0;
    end
    
    always@(posedge CLK) begin
        if (TARGET_V == SnakeState_Y[0] && TARGET_H == SnakeState_X[0] && Counter == 0 && M_STATE == 1)
            reached <= 1;
        else
            reached <= 0;
    end
    
    assign REACHED = reached;
    assign COLOUR = colour_out;
         
endmodule
