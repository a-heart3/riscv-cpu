`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 03:17:11 PM
// Design Name: 
// Module Name: pc
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


module pc(
    input      [31:0] pc_next,
    input             clk,
    input             rst,
    output reg [31:0] pc_current
);

always @(posedge clk) begin
    if (rst) begin
        pc_current <= 32'h00000000;
    end
    else begin
        pc_current <= pc_next;
    end
end
endmodule
