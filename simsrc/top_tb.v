`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 07:35:46 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();
reg         clk;
reg         reset;
reg  [ 4:0] wb_rd;
reg  [31:0] wb_wdata;
reg         wb_we;
reg         ex_mem_reg_allow_in;
wire        ex_to_mem_reg_valid;
wire [90:0] ds_ex_reg_data;

top top(
    .clk                (clk                 ),
    .reset              (reset               ),
    .wb_rd              (wb_rd               ),
    .wb_wdata           (wb_wdata            ),
    .wb_we              (wb_we               ),
    .ex_mem_reg_allow_in(ex_mem_reg_allow_in ),
    .ex_to_mem_reg_valid(ex_to_mem_reg_valid ),
    .ds_ex_reg_data     (ds_ex_reg_data      )
);

initial begin
    clk <= 1'b0;
    reset <= 1'b1;
    wb_rd <= 5'b00001;
    wb_wdata <= 32'd1;
    wb_we <= 1'b1;
    ex_mem_reg_allow_in <= 1'b0;
    #10;
    reset <= 1'b0;
    ex_mem_reg_allow_in = 1'b1;
    wb_rd <= 5'b00010;
    wb_wdata <= 32'd2;
    wb_we <= 1'b1;
    #10;
    wb_we <= 1'b0;
end

always begin
    #5;
    clk <= ~clk;
end

endmodule
