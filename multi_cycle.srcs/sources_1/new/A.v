`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:23:22 PM
// Design Name: 
// Module Name: A
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


module A(input clk,rst,
input [31:0]RD1,
output reg [31:0]A);

always@(posedge clk) begin
    if(rst)
        A <= 32'b0;
  
    else
        A <= RD1;

end
endmodule
