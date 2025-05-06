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
    output [3:0] MemtoReg,
    output [4:0] ALUControl,
    output [3:0] BranchControl
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

// BranchControl logiv
assign BranchControl = {auipc, jal, jalr, Btype};

endmodule
