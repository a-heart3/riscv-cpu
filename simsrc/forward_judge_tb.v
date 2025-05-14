`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2025 02:40:23 PM
// Design Name: 
// Module Name: forward_judge_tb
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


module forward_judge_tb();

reg [4:0] rs;
reg [4:0] ex_rd;
reg [4:0] mem_rd;
reg [4:0] wb_rd;
reg       ex_memread;
wire [3:0] fd_mode;
wire       load_use;

forward_judge forward_judge (
    .rs        (rs         ),
    .ex_rd     (ex_rd      ),
    .mem_rd    (mem_rd     ),
    .wb_rd     (wb_rd      ),
    .ex_memread(ex_memread ),
    .fd_mode   (fd_mode    ),
    .load_use  (load_use   )
);

initial begin
    rs <= 5'h00;
    ex_rd = 5'h01;
    mem_rd <= 5'h02;
    wb_rd <= 5'h03;
    ex_memread <= 1'b0;
    #5;
    rs <= 5'h01;
    #5;
    ex_memread <= 1'b1;
    #5;
    rs <= 5'h02;
    #5;
    rs <= 5'h03;
end

endmodule
