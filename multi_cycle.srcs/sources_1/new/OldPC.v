`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 11:55:17 AM
// Design Name: 
// Module Name: OldPC
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


module OldPC(input clk,rst,
input [31:0]pc_out,
output reg [31:0]OldPC );

always@(posedge clk) begin
    if(rst)
        OldPC <= 32'b0;

    else
        OldPC <= pc_out;

end

endmodule
