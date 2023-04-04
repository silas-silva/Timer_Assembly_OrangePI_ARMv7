.include "macros_gerais.s"
.include "display.s"
.include "pins_controle.s"
.include "digitos_display.s"


.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_SHARED, 1
.equ S_RDWR, 0666

.global _start

_start:
    openDevmem      @abrir arquivo devmem
    mapMem          @Mapear
    movs r8, r0     @Jogar o mapeamento em r8

    @ Setar os pinos do display como saida
    @pins_display_saida

    @Ligar display
    inicializar_display

    ldr r1, =num
    ldr r1, [r1]

    b loop_digitos

loop_digitos:
    @Valor tem que estar em r1 e retorna em r9
    num_para_digitos 

    lsr r3, r9, #16 @Pega a dezena

    mov r7, #F
    lsl r7, r7, #4
    bic r3, r3, r7

    @cmp r3, #0
    @beq mostrar_0

    cmp r3, #1
    beq mostrar_1

    cmp r3, #2
    beq mostrar_2

    cmp r3, #3
    beq mostrar_3

    cmp r3, #4
    beq mostrar_4

    cmp r3, #5
    beq mostrar_5

    cmp r3, #6
    beq mostrar_6

    cmp r3, #7
    beq mostrar_7

    cmp r3, #8
    beq mostrar_8

    cmp r3, #9
    beq mostrar_9


    lsr r3, r9, #20 @Pega a unidade

    @cmp r3, #0
    @beq mostrar_0

    cmp r3, #1
    beq mostrar_1

    cmp r3, #2
    beq mostrar_2

    cmp r3, #3
    beq mostrar_3

    cmp r3, #4
    beq mostrar_4

    cmp r3, #5
    beq mostrar_5

    cmp r3, #6
    beq mostrar_6

    cmp r3, #7
    beq mostrar_7

    cmp r3, #8
    beq mostrar_8

    cmp r3, #9
    beq mostrar_9

    sub r1, #1
    nanoSleep timeZero, time_900_mili
    b loop_digitos

@mostrar_0:
@    set_0:

mostrar_1:
    set_1

mostrar_2:
    set_2

mostrar_3:
    set_3

mostrar_4:
    set_4


mostrar_5:
    set_5

mostrar_6:
    set_6

mostrar_7:
    set_7

mostrar_8:
    set_8


mostrar_9:
    set_9

end:
    mov r0, #0
    mov r7, #1
    svc 0

.data
    timespecsec: .word 1
    timespecnano: .word 100000000
    devmem: .asciz "/dev/mem"
    pagelen: .word 0x1000
    gpioaddr: .word 0x1C20    @0x01C20800 / 0x1000 (4096)   @Endereço base do GPIO / 0x1000
    padraoPin: .word 0x77777777
    padraoSaidaPin: .word 0x00000000
    num: .word 45
    second: .word 1                 @ 1 segundo
    timeZero: .word 0
    time_1_mili: .word 1000000
    time_5_mili: .word 5000000
    time_15_mili: .word 15000000
    time_900_mili: .word 900000000
    time_1_micro: .word 1000
    time_100_micro: .word 100000
    time_150_micro: .word 150000 
    time_1_nano: .word 1000000000
    time_100_nano: .word 1000000000
	timespecnano120: .word 120000   @ 120 microssegundos
