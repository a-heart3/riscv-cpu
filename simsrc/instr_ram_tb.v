`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 02:46:44 PM
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
reg we;
reg [2:0] mode;
reg [31:0] address;
reg [31:0] wdata;
wire [31:0] rdata;

instr_ram instr_ram(
    .clk    (clk     ),
    .we     (we      ),
    .mode   (mode    ),
    .address(address ),
    .wdata  (wdata   ),
    .rdata  (rdata   )
);

initial begin
    clk = 0;
end

always begin
    #5 clk = ~clk;
end

initial begin
    mode = 3'b100;
    wdata = 32'h87654321;
    address = 32'd0;
    we = 1;
    #10;
    we = 0;
    #10;
    mode = 3'b010;
    #10;
    mode = 3'b001;
    #10;
    we = 1;
    wdata = 32'h98badcfe;
    #10;
    address = 32'd1;
    #10;
    address = 32'd2;
    #10;
    address = 32'd3;
    #10;
    mode = 010;
    address = 32'd2;
    wdata = 32'h21436587;
    #10;
    address = 32'd0;
end

endmodule
