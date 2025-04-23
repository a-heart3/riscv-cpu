`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 09:59:24 PM
// Design Name: 
// Module Name: add_tb
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


module add_tb();
reg [31:0] data1;
reg [31:0] data2;
wire [31:0] add_result;

add add(
    .data1(data1),
    .data2(data2),
    .add_result(add_result)
);

initial begin
    data1 = 32'd1;
    data2 = 32'd2;
    #5;
    data1 = 32'd3;
    data2 = 32'hffffffff;
end
endmodule
