
@Setar o pino PA8 como saida
.macro pinPA8_saida
    ldr r6, [r8, #0x804]        @Acessar pinos com deslocamento 0x4 do endereço base
                                @Valor padrão do 0x804 é 0x77777777 = 0111 0111 0111 0111 0111 0111 0111 0111
                                @Para setar como saida o PA8 setar os bits 2:0 como 001 -> 0x77777771  
                                @000 input, 001 output
    lsl r6, r6, #4              @0x77777770 = 0111 0111 0111 0111 0111 0111 0111 0000
    add, r6, #1                 @0x77777771 = 0111 0111 0111 0111 0111 0111 0111 0001
    str r6, [r8, #0x804]        @Carrega a configuração
.endm


@Setar o PA8 como saida logica alta
.macro pinPA8_saida_1
    @Configurar PA_DAT -> Valor padrão = 0x00000000
    ldr r6, [r8, #0x810]        @Acessar pinos com deslocamento 0x10 do endereço base -> PA_DAT
                                @Valor padrão do 0x810 é 0x00000000
                                @Para setar o PA8 com saida logica alta, mudar o bit 8 para 1
    add, r6, #1                 @0x00000001 = 0000 0000 0000 0000 0000 0000 0000 0001
    lsl r6, r6, #8              @0000 0000 0000 0000 0000 0000 1000 0000
    str r6, [r8, #0x810]        @Carrega a configuração
.endm


@Setar o pino PA8 como padrão
.macro pinPA8_padrao
    ldr r6, [r8, #0x804]        @Acessar pinos com deslocamento 0x4 do endereço base
                                @Valor está em 0x77777771
    add, r6, #6                 @0x77777777
    str r6, [r8, #0x804]        @Carrega a configuração
.endm

@Setar o PA8 como saida logica baixa
.macro pinPA8_saida_0
    @Configurar PA_DAT -> Valor atual = 0000 0000 0000 0000 0000 0000 1000 0000
    ldr r6, [r8, #0x810]        @Acessar pinos com deslocamento 0x10 do endereço base -> PA_DAT                      
    lsr r6, r6, #9              @0000 0000 0000 0000 0000 0000 0000 0000
    str r6, [r8, #0x810]        @Carrega a configuração
.endm
