`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2025 02:25:14 PM
// Design Name: 
// Module Name: mode_decoder
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


module mode_decoder(
    input  [1:0] func3_2,
    output [2:0] mode
);

assign mode = ({3{(func3_2 == 2'b00)}} & 3'b001)
            | ({3{(func3_2 == 2'b01)}} & 3'b010)
            | ({3{(func3_2 == 2'b10)}} & 3'b100);
endmodule
