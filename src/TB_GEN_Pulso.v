`timescale 1ns / 1ps

module TB_Pulsador;

reg CLK, Reset, Pulsador;
wire Salida;

wire CLK2, CLK3;


Gen_Pulso F1(.KEY(Pulsador), .CLK(CLK), .RESET(Reset),
.SALIDA(Salida), .CLK3(CLK2), .CLK4(CLK3));


initial begin 
    CLK = 0;
    forever #5 CLK = ~CLK;
end

initial begin
    Reset = 0;
    Pulsador = 0;
    #10;
    #1000
    Pulsador =1;
    #1000
    Pulsador =0;
    #2000000;
    Pulsador =1;
    #2000000;
    Pulsador =0;
    #2000000;
    Pulsador =0;
    #2000000;
    #10 $finish;
    

end


endmodule