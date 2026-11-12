`timescale 1ns / 1ps

module wb_mux (
  input wire [31:0] a, b,
  input wire sel,
  output wire [31:0] y
);

    assign y = sel ? a : b;

endmodule
