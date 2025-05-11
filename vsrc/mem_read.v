`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2025 09:51:03 AM
// Design Name: 
// Module Name: mem_we
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


module mem_read(
    input  [ 1:0] data_sram_cs,
    input  [ 2:0] data_sram_mode,
    input  [31:0] data_sram_rdata,
    input         data_sram_us,
    output [31:0] rdata
);

// data signal define
wire [7:0] data8_0;
wire [7:0] data8_1;
wire [7:0] data8_2;
wire [7:0] data8_3;

wire [15:0] data16_0;
wire [15:0] data16_1;

wire [ 7:0] data8_sel;
wire [15:0] data16_sel;

wire [31:0] data8_unsigned;
wire [31:0] data8_signed;
wire [31:0] data16_unsigned;
wire [31:0] data16_signed;

wire [31:0] data8;
wire [31:0] data16;
wire [31:0] data32;

assign data8_0 = data_sram_rdata[ 7: 0];
assign data8_1 = data_sram_rdata[15: 8];
assign data8_2 = data_sram_rdata[23:16];
assign data8_3 = data_sram_rdata[31:24];

assign data16_0 = data_sram_rdata[15: 0];
assign data16_1 = data_sram_rdata[31:16];

// cs tackle
wire cs0;
wire cs1;
wire cs2;
wire cs3;
wire [3:0] cs;

assign cs0 = (data_sram_cs == 2'b00);
assign cs1 = (data_sram_cs == 2'b01);
assign cs2 = (data_sram_cs == 2'b10);
assign cs3 = (data_sram_cs == 2'b11);
assign cs  = {cs3, cs2, cs1, cs0};

// 8 data
tmux4_1 #(8) data8_sel_result(
    .src1  (data8_0   ),
    .src2  (data8_1   ),
    .src3  (data8_2   ),
    .src4  (data8_3   ),
    .sel   (cs        ),
    .result(data8_sel )
);

// 16 data
assign data16_sel = ({16{cs0}} & data16_0)
                  | ({16{cs2}} & data16_1);

// 8 data extensions
assign data8_unsigned = {24'h000000, data8_sel};
assign data8_signed   = {{24{data8_sel[7]}}, data8_sel};

// 16 data extensions
assign data16_unsigned = {16'h0000, data16_sel};
assign data16_signed   = {{16{data16_sel[15]}}, data16_sel};

// extention select
wire [31:0] us;
assign us = {32{data_sram_us}};

assign data8 = (us & data8_unsigned) | (~us & data8_signed);
assign data16 = (us & data16_unsigned) | (~us & data16_signed);
assign data32 = data_sram_rdata;

// read data select
tmux3_1 #(32) readdata(
    .src1  (data8          ),
    .src2  (data16         ),
    .src3  (data32         ),
    .sel   (data_sram_mode ),
    .result(rdata          )
);

endmodule
