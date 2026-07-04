`timescale 1ns / 1ps

module top_module(
    input clk, rst,
    output [31:0] pc,
    output [31:0] instruction,
    output [4:0]  rs1, rs2, rd
);

// Control signals
wire PCWrite, AdrSrc, MemWrite, IRWrite, RegWrite, zero_flag;
wire [1:0] ResultSrc, ALUSrcA, ALUSrcB, Imm_Src;
wire [2:0] ALUControl;

// Internal wires
wire [31:0] Adr_in, WriteData, ReadData, inst_code, pc_out;
wire [31:0] read_data1, read_data2, A_out, Old_PC, ALU_Out;
wire [31:0] alu_result, SrcA, SrcB, imm_out, Data_out, result;

// Modules Instantiations
PC_32bit PC_inst(clk, PCWrite, rst, result, pc_out);

mux2_1 PCmux(pc_out, result, AdrSrc, Adr_in);

instr_data_memory InstDataMem(clk, MemWrite, Adr_in, WriteData, ReadData);

instr InstReg(clk, IRWrite, rst, ReadData, inst_code);

main_fsm FSMcontrol(clk, rst, zero_flag, inst_code, RegWrite, MemWrite, IRWrite,
                    ResultSrc, ALUSrcA, ALUSrcB, AdrSrc, PCWrite, ALUControl, Imm_Src);

reg_file RegFile(inst_code[19:15], inst_code[24:20], inst_code[11:7], result, RegWrite, clk, rst, read_data1, read_data2);

A Areg(clk, rst, read_data1, A_out);

WriteData writedataReg(clk, rst, read_data2, WriteData);

imm_ext ImmExt(Imm_Src, inst_code, imm_out);

// SrcA Mux (a=PC, b=Old_PC, c=A_out)
mux3_1 oldPCmux(.a(pc_out), .b(Old_PC), .c(A_out), .sel(ALUSrcA), .y(SrcA));

// SrcB Mux (a=WriteData, b=imm_out, c=32'd4)
mux3_1 WDmux(.a(WriteData), .b(imm_out), .c(32'd4), .sel(ALUSrcB), .y(SrcB));

OldPC oldpc_reg(clk, rst, pc_out, Old_PC);

alu_logic ALUlogic(SrcA, SrcB, ALUControl, alu_result, zero_flag);

ALUOut ALUout_register(clk, rst, alu_result, ALU_Out);

Data datareg(clk, rst, ReadData, Data_out);

// Result Mux (a=ALU_Out, b=Data_out, c=alu_result)
mux3_1 ALUmux(.a(ALU_Out), .b(Data_out), .c(alu_result), .sel(ResultSrc), .y(result));

// Outputs routing
assign pc          = pc_out;
assign instruction = inst_code;
assign rs1         = inst_code[19:15];
assign rs2         = inst_code[24:20];
assign rd          = inst_code[11:7];

endmodule