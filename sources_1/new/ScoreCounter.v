`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2019 15:07:05
// Design Name: 
// Module Name: ScoreCounter
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


module ScoreCounter(
    input CLK,
    input RESET,
    input ENABLE,
    output [3:0] SEG_SELECT,
    output [7:0] DEC_OUT,
    output FINISHED
    );
    
    wire Bit17TriggOut;
    wire trigger0;
    
    wire [3:0] DecCount0;
    wire [3:0] DecCount1;
    wire [1:0] StrobeCount;
    
    // Clock counter
    Generic_counter # (.COUNTER_WIDTH(17), .COUNTER_MAX(99999))
        Bit17Counter (
            .CLK(CLK),
            .RESET(1'b0),
            .ENABLE(1'b1),
            .TRIGGER_OUT(Bit17TriggOut)
        );
    
    // First digit counter    
    Generic_counter # (.COUNTER_WIDTH(4), .COUNTER_MAX(9))
        Bit4Counter0 (
            .CLK(CLK),
            .RESET(RESET),
            .ENABLE(ENABLE),
            .TRIGGER_OUT(trigger0),
            .COUNT(DecCount0)
        );   
        
    // Second digit counter
    Generic_counter # (.COUNTER_WIDTH(4), .COUNTER_MAX(1))
        Bit4Counter1 (
            .CLK(CLK),
            .RESET(RESET),
            .ENABLE(trigger0),
            .COUNT(DecCount1)
        );

    
    // Strobe counter
    Generic_counter # (.COUNTER_WIDTH(2), .COUNTER_MAX(3))
        Bit2Counter (
            .CLK(CLK),
            .ENABLE(Bit17TriggOut),
            .COUNT(StrobeCount)
        ); 
        
 
    // Output of the multiplexer i.e. which digit to display
    wire [4:0] MuxOut;
    
    Multiplexer_4way Mux4 (
        .CONTROL(StrobeCount),
        .IN0(DecCount0),
        .IN1(DecCount1),
        .OUT(MuxOut)
    );  
    
    Decimal_decoder seg7 (
        .SEG_SELECT_IN(StrobeCount),
        .BIN_IN(MuxOut[3:0]),
        .DOT_IN(MuxOut[4]),
        .SEG_SELECT_OUT(SEG_SELECT),
        .HEX_OUT(DEC_OUT)
    ); 
    
    assign FINISHED = DecCount1[0]; 
    
endmodule
