`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2019 13:16:34
// Design Name: 
// Module Name: VGA_Interface
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


module VGA_Interface(
    input CLK,
    input [11:0] COLOUR_IN,
    output reg [9:0] ADDR_H,
    output reg [8:0] ADDR_V,
    output reg [11:0] COLOUR_OUT,
    output reg HS,
    output reg VS
    );
    
    parameter VertTimeToPulseWidthEnd = 10'd2;
    parameter VertTimeToBackPorchEnd = 10'd31;
    parameter VertTimeToDisplayTimeEnd = 10'd511;
    parameter VertTimeToFrontPorchEnd = 10'd521;
    
    parameter HorzTimeToPulseWidthEnd = 10'd96;
    parameter HorzTimeToBackPorchEnd = 10'd144;
    parameter HorzTimeToDisplayTimeEnd = 10'd784;
    parameter HorzTimeToFrontPorchEnd = 10'd800;
    
    // For the simulation
    initial begin
        HS <= 0;
        VS <= 0;
        COLOUR_OUT <= 0;
    end
    
    wire [9:0] HORZ_COUNT;
    wire HORZ_TRIG;
    
    wire [9:0] VERT_COUNT;
    wire VERT_TRIG;
    
    wire SLOW_TRIG;
    
    // Counter to slow down the clock 4 times (25 MHz is needed instead of 100 MHz)
    Generic_counter # (.COUNTER_WIDTH(2), .COUNTER_MAX(3))
        Slow_counter (
            .CLK(CLK),
            .ENABLE(1'b1),
            .RESET(1'b0),
            .TRIGGER_OUT(SLOW_TRIG)
        );
    
    // Horizontal counter, counts the current position in the horizontal sweep
    Generic_counter # (.COUNTER_WIDTH(10), .COUNTER_MAX(799))
        Horz_Counter (
            .CLK(CLK),
            .ENABLE(SLOW_TRIG),
            .RESET(1'b0),
            .COUNT(HORZ_COUNT),
            .TRIGGER_OUT(HORZ_TRIG)
        );
        
    // Vertical counter,counts the current position in the vertical sweep
    Generic_counter # (.COUNTER_WIDTH(10), .COUNTER_MAX(520))
        Vert_Counter(
            .CLK(CLK),
            .ENABLE(HORZ_TRIG),
            .RESET(1'b0),
            .COUNT(VERT_COUNT)
        );
        
    // Set the horizontal sync to 1 only if the horizontal counter is in correct range  
    always@(posedge CLK) begin
        if (HORZ_COUNT < HorzTimeToPulseWidthEnd)
            HS <= 1'b0;
        else
            HS <= 1'b1;
    end
    
    // Set the vertical sync to 1 only if the vertical counter is in correct range
    always@(posedge CLK) begin
        if (VERT_COUNT < VertTimeToPulseWidthEnd)
            VS <= 1'b0;
        else
            VS <= 1'b1;
    end
    
    //Assign colour only if the counters are within display range
    always@(posedge CLK) begin
        if ((VERT_COUNT >= VertTimeToBackPorchEnd) && (VERT_COUNT < VertTimeToDisplayTimeEnd) && 
            (HORZ_COUNT >= HorzTimeToBackPorchEnd) && (HORZ_COUNT < HorzTimeToDisplayTimeEnd)) 
            COLOUR_OUT <= COLOUR_IN;
        else
            COLOUR_OUT = 0;
    end
    
    
    //Decoding addresses
    always@(posedge CLK) begin
        if (HORZ_COUNT >= HorzTimeToBackPorchEnd && HORZ_COUNT < HorzTimeToDisplayTimeEnd &&
            VERT_COUNT >= VertTimeToBackPorchEnd && VERT_COUNT < VertTimeToDisplayTimeEnd) begin
            ADDR_H <= HORZ_COUNT - 144;
            ADDR_V <= VERT_COUNT - 31;
        end
        else begin
            ADDR_H <= 0;
            ADDR_V <= 0;    
        end
    end
       
endmodule
