`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 08:18:43 PM
// Design Name: 
// Module Name: if_id_reg
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

module fs_ds_reg(
    input clk,
    input reset,
    // IF and fs_ds_reg communication
    input                  fs_to_ds_reg_valid,
    input  [`FS_DATA -1:0] fs_data,
    output                 fs_ds_reg_allow_in,
    // fs_ds_reg ds_ex_reg communication(data flow through a combination logic)
    input  ds_ex_reg_allow_in,
    output ds_to_ex_reg_valid,
    // data to next ID combination logic
    input                  load_use,
    output [`FS_DATA -1:0] fs_ds_reg_data  
);

// fs_ds_reg pipeline control signal
reg  fs_ds_reg_valid;
wire fs_ds_reg_ready_go;

// fs_ds_reg definition
reg [`FS_DATA -1:0] data;

// reg tackle
assign fs_ds_reg_ready_go = !load_use;
assign fs_ds_reg_allow_in = !fs_ds_reg_valid || fs_ds_reg_ready_go && ds_ex_reg_allow_in;
always @(posedge clk) begin
    if (reset) begin
        fs_ds_reg_valid <= 1'b0;
        data  <= 64'd0;
    end
    else if (fs_ds_reg_allow_in && fs_to_ds_reg_valid) begin
        fs_ds_reg_valid <= fs_to_ds_reg_valid;
        data <= fs_data;
    end
end

assign ds_to_ex_reg_valid = fs_ds_reg_valid && fs_ds_reg_ready_go;
assign fs_ds_reg_data = data;
endmodule
