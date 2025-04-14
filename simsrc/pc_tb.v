`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 03:27:18 PM
// Design Name: 
// Module Name: pc_tb
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


module pc_tb();

reg  clk;
reg  rst;
reg  [31:0] pc_next;
wire [31:0] pc_current;

pc pc(
    .pc_next(pc_next),
    .clk(clk),
    .rst(rst),
    .pc_current(pc_current)
);

initial begin 
    rst = 1;
    clk = 0;
    #100;
    pc_next = 32'h00000001;
    #100;
    rst = 0;
end

always begin
    #5;
    clk = ~clk;
end
endmodule
