`timescale 1ns / 1ps

module tb_instr_data_memory();

    reg clk;
    reg MemWrite;
    reg [31:0] Adr;
    reg [31:0] WD;
    wire [31:0] ReadData;

instr_data_memory InstrDataMem(clk,MemWrite, Adr,WD,ReadData );


    always #5 clk = ~clk;

    initial begin
        clk = 0;
        MemWrite = 0;
        Adr = 32'h0;
        WD = 32'h0;
        #20;
      
        
        Adr = 32'd0; #10;
        Adr = 32'd4; #10;        
        Adr = 32'd100; #10;
        WD = 32'd250;
        MemWrite=1'b1;#10;
       
        Adr = 32'd12; #10;
        MemWrite=1'b0;#10;
        Adr = 32'd120; #10;
        Adr = 32'd100; #10;
        Adr = 32'd16; #10;        
        Adr = 32'd20; #10;
        Adr = 32'd24; #10;
        Adr = 32'd28; #10;        
    
        


        #20;
        $finish;
    end
endmodule