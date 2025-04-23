`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2025 01:50:09 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();
reg clk;
reg rst;

wire [31:0] pc_current_out;
wire [31:0] pc_next_out;
wire [31:0] instr_out;
wire [31:0] data1_out;
wire [31:0] data2_out;
wire [31:0] aluresult_out;
wire [31:0] data_out;
wire        MemWrite;
wire [31:0] wdata_out;

top top(
    .clk(clk),
    .rst(rst),
    .pc_current_out(pc_current_out),
    .pc_next_out(pc_next_out),
    .instr_out(instr_out),
    .data1_out(data1_out),
    .data2_out(data2_out),
    .aluresult_out(aluresult_out),
    .data_out(data_out),
    .MemWrite(MemWrite),
    .wdata_out(wdata_out)
);

initial begin
    clk = 0;
    rst = 1;
    #20;
    rst = 0;
end

always begin
    #10;
    clk = ~clk;
end

endmodule
