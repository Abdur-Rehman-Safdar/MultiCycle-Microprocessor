`timescale 1ns / 1ps

module instr_data_memory (
    input wire clk,
    input wire MemWrite,          // Write enable from Control Unit
    input wire [31:0] Adr,        // Address input (from AdrSrc Mux)
    input wire [31:0] WD,         // Write Data bus (from Register B)
    output wire [31:0] ReadData   // Read Data output (goes to IR or MDR)
);

  
    parameter instr_mem=64;
    
    reg [7:0] Memory [0:1023];

    // Load instructions using Little-Endian format
   initial begin
        // Instruction 0: addi x5 x0 5 // 0x00500293
        Memory[0] = 8'h93; 
        Memory[1] = 8'h02; 
        Memory[2] = 8'h50; 
        Memory[3] = 8'h00; 
        
        // Instruction 1: sub x6, x0, x5 //0x40500333
        Memory[4] = 8'h33; 
        Memory[5] = 8'h03; 
        Memory[6] = 8'h50; 
        Memory[7] = 8'h40; 
        
        // Instruction 2: sw x5, 64(x0): loop
        Memory[8] = 8'h23; 
        Memory[9] = 8'h20; 
        Memory[10] = 8'h50; 
        Memory[11] = 8'h04; 
        
        // Instruction 3: lw x7, 64(x0)
        Memory[12] = 8'h83; 
        Memory[13] = 8'h23; 
        Memory[14] = 8'h00; 
        Memory[15] = 8'h04; 
        
        // Instruction 4: jal x10, 8       //0x0080056F
        Memory[16] = 8'h6f; 
        Memory[17] = 8'h05; 
        Memory[18] = 8'h80; 
        Memory[19] = 8'h00; 
        
        // Instruction 5: add x8, x4, x5 //skipped
        Memory[20] = 8'h33; 
        Memory[21] = 8'h04; 
        Memory[22] = 8'h52; 
        Memory[23] = 8'h00; 
        
        // Instruction 6: add x9, x0, x8 
        Memory[24] = 8'hb3; 
        Memory[25] = 8'h04; 
        Memory[26] = 8'h80; 
        Memory[27] = 8'h00; 
        
        // Instruction 7: beq x4, x0, loop (jump back to 0x08)
        Memory[28] = 8'he3; 
        Memory[29] = 8'h06; 
        Memory[30] = 8'h02; 
        Memory[31] = 8'hfe; 
    end

    // Synchronous Write Logic
    always @(posedge clk) begin
        if (MemWrite && Adr>=(instr_mem)) begin
            Memory[Adr]     <= WD[7:0];
            Memory[Adr + 1] <= WD[15:8];
            Memory[Adr + 2] <= WD[23:16];
            Memory[Adr + 3] <= WD[31:24];
        end
    end

    // Asynchronous Read Logic
    assign ReadData = {Memory[Adr + 3], Memory[Adr + 2], Memory[Adr + 1], Memory[Adr]};

endmodule