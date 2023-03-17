.include "macros.s"

.global _start

_start:
    mapMem
    
    ldr r6, [r8, #0x800]

    @Acessar pinos com deslocamento 4
    ldr r6, [r6, #4]   @Valor padrão 0x77777777 = 0111 0111 0111 0111 0111 0111 0111 0111
    
    @ 000 input, 001 output
    @ Os bits de configuração do PA8 são os bits 0 1 e 2 (2:0)
    @ 0111 0111 0111 0111 0111 0111 0111 0001 = 0x77777771
    @ Carregar nova configuração em r6 -> Setar como output
    str r6, [#0x77777771]

    @Configurar PA_DAT -> Valor padrão = 0x00000000
    @ldr r6, [r8, #0x810]
    mov r1, 0x1000000    @0x100 0000 = 0000 0001 0000 0000 0000 0000 0000 0000
    str r1, [r8, #0x810] @Acende o led

    mov r0, #0
    mov r7, #1
    svc 0