`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 06:53:54 PM
// Design Name: 
// Module Name: IF_tb
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


module IF_tb();
reg clk;
reg reset;
reg fs_ds_reg_allow_in;
reg [32:0] branch_data;
reg [31:0] instr;

wire fs_to_ds_reg_valid;
wire [63:0] fs_data;
wire [31:0] instr_sram_wdata;
wire [31:0] instr_sram_addr;
wire        instr_sram_en;
wire        instr_sram_wen;

IF IF(
    .clk(clk),
    .reset(reset),
    .fs_ds_reg_allow_in(fs_ds_reg_allow_in),
    .fs_to_ds_reg_valid(fs_to_ds_reg_valid),
    .fs_data(fs_data),
    .branch_data(branch_data),
    .instr(instr),
    .instr_sram_addr(instr_sram_addr),
    .instr_sram_wdata(instr_sram_wdata),
    .instr_sram_en(instr_sram_en),
    .instr_sram_wen(instr_sram_wen)
);

initial begin
    clk = 0;
    reset = 1;
    fs_ds_reg_allow_in = 1;
    branch_data = 33'h123456788;
    instr = 32'h12345678;
    #10;
    reset = 0;
end

always begin
    #5;
    clk = ~clk;
end

always begin
    #20;
    fs_ds_reg_allow_in = 0;
end
endmodule
