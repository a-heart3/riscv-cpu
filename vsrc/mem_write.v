`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2025 11:11:16 AM
// Design Name: 
// Module Name: mem_write
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


module mem_write(
    input  [31:0] data_sram_wdata,
    input  [ 2:0] data_sram_mode,
    input  [ 1:0] data_sram_cs,
    input         data_sram_we,
    output [ 3:0] we,
    output [31:0] wdata
);

// mode signal define
wire mode8;
wire mode16;
wire mode32;
assign {mode32, mode16, mode8} = data_sram_mode;

// data signal define
wire [31:0] wdata8_0;
wire [31:0] wdata8_1;
wire [31:0] wdata8_2;
wire [31:0] wdata8_3;

wire [31:0] wdata16_0;
wire [31:0] wdata16_1;

wire [31:0] wdata8;
wire [31:0] wdata16;
wire [31:0] wdata32;

assign wdata8_0 = {24'h000000, data_sram_wdata[7:0]};
assign wdata8_1 = {16'h0000, data_sram_wdata[7:0], 8'h00};
assign wdata8_2 = {8'h00, data_sram_wdata[7:0], 16'h0000};
assign wdata8_3 = {data_sram_wdata[7:0], 24'h000000};

assign wdata16_0 = {16'h0000, data_sram_wdata[15:0]};
assign wdata16_1 = {data_sram_wdata[15:0], 16'h0000};

// cs tackle
wire cs0;
wire cs1;
wire cs2;
wire cs3;
wire [3:0] cs;

assign cs0 = {data_sram_cs == 2'b00};
assign cs1 = {data_sram_cs == 2'b01};
assign cs2 = {data_sram_cs == 2'b10};
assign cs3 = {data_sram_cs == 2'b11};
assign cs  = {cs3, cs2, cs1,cs0};

// 8 data
tmux4_1 #(32) data8_sel(
    .src1  (wdata8_0 ),
    .src2  (wdata8_1 ),
    .src3  (wdata8_2 ),
    .src4  (wdata8_3 ),
    .sel   (cs       ),
    .result(wdata8   )
);

// 16 data
assign wdata16 = ({32{cs0}} & wdata16_0)
              |  ({32{cs2}} & wdata16_1);

// 32 data
assign wdata32 = data_sram_wdata;

// wdara select
tmux3_1 #(32) wdata_select(
    .src1  (wdata8         ),
    .src2  (wdata16        ),
    .src3  (wdata32        ),
    .sel   (data_sram_mode ),
    .result(wdata          )
);

// we signal tackle
wire we0;
wire we1;
wire we2;
wire we3;
assign we0 = data_sram_we & ((mode8 & cs0) | (mode16 & cs0) | mode32);
assign we1 = data_sram_we & ((mode8 & cs1) | (mode16 & cs0) | mode32);
assign we2 = data_sram_we & ((mode8 & cs2) | (mode16 & cs2) | mode32);
assign we3 = data_sram_we & ((mode8 & cs3) | (mode16 & cs2) | mode32);
assign we = {we3, we2, we1, we0};
endmodule
 