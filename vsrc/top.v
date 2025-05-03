`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 03:53:48 PM
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


module top(
    input clk,
    input rst,
    output [31:0] pc_current_out,
    output [31:0] pc_next_out,
    output [31:0] instr_out,
    output [31:0] data1_out,
    output [31:0] data2_out,
    output [31:0] aluresult_out,
    output [31:0] data_out,
    output MemWrite,
    output [31:0] wdata_out
); 

// IF
// IF input definition
wire [31:0] pc_next;

// IF output definition
wire [31:0] pc_current;
wire [31:0] instr;

// IF assign logic
pc pc(
    .clk       (clk        ),
    .rst       (rst        ),
    .pc_next   (pc_next    ),
    .pc_current(pc_current )
);
/*
instruction_ram instruction_ram(
    .clk(clk        ),
    .we (1'b0       ), // instruction ram can not wrtie
    .a  (pc_current ),
    .d  (32'd1      ), // anything, write has been forbidden
    .spo(instr      )
);
*/


instr_ram instr_ram(
    .clk    (clk        ),
    .we     (1'b0       ),
    .func3  (3'b010     ),
    .address(pc_current ),
    .wdata  (32'd1      ),
    .rdata  (instr      )
);


// ID
// ID control input definition, branch_control need data1, data2 has been definited
wire [6:0] opcode;
wire [2:0] func3;
wire       instr30;

// ID control output definition, RegWrite, AluSrc has been definition
wire [ 4:0] ALUControl;
wire [ 3:0] BranchControl;
wire        MemWrite;
wire        RegWrite;
wire [ 3:0] AluSrc;
wire [ 3:0] MemtoReg;
wire [ 4:0] branch_type;
wire [10:0] ALUop;

// ID control assign logic
assign opcode = instr[6:0];
assign instr30 = instr[30];
assign func3 = instr[14:12];

controller controller(
    .opcode       (opcode        ),
    .MemWrite     (MemWrite      ),
    .RegWrite     (RegWrite      ),
    .ALUSrc       (AluSrc        ),
    .MemtoReg     (MemtoReg      ),
    .ALUControl   (ALUControl    ),
    .BranchControl(BranchControl )
);

Branch_control Branch_control(
    .BranchControl(BranchControl ),
    .data1        (rdata1         ),
    .data2        (rdata2         ),
    .func3        (func3         ),
    .branch_type  (branch_type   )
);

Alu_controller Alu_controller(
    .ALUControl(ALUControl ),
    .func3     (func3      ),
    .instr30   (instr30    ),
    .OpControl (ALUop      )
);

// ID datapath input definition, instr has been definite, RegWrite, AluSrc has been definition
wire [ 4:0] rs1;
wire [ 4:0] rs2;
wire [ 4:0] rd;
wire [31:0] wdata;
wire [31:0] src1;
wire [31:0] src2;
wire [31:0] src3;
wire [31:0] src4;

// ID datapath output definition
wire [31:0] rdata1;
wire [31:0] rdata2;
wire [31:0] src;

// ID datapath assign
assign rs1 = instr[19:15];
assign rs2 = instr[24:20];
assign rd  = instr[11: 7];
regfile regfile(
    .clk   (clk      ),
    .we    (RegWrite ),
    .raddr1(rs1      ),
    .raddr2(rs2      ),
    .waddr (rd       ),
    .wdata (wdata    ),
    .rdata1(rdata1   ),
    .rdata2(rdata2   )
);

assign src1 = rdata2;
assign src2 = {{20{instr[31]}}, instr[31:20]};  // Itype
assign src3 = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // sw
assign src4 = {{12{instr[31]}}, instr[31:12]}; // lui

tmux4_1 tmux4_1_src(
    .src1  (src1   ),
    .src2  (src2   ),
    .src3  (src3   ),
    .src4  (src4   ),
    .sel   (AluSrc ),
    .result(src    )
);

// ID branch input definition, branch_type has been definition before
wire [31:0] pc_next1;
wire [31:0] pc_next2;
wire [31:0] pc_next3;
wire [31:0] pc_next4;
wire [31:0] pc_next5;
wire [31:0] pc_4;
wire [31:0] offset_btype;
wire [31:0] offset_jal;
wire [31:0] offset_jalr;
wire [31:0] offset_auipc;

// ID branch output definition, pc_next has been definition before
// ID branch assign logic
assign pc_4 = pc_current + 32'd4;
assign offset_btype = {{20{instr[31]}}, instr[ 7], instr[30:25], instr[11: 8], 1'b0};
assign offset_jal   = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
assign offset_jalr  = ({{20{instr[31]}}, instr[31:20]} + rdata1) & 32'hfffffffe;   // last bit is 0
assign offset_auipc = {instr[31:12], 12'd0};
assign pc_next1 = pc_4;
add add2(.data1(pc_4), .data2(offset_btype), .add_result(pc_next2));
add add3(.data1(pc_4), .data2(offset_jal  ), .add_result(pc_next3));
add add4(.data1(pc_4), .data2(offset_jalr ), .add_result(pc_next4));
add add5(.data1(pc_4), .data2(offset_auipc), .add_result(pc_next5));


tmux5_1 tmux5_1_pcnext(
    .src1  (pc_next1    ),
    .src2  (pc_next2    ),
    .src3  (pc_next3    ),
    .src4  (pc_next4    ),
    .src5  (pc_next5    ),
    .sel   (branch_type ),
    .result(pc_next     )
);

// EX
// EX input definition, Aluop has been definition
wire [31:0] alu_operator1;
wire [31:0] alu_operator2;

// EX output definition
wire [31:0] aluresult;

// EX assign logic
assign alu_operator1 = rdata1;
assign alu_operator2 = src;
alu alu(
    .src1  (alu_operator1 ),
    .src2  (alu_operator2 ),
    .sel   (ALUop         ),
    .result(aluresult     )
);

// SW
// SW input definition, aluresult(addr), rdata2(wdata), MemWrite has been definited
// SW output definition
wire [31:0] Memdata;

// SW assign logic
/*
data_ram data_ram(
    .clk(clk       ),
    .we (MemWrite  ),
    .a  (aluresult ),
    .d  (rdata2    ),
    .spo(Memdata   )
);
*/

data_ram data_ram(
    .clk    (clk       ),
    .we     (MemWrite  ),
    .func3  (func3     ),
    .address(aluresult ),
    .wdata  (rdata2    ),
    .rdata  (Memdata   )
);


// WB
// WB input definition, pc_4, Memdata, aluresult has been definition
// WB output definition, wdata has been definition
// WB assign logic
tmux4_1 tmux4_1_mem2reg(
    .src1  (aluresult ),
    .src2  (Memdata   ),
    .src3  (pc_4      ),
    .src4  (pc_next5  ),
    .sel   (MemtoReg  ),
    .result(wdata     )
);

// use to test
assign pc_current_out = pc_current;
assign pc_next_out = pc_next;
assign instr_out = instr;
assign data1_out = rdata1;
assign data2_out = rdata2;
assign aluresult_out = aluresult;
assign data_out = Memdata;
assign wdata_out = wdata;

endmodule
