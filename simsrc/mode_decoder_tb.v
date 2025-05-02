`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2025 02:32:20 PM
// Design Name: 
// Module Name: mode_decoder_tb
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


module mode_decoder_tb();

reg [1:0] func3_2;
wire [2:0] mode;

mode_decoder mode_decoder(
    .func3_2(func3_2 ),
    .mode   (mode    )
);

initial begin
    func3_2 <= 2'b00;
    #5;
    func3_2 <= 2'b01;
    #5;
    func3_2 <= 2'b10;
end
endmodule
