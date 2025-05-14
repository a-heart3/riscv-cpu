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
    input                  reset
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
// wire use to data risk
wire [4:0] ex_rd;
wire [4:0] mem_rd;
wire       ex_memread;
wire [31:0] ex_fd_data;
wire [31:0] mem_fd_data;
wire        load_use;
ID ID(
    .clk           (clk            ),
    .fs_ds_reg_data(fs_ds_reg_data ),
    .wb_wdata      (wb_wdata       ),
    .wb_rd         (wb_rd          ),
    .wb_we         (wb_we          ),
    .ds_branch_data(ds_branch_data ),
    .ds_data       (ds_data        ),
    .ex_rd         (ex_rd          ),
    .mem_rd        (mem_rd         ),
    .ex_memread    (ex_memread     ),
    .ex_data       (ex_fd_data     ),
    .mem_data      (mem_fd_data    ),
    .load_use      (load_use       )
);

// connect with ds_ex_reg
// wire between ds_ex_reg and ex
wire [`ID_DATA -1:0] ds_ex_reg_data;
wire ex_to_mem_reg_valid;
wire ex_mem_reg_allow_in;
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

// connect EX
// wire between ds_ex_reg and EX
wire [`EX_DATA -1:0] ex_data;
ex ex(
    .ds_ex_reg_data (ds_ex_reg_data ),
    .ex_data        (ex_data        ),
    .ex_rd          (ex_rd          ),
    .ex_fd_data     (ex_fd_data     ),
    .ex_memread     (ex_memread     )
);

// connect data_instr
wire [31:0] data_sram_addr;
wire [31:0] data_sram_wdata;
wire        data_sram_en;
wire        data_sram_we;
wire [ 2:0] data_sram_mode;
wire [ 2:0] data_sram_write_mode;
wire        data_sram_us;
wire [31:0] data_sram_rdata;

// connect with mem stage
wire [`MEM_DATA -1:0] mem_data;

// connect with mem_wb_reg
wire mem_to_wb_reg_valid;
wire mem_wb_reg_allow_in;

ex_Mem_reg ex_Mem_reg(
    .clk                 (clk                  ),
    .reset               (reset                ),
    .ex_data             (ex_data              ),
    .ex_to_mem_reg_valid (ex_to_mem_reg_valid  ),
    .ex_mem_reg_allow_in (ex_mem_reg_allow_in  ),
    .mem_wb_reg_allow_in (mem_wb_reg_allow_in  ),
    .mem_to_wb_reg_valid (mem_to_wb_reg_valid  ),
    .mem_data            (mem_data             ),
    .data_sram_addr      (data_sram_addr       ),
    .data_sram_wdata     (data_sram_wdata      ),
    .data_sram_en        (data_sram_en         ),
    .data_sram_we        (data_sram_we         ),
    .data_sram_mode      (data_sram_mode       ),
    .data_sram_write_mode(data_sram_write_mode ),
    .data_sram_us        (data_sram_us         ),
    .data_sram_rdata     (data_sram_rdata      )
);

data_ram data_ram(
    .clk                 (clk                  ),
    .data_sram_addr      (data_sram_addr       ),
    .data_sram_wdata     (data_sram_wdata      ),
    .data_sram_en        (data_sram_en         ),
    .data_sram_we        (data_sram_we         ),
    .data_sram_mode      (data_sram_mode       ),
    .data_sram_write_mode(data_sram_write_mode ),
    .data_sram_us        (data_sram_us         ),
    .data_sram_rdata     (data_sram_rdata      )
);

// connect with mem_wb_reg
wire [`MEM_DATA -1:0] mem_stage_data;
mem mem(
    .mem_data      (mem_data       ),
    .mem_stage_data(mem_stage_data ),
    .mem_rd        (mem_rd         ),
    .mem_fd_data   (mem_fd_data    )
);

// connect with wb stage
wire [`WB_DATA -1:0] wb_data;
mem_wb_reg mem_wb_reg(
    .clk                (clk                 ),
    .reset              (reset               ),
    .mem_stage_data     (mem_stage_data      ),
    .mem_to_wb_reg_valid(mem_to_wb_reg_valid ),
    .mem_wb_reg_allow_in(mem_wb_reg_allow_in ),
    .wb_data            (wb_data             )
);

wb wb(
    .wb_data (wb_data  ),
    .wb_wdata(wb_wdata ),
    .wb_rd   (wb_rd    ),
    .wb_we   (wb_we    )
);

endmodule
 