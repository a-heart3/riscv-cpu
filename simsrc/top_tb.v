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
reg clk;
reg reset;
reg [32:0] branch_data;
reg  ds_ex_reg_allow_in;
wire ds_to_ex_reg_valid;
wire [63:0] fs_ds_reg_data;

top top(
    .clk               (clk               ),
    .reset             (reset             ),
    .ds_ex_reg_allow_in(ds_ex_reg_allow_in),
    .branch_data       (branch_data       ),
    .ds_to_ex_reg_valid(ds_to_ex_reg_valid),
    .fs_ds_reg_data    (fs_ds_reg_data    )
);

initial begin
    clk <= 1'b0;
    reset <= 1'b1;
    ds_ex_reg_allow_in = 1'b0;
    branch_data <= 33'h123456788;
    #10;
    reset <= 1'b0;
    ds_ex_reg_allow_in = 1'b1;
end

always begin
    #5;
    clk <= ~clk;
end

endmodule
