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
    output       MemWrite,
    output       RegWrite,
    output [3:0] ALUSrc,
    output [2:0] MemtoReg,
    output [4:0] ALUControl,
    output [2:0] BranchControl
);

// type definition
wire Rtype;
wire Itype;
wire lw;
wire sw;
wire Btype;
wire jalr;
wire jal;
wire lui;

// assign type
assign Rtype = (opcode == 7'b011_0011);
assign Itype = (opcode == 7'b001_0011);
assign lw    = (opcode == 7'b000_0011);
assign sw    = (opcode == 7'b010_0011);
assign Btype = (opcode == 7'b110_0011);
assign jalr  = (opcode == 7'b110_0111);
assign jal   = (opcode == 7'b110_1111);
assign lui   = (opcode == 7'b011_0111);

// MemWrite logic
assign MemWrite = sw;

// RegWrite logic
assign RegWrite = Rtype | Itype | lw | jalr | jal | lui;

// AluSrc logic
assign ALUSrc = ({4{Rtype     }} & 4'b0001)
              | ({4{Itype | lw}} & 4'b0010)
              | ({4{sw        }} & 4'b0100)
              | ({4{lui       }} & 4'b1000);

// MemtoReg logic
assign MemtoReg = ({3{Rtype | Itype | lui}} & 3'b001)
                | ({3{lw                 }} & 3'b010)
                | ({3{jal   | jalr       }} & 3'b100);

// ALUControl logic
assign ALUControl = {lui, sw, lw, Itype, Rtype};

// BranchControl logiv
assign BranchControl = {jal, jalr, Btype};

endmodule
