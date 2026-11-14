`timescale 1ns / 1ps

module memory (
    input wire          clk, rst, m_ctlout, zero, mem_write, mem_read,
    input wire [1:0]    ctlwb_in,
    input wire [4:0]    muxout_in,
    input wire [31:0]   alu_result, readdata2_ex_mem,
    
    output wire          reg_write, mem_to_reg, PCSrc,
    output wire [31:0]   readdata_out, mem_alu_result,
    output wire [4:0]    mem_write_reg
);

    wire [31:0] readdata_in;

    AND and1 (
        .m_ctlout   (m_ctlout),
        .zero       (zero),
        .PCSrc      (PCSrc)
    );
    
    data_memory data_memory (
        .clk        (clk),
        .rst        (rst),
        .addr       (alu_result),         
        .write_data (readdata2_ex_mem),   
        .memread    (mem_read), 
        .memwrite   (mem_write),  
        .read_data  (readdata_in)
    );
        
    mem_wb_latch mem_wb_latch (
        .clk            (clk), 
        .rst            (rst),
        .ctlwb_in       (ctlwb_in),
        .readdata_in    (readdata_in), 
        .alu_result_in  (alu_result),       
        .muxout_in      (muxout_in),
        .reg_write      (reg_write), 
        .mem_to_reg     (mem_to_reg),
    
        .readdata_out   (readdata_out), 
        .mem_alu_result (mem_alu_result),
        .mem_write_reg  (mem_write_reg)
    );
        
endmodule
