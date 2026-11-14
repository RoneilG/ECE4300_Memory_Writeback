`timescale 1ns / 1ps

module mem_wb_latch (
    input wire        clk, rst,

    input wire [1:0]  ctlwb_in,

    input wire [31:0] readdata_in, alu_result_in,       
    input wire [4:0]  muxout_in,

    output reg        reg_write, mem_to_reg,

    output reg [31:0] readdata_out, mem_alu_result,
    output reg [4:0]  mem_write_reg
);

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            reg_write        <= 1'b0;
            mem_to_reg       <= 1'b0;

            readdata_out     <= 32'b0;
            mem_alu_result   <= 32'b0;
            mem_write_reg    <= 5'b0;
        end
        
        else begin
            reg_write        <= ctlwb_in[1];
            mem_to_reg       <= ctlwb_in[0];

            readdata_out     <= readdata_in;
            mem_alu_result   <= alu_result_in;
            mem_write_reg    <= muxout_in;

        end
    end
    
endmodule
