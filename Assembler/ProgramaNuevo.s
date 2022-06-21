.global main

.eqv MemoriaBASE, 0x0000

.eqv XADControl, 0x0100
.eqv XADCDatos,0x0104
.eqv Teclado, 0x0108
.eqv SieteSegmentos,0x010C
.eqv LEDs, 0x0110
.eqv Switches, 0x0114
.eqv Timer, 0x0118


.eqv MAXDEC, 0x989680
.eqv MAXHEX, 0x1000 0000

.eqv S, 0xA
.eqv multiplicacion, 0xB
.eqv Suma,0xC
.eqv Resta,0xD
.eqv Igual,0xE
.eqv MultiplicacionesMAX, 0x7
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
 #regmutiplicaciones=s9
 #reg10=s10
 #regi=s11
main:
 addi t6,x0,1
 addi s0,x0, Switches
 lw a1,0(s0)
 srli a0,a0,4
 bne a1,x0,explorador
 add a4,x0,x0
 add a2,x0,x0
 add a1,x0,x0
calculadora:
 addi s0,x0, Teclado     #Revisar registro de teclado
 lw a1,0(s0)
 beq a1,x0, calculadora
 sw x0,0(s0)
 slli a1,a1,1             #Quitar 1 de control
 srli a1,a1,1
 sw x0,0(s0)             #Guardar 0 en reg
 addi t0,x0,Igual
 beq a1,t0, EQ3
 addi t0,x0,multiplicacion
 beq a1,t0, OP
 addi t0,x0,Suma
 beq a1,t0, OP
 addi t0,x0,Resta
 beq a1,t0, OP
 addi t0,x0,S
 beq a1,t0, EQ
 beq x0,x0 Numero
OP:
 add a2,x0,a0  
 add a5,x0,a1
 add a0,x0,x0
 beq x0,x0, Dis
Numero:
 add t1,x0,a1
 addi t2,x0,10
 add s7,x0,x0
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
 addi s0,x0, XADControl
 addi t6,x0,1
 sw t6,0(s0)
XadcBIT:
 lw a0,0(s0)
 beq a0,t6,XadcBIT
 addi s0,x0,XADCDatos
 lw a0,0(s0)
 add s2,x0,a0
 jal tp,SEVEN
 slli a4,a4,20
 add a4,a4,s5
 addi,s0,x0,SieteSegmentos
 sw a4,0(s0)
 beq x0,x0,calculadora
EQ3:
 addi t0,x0,multiplicacion
 bne a5,t0, SumOP
MultiOP:
 add t1,x0,a0
 add t2,a2,x0
 jal multiplicacionPRO
 add a0,t4,x0
 add a2,x0,x0
 beq x0,x0,POS
SumOP:
 addi t0,x0,Suma
 bne t0,a5,RestaOP
 add a0,a0,a2
 add a2,x0,x0
 beq x0,x0,POS
RestaOP:
 sub a0,a0,a2
POS:
 add s2,a0,x0
 sw s2,0(a7) #cargar s2 en RAM
 addi a7,a7,4
 add s8,x0,x0
 add a0,x0,x0
 jal tp,SEVEN
 beq x0,x0 main
SEVEN:#regmutiplicaciones=s9 #reg10=s10 #regi=s11 #regMAXDEC=s3 #regMAXHEX=s4 #regBCD=s5
 add s11,x0,x0
 add s5,x0,x0
 lui s4,0x10000
 addi s10,x0,10
SET1:
 addi s9,x0,MultiplicacionesMAX
 sub s9,s9,s11
 addi s3,x0,1
regmuls0:
 beq s9,x0 MAXDEC1
 add t1,x0 s3
 add t2,x0,s10
 jal multiplicacionPRO
 add s3,x0,t4
 addi s9,s9,-1
 beq x0,x0 regmuls0
MAXDEC1:
 addi t6,x0,1
 beq s3,t6, finishHEXBCD
CompHEXBCD:
 bge s2,s3, RS
 srli s4,s4,4
 addi s11,s11,1
 beq x0,x0 SET1
RS:
 sub s2,s2,s3
 add s5,s5,s4
 beq x0,x0 CompHEXBCD
finishHEXBCD:
 add,s5,s5,s2
 addi s0,x0,SieteSegmentos
 sw s5,0(s0)
 jalr tp,0(tp)
explorador:
 addi s0,x0, Switches
 lw a1,0(s0)
 addi s8,a7,MemoriaBASE
Sig:
 addi s0,x0,Timer
 sw a0,0(s0)
checkTimer:
 lw s7,0(s0)
 beq a0,s7,checkTimer
 lw s2,0(s8)
 jal tp,SEVEN
 addi s0,x0,MemoriaBASE
 beq s8,s0,main
 addi s8,s8,-4
 beq x0,x0, Sig
multiplicacionPRO:  #El resultado es t4, Mul1=t1 Mul2=t2
 add t4,x0,x0
 beq t1,x0,CC
 beq t2,x0,CC
R:
 add t4,t4,t1
 addi t2,t2,-1
 bne t2,x0,R
 jalr ra,0(ra)
CC:
 add t4,x0,x0
 jalr ra,0(ra)
