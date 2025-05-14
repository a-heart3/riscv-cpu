`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2025 02:30:50 PM
// Design Name: 
// Module Name: mem
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
`include "pipeline.vh"

module mem(
    input  [`MEM_DATA -1:0] mem_data,
    output [`MEM_DATA -1:0] mem_stage_data,
    output [4:0]            mem_rd,
    output [31:0]           mem_fd_data
);

/*
do nothing
everything has done by reg
*/

// split data
wire RegWrite;
wire [ 3:0] MemtoReg;
wire [ 4:0] rd;
wire [31:0] result;
wire [31:0] data_sram_rdata;

assign {RegWrite, MemtoReg, rd, result, data_sram_rdata} = mem_data;

assign mem_stage_data = mem_data;
assign mem_rd = rd;
assign mem_fd_data = data_sram_rdata;

endmodule
