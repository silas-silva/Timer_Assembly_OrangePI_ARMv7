@Configuração de pinos para o led

@PG07 -> d7   -> PG07 : Pino -> 30:28 : Bits de configuração -> 0xD8 : Offset
@PG06 -> d6   -> PG06 : Pino -> 26:24 : Bits de configuração -> 0xD8 : Offset

@PG09 -> d5   -> PG09 : Pino -> 06:04 : Bits de configuração -> 0xDC : Offset
@PG08 -> d4   -> PG08 : Pino -> 02:00 : Bits de configuração -> 0xDC : Offset
@ PG_DATA -> 0xE8 : Offset -> Bits para mandar sinal alto ou baixo pro pino

@PA18 -> E    -> PA18 : Pino -> 10:08 : Bits de configuração -> 0x08 : Offset
@PA02 -> RS   -> PA02 : Pino -> 10:08 : Bits de configuração -> 0x00 : Offset


@Setar o pino PA8 como saida
.macro pinPA8_saida
    ldr r6, [r8, #0x804]        @Acessar pinos com deslocamento 0x4 do endereço base
                                @Valor padrão do 0x804 é 0x77777777 = 0111 0111 0111 0111 0111 0111 0111 0111
                                @Para setar como saida o PA8 setar os bits 2:0 como 001 -> 0x77777771  
                                @000 input, 001 output
    lsl r6, r6, #4              @0x77777770 = 0111 0111 0111 0111 0111 0111 0111 0000
    add r6, #1                 @0x77777771 = 0111 0111 0111 0111 0111 0111 0111 0001
    str r6, [r8, #0x804]        @Carrega a configuração
.endm


@Setar o PA8 como saida logica alta
.macro pinPA8_saida_1
    @Configurar PA_DAT -> Valor padrão = 0x00000000
    ldr r6, [r8, #0x810]        @Acessar pinos com deslocamento 0x10 do endereço base -> PA_DAT
                                @Valor padrão do 0x810 é 0x00000000
                                @Para setar o PA8 com saida logica alta, mudar o bit 8 para 1
    add r6, #1                 @0x00000001 = 0000 0000 0000 0000 0000 0000 0000 0001
    lsl r6, r6, #8              @0000 0000 0000 0000 0000 0000 1000 0000
    str r6, [r8, #0x810]        @Carrega a configuração
.endm


@Setar o pino PA8 como padrão
.macro pinPA8_padrao
    ldr r6, =padraoPin        
    ldr r6, [r6]                @Carrega o valor 0x77777777 em r6
    str r6, [r8, #0x804]        @Carrega a configuração para resetar os pinos de PA8
.endm

@Setar o PA8 como saida logica baixa
.macro pinPA8_saida_0
    @Configurar PA_DAT -> Valor atual = 0000 0000 0000 0000 0000 0000 1000 0000
    ldr r6, [r8, #0x810]        @Acessar pinos com deslocamento 0x10 do endereço base -> PA_DAT                      
    lsr r6, r6, #9              @0000 0000 0000 0000 0000 0000 0000 0000
    str r6, [r8, #0x810]        @Carrega a configuração
.endm
