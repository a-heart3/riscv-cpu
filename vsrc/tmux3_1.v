`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2025 10:36:58 AM
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


module tmux3_1
# ( parameter    WIDTH =32) (
    input  [WIDTH -1:0] src1,
    input  [WIDTH -1:0] src2,
    input  [WIDTH -1:0] src3,
    input  [2:0] sel,
    output [WIDTH -1:0] result
);

assign result = ({32{sel[0]}} & src1)
              | ({32{sel[1]}} & src2)
              | ({32{sel[2]}} & src3);
endmodule
