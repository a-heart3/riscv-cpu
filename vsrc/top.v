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
    input                  clk,
    input                  reset,
    input   [ 4:0]         wb_rd,
    input   [31:0]         wb_wdata,
    input                  wb_we,
    input                  ex_mem_reg_allow_in,
    output                 ex_to_mem_reg_valid,
    output [`ID_DATA -1:0] ds_ex_reg_data
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

//wire between pc and ID branch controller
wire [`BRANCH_DATA -1:0] ds_branch_data;

IF IF(
    .clk               (clk                ),
    .reset             (reset              ),
    .fs_ds_reg_allow_in(fs_ds_reg_allow_in ),
    .fs_to_ds_reg_valid(fs_to_ds_reg_valid ),
    .fs_data           (fs_data            ),
    .branch_data       (ds_branch_data     ),
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
// signal define
wire [`FS_DATA -1:0] fs_ds_reg_data;
wire ds_ex_reg_allow_in;
wire ds_to_ex_reg_valid;
fs_ds_reg fs_ds_reg(
    .clk               (clk                ),
    .reset             (reset              ),
    .fs_to_ds_reg_valid(fs_to_ds_reg_valid ),
    .fs_data           (fs_data            ),
    .fs_ds_reg_allow_in(fs_ds_reg_allow_in ),
    .ds_ex_reg_allow_in(ds_ex_reg_allow_in ),
    .ds_to_ex_reg_valid(ds_to_ex_reg_valid ),
    .fs_ds_reg_data    (fs_ds_reg_data     )
);

// connect with ID
// wire between ID and WB
wire [31:0] wb_wdata;
wire [ 4:0] wb_rd;
wire        wb_we;
// wire between ID and ds_ex_reg
wire [`ID_DATA -1:0] ds_data;
ID ID(
    .clk           (clk            ),
    .fs_ds_reg_data(fs_ds_reg_data ),
    .wb_wdata      (wb_wdata       ),
    .wb_rd         (wb_rd          ),
    .wb_we         (wb_we          ),
    .ds_branch_data(ds_branch_data ),
    .ds_data       (ds_data        )
);

// connect with ds_ex_reg
// wire between ds_ex_reg
ds_ex_reg ds_ex_reg(
    .clk                (clk                 ),
    .reset              (reset               ),
    .ds_data            (ds_data             ),
    .ds_to_ex_reg_valid (ds_to_ex_reg_valid  ),
    .ds_ex_reg_allow_in (ds_ex_reg_allow_in  ),
    .ex_mem_reg_allow_in(ex_mem_reg_allow_in ),
    .ex_to_mem_reg_valid(ex_to_mem_reg_valid ),
    .ds_ex_reg_data     (ds_ex_reg_data      )
);
endmodule
 