`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2025 05:44:47 PM
// Design Name: 
// Module Name: ID
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

module ID(
    input clk,
    // data from fs_ds_reg
    input [`FS_DATA -1:0] fs_ds_reg_data,
    // data from wb
    input [31:0] wb_wdata,
    input [ 4:0] wb_rd,
    input        wb_we,
    // branch data to pc
    output [`BRANCH_DATA -1:0] ds_branch_data,
    // branch data to id_ex_reg
    output [`ID_DATA -1:0] ds_data,
    // data risk access
    input  [ 4:0] ex_rd,
    input  [ 4:0] mem_rd,
    input         ex_memread,
    input  [31:0] ex_data,
    input  [31:0] mem_data,
//    output        is_branch,
    output        load_use
);

// ID input data
wire [31:0] instr;
wire [31:0] pc;
assign instr = fs_ds_reg_data[`FS_DATA -1: `FS_DATA -32];
assign pc    = fs_ds_reg_data[`FS_DATA -33: 0];


// ID output DATA
// controller
wire ds_MemWrite;
wire ds_MemRead;
wire ds_RegWrite;
wire [3:0] ds_MemtoReg;
wire [2:0] ds_Mem_mode;
wire       ds_Mem_read_us;
// branch control
wire [31:0] ds_branch_addr;
wire        ds_branch_control;
// ALU control
wire [10:0] ds_OpControl;
// data for use
wire [31:0] ds_data1;
wire [31:0] ds_data2;
wire [ 4:0] ds_rd; 
wire [31:0] ds_rdata2;

// split 
wire        instr30;
wire [ 6:0] opcode;
wire [ 4:0] rd;
wire [ 2:0] func3;
wire [ 4:0] rs1;
wire [ 4:0] rs2;

assign instr30 = instr[30];
assign opcode  = instr[ 6: 0];
assign rd      = instr[11: 7];
assign func3   = instr[14:12];
assign rs1     = instr[19:15];
assign rs2     = instr[24:20];

// connect with controller
// signal definition
wire MemWrite;
wire MemRead;
wire RegWrite;
wire [3:0] ALUSrc;
wire [3:0] MemtoReg;
wire [4:0] ALUControl;
wire [3:0] BranchControl;
wire [2:0] Mem_mode;
wire       Mem_read_us;

controller controller(
    .opcode       (opcode        ),
    .func3        (func3         ),
    .MemWrite     (MemWrite      ),
    .MemRead      (MemRead       ),
    .RegWrite     (RegWrite      ),
    .ALUSrc       (ALUSrc        ),
    .MemtoReg     (MemtoReg      ),
    .ALUControl   (ALUControl    ),
    .BranchControl(BranchControl ),
    .Mem_mode     (Mem_mode      ),
    .Mem_read_us  (Mem_read_us   )
);

// connect with Alu_controller
// signal define
wire [10:0] OpControl;

Alu_controller Alu_controller(
    .ALUControl(ALUControl),
    .func3(func3),
    .instr30(instr30),
    .OpControl(OpControl)
);

// connect with branch_controller
// signal define
wire [31:0] rdata1;
wire [31:0] rdata2;
wire [ 3:0] branch_type;
wire        branch_control;
wire [31:0] reg_data1;
wire [31:0] reg_data2;

Branch_control Branch_control(
    .BranchControl (BranchControl ),
    .data1         (reg_data1     ),
    .data2         (reg_data2     ),
    .func3         (func3         ),
    .branch_type   (branch_type   ),
    .branch_control(branch_control)
);

// branch address
wire [31:0] offset_btype;
wire [31:0] offset_jal;
wire [31:0] offset_jalr;
wire [31:0] offset_auipc;
wire [31:0] offset;
wire [31:0] branch_addr;

assign offset_btype = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
assign offset_jal   = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
assign offset_jalr  = {{20{instr[31]}}, instr[31:20], instr[20], instr[30:21], 1'b0};
assign offset_auipc = {instr[31:12], 12'd0};

// select offset
tmux4_1 #(32) offset_select(
    .src1  (offset_btype ),
    .src2  (offset_jal   ),
    .src3  (offset_jalr  ),
    .src4  (offset_auipc ),
    .sel   (branch_type  ),
    .result(offset       )
);

add add(.data1(pc), .data2(offset), .add_result(branch_addr));

// access regfile
regfile rf(
    .clk   (clk      ),
    .we    (wb_we    ),
    .raddr1(rs1      ),
    .raddr2(rs2      ),
    .waddr (wb_rd    ),
    .wdata (wb_wdata ),
    .rdata1(rdata1   ),
    .rdata2(rdata2   )
);

// select forward_mode
wire [3:0] fd_mode_rs1;
wire [3:0] fd_mode_rs2;
wire load_use_rs1;
wire load_use_rs2;

forward_judge forward_judge_rs1(
    .rs        (rs1          ),
    .ex_rd     (ex_rd        ),
    .mem_rd    (mem_rd       ),
    .wb_rd     (wb_rd        ),
    .ex_memread(ex_memread   ),
    .fd_mode   (fd_mode_rs1  ),
    .load_use  (load_use_rs1 )
);

forward_judge forward_judge_rs2(
    .rs        (rs2          ),
    .ex_rd     (ex_rd        ),
    .mem_rd    (mem_rd       ),
    .wb_rd     (wb_rd        ),
    .ex_memread(ex_memread   ),
    .fd_mode   (fd_mode_rs2  ),
    .load_use  (load_use_rs2 )
);

tmux4_1 tmux4_1_regdata1(
    .src1  (ex_data     ),
    .src2  (mem_data    ),
    .src3  (wb_wdata    ),
    .src4  (rdata1      ),
    .sel   (fd_mode_rs1 ),
    .result(reg_data1   )
);

tmux4_1 tmux4_1_regdata2(
    .src1  (ex_data     ),
    .src2  (mem_data    ),
    .src3  (wb_wdata    ),
    .src4  (rdata2      ),
    .sel   (fd_mode_rs2 ),
    .result(reg_data2   )
);

// select src2
// signal define
wire [31:0] imme_itype;
wire [31:0] imme_stype;
wire [31:0] imme_lui;
wire [31:0] data2;

assign imme_itype = {{20{instr[31]}}, instr[31:20]};
assign imme_stype = {{20{instr[31]}}, instr[31:25], instr[11:7]};
assign imme_lui   = {{12{instr[31]}}, instr[31:12]};

tmux4_1 #(32) Srcselect(
    .src1  (reg_data2   ),
    .src2  (imme_itype ),
    .src3  (imme_stype ),
    .src4  (imme_lui   ),
    .sel   (ALUSrc     ),
    .result(data2      )
);

// output signal
assign ds_MemWrite = MemWrite;
assign ds_MemRead = MemRead;
assign ds_RegWrite = RegWrite;
assign ds_MemtoReg = MemtoReg;
assign ds_Mem_mode = Mem_mode;
assign ds_Mem_read_us = Mem_read_us;
assign ds_branch_addr = branch_addr;
assign ds_branch_control = branch_control;
assign ds_OpControl = OpControl;
assign ds_data1 = reg_data1;
assign ds_data2 = data2;
assign ds_rd = rd;
assign ds_rdata2 = rdata2;

// output data;
assign ds_data = {ds_MemWrite, ds_MemRead, ds_RegWrite, ds_MemtoReg, ds_Mem_mode,
                  ds_Mem_read_us, ds_OpControl, ds_data1, ds_data2, ds_rd, ds_rdata2};

assign ds_branch_data = {ds_branch_addr, ds_branch_control};

assign load_use = load_use_rs1 | load_use_rs2;

//assign is_branch = branch_control;

endmodule
