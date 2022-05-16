module Instr_reg (input [31:0] Instruction_IN, 
                    input fetch,rst,clk, 
                    output  [31:0] fetched_instr);
    reg [31:0] Instruction;
    always @(posedge clk) begin
        if (rst) Instruction<=0;
        else begin
            if (fetch) Instruction<=Instruction_IN;
            else Instruction<=Instruction;
        end
    end
endmodule 