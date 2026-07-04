`timescale 1ns / 1ps

module top_module_tb();


    reg clk;
    reg rst;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [4:0]  rs1, rs2, rd;

    top_module uut (
        .clk(clk), 
        .rst(rst), 
        .pc(pc), 
        .instruction(instruction), 
        .rs1(rs1), 
        .rs2(rs2), 
        .rd(rd)
    );


    always #10 clk = ~clk;



    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;


        #20;
        rst = 0; 

        $display("RISC-V MULTICYCLE PROCESSOR SIMULATION ");

        
        #700;


        $finish;
    end
      
   
    initial begin
        $timeformat(-9, 0, " ns", 10);
        forever begin
            @(posedge clk);
         
            if (!rst) begin
                $display("Time: %t | PC: 0x%h | Instruction: 0x%h | FSM State: S%0d | RegWrite: %b | PCWrite: %b", 
                         $time, pc, instruction, uut.FSMcontrol.state, uut.RegWrite, uut.PCWrite);
                
           
                if (uut.FSMcontrol.state == 4'd9) begin
                    $display(">>> [JAL DETECTED] Target JUMP Address Calculated: 0x%h <<<", uut.result);
                end
            end
        end
    end

endmodule