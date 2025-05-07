`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 02:43:24 PM
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
    input [4:0] wb_rd,
    input wb_we,
    input [31:0] wb_wdata,
    input [`FS_DATA -1:0] fs_data,
    output [`BRANCH_DATA -1:0] branch_data
);

// split fs_data
wire [31:0] pc;
wire [31:0] instr;
assign pc = fs_data[31:0];
assign instr = fs_data[63:32];

// generate control signal
// split instr to generate control signal;
wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] func3;
wire [4:0] rs1;
wire [4:0] rs2;
wire       instr30;

assign {rs2, rs1, func3, rd, opcode} = instr[24:0];
assign instr30 = instr[30];

// wire definition for control signal
//controller
wire       MemWrite;
wire       MemRead;
wire       RegWrite;
wire [3:0] ALUSrc;
wire [3:0] MemtoReg;
wire [4:0] ALUControl;
wire [3:0] BranchControl;
wire [2:0] Mem_mode;
wire       Mem_read_us;

// branch_controller
wire [31:0] data1;
wire [31:0] data2;
wire [3:0] branch_type;
wire is_branch;

// Alu_controller
wire [10:0] OpControl;

// combination logic
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

Branch_control Branch_control(
    .BranchControl(BranchControl ),
    .data1        (data1         ),
    .data2        (data2         ),
    .func3        (func3         ),
    .branch_type  (branch_type   ),
    .is_branch    (is_branch     )
);

Alu_controller Alu_controller(
    .ALUControl(ALUControl ),
    .func3     (func3      ),
    .instr30   (instr30    ),
    .OpControl (Opcontrol  )
);


// ALUSrc generate
// immediate data
wire [19:0] lui_imme;
wire [11:0] itype_imme;
wire [11:0] stype_imme;
assign lui_imme = instr[31:12];
assign itype_imme = instr[31:20];
assign stype_imme = {instr[31:25], instr[11:7]};

// data
wire [31:0] lui_data;
wire [31:0] itype_data;
wire [31:0] stype_data;
assign lui_data = {{12{lui_imme[19]}}, lui_imme};
assign itype_data = {{20{itype_imme[11]}}, itype_data};
assign stype_data = {{20{stype_imme[11]}}, stype_data};

regfile regfile(
    .clk   (clk      ),
    .we    (wb_we    ),
    .raddr1(rs1      ),
    .raddr2(rs2      ),
    .waddr (wb_rd    ),
    .wdata (wb_wdata ),
    .rdata1(data1    ),
    .rdata2(data2    )
);





endmodule
