.include "macros_gerais.s"
.include "macros_pin_display.s"

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
    pins_display_saida

    @Ligar display
    inicializar_display

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
    num: .ascii "1000"
    len_num = .-num
    second: .word 1                 @ 1 segundo
    timeZero: .word 0
    time_1_mili: .word 1000000
    time_5_mili: .word 5000000
    time_15_mili: .word 15000000
    time_1_micro: .word 1000
    time_100_micro: .word 100000
    time_150_micro: .word 150000 
    time_1_nano: .word 1000000000
    time_100_nano: .word 1000000000
	timespecnano120: .word 120000   @ 120 microssegundos
