`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 12:49:03 PM
// Design Name: 
// Module Name: tmux4_1
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


module tmux4_1(
    input  [31:0] src1,
    input  [31:0] src2,
    input  [31:0] src3,
    input  [31:0] src4,
    input  [ 3:0] sel,
    output [31:0] result
);

assign result = ({32{sel[0]}} & src1)
              | ({32{sel[1]}} & src2)
              | ({32{sel[2]}} & src3)
              | ({32{sel[3]}} & src4);
endmodule
