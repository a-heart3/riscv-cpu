`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 11:14:25 AM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();

reg  [31:0] src1;
reg  [31:0] src2;
reg  [10:0] sel;
wire [31:0] result;

alu alu(
    .src1  (src1   ),
    .src2  (src2   ),
    .sel   (sel    ),
    .result(result )
);

initial begin
    src1 = 32'h80000000;
    src2 = 32'h00000010;
    sel  = 11'b000_0000_0001;
    #10;
    sel  = 11'b000_0000_0010;
    #10;
    sel  = 11'b000_0000_0100;
    #10;
    sel  = 11'b000_0000_1000; 
    #10;
    sel  = 11'b000_0001_0000;
    #10;
    sel  = 11'b000_0010_0000;
    #10;
    sel  = 11'b000_0100_0000; 
    #10;
    sel  = 11'b000_1000_0000;
    #10;
    sel  = 11'b001_0000_0000;
    #10;
    sel  = 11'b010_0000_0000; 
    #10;
    sel  = 11'b100_0000_0000;

end
endmodule
