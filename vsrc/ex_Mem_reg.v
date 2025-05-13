`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2025 06:09:50 PM
// Design Name: 
// Module Name: ex_Mem_reg
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

module ex_Mem_reg(
    input clk,
    input reset,
    // ex and ex_Mem_reg connect
    input [`EX_DATA -1:0] ex_data,
    // ex_Mem_reg and ds_ex_reg connect
    input ex_to_mem_reg_valid,
    output ex_mem_reg_allow_in,
    // ex_Mem_reg and mem_wb_reg connect
    input mem_wb_reg_allow_in,
    output mem_to_wb_reg_valid,
    // data to Mem stage
    output [`MEM_DATA -1:0] mem_data,
    // output data ram
    output [31:0] data_sram_addr,
    output [31:0] data_sram_wdata,
    output        data_sram_en,
    output        data_sram_we,
    output [ 2:0] data_sram_mode,
    output [ 2:0] data_sram_write_mode,
    output        data_sram_us,
    input  [31:0] data_sram_rdata
);

// ex_mem_reg data
wire MemWrite;
wire MemRead;
wire RegWrite;
wire [ 3:0] MemtoReg;
wire [ 2:0] Mem_mode;
wire        Mem_read_us;
wire [31:0] rdata2;
wire [ 4:0] rd;
wire [31:0] result;
wire [`EX_MEM_DATA -1:0] ex_mem_reg_data;

assign {MemWrite, MemRead, RegWrite, MemtoReg,
        Mem_mode, Mem_read_us, rdata2, rd, result} = ex_data; 

assign ex_mem_reg_data = {RegWrite, MemtoReg, rd, result};

// ex_Mem_reg pipeline control
reg ex_mem_reg_valid;
wire ex_mem_reg_ready_go;

// ex_mem_reg definition
reg [`EX_MEM_DATA -1:0] data;
reg [2:0] mem_read_mode;
reg       mem_read_us; 

// reg tackle
assign ex_mem_reg_ready_go = 1'b1;
assign ex_mem_reg_allow_in = !ex_mem_reg_valid || ex_mem_reg_ready_go && mem_wb_reg_allow_in;
always @(posedge clk) begin
    if (reset) begin
        ex_mem_reg_valid <= 1'b0;
        data <= 42'd0;
        mem_read_mode <= 3'd0;
        mem_read_us <= 1'b0;
    end
    else if (ex_mem_reg_allow_in && ex_to_mem_reg_valid) begin
        ex_mem_reg_valid <= ex_to_mem_reg_valid;
        data <= ex_mem_reg_data;
        mem_read_mode <= Mem_mode;
        mem_read_us <= Mem_read_us;
    end
end

assign mem_to_wb_reg_valid = ex_mem_reg_valid && ex_mem_reg_ready_go;

// data ram
assign data_sram_addr  = result;
assign data_sram_en    = MemRead;
assign data_sram_we    = MemWrite && ex_mem_reg_valid;
assign data_sram_wdata = rdata2;
assign data_sram_mode  = mem_read_mode;
assign data_sram_us    = mem_read_us;
assign data_sram_write_mode = Mem_mode;

// out data
assign mem_data = {data, data_sram_rdata};
endmodule
