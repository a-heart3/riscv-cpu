`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2025 10:47:14 AM
// Design Name: 
// Module Name: mem_read_tb
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


module mem_read_tb();
reg  [ 1:0] data_sram_cs;
reg  [ 2:0] data_sram_mode;
reg  [31:0] data_sram_rdata;
reg         data_sram_us;
wire [31:0] rdata;

mem_read mem_read(
    .data_sram_cs   (data_sram_cs    ),
    .data_sram_mode (data_sram_mode  ),
    .data_sram_rdata(data_sram_rdata ),
    .data_sram_us   (data_sram_us    ),
    .rdata          (rdata           )
);

initial begin
    data_sram_rdata <= 32'hf1f2f3f4;
    data_sram_mode <= 3'b001;
    data_sram_us <= 1'b0;
    data_sram_cs <= 2'b00;
    #5;
    data_sram_cs <= 2'b01;
    #5;
    data_sram_cs <= 2'b10;
    #5;
    data_sram_cs <= 2'b11;
    #5;
    data_sram_us <= 1'b1;
    #5;
    data_sram_mode <= 3'b010;
    data_sram_cs <= 2'b00;
    #5;
    data_sram_cs <= 2'b10;
    #5;
    data_sram_us <= 1'b0;
    #5;
    data_sram_mode <= 3'b100;
    #5;
    data_sram_us <= 1'b1;
    #5;
    data_sram_cs <= 2'b01;
    
end
endmodule
