`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2019 13:36:36
// Design Name: 
// Module Name: Colour_control
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


module Colour_control(
    input [8:0] vert_address,
    input [9:0] horz_address,
    input [11:0] COLOUR_IN,
    input [1:0] M_STATE,
    input CLK,
    output [11:0] COLOUR_OUT
    );
    
    // Final output colour
    reg [11:0] out_col;
    
    // Variables for creating interesting animation in the last state
    reg [15:0] FrameCount;
    reg [11:0] colour;
    
    always@(posedge CLK) begin
        if (vert_address == 479)
            FrameCount <= FrameCount + 1;
    end
    
    always@(posedge CLK) begin
        if (M_STATE == 2'b10) begin
            if (vert_address[8:0] > 240) begin
                if (horz_address[9:0] > 320)
                    colour <= FrameCount[15:8] + vert_address[7:0] + horz_address[7:0] - 240 - 320;
                else
                    colour <= FrameCount[15:8] + vert_address[7:0] + horz_address[7:0] - 240 + 320;
            end
            else begin
                if (horz_address > 320)
                    colour <= FrameCount[15:8] - vert_address[7:0] + horz_address[7:0] + 240 - 320;
                else
                    colour <= FrameCount[15:8] - vert_address[7:0] - horz_address[7:0] + 240 + 320;
            end
        end
    end 
    
    always@(posedge CLK) begin
        case (M_STATE)
        
            2'b00: begin
                out_col <= 12'hF00;
            end
            
            2'b01: begin
                out_col <= COLOUR_IN;
            end
            
            2'b10: begin
                out_col <= colour;
            end
        
        endcase
     end
     
     assign COLOUR_OUT = out_col;
     
endmodule
