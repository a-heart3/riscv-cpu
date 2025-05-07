`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 01:09:42 PM
// Design Name: 
// Module Name: controller
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


module controller(
    input  [6:0] opcode,
    input  [2:0] func3,
    output       MemWrite,
    output       MemRead,
    output       RegWrite,
    output [3:0] ALUSrc,
    output [3:0] MemtoReg,
    output [4:0] ALUControl,
    output [3:0] BranchControl,
    output [2:0] Mem_mode,              // memory type:8?16?32?
    output       Mem_read_us            // mem read unsigned or signed
);

// type definition
wire Rtype;
wire Itype;
wire ltype;
wire stype;
wire Btype;
wire jalr;
wire jal;
wire lui;
wire auipc;

// assign type
assign Rtype = (opcode == 7'b011_0011);
assign Itype = (opcode == 7'b001_0011);
assign ltype = (opcode == 7'b000_0011);
assign stype = (opcode == 7'b010_0011);
assign Btype = (opcode == 7'b110_0011);
assign jalr  = (opcode == 7'b110_0111);
assign jal   = (opcode == 7'b110_1111);
assign lui   = (opcode == 7'b011_0111);
assign auipc = (opcode == 7'b001_0111);

// MemWrite logic
assign MemWrite = stype;

// RegWrite logic
assign RegWrite = Rtype | Itype | ltype | jalr | jal | lui | auipc;

// AluSrc logic
assign ALUSrc = ({4{Rtype        }} & 4'b0001)
              | ({4{Itype | ltype}} & 4'b0010)
              | ({4{stype        }} & 4'b0100)
              | ({4{lui          }} & 4'b1000);

// MemtoReg logic
assign MemtoReg = ({4{Rtype | Itype | lui}} & 4'b0001)
                | ({4{ltype              }} & 4'b0010)
                | ({4{jal   | jalr       }} & 4'b0100)
                | ({4{auipc              }} & 4'b1000);

// ALUControl logic
assign ALUControl = {lui, stype, ltype, Itype, Rtype};

// BranchControl logic
assign BranchControl = {auipc, jal, jalr, Btype};

// MemRead logic
assign MemRead = ltype;

// Memmode logic
wire type8;
wire type16;
wire type32;

assign type8  = (func3 == 3'b000 | func3 == 3'b100);
assign type16 = (func3 == 3'b001 | func3 == 3'b101);
assign type32 = (func3 == 3'b010);

assign Mem_read_us = (func3 == 3'b100 | func3 == 3'b101);           // signed when Mem_read_us is 0, oherwise is unsigned
assign Mem_mode = {type32, type16, type8};
endmodule
