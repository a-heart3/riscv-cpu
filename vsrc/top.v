`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 07:19:48 PM
// Design Name: 
// Module Name: top
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

module top(
    input                      clk,
    input                      reset,
    input  [`BRANCH_DATA -1:0] branch_data,
    input                      ds_ex_reg_allow_in,
    output                     ds_to_ex_reg_valid,
    output [`FS_DATA     -1:0] fs_ds_reg_data
);

// wire between fs and instr_ram
wire [31:0] instr;
wire [31:0] instr_sram_addr;
wire [31:0] instr_sram_wdata;
wire        instr_sram_en;
wire        instr_sram_we;

// wire between pc and fs_ds_reg
wire fs_to_ds_reg_valid;
wire fs_ds_reg_allow_in;
wire [`FS_DATA -1:0] fs_data;

IF IF(
    .clk               (clk                ),
    .reset             (reset              ),
    .fs_ds_reg_allow_in(fs_ds_reg_allow_in ),
    .fs_to_ds_reg_valid(fs_to_ds_reg_valid ),
    .fs_data           (fs_data            ),
    .branch_data       (branch_data        ),
    .instr             (instr              ),
    .instr_sram_addr   (instr_sram_addr    ),
    .instr_sram_wdata  (instr_sram_wdata   ),
    .instr_sram_en     (instr_sram_en      ),
    .instr_sram_we     (instr_sram_we      )
);

instr_ram instr_ram(
    .clk             (clk              ),
    .instr_sram_addr (instr_sram_addr  ),
    .instr_sram_wdata(instr_sram_wdata ),
    .instr_sram_we   (instr_sram_we    ),
    .instr_sram_en   (instr_sram_en    ),
    .instr           (instr            )
);

// connect with fs_ds_reg
fs_ds_reg fs_ds_reg(
    .clk(clk),
    .reset(reset),
    .fs_to_ds_reg_valid(fs_to_ds_reg_valid),
    .fs_data(fs_data),
    .fs_ds_reg_allow_in(fs_ds_reg_allow_in),
    .ds_ex_reg_allow_in(ds_ex_reg_allow_in),
    .ds_to_ex_reg_valid(ds_to_ex_reg_valid),
    .fs_ds_reg_data(fs_ds_reg_data)
);
endmodule
 