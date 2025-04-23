`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 01:02:41 PM
// Design Name: 
// Module Name: tmux3_1_tb
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


module tmux3_1_tb();
reg  [31:0] src1;
reg  [31:0] src2;
reg  [31:0] src3;
reg  [ 2:0] sel;
wire [31:0] result;

tmux3_1 tmux3_1(
    .src1  (src1   ),
    .src2  (src2   ),
    .src3  (src3   ),
    .sel   (sel    ),
    .result(result )
);

initial begin
    src1 = 32'd1;
    src2 = 32'd2;
    src3 = 32'd3;
    sel  =  3'b000;
    #10;
    sel = 3'b001;
    #10;
    sel = 3'b010;
    #10;
    sel = 3'b100;
end
endmodule
