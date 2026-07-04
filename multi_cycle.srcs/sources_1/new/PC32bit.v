`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 10:09:15 AM
// Design Name: 
// Module Name: PC32bit
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


module PC_32bit(
    input clk,
    input PCWrite, //enable signal
    input rst,
    input [31:0] pc_next,  
    output reg [31:0] pc_out // Current PC address
);

    always @(posedge clk) begin
        if (rst) begin
            pc_out <= 32'b0;    // Reset 
        end
        else if(PCWrite)begin
            pc_out <= pc_next;  
        end
        else
            pc_out <= pc_out;
    end

endmodule
