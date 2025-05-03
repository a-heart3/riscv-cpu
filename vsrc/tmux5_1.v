`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2025 10:08:49 AM
// Design Name: 
// Module Name: tmux5_1
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


module tmux5_1(
    input  [31:0] src1,
    input  [31:0] src2,
    input  [31:0] src3,
    input  [31:0] src4,
    input  [31:0] src5,
    input  [ 4:0] sel,
    output [31:0] result
);

assign result = ({32{(sel[0])}} & src1)
              | ({32{(sel[1])}} & src2)
              | ({32{(sel[2])}} & src3)
              | ({32{(sel[3])}} & src4)
              | ({32{(sel[4])}} & src5);
endmodule
