`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2025 03:30:12 PM
// Design Name: 
// Module Name: wb
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

module wb(
    input  [`WB_DATA -1:0] wb_data,
    output [31:0] wb_wdata,
    output [ 4:0] wb_rd,
    output        wb_we
);

// split wb_data
wire RegWrite;
wire [ 3:0] MemtoReg;
wire [ 4:0] rd;
wire [31:0] result;
wire [31:0] data_sram_rdata;
assign {RegWrite, MemtoReg, rd, result, data_sram_rdata} = wb_data;

tmux4_1 mem2reg(
    .src1  (result          ),
    .src2  (data_sram_rdata ),
    .src3  (32'd3           ),
    .src4  (32'd4           ),
    .sel   (MemtoReg        ),
    .result(wb_wdata        )
);

assign wb_rd = rd;
assign wb_we = RegWrite;
endmodule
