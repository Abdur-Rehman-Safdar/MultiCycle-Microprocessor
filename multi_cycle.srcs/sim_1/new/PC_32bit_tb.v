`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 10:10:54 AM
// Design Name: 
// Module Name: PC_32bit_tb
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




module PC_32bit_tb( );
reg clk,rst,enb;
reg [31:0]pc_next;
wire [31:0]pc_out;

PC_32bit PC(clk,enb,rst,pc_next,pc_out);

always #5 clk=~clk;
initial begin
    clk = 1'b0;
    rst = 1'b1;
    enb = 1'b0;
    #20;
    pc_next = 32'haabbccdd;
    rst = 1'b0;
    
    #20;
    enb = 1'b1;
    
    #20;
    enb = 1'b0;
    
    #20;
    pc_next = 32'habcdef;
    
    #20;
    enb = 1'b1;
    
    #200;
    $finish;
    end
endmodule

