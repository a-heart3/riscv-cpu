`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2025 06:49:21 PM
// Design Name: 
// Module Name: comp_tb
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


module comp_tb();

reg [31:0] data1;
reg [31:0] data2;
wire       zero;
wire       cout;
wire       sign;

comp comp(
    .data1(data1 ),
    .data2(data2 ),
    .zero (zero  ),
    .cout (cout  ),
    .sign (sign  )
);

initial begin
    data1 = 32'd1;
    data2 = 32'd1;
    #10;
    data2 = 32'd2;
    #10;
    data1 = 31'd3;
end
endmodule
