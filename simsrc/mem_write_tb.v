`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2025 02:28:35 PM
// Design Name: 
// Module Name: mem_write_tb
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


module mem_write_tb();

reg  [31:0] data_sram_wdata;
reg  [ 2:0] data_sram_mode;
reg  [ 1:0] data_sram_cs;
reg         data_sram_we;
wire [ 3:0] we;
wire [31:0] wdata;

mem_write mem_write(
    .data_sram_wdata(data_sram_wdata ),
    .data_sram_mode (data_sram_mode  ),
    .data_sram_cs   (data_sram_cs    ),
    .data_sram_we   (data_sram_we    ),
    .we             (we              ),
    .wdata          (wdata           )
);

initial begin
    data_sram_wdata <= 32'hf1f2f3f4;
    data_sram_mode <= 3'b001;
    data_sram_cs <= 2'b00;
    data_sram_we <= 1'b1;
    #5;
    data_sram_cs <= 2'b01;
    #5;
    data_sram_cs <= 2'b10;
    #5;
    data_sram_cs <= 2'b11;
    #5;
    data_sram_mode <= 3'b010;
    data_sram_cs <= 2'b10;
    #5;
    data_sram_cs <= 2'b00;
    #5;
    data_sram_mode <= 3'b100;
    #5;
    data_sram_cs <= 2'b01;
    #5;
    data_sram_we <= 1'b0;
end
endmodule
