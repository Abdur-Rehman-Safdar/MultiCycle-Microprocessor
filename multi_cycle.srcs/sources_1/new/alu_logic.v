`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 11:47:51 AM
// Design Name: 
// Module Name: alu_logic
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


module alu_logic(input [31:0]SrcA,SrcB,
input [2:0]alu_control,
output reg[31:0] alu_result,
output reg zero_flag);

always @(*) begin
    alu_result = 32'b0;
    case(alu_control)
        3'b000: alu_result= SrcA + SrcB;        // ADD
        3'b001: alu_result = SrcA - SrcB;       // SUB
        3'b010: alu_result = SrcA & SrcB;      // AND
        3'b011: alu_result = SrcA | SrcB;      // OR

        default: alu_result = 32'b0;
    endcase
    
    //BEQ Zero_flag
    zero_flag = (alu_result == 32'b0) ? 1'b1 : 1'b0; 
end
        
    

endmodule
