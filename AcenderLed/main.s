.include "macros_gerais.s"
.include "macros_pin_08.s"
.include "macros_pin_generica"

.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_SHARED, 1
.equ S_RDWR, 0666

.global _start

_start:
    openDevmem      @abrir arquivo devmem
    mapMem          @Mapear
    movs r8, r0     @Jogar o mapeamento em r8

    pinPA8_saida    @Configura PA8 como saida.

loop:
    pinPA8_saida_1  @Manda o bit 1 em PA8.
    nanoSleep
    pinPA8_saida_0  @Manda o bit 0 em PA8.
    nanoSleep
    b loop

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
