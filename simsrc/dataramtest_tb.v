`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2025 03:03:00 PM
// Design Name: 
// Module Name: dataramtest_tb
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


module dataramtest_tb();
reg clk;
reg we;
reg [31:0] aluresult;
reg [31:0] rdata2;
wire [31:0] Memdata;

dataramtest dataramtest(
    .clk(clk),
    .we(we),
    .aluresult(aluresult),
    .rdata2(rdata2),
    .Memdata(Memdata)
);
always begin
   #5; clk = ~clk;
end
initial begin
    clk = 0;
    we  = 0;
    aluresult = 32'd0;
    rdata2 = 32'd2323;
    #10;
    aluresult = 32'd1;
    #10;
    aluresult = 32'd2;
end
endmodule
