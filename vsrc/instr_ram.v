`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 05:20:52 PM
// Design Name: 
// Module Name: instr_ram
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


module instr_ram(
    input         clk,
    input  [31:0] instr_sram_addr,
    input  [31:0] instr_sram_wdata,
    input         instr_sram_we,
    input         instr_sram_en,
    output [31:0] instr
);

// data split
wire [7:0] instr0;
wire [7:0] instr1;
wire [7:0] instr2;
wire [7:0] instr3;

wire [7:0] wdata0;
wire [7:0] wdata1;
wire [7:0] wdata2;
wire [7:0] wdata3;

assign wdata0 = instr_sram_wdata[ 7: 0];
assign wdata1 = instr_sram_wdata[15: 8];
assign wdata2 = instr_sram_wdata[23:16];
assign wdata3 = instr_sram_wdata[31:24];

// address split
wire [29:0] instr_addr;
assign instr_addr = instr_sram_addr[31:2];

instr_ram0 instr_ram0(
    .clka (clk             ),
    .ena  (instr_sram_en   ),
    .wea  (instr_sram_we   ),
    .addra(instr_sram_addr ),
    .dina (wdata0          ),
    .douta(instr0          )
);

instr_ram1 instr_ram1(
    .clka (clk             ),
    .ena  (instr_sram_en   ),
    .wea  (instr_sram_we   ),
    .addra(instr_sram_addr ),
    .dina (wdata1          ),
    .douta(instr1          )
);

instr_ram2 instr_ram2(
    .clka (clk             ),
    .ena  (instr_sram_en   ),
    .wea  (instr_sram_we   ),
    .addra(instr_sram_addr ),
    .dina (wdata2          ),
    .douta(instr2          )
);

instr_ram3 instr_ram3(
    .clka (clk             ),
    .ena  (instr_sram_en   ),
    .wea  (instr_sram_we   ),
    .addra(instr_sram_addr ),
    .dina (wdata3          ),
    .douta(instr3          )
);

assign instr = {instr3, instr2, instr1, instr0};

endmodule
