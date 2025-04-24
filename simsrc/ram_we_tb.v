`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/20210 08:41:11 PM
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
reg       we;
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
    .we3 (we3  ),
    .we  (we   )
);

always begin
    #5; we = ~we;
end

initial begin
    mode = 3'b001;
    we   = 0;
    cs   = 3'b00;
    #10;
    cs   = 3'b01;
    #10;
    cs   = 3'b10;
    #10;
    cs   = 3'b11;
    #10;
    mode = 3'b010;
    #10;
    cs   = 3'b10;
    #10;
    cs   = 3'b01;
    #10;
    cs   = 3'b00;
    #10;
    mode = 3'b100;
    #10;
    cs   = 3'b01;
    #10;
    cs   = 3'b10;
    #10;
    cs   = 3'b11;
end
endmodule
