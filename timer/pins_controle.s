@pins_controle

@Configuração de pinos para o led
@PG07 -> db7   -> PG07 : Pino -> 30:28 : Bits de configuração -> 0xD8 : Offset
@PG06 -> db6   -> PG06 : Pino -> 26:24 : Bits de configuração -> 0xD8 : Offset
@PG09 -> db5   -> PG09 : Pino -> 06:04 : Bits de configuração -> 0xDC : Offset
@PG08 -> db4   -> PG08 : Pino -> 02:00 : Bits de configuração -> 0xDC : Offset
@ PG_DATA -> 0xE8 : Offset -> Bits para mandar sinal alto ou baixo pro pino

@PA18 -> E    -> PA18 : Pino -> 10:08 :  -> 0x08 : Offset
@PA02 -> RS   -> PA02 : Pino -> 10:08 : Bits de configuração -> 0x00 : Offset
@ PA_DATA -> 0x10 : Offset -> Bits para mandar sinal alto ou baixo pro pino


@Botões
@ PA20 -> 18:16 : Bits de configuração ->  0x08 : Offset
@ PA10 -> 10:8 : Bits de configuração ->  0x04 : Offset
@ PA_DATA -> 0x10 : Offset -> Bits para mandar sinal alto ou baixo pro pino




@
@ ====================================== Pinos do Botão como entrada ======================================
@
.macro pins_botoes_entrada
    
    @
    @Setar PA20 como entrada
    @
    ldr r6, [r8, #0x808]
    mov r7, #0xF
    lsl r7, r7, #16
    bic r6, r6, r7
    str r6, [r8, #0x808]
    


    @
    @Setar PA10 como entrada
    @
    ldr r6, [r8, #0x804]
    mov r7, #0xF
    lsl r7, r7, #8
    bic r6, r6, r7
    str r6, [r8, #0x804]

    
.endm




@
@ ====================================== Pinos do Botão como entrada ======================================
@
@
@ PA20
@
.macro get_pa20
    ldr r6, [r8, #0x810] @PA dat
    mov r2, #1
    lsr r6, r6, #20
    and r2, r6, r2 @Se r9 = 1 botão desligado, se r9 = 0 botão ligado
.endm

@
@ PA10
@
.macro get_pa10
    ldr r6, [r8, #0x810] @PA dat
    mov r2, #1
    lsr r6, r6, #10
    and r2, r6, r2 @Se r1 = 1 botão desligado, se r1 = 0 botão ligado
.endm




@ ====================================== Pinos do Display como saida ======================================
@
.macro pins_display_saida
    
    @Setar pins do d7 e d6 como saida
    ldr r6, [r8, #0x8D8]
    mov r7, #0xFF
    lsl r7, r7, #24
    bic r6, r6, r7
    mov r7, #0x11
    lsl r7, r7, #24
    orr r6, r6, r7
    str r6, [r8, #0x8D8]


    @Setar d5 e d4 como saida
    ldr r6, [r8, #0x8DC]
    mov r7, #0xFF
    bic r6, r6, r7
    mov r7, #0x11
    orr r6, r6, r7
    str r6, [r8, #0x8DC]


    @Setar E como saida
    ldr r6, [r8, #0x808] @E
    ldr r5, [r8, #0x800] @RS
    
    mov r7, #0xF00
    bic r6, r6, r7
    bic r5, r5, r7
    
    mov r7, #0x100
    orr r6, r6, r7
    orr r5, r5, r7

    str r6, [r8, #0x808] @E
    str r6, [r8, #0x800] @RS
.endm




@
@=========================================== Controladores dos Pinos DB4 a DB7, RS e Enable ===========================================
@
@ Todos os controladores, esperam o valor de configuração do pino no r7
@ r7: esperam o valor de configuração do pino
@


@
@ Db4 On
@
.macro db4_on
    mov r7, #1
    ldr r6, [r8, #0x8E8] @PG_dat
    lsl r7, r7, #8
    orr r6, r6, r7
    str r6, [r8, #0x8E8]
.endm


@
@ Db4 Off
@
.macro db4_off
    mov r7, #1
    ldr r6, [r8, #0x8E8] @PG_dat
    lsl r7, r7, #8
    bic r6, r6, r7
    str r6, [r8, #0x8E8]
.endm


@
@ Db5 On
@
.macro db5_on
    mov r7, #1
    ldr r6, [r8, #0x8E8] @PG_dat
    lsl r7, r7, #9
    orr r6, r6, r7
    str r6, [r8, #0x8E8]
.endm


@
@ Db5 Off
@
.macro db5_off
    mov r7, #1
    ldr r6, [r8, #0x8E8] @PG_dat
    lsl r7, r7, #9
    bic r6, r6, r7
    str r6, [r8, #0x8E8]
.endm


@
@ Db6 On
@
.macro db6_on
    mov r7, #1
    ldr r6, [r8, #0x8E8] @PG_dat
    lsl r7, r7, #6
    orr r6, r6, r7
    str r6, [r8, #0x8E8]
.endm


@
@ Db6 Off
@
.macro db6_off
    mov r7, #1
    ldr r6, [r8, #0x8E8] @PG_dat
    lsl r7, r7, #6
    bic r6, r6, r7
    str r6, [r8, #0x8E8]
.endm


@
@ Db7 on
@
.macro db7_on
    mov r7, #1
    ldr r6, [r8, #0x8E8] @PG_dat
    lsl r7, r7, #7
    orr r6, r6, r7
    str r6, [r8, #0x8E8]
.endm


@
@ Db7 Off
@
.macro db7_off
    mov r7, #1
    ldr r6, [r8, #0x8E8] @PG_dat
    lsl r7, r7, #7
    bic r6, r6, r7
    str r6, [r8, #0x8E8]
.endm


@
@ RS On
@
.macro rs_on
    mov r7, #1
    ldr r6, [r8, #0x810] @PA_dat
    mov r7, #1
    lsl r7, r7, #2
    orr r6, r6, r7
    str r6, [r8, #0x810]
.endm


@
@ RS Off
@
.macro rs_off
    mov r7, #1
    ldr r6, [r8, #0x810] @PA_dat
    mov r7, #1
    lsl r7, r7, #2
    bic r6, r6, r7
    str r6, [r8, #0x810]
.endm


@
@ Enable On
@
.macro e_on
    mov r7, #1
    ldr r6, [r8, #0x810] @PA_dat
    mov r7, #0x1
    lsl r7, r7, #18
    orr r6, r6, r7
    str r6, [r8, #0x810]
.endm


@
@ Enable Off
@
.macro e_off
    mov r7, #1
    ldr r6, [r8, #0x810] @PA_dat
    mov r7, #0x1
    lsl r7, r7, #18
    bic r6, r6, r7
    str r6, [r8, #0x810]
.endm

