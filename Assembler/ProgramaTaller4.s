.global main

.eqv MemoriaMAX, 0x00FC

.eqv XADControl, 0x0100
.eqv XADCDatos,0x0104
.eqv Teclado, 0x0108
.eqv SieteSegmentos,0x010C
.eqv LEDs, 0x0110
.eqv Switches, 0x0114
.eqv Timer, 0x0118


.eqv MAXDEC, 0x989680
.eqv MAXHEX, 0x1000 0000
.eqv Low, 0x99A
.eqv Up, 0x19999

.eqv S, 0xA
.eqv multiplicacion, 0xB
.eqv Suma,0xC
.eqv Resta,0xD
.eqv Igual,0xE
 #regX=a0  regX+1=a1
 #regY a2
 #regL=a4
 #regOP=a5
 #regZ=s2
 #regN=a7
 #regMUL1= t1
 #regMUL2 =t2
 #regAUX=t3

 #regMAXDEC=s3
 #regMAXHEX=s4
 #regBCD=s5
 #reg1=t6
 #regS=t5
#regResultado=t4
#regK=s8
#regcarry=s9
#regEXCE=s10
#regUNOS=s11
main:
 addi t6,x0,1
 addi s0,x0, Switches
 lw a1,0(s0)
 bne a1,x0,explorador
calculadora:
 addi s0,x0, Teclado     #Revisar registro de teclado
 lw a1,0(s0)
 beq a1,x0, calculadora
 sw x0,0(s0)
 slli a1,a1,1             #Quitar 1 de control
 srli a1,a1,1
 sw x0,0(s0)             #Guardar 0 en reg
 addi t0,x0,Igual
 beq a1,t0, EQ
 addi t0,x0,multiplicacion
 beq a1,t0, OP
 addi t0,x0,Suma
 beq a1,t0, OP
 addi t0,x0,Resta
 beq a1,t0, OP
 beq x0,x0 Numero
OP:
 add a2,x0,a0  
 add a5,x0,a1
 add a0,x0,x0
 add a1,x0,x0
 beq x0,x0, Dis
Numero:
 add t1,x0,a1
 addi t2,x0,10
mult10:
 add s7,s7,a0
 sub t2,t2,t6
 bne x0,t2, mult10
 add a0,s7,a1
Dis:
 slli a4,a4,4
 add a4,a4,a1
 addi,s0,x0,SieteSegmentos
 sw a4,0(s0)
 beq x0,x0,calculadora
EQ:
 addi t5,x0,S
 bne a0,t5,EQ2
 addi s0,x0, XADControl
 sw t6,0(s0)
XadcBIT:
 lw a0,0(s0)
 beq a0,t6,XadcBIT
 addi s0,x0,XADCDatos
 lw a0,0(s0)
EQ2:
 bne a2, t5, EQ3
 addi s0,x0, XADControl
 sw t6,0(s0)
XadcBIT2:
 lw a2,0(s0)
 beq a2,t6,XadcBIT2
 addi s0,x0,XADCDatos
 lw a2,0(s0)
EQ3:
 addi t0,x0,multiplicacion
 bne a5,t0, SumOP
MultiOP:
 add t1,x0,a0
 add t2,a3,x0
 jal multiplicacionPRO
 add a0,t4,x0
 beq x0,x0,POS
SumOP:
 addi t0,x0,Suma
 bne t0,a5,RestaOP
 add a0,a0,a2
 beq x0,x0,POS
RestaOP:
 sub a0,a0,a2
POS:
 add s2,a0,x0
 sw s2,0(a7) #cargar s2 en RAM
 addi a7,a7,4
 add s8,x0,x0
SEVEN:
 lui s3,0xF4
 addi s3,x0,0x240
 lui s4,0x100
KU1:
 bltu s2,s3, KU2
 sub s2,s2,s3
 add s5,s5,s4
 beq x0,x0, KU1
KU2:
 srli s4,s4,4
 add t1,x0,s3
 lui t2,0x19999
 addi t2,t2,0x79a
 addi,t2,t2,0x200
 jal multiplicacionPRO
 add s3,x0,t3
 bne s3,t6,KU1
 add s5,s5,s2
 add a4,x0,s5
 addi,s0,x0,SieteSegmentos
 sw a4,0(s0)
 add a0,x0,x0
 add a1,x0,x0
 add a5,x0,x0
 add s5,x0,x0
 add a4,x0,x0
 beq s8,x0 main
 jalr ra,0(ra)
explorador:
 addi s0,x0, Switches
 lw a0,0(s0)
A:
 addi s0,x0,Timer
 sw a0,0(s0)
checkTimer:
 lw s7,0(s0)
 beq a0,s7,checkTimer
 add s8,a7,x0
 lw s7,0(s8)
 jal SEVEN
 beq s8,x0,main
 sub s8,s8,t6
 sub s8,s8,t6
 sub s8,s8,t6
 sub s8,s8,t6
 beq x0,x0, A
multiplicacionPRO:  #El resultado es t4, regAUX es t3
 lui s11,0xFFFFF
 addi s11,s11,0x7FF
 addi s11,s11,0x700
 addi,s11,s11,100
 add t4,x0,x0
 beq t1,x0,CC
 beq t2,x0,CC
R:
 sub s10,s11,t1
 slt s9,t1,s10
 add t3,t3,s9
 add t4,t4,t1
 sub t2,t2, t6
 bne t2,x0,R
 jalr ra,0(ra)
CC:
 add t4,x0,x0
 jalr ra,0(ra)
 


