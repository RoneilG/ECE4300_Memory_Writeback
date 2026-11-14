`timescale 1ns / 1ps

/*This bit-wise ANDs the branch and zero, indicating if a jump to an address is necessary.
The output, PCSrc, goes to mux.v from the Fetch Stage. If PCSrc is true, then there is a branch jump,
otherwise there is not.  */

module AND(
    input wire m_ctlout, zero,
    output wire PCSrc
    );
        
    assign PCSrc = m_ctlout & zero;
    
endmodule
