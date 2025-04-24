`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 02:08:54 PM
// Design Name: 
// Module Name: ram
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


module ram(
    input         clk,
    input  [ 2:0] mode,
    input  [31:0] address,
    input  [31:0] wdata,
    output [31:0] rdata
);

// first analyse we signal
// we and cs signal define
wire we_0;
wire we_1;
wire we_2;
wire we_3;

wire [1:0] cs;

assign cs = address[1:0];

// mode, cs, use for analyse we signal
ram_we ram_we(
    .mode(mode ),
    .cs  (cs   ),
    .we0 (we_0 ),
    .we1 (we_1 ),
    .we2 (we_2 ),
    .we3 (we_3 )
);

// address define, need high 30 bits
wire [29:0] address_ram;

// data define
wire [7:0] rdata0;
wire [7:0] rdata1;
wire [7:0] rdata2;
wire [7:0] rdata3;

wire [7:0] wdata0;
wire [7:0] wdata1;
wire [7:0] wdata2;
wire [7:0] wdata3;

// assign
assign address_ram = address[31:2];
assign wdata0 = wdata[ 7: 0];
assign wdata1 = wdata[15: 8];
assign wdata2 = wdata[23:16];
assign wdata3 = wdata[31:24];

// read data logic
ram ram0(
    .a(address_ram),
    .d(wdata0),
    .clk(clk),

);


endmodule
