`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:31:09 PM
// Design Name: 
// Module Name: WriteData
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


module WriteData(input clk,rst,
input [31:0]RD2,
output reg [31:0]WriteData);

always@(posedge clk) begin
    if(rst)
       WriteData <= 32'b0;
  
    else
        WriteData <= RD2;

end
endmodule