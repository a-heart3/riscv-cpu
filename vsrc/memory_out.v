`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2025 02:42:46 PM
// Design Name: 
// Module Name: memory_out
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


module memory_out(
    input  [ 7:0] data_0,
    input  [ 7:0] data_1,
    input  [ 7:0] data_2,
    input  [ 7:0] data_3,
    input  [ 2:0] mode,
    input         uint,
    input  [ 1:0] cs,
    output [31:0] data
);

// definition
wire [ 7:0] data8;
wire [15:0] data16;
wire [31:0] data32;

// assign
assign data8 = ({8{(cs == 2'b00)}} & data_0)
             | ({8{(cs == 2'b01)}} & data_1)
             | ({8{(cs == 2'b10)}} & data_2)
             | ({8{(cs == 2'b11)}} & data_3);

assign data16 = ({16{cs == 2'b00}} & {data_1, data_0})
              | ({16{cs == 2'b10}} & {data_3, data_2});

assign data32 = {data_3, data_2, data_1, data_0};

// zero and sign extension definition
wire [31:0] data8_zero;
wire [31:0] data8_sign;
wire [31:0] data16_zero;
wire [31:0] data16_sign;

// assign 
assign data8_zero = {{24{1'b0}}, data8};
assign data8_sign = {{24{data8[7]}}, data8};
assign data16_zero = {{16{1'b0}}, data16};
assign data16_sign = {{16{data16[15]}}, data16};

// select zero or extension definition
wire [31:0] data8_sel;
wire [31:0] data16_sel;

assign data8_sel = ({32{uint }} & data8_zero)
                 | ({32{~uint}} & data8_sign);

assign data16_sel = ({32{uint }} & data16_zero)
                  | ({32{~uint}} & data16_sign);

// select data
tmux3_1 mem_out(
    .src1  (data8_sel),
    .src2  (data16_sel),
    .src3  (data32),
    .sel   (mode),
    .result(data)
);

endmodule
