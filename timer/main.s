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
    @inicializar_display

    @Timer
    @b loop
    b end

@loop:
@    @COlocar numero a ser dividido em r1
@    ldr r1, =numContar
@    ldr r1, [r1]
@    num_para_digitos
@    @ Mostrar digitos no Display
@    b loop

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
    pins_d7_d6_saida: .word 0x11777777 @0001 0001 0111 0111 0111
    pins_d5_d4_saida: .word 0x77777711
    pins_E_RS_saida: .word 0x77777177
    enable_saida: .word 0x00040000  @ 0000 0000 0000 0100 0000 0000 0000 0000, só fazer um or para acender o bit 18
    numContar: .word 0xFF 
    second: .word 1                 @ 1 segundo
    timeZero: .word 0
    timeZeroMili: .word 000000000
    timespecnano5: .word 5000000    @ 5 milissegundos
		timespecnano120: .word 120000   @ 120 microssegundos
