`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:06:22 PM
// Design Name: 
// Module Name: Data
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


module Data(input clk,rst,
input [31:0]ReadData,
output reg [31:0]Data);

always@(posedge clk) begin
    if(rst)
        Data <= 32'b0;
  
    else
        Data <= ReadData;

end
endmodule
