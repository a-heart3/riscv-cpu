`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2025 10:03:08 PM
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
    input  [31:0] data_sram_addr,
    input  [31:0] data_sram_wdata,
    input         data_sram_en,
    input         data_sram_we,
    input  [ 2:0] data_sram_mode,
    input         data_sram_us,
    output [31:0] data_sram_rdata
);

// split address
wire [ 1:0] cs;
wire [29:0] addr;
assign cs   = data_sram_addr[ 1:0];
assign addr = data_sram_addr[31:2];

// we data tackle
wire [ 3:0] we;
wire [31:0] wdata;
mem_write mem_write(
    .data_sram_wdata(data_sram_wdata ),
    .data_sram_mode (data_sram_mode  ),
    .data_sram_cs   (cs              ),
    .data_sram_we   (data_sram_we    ),
    .we             (we              ),
    .wdata          (wdata           )
);

// data ram
wire [ 7:0] rdata0;
wire [ 7:0] rdata1;
wire [ 7:0] rdata2;
wire [ 7:0] rdata3;
wire [31:0] rdata;

wire we0;
wire we1;
wire we2;
wire we3;

assign {we3, we2, we1, we0} = we;

data_ram0 data_ram0(
    .clka (clk          ),
    .ena  (data_sram_en ),
    .wea  (we0          ),
    .addra(addr         ),
    .dina (wdata        ),
    .douta(rdata0       )
);

data_ram1 data_ram1(
    .clka (clk          ),
    .ena  (data_sram_en ),
    .wea  (we1          ),
    .addra(addr         ),
    .dina (wdata        ),
    .douta(rdata1       )
);

data_ram2 data_ram2(
    .clka (clk          ),
    .ena  (data_sram_en ),
    .wea  (we2          ),
    .addra(addr         ),
    .dina (wdata        ),
    .douta(rdata2       )
);

data_ram3 data_ram3(
    .clka (clk          ),
    .ena  (data_sram_en ),
    .wea  (we3          ),
    .addra(addr         ),
    .dina (wdata        ),
    .douta(rdata3       )
);

assign rdata = {rdata3, rdata2, rdata1, rdata0};

// mem read
mem_read mem_read(
    .data_sram_cs   (cs              ),
    .data_sram_mode (data_sram_mode  ),
    .data_sram_rdata(rdata           ),
    .data_sram_us   (data_sram_us    ),
    .rdata          (data_sram_rdata )
);

endmodule
