`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 08:26:01 PM
// Design Name: 
// Module Name: ram_we
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


module ram_we(
    input         we,
    input  [ 2:0] mode,
    input  [ 1:0] cs,
    input  [31:0] wdata_in,
    output        we0,
    output        we1,
    output        we2,
    output        we3,
    output [31:0] wdata
); 

// signal definition
wire wdata32;
wire wdata16;
wire wdata8;

assign wdata32 = mode[2];
assign wdata16 = mode[1];
assign wdata8  = mode[0];

// data definition
wire [31:0] wdata_8;
wire [31:0] wdata_16;
wire [31:0] wdata_32;

// data assign
assign wdata_8 = ({32{(cs == 2'b00)}} & {24'b0, wdata_in[7:0]})
               | ({32{(cs == 2'b01)}} & {16'b0, wdata_in[7:0],  8'b0})
               | ({32{(cs == 2'b10)}} & { 8'b0, wdata_in[7:0], 16'b0})
               | ({32{(cs == 2'b11)}} & {wdata_in[7:0], 24'b0});

assign wdata_16 = ({32{(cs == 2'b00)}} & {16'b0, wdata_in[15:0]})
                | ({32{(cs == 2'b10)}} & {wdata_in[15:0], 16'b0});

assign wdata_32 = wdata_in;            

// signal logic
assign we3 = (wdata32
           | ((cs == 2'b10) & wdata16)
           | ((cs == 2'b11) & wdata8))
           & we;

assign we2 = (wdata32
           | ((cs == 2'b10) & wdata16)
           | ((cs == 2'b10) & wdata8))
           & we;

assign we1 = (wdata32
           | ((cs == 2'b00) & wdata16)
           | ((cs == 2'b01) & wdata8))
           & we;

assign we0 = (wdata32
           | ((cs == 2'b00) & wdata16)
           | ((cs == 2'b00) & wdata8))
           & we;           
        
tmux3_1 wdata_sel(
    .src1  (wdata_8  ),
    .src2  (wdata_16 ),
    .src3  (wdata_32 ),
    .sel   (mode     ),
    .result(wdata    )
);

endmodule
