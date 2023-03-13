@ main.s


.include "gpiomacros.s"

.global _start

_start:
    GPIOExport pin17
    nanoSleep
    GPIODirectionOut pin17
    @mov r6, #10          @Colocar 10 em r6

loop: 
    GPIOWrite pin17, high
    b loop

    @nanoSleep
    @GPIOWrite pin17, low
    @nanoSleep
    @subs r6, #1  @Decrementar 1 de r6
    @bne loop       @Se a subtração anterior não deixou r6 igual a zero, pula pro loop

_end: 
    mov R0, #0   @ Usar 0 como retorno do codigo
    mov R7, #1   @ Colocar 1 em r7 para sinalizar para o SO fechar o programa
    svc 0        @ Chamada de sistema 

pin17: .asciz "17"
pin27: .asciz "27"
pin22: .asciz "22"
low: .asciz "0"
high: .asciz "1"