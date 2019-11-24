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
    output [11:0] COLOUR,
    output HIT
    );
    
    // Initial snake length
    parameter SnakeLength = 20;
    parameter MaxY = 119;
    parameter MaxX = 159;
    
    // Maximum length to which the snake can grow after eating 10 targets
    parameter MaxSnakeLength = SnakeLength + 10;
    
    reg [7:0] SnakeState_X [0:MaxSnakeLength - 1];
    reg [6:0] SnakeState_Y [0:MaxSnakeLength - 1];
    
    wire [22:0] Counter [0:9];
    
    // Variable to express the current length of snake, will be incremented every time it reaches a target
    integer CurrLength = SnakeLength;
    
    integer CountIdx = 0;

    genvar CountNo;
    
    generate
        for (CountNo = 0; CountNo < 10; CountNo = CountNo + 1)
        begin: CountSelect
    // Count the clock cycles in order to move the snake every 1/20 second
            Generic_counter # (.COUNTER_MAX(3999999 - CountNo * 200000), .COUNTER_WIDTH(22))
                Move_Counter (
                    .CLK(CLK),
                    .ENABLE(1),
                    .RESET(RESET),
                    .COUNT(Counter[CountNo])
                );
        end
    endgenerate
        
    
    genvar PixNo;
    
    generate
        for (PixNo=0; PixNo < MaxSnakeLength - 1; PixNo = PixNo + 1)
        begin: PixShift
            always@(posedge CLK) begin
                if (RESET) begin
                    SnakeState_X[PixNo + 1] <= 80;
                    SnakeState_Y[PixNo + 1] <= 100;
                end
                // To make a move, each snake element will inherit the coordinates from the element before it
                else if (Counter[CountIdx] == 0) begin
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
        // Find the next coordinates of the snake's head based on which button was pressed
        else if (Counter[CountIdx] == 0) begin
            case (DIR)
            
                // UP
                2'b00: begin
                    if (SnakeState_Y[0] == 0)
                        SnakeState_Y[0] <= MaxY;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] - 1;
                end
                
                // RIGHT
                2'b01: begin
                    if (SnakeState_X[0] == MaxX)
                        SnakeState_X[0] <= 0;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] + 1;
                end
                
                // DOWN
                2'b10: begin
                    if (SnakeState_Y[0] == MaxY)
                        SnakeState_Y[0] <= 0;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] + 1;
                end
                
                // LEFT
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
    reg hit_itself;

    
    integer i;
    
    always@(posedge CLK) begin
        // Go through every snake element and check if any of them are within the range of next pixel to be displayed through the VGA 
        for (i = 0; i < MaxSnakeLength; i = i + 1) begin
            if (ADDR_V[8:2] == SnakeState_Y[i] && ADDR_H[9:2] == SnakeState_X[i] && i < CurrLength)
                is_snake <= 1;
                // Determine if the snake has bit itself and end the game if that is the case
            if (SnakeState_Y[0] == SnakeState_Y[i] && SnakeState_X[0] == SnakeState_X[i] && i < CurrLength && i > 0 && M_STATE == 1)
                hit_itself <= 1;
        end
        
        // Select colour - yellow for snake, blue for background, red for target
        if (is_snake)
            colour_out <= 12'h0FF;
        else if (ADDR_V[8:2] == TARGET_V && ADDR_H[9:2] == TARGET_H)
            colour_out <= 12'h00F;
        else 
            colour_out <= 12'hF00;
        hit_itself = 0;
        is_snake = 0;
    end
    
    always@(posedge CLK) begin
        if (RESET) begin
            CurrLength <= SnakeLength;
            CountIdx <= 0;
        end
        // If snake reaches a target, indicate it by setting reached register to 1 and extend the length of the snake
        else if (TARGET_V == SnakeState_Y[0] && TARGET_H == SnakeState_X[0] && Counter[CountIdx] == 0 && M_STATE == 1) begin
            reached <= 1;
            CurrLength <= CurrLength + 1;
            CountIdx <= CountIdx + 1;
        end
        else
            reached <= 0;
    end
   
    assign REACHED = reached;
    assign COLOUR = colour_out;
    assign HIT = hit_itself;
         
endmodule
