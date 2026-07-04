`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:28:16 PM
// Design Name: 
// Module Name: A_tb
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


module A_tb();

reg clk,rst;
reg [31:0]RD1;
wire [31:0]A;

A AReg(clk,rst,RD1,A);

initial begin
    {clk,rst}=0;  
end
always #5 clk=~clk;

initial begin
    rst = 1'b1;
  
    #20;
    rst = 1'b0;
    RD1= 32'haabbccdd;
    
    #20;
    RD1= 32'habcdef;
    
    #20;
    rst = 1'b1;
    
    #50;

    $finish;
    
end

endmodule