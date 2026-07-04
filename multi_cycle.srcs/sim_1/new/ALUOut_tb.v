`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:38:21 PM
// Design Name: 
// Module Name: ALUOut_tb
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


module ALUOut_tb();


reg clk,rst;
reg [31:0]alu_result;
wire [31:0]ALUOut;


ALUOut ALUOutReg(clk,rst,alu_result,ALUOut);

initial begin
    {clk,rst}=0;  
end
always #5 clk=~clk;

initial begin
    rst = 1'b1;
  
    #20;
    rst = 1'b0;
    alu_result= 32'haabbccdd;
    
    #20;
    alu_result= 32'habcdef;
    
    #20;
    rst = 1'b1;
    
    #50;

    $finish;
    
end

endmodule
