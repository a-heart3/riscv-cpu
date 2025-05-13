`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2025 03:02:17 PM
// Design Name: 
// Module Name: mem_wb_reg
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

module mem_wb_reg(
  input clk,
  input reset,
  // mem adn mem_wb_reg connect
  input [`MEM_DATA -1:0] mem_stage_data,
  // ex_mem_reg and mem_wb_reg connect
  input mem_to_wb_reg_valid,
  output mem_wb_reg_allow_in,
  output [`WB_DATA -1:0] wb_data 
);

// mem_wb_reg pipeline control signal
reg mem_wb_reg_valid;
wire mem_wb_reg_ready_go;

// mem_wb_reg definition
reg [`MEM_DATA -1:0] data;

// reg tackle
assign mem_wb_reg_ready_go = 1'b1;
assign mem_wb_reg_allow_in = !mem_wb_reg_valid || mem_wb_reg_ready_go;
always @(posedge clk) begin
    if (reset) begin
        mem_wb_reg_valid <= 1'b0;
        data <= 73'd0;
    end
    else if(mem_wb_reg_allow_in && mem_to_wb_reg_valid) begin
        mem_wb_reg_valid <= mem_to_wb_reg_valid;
        data <= mem_stage_data;
    end
end

assign wb_data = data;
endmodule
