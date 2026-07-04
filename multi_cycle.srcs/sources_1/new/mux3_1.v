`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 12:45:12 PM
// Design Name: 
// Module Name: mux3_1
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



module mux3_1(input [31:0]a,b,c, input[1:0] sel, output reg[31:0]y);

always@(*) begin

    case(sel)
    2'b00: y=a;  
    2'b01: y=b;  
    2'b10: y=c;
    default: y=a;   
    endcase

end


endmodule
