`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 01:38:43 PM
// Design Name: 
// Module Name: comtroller_tb
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


module comtroller_tb();

reg  [6:0] opcode;
reg  [2:0] func3;
wire       MemWrite;
wire       MemRead;
wire       RegWrite;
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

initial begin
    opcode <= 7'b011_0011;
    #5;
    opcode <= 7'b001_0011;
    #5;
    opcode <= 7'b000_0011;
    func3 <= 3'b000;
    #5;
    func3 <= 3'b001;
    #5;
    func3 <= 3'b010;
    #5;
    func3 <= 3'b100;
    #5;
    func3 <= 3'b101;
    #5;
    opcode <= 7'b010_0011;
    func3 <= 3'b000;
    #5;
    func3 <= 3'b001;
    #5;
    func3 <= 3'b010;
    #5;
    opcode <= 7'b110_0011;
    #5;
    opcode <= 7'b110_0111;
    #5;
    opcode <= 7'b110_1111;
    #5;
    opcode <= 7'b011_0111;
    #5;
    opcode <= 7'b001_0111;
end
endmodule
