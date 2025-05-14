`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2025 02:28:01 PM
// Design Name: 
// Module Name: forward_judge
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


module forward_judge(
    input [4:0] rs,
    input [4:0] ex_rd,
    input [4:0] mem_rd,
    input [4:0] wb_rd,
    input       ex_memread,
    output [3:0] fd_mode,
    output       load_use
);

wire fd_ex;
wire fd_mem;
wire fd_wb;
wire id;
wire is_zero;

assign is_zero = (rs == 5'b00000);
assign fd_ex = (!is_zero) & (rs == ex_rd) & (!ex_memread);
assign fd_mem = (!is_zero) & (rs == mem_rd);
assign fd_wb = (!is_zero) & (rs == wb_rd);
assign load_use = (!is_zero) & (rs == ex_rd) & ex_memread;
assign id = ((~fd_ex) & (~fd_mem) & (~fd_wb) & (~load_use)) | is_zero;
assign fd_mode = {id, fd_wb, fd_mem, fd_ex};
endmodule
