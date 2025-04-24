`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 08:41:11 PM
// Design Name: 
// Module Name: ram_we_tb
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


module ram_we_tb();
reg [2:0] mode;
reg [1:0] cs;
wire      we0;
wire      we1;
wire      we2;
wire      we3;

ram_we ram_we(
    .mode(mode ),
    .cs  (cs   ),
    .we0 (we0  ),
    .we1 (we1  ),
    .we2 (we2  ),
    .we3 (we3  )
);

initial begin
    mode = 3'b001;
    cs   = 3'b00;
    #5;
    cs   = 3'b01;
    #5;
    cs   = 3'b10;
    #5;
    cs   = 3'b11;
    #5;
    mode = 3'b010;
    #5;
    cs   = 3'b10;
    #5;
    cs   = 3'b01;
    #5;
    cs   = 3'b00;
    #5;
    mode = 3'b100;
    #5;
    cs   = 3'b01;
    #5;
    cs   = 3'b10;
    #5;
    cs   = 3'b11;
end
endmodule
