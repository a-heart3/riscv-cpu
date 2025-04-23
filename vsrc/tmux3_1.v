`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 12:59:40 PM
// Design Name: 
// Module Name: tmux3_1
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


module tmux3_1(
    input  [31:0] src1,
    input  [31:0] src2,
    input  [31:0] src3,
    input  [ 2:0] sel,
    output [31:0] result
);

assign result = ({32{sel[0]}} & src1)
              | ({32{sel[1]}} & src2)
              | ({32{sel[2]}} & src3);
endmodule
