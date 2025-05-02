`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2025 03:13:54 PM
// Design Name: 
// Module Name: memory_out_tb
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


module memory_out_tb();
reg  [ 7:0] data_0;
reg  [ 7:0] data_1;
reg  [ 7:0] data_2;
reg  [ 7:0] data_3;
reg  [ 2:0] mode;
reg         uint;
reg  [ 1:0] cs;
wire [31:0] data;

memory_out memory_out(
    .data_0(data_0),
    .data_1(data_1),
    .data_2(data_2),
    .data_3(data_3),
    .mode  (mode),
    .uint  (uint),
    .cs    (cs),
    .data(data)
);

initial begin
    data_0 = 8'h82;
    data_1 = 8'h94;
    data_2 = 8'ha6;
    data_3 = 8'hb8;
    uint = 1;
    mode = 3'b001;
    cs = 2'b00;
end

always begin
    #5;
    uint = ~uint;
    cs = cs + 1;
end

always begin
    #20;
    mode = mode + 1;
end
endmodule
