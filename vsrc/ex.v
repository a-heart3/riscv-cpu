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
    input  [`ID_DATA -1:0] ds_ex_reg_data,
    output [`EX_DATA -1:0] ex_data
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
wire [31:0] rdata2;

assign {MemWrite, MemRead, RegWrite, MemtoReg,
        Mem_mode, Mem_read_us, OpControl, data1,
        data2, rd, rdata2} = ds_ex_reg_data;

// ex stage data
wire ex_MemWrite;
wire ex_MemRead;
wire ex_RegWrite;
wire [ 3:0] ex_MemtoReg;
wire [ 2:0] ex_Mem_mode;
wire        ex_Mem_read_us;
wire [31:0] ex_data2;
wire [ 4:0] ex_rd;
wire [31:0] ex_result;
wire [31:0] ex_rdata2;

// alu execution
// signal define
wire [31:0] result;
alu alu(
    .src1  (data1     ),
    .src2  (data2     ),
    .sel   (OpControl ),
    .result(result    )
);

// data out
assign ex_MemWrite = MemWrite;
assign ex_MemRead = MemRead;
assign ex_RegWrite = RegWrite;
assign ex_MemtoReg = MemtoReg;
assign ex_Mem_mode = Mem_mode;
assign ex_Mem_read_us = Mem_read_us;
assign ex_rdata2 = rdata2;
assign ex_rd = rd;
assign ex_result = result;
assign ex_data = {ex_MemWrite, ex_MemRead, ex_RegWrite, ex_MemtoReg,
                          ex_Mem_mode, ex_Mem_read_us, ex_rdata2, ex_rd, ex_result};
endmodule
