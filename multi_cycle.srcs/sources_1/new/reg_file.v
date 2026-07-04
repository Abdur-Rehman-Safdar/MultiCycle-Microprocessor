`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 10:17:05 AM
// Design Name: 
// Module Name: reg_file
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



module reg_file(
input [4:0]Read_A1,Read_A2,Write_A3, // rs reg & rd addressess
input [31:0]WD3, //write data
input RegWrite,clk,rst, //write_enable, clock , reset
output [31:0]RD1,RD2 ); //ReadData1, ReadData2

reg [31:0]reg_memory [31:0];

integer i;
always@(posedge clk) begin
    if(rst) begin
        for(i=0;i<32;i=i+1) begin
        reg_memory[i]<=0;  // 
        end
        
     end
     else if(RegWrite && (Write_A3!=0))begin
        reg_memory[Write_A3]<=WD3;
     end
    end        
    
    // continuous read
assign RD1=reg_memory[Read_A1];
assign RD2=reg_memory[Read_A2];


endmodule