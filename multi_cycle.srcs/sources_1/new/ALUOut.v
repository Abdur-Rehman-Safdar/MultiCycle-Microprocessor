`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:35:10 PM
// Design Name: 
// Module Name: ALUOut
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


module ALUOut(input clk,rst,
input [31:0]alu_result,
output reg [31:0]ALUOut);

always@(posedge clk) begin
    if(rst)
        ALUOut <= 32'b0;
  
    else
        ALUOut <= alu_result;

end
endmodule

