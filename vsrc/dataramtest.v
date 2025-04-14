`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2025 03:00:22 PM
// Design Name: 
// Module Name: dataramtest
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


module dataramtest(
    input clk,
    input we,
    input [31:0] aluresult,
    input [31:0] rdata2,
    output [31:0] Memdata
);

data_ram data_ram(
    .clk(clk),
    .we(we),
    .a(aluresult),
    .d(rdata2),
    .spo(Memdata)
);
endmodule
