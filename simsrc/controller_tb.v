`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 01:29:24 PM
// Design Name: 
// Module Name: controller_tb
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


module controller_tb();
reg  [6:0] opcode;
wire [3:0] ALUSrc;
wire [2:0] MemtoReg;
wire [4:0] ALUControl;
wire [2:0] BranchControl;
wire       MemWrite;
wire       RegWrite;

controller comtroller (
    .opcode       (opcode        ),
    .MemWrite     (MemWrite      ),
    .RegWrite     (RegWrite      ),
    .ALUSrc       (ALUSrc        ),
    .MemtoReg     (MemtoReg      ),
    .ALUControl   (ALUControl    ),
    .BranchControl(BranchControl )
);

initial begin
    opcode = 7'b011_0011;
    #10;
    opcode = 7'b001_0011;
    #10;
    opcode = 7'b000_0011;
    #10;
    opcode = 7'b010_0011;
    #10;
    opcode = 7'b110_0011;
    #10;
    opcode = 7'b110_0111;
    #10;
    opcode = 7'b110_1111;
    #10;
    opcode = 7'b011_0111;
end
endmodule
