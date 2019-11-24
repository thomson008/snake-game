`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2019 12:26:43
// Design Name: 
// Module Name: Master
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


module Master(
    input FINISHED,
    input RESET,
    input CLK,
    input BTN_U,
    input BTN_D,
    input BTN_L,
    input BTN_R,
    input HIT,
    output [1:0] STATE
    );
    
    reg [1:0] curr_state;
    reg [1:0] next_state;
    
    // Update state at each rising clock edge
    always@(posedge CLK) begin
        if (RESET)
            curr_state <= 2'b00;
        else
            curr_state <= next_state;
    end
    
    //Combinational logic
    always@(curr_state or BTN_L or BTN_R or BTN_U or BTN_D or FINISHED or HIT) begin
        case (curr_state)
            
            2'b00: begin
                if (BTN_L || BTN_R || BTN_U || BTN_D)
                    next_state <= 2'b01;
                else
                    next_state <= curr_state;
            end
            
            2'b01: begin
                if (FINISHED || HIT)
                    next_state <= 2'b10;
                else
                    next_state <= curr_state;
            end
            
            2'b10: begin
                next_state <= curr_state;
            end
            
        endcase
    end
    
    assign STATE = curr_state;
    
endmodule
