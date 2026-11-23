`timescale 1ns / 1ps

module memory_tb();

    reg         clk, rst;
    reg         m_ctlout;
    reg [31:0]  alu_result, readdata2_ex_mem;
    reg [4:0]   muxout_in;
    reg [1:0]   ctlwb_in;
    reg         mem_write, mem_read, zero;
    wire [31:0] readdata_out, mem_alu_result;
    wire [4:0]  mem_write_reg;
    wire        reg_write, mem_to_reg;
    wire        PCSrc;

    memory dut (
        .clk                (clk),
        .rst                (rst),
        .alu_result         (alu_result),
        .readdata2_ex_mem   (readdata2_ex_mem),
        .muxout_in          (muxout_in),
        .ctlwb_in           (ctlwb_in),
        .mem_write          (mem_write),
        .mem_read           (mem_read),
        .m_ctlout           (m_ctlout),
        .zero               (zero),
        .readdata_out       (readdata_out),
        .mem_alu_result     (mem_alu_result),
        .mem_write_reg      (mem_write_reg),
        .reg_write          (reg_write),
        .mem_to_reg         (mem_to_reg),
        .PCSrc              (PCSrc)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        
        // Mem Read (reset first)
        rst = 0;
        alu_result = 32'h00000004;
        readdata2_ex_mem = 32'h12345678;
        muxout_in = 5'h02;
        ctlwb_in = 2'b01;
        mem_write = 0;
        mem_read = 1;
        m_ctlout = 0;
        zero = 0;
        
        #10; 
        
        rst = 1;
        
        #10;
    
        // Mem Write
        mem_write = 1;
        mem_read = 0;
        
        #10; // Allow write to occur
        
        // Mem read
        mem_write = 0;
        mem_read = 1;
        
        #10; // Verify write by reading back
    
        // Branch
        m_ctlout = 1;
        zero = 1;
        
        #20; // Check PCSrc
    
        $finish;
    end
endmodule
