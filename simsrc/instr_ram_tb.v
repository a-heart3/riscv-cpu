`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2025 09:31:38 PM
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
reg [31:0] addr;
reg [31:0] wdata;
reg we;
wire [31:0] rdata;

instr_ram instr_ram(
    .clk    (clk  ),
    .we     (we   ),
    .address(addr ),
    .wdata  (wdata),
    .rdata  (rdata)
);

initial begin
    clk = 0;
end

always begin
    #5;
    clk = ~clk;
end

initial begin
    addr = 32'd1;
    wdata = 32'd1;
    we = 0;
    #10;
    we = 1;
    #10;
    we = 0;

end
endmodule
