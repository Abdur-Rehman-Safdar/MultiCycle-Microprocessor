`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:32:25 PM
// Design Name: 
// Module Name: WriteData_tb
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


module WriteData_tb();



reg clk,rst;
reg [31:0]RD2;
wire [31:0]WriteData;

WriteData WriteDataReg(clk,rst,RD2,WriteData);

initial begin
    {clk,rst}=0;  
end
always #5 clk=~clk;

initial begin
    rst = 1'b1;
  
    #20;
    rst = 1'b0;
    RD2= 32'haabbccdd;
    
    #20;
    RD2= 32'habcdef;
    
    #20;
    rst = 1'b1;
    
    #50;

    $finish;
    
end

endmodule
