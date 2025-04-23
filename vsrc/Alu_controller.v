`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 01:41:36 PM
// Design Name: 
// Module Name: Alu_controller
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


module Alu_controller(
    input  [ 4:0] ALUControl,
    input  [ 2:0] func3,
    input         instr30,
    output [10:0] OpControl
);

// type definition
wire Rtype;
wire Itype;
wire lw;
wire sw;
wire lui;

// type definition
assign Rtype = ALUControl[0];
assign Itype = ALUControl[1];
assign lw    = ALUControl[2];
assign sw    = ALUControl[3];
assign lui   = ALUControl[4];

// op definition
wire op_add;
wire op_sub;
wire op_sll;
wire op_xor;
wire op_srl;
wire op_sra;
wire op_or;
wire op_and;
wire op_slt;
wire op_sltu;
wire op_lui;

// add logic
assign op_add  = (Rtype & ~instr30 & (func3 == 3'b000))
               | (Itype & (func3 == 3'b000))
               | lw
               | sw;

// sub logic
assign op_sub  = Rtype & (func3 == 3'b000) & instr30;

// sll logic
assign op_sll  = (Rtype | Itype) & (func3 == 3'b001) & ~instr30;

// xor logic
assign op_xor  = (Rtype | Itype) & (func3 == 3'b100);

// srl logic
assign op_srl  = (Rtype | Itype) & (func3 == 3'b101) & ~instr30;

// sra logic
assign op_sra  = (Rtype | Itype) & (func3 == 3'b101) & instr30;

// or logic 
assign op_or   = (Rtype | Itype) & (func3 == 3'b110);

// and logic
assign op_and  = (Rtype | Itype) & (func3 == 3'b111);

// slt logic 
assign op_slt  = (Rtype | Itype) & (func3 == 3'b010);

// sltu logic
assign op_sltu = (Rtype | Itype) & (func3 == 3'b011);

// lui logic
assign op_lui  = lui;

assign OpControl = {op_lui, op_sltu, op_slt, op_and, op_or, op_sra, op_srl, op_xor, op_sll, op_sub, op_add};
endmodule
