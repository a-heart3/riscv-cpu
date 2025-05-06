`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:29:33 PM
// Design Name: 
// Module Name: IF
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

module IF(
    input                      clk,
    input                      reset,
    // IF and fs_ds_reg transaction
    input                      fs_ds_reg_allow_in,
    output                     fs_to_ds_reg_valid,
    output [`FS_DATA     -1:0] fs_data,
    // Branch data
    input  [`BRANCH_DATA -1:0] branch_data,
    // instr_sram
    input  [31:0] instr,
    output [31:0] instr_sram_addr,
    output [31:0] instr_sram_wdata,
    output        instr_sram_en,
    output        instr_sram_we
);

// pc reg pipeline control signal
reg  pc_valid;
wire pc_ready_go;
wire pc_allow_in;
wire to_pc_valid;

// branch_data
wire [31:0] branch_addr;
wire        branch_control;
assign {branch_addr, branch_control} = branch_data;

// pc_next and pc_current and pc_seq
reg  [31:0] pc_current;
wire [31:0] pc_next;
wire [31:0] pc_seq;

assign pc_seq = pc_current + 32'd4;
assign pc_next = (branch_control) ? branch_addr : pc_seq;

// pc reg tackle
assign to_pc_valid = ~reset;
assign pc_ready_go = 1'b1;
assign pc_allow_in = !pc_valid || pc_ready_go && fs_ds_reg_allow_in;
always @(posedge clk) begin
    if (reset) begin
        pc_valid <= 1'b0;
        pc_current <= 32'hfffffffc;
    end
    else if (pc_allow_in) begin
        pc_valid <= to_pc_valid;
        pc_current <= pc_next;
    end
end

// access instr
assign instr_sram_addr  = pc_next;
assign instr_sram_en    = to_pc_valid && pc_allow_in;
assign instr_sram_we   = 1'b0;
assign instr_sram_wdata = 32'd0;

// data to send
assign fs_data = {instr, pc_current};
assign fs_to_ds_reg_valid = pc_valid && pc_ready_go;
endmodule
