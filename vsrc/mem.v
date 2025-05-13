`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2025 02:30:50 PM
// Design Name: 
// Module Name: mem
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
`include "pipeline.vh"

module mem(
    input  [`MEM_DATA -1:0] mem_data,
    output [`MEM_DATA -1:0] mem_stage_data
);

/*
do nothing
everything has done by reg
*/

assign mem_stage_data = mem_data;

endmodule
