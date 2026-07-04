`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:00:39 PM
// Design Name: 
// Module Name: OldPC_tb
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


module OldPC_tb();

reg clk,rst;
reg [31:0]pc_out;
wire [31:0]OldPC;

OldPC Old_PC(clk,rst,pc_out,OldPC);

initial begin
    {clk,rst}=0;  
end
always #5 clk=~clk;

initial begin
    rst = 1'b1;

    #20;
    rst = 1'b0;
    pc_out= 32'haabbccdd;

    #20;
    rst = 1'b1;
    
    #20;
    rst = 1'b0;
    pc_out= 32'habcdef;
    
    #50;
    $finish;
    
end
endmodule
