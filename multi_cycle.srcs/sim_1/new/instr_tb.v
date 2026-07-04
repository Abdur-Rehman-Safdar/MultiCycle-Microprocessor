`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 11:24:39 AM
// Design Name: 
// Module Name: instr_tb
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


module instr_tb();
reg clk,enb,rst;
reg [31:0]ReadData;
wire [31:0]instr;

instr InstrReg(clk,enb,rst,ReadData,instr );

initial begin
    {clk,enb,rst} = 0;  
end
always #5 clk = ~clk;

initial begin
    rst = 1'b1;
    enb = 1'b0;
    
    #20;
    rst = 1'b0;
    ReadData = 32'haabbccdd;
    
    #20;
    enb = 1'b1;
    
    #20;
    enb = 1'b0;
    
    #20;
    ReadData= 32'habcdef;
    
    #20;
    enb = 1'b1;
    
    #50;
    rst = 1'b1;
    
    #20;
    $finish;
    
end


endmodule
