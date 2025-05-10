`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2025 05:12:25 PM
// Design Name: 
// Module Name: ex
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

module ex(
    input [`ID_DATA -1:0] ds_ex_reg_data
);

// ex input data
wire MemWrite;
wire MemRead;
wire RegWrite;
wire [ 3:0] MemtoReg;
wire [ 2:0] Mem_mode;
wire        Mem_read_us;
wire [10:0] OpControl;
wire [31:0] data1;
wire [31:0] data2;
wire [ 4:0] rd;

assign {MemWrite, MemRead, RegWrite, MemtoReg,
        Mem_mode, Mem_read_us, OpControl, data1,
        data2, rd} = ds_ex_reg_data;


endmodule
