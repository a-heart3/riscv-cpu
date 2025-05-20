`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2025 04:05:50 PM
// Design Name: 
// Module Name: ds_ex_reg
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

module ds_ex_reg(
    input clk,
    input reset,
    // id and ds_ex_reg connect
    input                 load_use,
    input [`ID_DATA -1:0] ds_data,
    // fs_ds_reg and ds_ex_reg connect
    input ds_to_ex_reg_valid,
    output ds_ex_reg_allow_in,
    // ds_ex_reg and ex_mem_reg connect
    input ex_mem_reg_allow_in,
    output ex_to_mem_reg_valid,
    // data to next EX combination
    output [`ID_DATA -1:0] ds_ex_reg_data
);

// ds_ex_reg pipeline control signal
reg ds_ex_reg_valid;
wire ds_ex_reg_ready_go;

// ds_ex_reg definition
reg [`ID_DATA -1:0] data;

// reg tackle
assign ds_ex_reg_ready_go = 1'b1;
assign ds_ex_reg_allow_in = !ds_ex_reg_valid || ds_ex_reg_ready_go && ex_mem_reg_allow_in;
always @(posedge clk) begin
    if (reset | load_use) begin
        ds_ex_reg_valid <= 1'b0;
        data <= 122'd0;
    end
    else if(ds_ex_reg_allow_in && ds_to_ex_reg_valid) begin
        ds_ex_reg_valid <= ds_to_ex_reg_valid;
        data <= ds_data;
    end
end

assign ex_to_mem_reg_valid = ds_ex_reg_valid && ds_ex_reg_ready_go;
assign ds_ex_reg_data = data;

endmodule
