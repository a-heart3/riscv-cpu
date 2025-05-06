`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 06:37:02 PM
// Design Name: 
// Module Name: instr_ram_tb
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


module instr_ram_tb();
reg clk;
reg  [31:0] instr_sram_addr;
reg  [31:0] instr_sram_wdata;
reg         instr_sram_we;
reg         instr_sram_en;
wire [31:0] instr;

instr_ram instr_ram(
    .clk(clk),
    .instr_sram_addr(instr_sram_addr),
    .instr_sram_wdata(instr_sram_wdata),
    .instr_sram_we(instr_sram_we),
    .instr_sram_en(instr_sram_en),
    .instr(instr)
);

always begin
    #10;
    clk = ~clk;
end

initial begin
    clk = 0;
    instr_sram_en = 0;
    instr_sram_wdata = 32'd0;
    instr_sram_addr = 32'd0;
    instr_sram_we = 0;
    #20;
    instr_sram_addr = 32'd1;
end

always begin
    #5;
    instr_sram_en = ~instr_sram_en;
end
endmodule
