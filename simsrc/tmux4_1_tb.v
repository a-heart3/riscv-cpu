`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 12:53:45 PM
// Design Name: 
// Module Name: tmux4_1_tb
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


module tmux4_1_tb();

reg  [31:0] src1;
reg  [31:0] src2;
reg  [31:0] src3;
reg  [31:0] src4;
reg  [ 3:0] sel;
wire [31:0] result;

tmux4_1 tmux4_1(
    .src1  (src1   ),
    .src2  (src2   ),
    .src3  (src3   ),
    .src4  (src4   ),
    .sel   (sel    ),
    .result(result )
);

initial begin
    src1 = 32'd1;
    src2 = 32'd2;
    src3 = 32'd3;
    src4 = 32'd4;
    sel  =  4'b0000;
    #10;
    sel = 4'b0001;
    #10;
    sel = 4'b0010;
    #10;
    sel = 4'b0100;
    #10;
    sel = 4'b1000;
end
endmodule
