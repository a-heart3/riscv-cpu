`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 05:22:41 PM
// Design Name: 
// Module Name: branch_control_tb
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


module branch_control_tb();
reg  [ 2:0] BranchControl;
reg  [31:0] data1;
reg  [31:0] data2;
reg  [ 2:0] func3;
wire [ 3:0] branch_type;

Branch_control Branch_control(
    .BranchControl(BranchControl),
    .data1        (data1       ),
    .data2        (data2       ),
    .func3        (func3       ),
    .branch_type  (branch_type )
);

initial begin
    BranchControl = 3'b001;
    func3 = 3'b000;
    data1 = 32'd1;
    data2 = 32'd1;
    #5;
    data2 = 32'd2;
    #5; 
    func3 = 3'b001;
    #5;
    func3 = 3'b100;
    #5;
    func3 = 3'b101;
    #5;
    data1 = 32'd3;
    #5;
    func3 = 3'b110;
    #5;
    data2 = 32'd6;
    #5;
    func3 = 3'b111;
    #5;
    data1 = 32'd7;

    #10;
    BranchControl = 3'b010;
    #5;
    func3 = 3'b110;
    #5;
    func3 = 3'b101;
    #5;
    func3 = 3'b100;
    #5; 
    func3 = 3'b001;
    #5;
    func3 = 3'b000;

    #10;
    BranchControl = 3'b100;
    #5;
    func3 = 3'b001;
    #5;
    func3 = 3'b100;
    #5;
    func3 = 3'b101;
    #5;
    func3 = 3'b110;
    #5;
    func3 = 3'b111;

    #10;
    BranchControl = 3'b000;


end
endmodule
