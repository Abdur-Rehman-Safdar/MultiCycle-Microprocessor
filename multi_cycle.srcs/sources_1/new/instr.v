`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 11:17:48 AM
// Design Name: 
// Module Name: instr
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


module instr(input clk,IRWrite,rst,
input [31:0]ReadData,
output reg [31:0]instr );

always@(posedge clk) begin
    if(rst)
        instr <= 32'b0;
    else if(IRWrite)
        instr <= ReadData;
    else
        instr <= instr;

end

endmodule
