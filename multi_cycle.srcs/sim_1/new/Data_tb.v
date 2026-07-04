`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:09:11 PM
// Design Name: 
// Module Name: Data_tb
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


module Data_tb();
reg clk,rst;
reg [31:0]ReadData;
wire [31:0]Data;

Data DataReg(clk,rst,ReadData,Data);

initial begin
    {clk,rst}=0;  
end
always #5 clk=~clk;

initial begin
    rst = 1'b1;
  
    #20;
    rst = 1'b0;
    ReadData = 32'haabbccdd;
    
    #20;
    ReadData= 32'habcdef;
    
    #20;
    rst = 1'b1;
    
    #50;

    $finish;
    
end

endmodule
