`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 05:09:02 PM
// Design Name: 
// Module Name: ID_tb
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


module ID_tb();
reg clk;
reg [4:0] wb_rd;
reg wb_we;
reg [31:0] wb_wdata;
reg [63:0] fs_ds_reg_data;
wire [32:0] ds_branch_data;
wire [90:0] ds_data;

ID ID(
    .clk(clk),
    .fs_ds_reg_data(fs_ds_reg_data),
    .wb_wdata(wb_wdata),
    .wb_rd(wb_rd),
    .wb_we(wb_we),
    .ds_branch_data(ds_branch_data),
    .ds_data(ds_data)
);

always begin
    #5;
    clk <= ~clk;
end
initial begin
    clk <= 0;
    #10;
    wb_rd <= 5'b00001;
    wb_we <= 1'b1;
    wb_wdata <= 32'd1;
    #10;
    wb_rd <= 5'b00010;
    wb_wdata <= 32'd2;
    #10;
    wb_we <= 1'b0;
    fs_ds_reg_data <= 64'h002081b300000000;
    #10;
    fs_ds_reg_data <= 64'h0220906300000004;
end
endmodule
