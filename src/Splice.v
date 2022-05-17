module Splice (input [31:0] full_intruc, output [6:0] POC, 
                [6:0] func7, output [2:0] func3,
                output [31:0] imm_S,
                output [31:0] imm_I,
                output [31:0] imm_B,
                output [31:0] imm_J, 
                output [4:0] RS1,RS2,RD);
    wire a=full_intruc[31];
    wire [31:0]AA = {a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a}; 
    assign POC = full_intruc [6:0];
    assign func7 = full_intruc [31:25];
    assign func3 = full_intruc [14:12];
    assign imm_B = {AA[19:0],full_intruc[7],full_intruc[30:25], full_intruc[11:8],1'b0};
    assign imm_S = {AA[20:0], full_intruc[30:25], full_intruc[11:7]};
    assign imm_J = {AA[12:0], full_intruc[19:12], full_intruc[20], full_intruc[30:21]};
    assign imm_I = {AA[20:0], full_intruc[30:20]};
    
endmodule 