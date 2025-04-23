`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 02:18:43 PM
// Design Name: 
// Module Name: ALU_controller_tb
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


module ALU_controller_tb();
reg  [4:0]  ALUControl;
reg  [2:0]  func3;
reg         instr30;
wire [10:0] OpControl;

Alu_controller Alu_controller(
    .ALUControl(ALUControl ),
    .func3     (func3      ),
    .instr30   (instr30    ),
    .OpControl (OpControl  )
);

always begin
    #40;
    instr30 = ~instr30;
end

always begin
    #5
    func3 = func3 + 1;
end

initial begin
    instr30 = 0;
    ALUControl = 5'b00000;
    func3  = 3'b000;
    #80;
    ALUControl = 5'b00001;
    #80;
    ALUControl = 5'b00010;
    #80;
    ALUControl = 5'b00100;
    #80;
    ALUControl = 5'b01000;
    #80;
    ALUControl = 5'b10000;
end
endmodule
