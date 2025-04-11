`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 02:58:42 PM
// Design Name: 
// Module Name: comp_b
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


module comp( 
    input  [31:0] data1,
    input  [31:0] data2,
    output        zero,
    output        cout,
    output        sign
);

// use sub to finish compare
wire [31:0] adder_src1;
wire [31:0] adder_src2;
wire [31:0] adder_result;

assign adder_src1 = data1;
assign adder_src2 = ~data2 + 1'b1;
assign {cout, adder_result} = adder_src1 + adder_src2;

// judges
assign zero = (adder_result == 0);
assign sign = (adder_result[31]);

endmodule
