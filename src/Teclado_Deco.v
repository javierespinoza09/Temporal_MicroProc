module Teclado_Deco(
    input [3:0] in,
    output reg [3:0] Salida    
    );
    
    always @(*)begin
        case(in)
            //OPERANDOS
            1000: Salida = 0000; //Numero 0
            0011: Salida = 0001; //NUMERO 1
            1011: Salida = 0010; //Numero 2
            0111: Salida = 0011; //Numero 3
            0001: Salida = 0101; //Numero 4
            1001: Salida = 0101; //Numero 5
            0101: Salida = 0110; //Numero 6
            0010: Salida = 0111; //Numero 7
            1010: Salida = 1000; //Numero 8
            0110: Salida = 1001; //Numero 9
            
            //OPERADORES
            0000: Salida = 1111; //Tecla *
            0100: Salida = 1110; //Tecla #
            1111: Salida = 1101; //Tecla A
            1101: Salida = 1100; //Tecla B
            1110: Salida = 1011; //Tecla C
            1100: Salida = 1010; //Tecla D
            
        endcase     
    end
    
endmodule