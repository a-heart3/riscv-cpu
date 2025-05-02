`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 03:01:36 PM
// Design Name: 
// Module Name: data_ram
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


module data_ram(
    input         clk,
    input         we,
    input  [ 2:0] mode,
    input  [31:0] address,
    input  [31:0] wdata,
    output [31:0] rdata
);

// first analyse we signal
// we and cs signal define
wire we0;
wire we1;
wire we2;
wire we3;

wire [1:0] cs;

assign cs = address[1:0];

// mode, cs, use for analyse we signal
ram_we ram_we(
    .mode(mode),
    .cs  (cs  ),
    .we  (we  ),
    .we0 (we0 ),
    .we1 (we1 ),
    .we2 (we2 ),
    .we3 (we3 )
);

// address define, need high 30 bits
wire [29:0] address_ram;

// data define
wire [7:0] rdata0;
wire [7:0] rdata1;
wire [7:0] rdata2;
wire [7:0] rdata3;

wire [7:0] wdata0;
wire [7:0] wdata1;
wire [7:0] wdata2;
wire [7:0] wdata3;

// assign
assign address_ram = address[31:2];
assign wdata0 = wdata[ 7: 0];
assign wdata1 = wdata[15: 8];
assign wdata2 = wdata[23:16];
assign wdata3 = wdata[31:24];

// read data logic
data_ram0 ram0(
    .a  (address_ram ),
    .d  (wdata0      ),
    .clk(clk         ),
    .spo(rdata0      ),
    .we (we0         )
);

data_ram1 ram1(
    .a  (address_ram ),
    .d  (wdata1      ),
    .clk(clk         ),
    .spo(rdata1      ),
    .we (we1         )
);

data_ram2 ram2(
    .a  (address_ram ),
    .d  (wdata2      ),
    .clk(clk         ),
    .spo(rdata2      ),
    .we (we2         )
);

data_ram3 ram3(
    .a  (address_ram ),
    .d  (wdata3      ),
    .clk(clk         ),
    .spo(rdata3      ),
    .we (we3         )
);

// define 16 bits data and 32 bits data
wire [15:0] data16_0;
wire [15:0] data16_1;
wire [31:0] data32;

assign data16_0 = {rdata1, rdata0};
assign data16_1 = {rdata3, rdata2};
assign data32 = {rdata3, rdata2, rdata1, rdata0};

// define select 16 bits result and 8 bits result
wire [ 7:0] data8_s;
wire [15:0] data16_s;

// cs 8 bits
assign data8_s = ({8{(cs == 2'b00)}} & rdata0)
             | ({8{(cs == 2'b01)}} & rdata1)
             | ({8{(cs == 2'b10)}} & rdata2)
             | ({8{(cs == 2'b11)}} & rdata3);

assign data16_s = ({16{(cs == 2'b00)}} & data16_0)
              | ({16{(cs == 2'b10)}} & data16_1);

// define extion bits
wire [31:0] data8;
wire [31:0] data16;

// extention logic
assign data8 = {{24{data8_s[7]}}, data8_s};
assign data16 = {{16{data16_s[15]}}, data16_s};

// data out logic
tmux3_1 Memout(
    .src1  (data8  ),
    .src2  (data16 ),
    .src3  (data32 ),
    .sel   (mode   ),
    .result(rdata  )
);
endmodule
