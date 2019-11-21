`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2019 12:39:46
// Design Name: 
// Module Name: Navigation
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


module Navigation(
    input RESET,
    input CLK,
    input BTN_R,
    input BTN_L,
    input BTN_U,
    input BTN_D,
    output [1:0] DIR
    );
    
    reg [1:0] curr_state;
    reg [1:0] next_state;
    
    // Update state at every risign clock edge
    always@(posedge CLK) begin
        if (RESET)
            curr_state <= 2'b00;
        else
            curr_state <= next_state;
    end
    
    //Combinational logic
    always@(curr_state or BTN_L or BTN_R or BTN_U or BTN_D) begin
        case (curr_state)
            
            2'b00: begin
                if (BTN_R)
                    next_state <= 2'b01;
                else if (BTN_L)
                    next_state <= 2'b11;
                else
                    next_state <= curr_state;
            end
            
            2'b01: begin
                if (BTN_D)
                    next_state <= 2'b10;
                else if (BTN_U)
                    next_state <= 2'b00;
                else
                    next_state <= curr_state;
            end
            
            2'b10: begin
                if (BTN_R)
                    next_state <= 2'b01;
                else if (BTN_L)
                    next_state <= 2'b11;
                else
                    next_state <= curr_state;
            end
            
            2'b11: begin
                if (BTN_U)
                    next_state <= 2'b00;
                else if (BTN_D)
                    next_state <= 2'b10;
                else
                    next_state <= curr_state;
            end
                 
        endcase
    end
    
    assign DIR = curr_state;
    
endmodule
