`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 08:03:17 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input           clk,
    input           we,
    input   [4:0]   raddr1,
    input   [4:0]   raddr2,
    input   [4:0]   waddr,
    input   [31:0]  wdata,
    output  [31:0]  rdata1,
    output  [31:0]  rdata2
);
reg [31:0]  reg_array[31:0];

//write
always @(posedge clk) begin
    if (we) reg_array[waddr] <= wdata;
end

//read here register 0 is always 0
assign rdata1 = (raddr1 == 5'b0) ? 32'b0 : reg_array[raddr1];
assign rdata2 = (raddr2 == 5'b0) ? 32'b0 : reg_array[raddr2]; 

endmodule
