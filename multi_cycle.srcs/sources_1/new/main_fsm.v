`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2026 06:46:59 PM
// Design Name: 
// Module Name: main_fsm
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


module main_fsm(input clk,rst,zero_flag,
input [31:0]instruction, 
output reg RegWrite, MemWrite, IRWrite,
output reg[1:0]ResultSrc,ALUSrcA,ALUSrcB,
output reg AdrSrc,
output PCWrite,
output [2:0]ALUControl, 
output [1:0]ImmSrc);

reg [1:0]ALUOp;
reg Branch, PCupdate;
wire [2:0]func3;
wire [6:0]func7;
wire [6:0]opcode;

wire [1:0]opfunc; // {opcode[5], func7[5]}

wire branch_pc; //Branch/PCupdate wire and,or


assign opcode = instruction[6:0];
assign func3 = instruction[14:12];
assign func7 = (opcode == 7'b0110011 ) ? instruction[31:25] : 7'b0;
 
assign opfunc = {opcode[5], func7[5]};

assign ALUControl = (ALUOp == 2'b00) ? 3'b000 : // lw, sw
         (ALUOp == 2'b01) ? 3'b001 : // beq
         (ALUOp == 2'b10 && func3 == 3'b000 && (opfunc == 2'b00 || opfunc == 2'b01 || opfunc == 2'b10)) ? 3'b000 : // add
         (ALUOp == 2'b10 && func3 == 3'b000 && (opfunc == 2'b11)) ? 3'b001 : // sub
         (ALUOp == 2'b10 && func3 == 3'b110) ? 3'b011 : // or
         (ALUOp == 2'b10 && func3 == 3'b111) ? 3'b010 : //and
         3'b010; //else(default )
         
assign ImmSrc = (opcode == 7'b0000011)? 2'b00: //lw i-type
        (opcode == 7'b0100011)? 2'b01: //sw
       // (opcode == 7'b0110011)? 2'bxx: //R-type
        (opcode == 7'b1100011)? 2'b10: //beq
        (opcode == 7'b1101111)? 2'b11: //jal
        2'b00; //else

parameter S0_fetch =    4'd0;
parameter S1_decode =   4'd1;
parameter S2_MemAdr =   4'd2;
parameter S3_MemRead =  4'd3;
parameter S4_MemWB =    4'd4;
parameter S5_MemWrite = 4'd5;
parameter S6_ExecuteR = 4'd6;
parameter S7_ALUWB =    4'd7;
parameter S8_ExecuteI = 4'd8;
parameter S9_JAL =      4'd9;
parameter S10_BEQ =     4'd10;

reg [3:0]state, next_state;

always @(posedge clk)begin
    if(rst)
        state <= S0_fetch;
    else
        state <= next_state;
end

always@(*) begin
    RegWrite  = 0;
    MemWrite  = 0;
    IRWrite   = 0;
    ResultSrc = 0;
    ALUSrcA   = 0;
    ALUSrcB   = 0;
    AdrSrc    = 0;
    ALUOp     = 0;
    Branch    = 0;
    PCupdate  = 0;
    case(state)
    S0_fetch: begin
        AdrSrc = 1'b0;
        ALUSrcA = 2'b00;
        ALUSrcB = 2'b10;
        ALUOp = 2'b00;
        ResultSrc = 2'b10;
        PCupdate = 1'b1;
        IRWrite = 1'b1;
        
        next_state = S1_decode; 
        
    
    end 
    S1_decode: begin
        AdrSrc = 1'b0;
        ALUSrcA = 2'b01;
        ALUSrcB = 2'b01;
        ALUOp = 2'b00;
        if((opcode == 7'b0000011 )||(opcode == 7'b0100011 )) begin
            next_state = S2_MemAdr; //lw and sw
        end
        else if(opcode == 7'b0110011) begin //R=type
            next_state = S6_ExecuteR;
        end
        else if(opcode == 7'b0010011) begin //I-type
            next_state = S8_ExecuteI;
        end
        else if(opcode == 7'b1101111) begin //Jal
            next_state = S9_JAL;
        end
        else if(opcode == 7'b1100011) begin //beq
            next_state = S10_BEQ;
        end
        
    end 
    
    S2_MemAdr: begin
       // AdrSrc = 1'b0;
        ALUSrcA = 2'b10;
        ALUSrcB = 2'b01;
        ALUOp = 2'b00;
       
        if(opcode == 7'b0000011) //lw
            next_state = S3_MemRead; 
        else if(opcode == 7'b0100011) //sw
            next_state = S5_MemWrite; 
              
    end 
    S3_MemRead: begin
        AdrSrc = 1'b1;
        ResultSrc = 2'b00; //  
              
        next_state = S4_MemWB; 
       
       end 
    S4_MemWB: begin
              
        ResultSrc = 2'b01;//
        RegWrite = 1'b1; // 
               
        next_state = S0_fetch; 
     
    end 
    
    S5_MemWrite: begin
        AdrSrc = 1'b1;
        ResultSrc = 2'b00;
        MemWrite = 1'b1;
        
        next_state = S0_fetch; 
    end
    
    S6_ExecuteR: begin
            
        ALUSrcA = 2'b10;
        ALUSrcB = 2'b00;
        ALUOp = 2'b10;
            
        next_state = S7_ALUWB; 
    end
    
    S7_ALUWB: begin
           
        ResultSrc = 2'b00;
        RegWrite = 1'b1;
            
        next_state = S0_fetch; 
    end
    
    S8_ExecuteI: begin
                
        ALUSrcA = 2'b10;
        ALUSrcB = 2'b01;
        ALUOp = 2'b10;
                
        next_state = S7_ALUWB; 
    end
    
    S9_JAL: begin
           
        ALUSrcA = 2'b01;
        ALUSrcB = 2'b10;
        ALUOp = 2'b00;
        ResultSrc = 2'b00;
        PCupdate = 1'b1;          
            
        next_state = S7_ALUWB; 
   
    end 
    
    S10_BEQ: begin
               
        ALUSrcA = 2'b10;
        ALUSrcB = 2'b00;
        ALUOp = 2'b01;
        ResultSrc = 2'b00;
        Branch = 1'b1;          
                
        next_state = S0_fetch; 
       
    end 
    
    default: next_state = S0_fetch;  
    endcase
       
     
end

assign PCWrite = PCupdate || (Branch && zero_flag);


endmodule
