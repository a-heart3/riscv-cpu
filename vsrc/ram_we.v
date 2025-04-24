`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 08:26:01 PM
// Design Name: 
// Module Name: ram_we
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


module ram_we(
    input        we,
    input  [2:0] mode,
    input  [1:0] cs,
    output       we0,
    output       we1,
    output       we2,
    output       we3
);

// signal definition
wire wdata32;
wire wdata16;
wire wdata8;

assign wdata32 = mode[2];
assign wdata16 = mode[1];
assign wdata8  = mode[0];

// signal logic
assign we3 = (wdata32
           | ((cs == 2'b10) & wdata16)
           | ((cs == 2'b11) & wdata8))
           & we;

assign we2 = (wdata32
           | ((cs == 2'b10) & wdata16)
           | ((cs == 2'b10) & wdata8))
           & we;

assign we1 = (wdata32
           | ((cs == 2'b00) & wdata16)
           | ((cs == 2'b01) & wdata8))
           & we;

assign we0 = (wdata32
           | ((cs == 2'b00) & wdata16)
           | ((cs == 2'b00) & wdata8))
           & we;           
endmodule
