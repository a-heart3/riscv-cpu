`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 09:49:32 AM
// Design Name: 
// Module Name: alu
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


module alu(
    input  [31:0] src1,
    input  [31:0] src2,
    input  [10:0]  sel,
    output [31:0] result
);

wire op_add;
wire op_sub;
wire op_sll;
wire op_xor;
wire op_srl;
wire op_sra;
wire op_or ;
wire op_and;
wire op_slt;
wire op_sltu;
wire op_lui;

assign op_add  = sel[ 0];
assign op_sub  = sel[ 1];
assign op_sll  = sel[ 2];
assign op_xor  = sel[ 3];
assign op_srl  = sel[ 4];
assign op_sra  = sel[ 5];
assign op_or   = sel[ 6];
assign op_and  = sel[ 7];
assign op_slt  = sel[ 8];
assign op_sltu = sel[ 9];
assign op_lui  = sel[10];

// add and sub and compare
wire [31:0] adder_src1;
wire [31:0] adder_src2;
wire [31:0] adder_result;
wire [31:0] add_sub_result;
wire [31:0] slt_result;
wire [31:0] sltu_result;
wire        adder_cin;
wire        adder_cout;

// add and sub
assign adder_src1 = src1;
assign adder_src2 = (op_sub | op_slt | op_sltu) ? ~src2 : src2;
assign adder_cin  = (op_sub | op_slt | op_sltu) ?  1'b1 : 1'b0;
assign {adder_cout, adder_result} = adder_src1 + adder_src2 +adder_cin;
assign add_sub_result = adder_result;

// compare
assign slt_result[31:1] = 31'b0;
assign slt_result[0]    = (src1[31] & ~src2[31])
                        | (~(src1[31] ^ src2[31])) & adder_result[31];

assign sltu_result[31:1] = 31'b0;
assign sltu_result[0]    = ~adder_cout;


// shift
wire [31:0] sll_result;
wire [31:0] srl_result;
wire [31:0] sra_result;

assign sll_result = src1 << src2[4:0];
assign srl_result = src1 >> src2[4:0];
assign sra_result = ($signed(src1)) >>> src2[4:0];

// others
wire [31:0] xor_result;
wire [31:0] or_result;
wire [31:0] and_result;
wire [31:0] lui_result;

assign xor_result = src1 ^ src2;
assign or_result  = src1 | src2;
assign and_result = src1 & src2;
assign lui_result = {src2[19:0], 12'b0};

// result
assign result = ({32{op_add | op_sub}} & add_sub_result)
              | ({32{op_sll         }} & sll_result)
              | ({32{op_xor         }} & xor_result)
              | ({32{op_srl         }} & srl_result)
              | ({32{op_sra         }} & sra_result)
              | ({32{op_or          }} &  or_result)
              | ({32{op_and         }} & and_result)
              | ({32{op_slt         }} & slt_result)
              | ({32{op_sltu        }} & sltu_result)
              | ({32{op_lui         }} & lui_result);
endmodule
