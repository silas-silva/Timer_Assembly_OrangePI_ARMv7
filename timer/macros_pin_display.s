@Configuração de pinos para o led
@PG07 -> d7   -> PG07 : Pino -> 30:28 : Bits de configuração -> 0xD8 : Offset
@PG06 -> d6   -> PG06 : Pino -> 26:24 : Bits de configuração -> 0xD8 : Offset
@PG09 -> d5   -> PG09 : Pino -> 06:04 : Bits de configuração -> 0xDC : Offset
@PG08 -> d4   -> PG08 : Pino -> 02:00 : Bits de configuração -> 0xDC : Offset
@ PG_DATA -> 0xE8 : Offset -> Bits para mandar sinal alto ou baixo pro pino

@PA18 -> E    -> PA18 : Pino -> 10:08 : Bits de configuração -> 0x08 : Offset
@PA02 -> RS   -> PA02 : Pino -> 10:08 : Bits de configuração -> 0x00 : Offset
@ PA_DATA -> 0x10 : Offset -> Bits para mandar sinal alto ou baixo pro pino



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


@ =========================================== Inicializar display ===========================================
@

.macro inicializar_display
    function_Set

    .ltorg
    
    set_display  0, 0, 0, 1, 0
    set_enable

    set_display  0, 0, 0, 1, 0
    set_enable

    set_display  0, 0, 0, 1, 1
    set_enable



    set_display  0, 0, 0, 0, 0
    set_enable

    set_display  0, 0, 0, 0, 0
    set_enable

    set_display  0, 0, 0, 0, 0
    set_enable

    set_display  0, 0, 0, 0, 1
    set_enable

    set_display  0, 0, 0, 0, 0
    set_enable

    set_display  0, 0, 1, 1, 0
    set_enable

    .ltorg
.endm

@ ======================================================================================
@

.macro setH
    set_display 1, 0, 1, 0, 0
    set_enable

    set_display 1, 1, 0, 0, 0
    set_enable
.endm

@ ======================================================================================
@

.macro clear
    set_display 0, 0, 0, 0, 0
    set_enable

    set_display 0, 0, 0, 0, 1
    set_enable
.endm

@ ======================================================================================
@

.macro entry_mode_Set
    set_display 0, 0, 0, 0, 0
    set_enable

    set_display 0, 0, 1, 1, 0
    set_enable
.endm

@ ======================================================================================
@
.macro display_on_off
    set_display 0, 0, 0, 0, 0
    set_enable

    set_display 0, 1, 1, 1, 0
    set_enable
.endm


@ ======================================================================================
@
.macro function_Set
        
    @Primeiros 3 comandos
    set_display 0, 0, 0, 1, 1
    set_enable_1
    nanoSleep timeZero, time_5_mili
    set_enable_0

    set_display 0, 0, 0, 1, 1
    set_enable_1
    nanoSleep timeZero, time_100_micro
    set_enable_0

    set_display  0, 0, 0, 1, 1
    set_enable

    set_display  0, 0, 0, 1, 0
    set_enable

.endm


@ ======================================================================================
@
.macro set_enable
    set_enable_0
    set_enable_1
    nanoSleep timeZero, time_1_mili
    set_enable_0
.endm

@ ====================================== controle enable ======================================
@Setar enable como saida logica alta (1)
.macro set_enable_1
    ldr r6, [r8, #0x810] @PA_dat
    mov r7, #0x1
    lsl r7, r7, #18
    orr r6, r6, r7
    str r6, [r8, #0x810]
.endm

@ ======================================================================================
@
@Setar enable como saida logica baixa (0)
.macro set_enable_0
    ldr r6, [r8, #0x810] @PA_dat
    mov r7, #0x1
    lsl r7, r7, #18
    bic r6, r6, r7
    str r6, [r8, #0x810]
.endm

@ ============================================== Setar display ==============================================
@
.macro set_display RS, DB7, DB6, DB5, DB4
    
    mov r7, #\DB4
    controller_d4

    mov r7, #\DB5
    controller_d5

    mov r7, #\DB6
    controller_d6

    mov r7, #\DB7
    controller_d7
    
    mov r11, #0x0
    add r11, #\RS
    lsl r11, r11, #2
    str r11, [r8, #0x810]

.endm  @Configuração de pinos para o led



@=====================================================================================================================
.macro controller_d4
    ldr r6, [r8, #0x8E8] @PA_dat
    lsl r7, r7, #8
    orr r6, r6, r7
    str r6, [r8, #0x8E8]
.endm



.macro controller_d5
    ldr r6, [r8, #0x8E8] @PA_dat
    lsl r7, r7, #9
    orr r6, r6, r7
    str r6, [r8, #0x8E8]
.endm


.macro controller_d6
    ldr r6, [r8, #0x8E8] @PA_dat
    lsl r7, r7, #6
    orr r6, r6, r7
    str r6, [r8, #0x8E8]
.endm

.macro controller_d7
    ldr r6, [r8, #0x8E8] @PA_dat
    lsl r7, r7, #7
    orr r6, r6, r7
    str r6, [r8, #0x8E8]
.endm




@PG07 -> d7   -> PG07 : Pino -> 30:28 : Bits de configuração -> 0xD8 : Offset
@PG06 -> d6   -> PG06 : Pino -> 26:24 : Bits de configuração -> 0xD8 : Offset
@PG09 -> d5   -> PG09 : Pino -> 06:04 : Bits de configuração -> 0xDC : Offset
@PG08 -> d4   -> PG08 : Pino -> 02:00 : Bits de configuração -> 0xDC : Offset
@ PG_DATA -> 0xE8 : Offset -> Bits para mandar sinal alto ou baixo pro pino

@PA18 -> E    -> PA18 : Pino -> 10:08 : Bits de configuração -> 0x08 : Offset
@PA02 -> RS   -> PA02 : Pino -> 10:08 : Bits de configuração -> 0x00 : Offset
@ PA_DATA -> 0x10 : Offset -> Bits para mandar sinal alto ou baixo pro pino
