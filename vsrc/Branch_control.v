`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 04:55:59 PM
// Design Name: 
// Module Name: Branch_control
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


module Branch_control(
    input  [ 3:0] BranchControl,
    input  [31:0] data1,
    input  [31:0] data2,
    input  [ 2:0] func3, 
    output [ 4:0] branch_type 
);

// type
wire Btype = BranchControl[0];
wire jalr  = BranchControl[1];
wire jal   = BranchControl[2]; 
wire auipc = BranchControl[3];

// comp module
wire zero;
wire slt;
wire sltu;

comp comp(
    .data1(data1  ),
    .data2(data2  ),
    .zero (zero   ),
    .slt  (slt    ),
    .sltu (sltu   )
);

// logic
wire beq;
wire bne;
wire blt;
wire bltu;
wire bge;
wire bgeu;

assign beq  = (func3 == 3'b000);
assign bne  = (func3 == 3'b001);
assign blt  = (func3 == 3'b100);
assign bge  = (func3 == 3'b101);
assign bltu = (func3 == 3'b110);
assign bgeu = (func3 == 3'b111);

wire pc_btype;
wire pc_jal;
wire pc_jalr;
wire pc_4;
wire pc_auipc;

assign pc_btype = Btype & 
            ( (beq  & zero ) | (bne  & ~zero)
            | (blt  & slt  ) | (bge  & ~slt)
            | (bltu & sltu ) | (bgeu & ~sltu));

assign pc_jal = jal;
assign pc_jalr = jalr;
assign pc_auipc = auipc;
assign pc_4 = ~pc_btype & ~pc_jal & ~pc_jalr & ~pc_auipc;

assign branch_type = {pc_auipc, pc_jalr, pc_jal, pc_btype, pc_4};
endmodule
