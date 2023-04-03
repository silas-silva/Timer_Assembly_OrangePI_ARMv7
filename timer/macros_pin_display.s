@Configuração de pinos para o led
@PG07 -> db7   -> PG07 : Pino -> 30:28 : Bits de configuração -> 0xD8 : Offset
@PG06 -> db6   -> PG06 : Pino -> 26:24 : Bits de configuração -> 0xD8 : Offset
@PG09 -> db5   -> PG09 : Pino -> 06:04 : Bits de configuração -> 0xDC : Offset
@PG08 -> db4   -> PG08 : Pino -> 02:00 : Bits de configuração -> 0xDC : Offset
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




@
@ ================================================== enable ==================================================
@
@ Depois de colocar os dados no pino do db4 a db7, chamar o enable, para o LCD ler os bits
@
.macro enable
    e_off
    e_on
    nanoSleep timeZero, time_1_micro
    e_off
    nanoSleep timeZero, time_5_mili

.endm




@
@ ============================================== Clear Display ==============================================
@ 
@ Limpar o display
@

.macro clear_display
    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 0, 0
    rs_off
    db7_off
    db6_off
    db5_off
    db4_off
    enable

    @set_display 0, 0, 0, 0, 1
    rs_off
    db7_off
    db6_off
    db5_off
    db4_on
    enable
.endm




@
@ ================================================== Display ON/OFF ==================================================
@
.macro display_on
    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 0, 0
    rs_off
    db7_off
    db6_off
    db5_off
    db4_off
    enable

    @set_display 0, 1, 1, 1, 1  @Ultimo parametro, faz cursor piscar, penultimo faz o cursor ligar, e o do lado é para ligar o lcd
    rs_off
    db7_on
    db6_on
    db5_on
    db4_on
    enable
.endm


.macro display_off
    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 0, 0
    rs_off
    db7_off
    db6_off
    db5_off
    db4_off
    enable

    @set_display 0, 1, 0, 0, 0  @Ultimo parametro, faz cursor piscar, penultimo faz o cursor ligar, e o do lado é para ligar o lcd
    rs_off
    db7_on
    db6_off
    db5_off
    db4_off
    enable
.endm




@
@ ======================================= Modo set de dados ===============================================
@
@ Configura o display para receber um dado, escrever e deslocar o cursor para a proxima posição
@
.macro entry_mode_set
    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 0, 0
    rs_off
    db7_off
    db6_off
    db5_off
    db4_off
    enable

    @set_display 0, 0, 1, 1, 0
    rs_off
    db7_off
    db6_on
    db5_on
    db4_off
    enable
.endm




@
@ ========================================================= Set Função 4 bits =========================================================
@
.macro function_set
    @rs, d7, d6, d5, d4
    
    @set_display 0, 0, 0, 1, 1
    rs_off
    db7_off
    db6_off
    db5_on
    db4_on
    enable
    nanoSleep timeZero, time_5_mili


    @set_display 0, 0, 0, 1, 1
    rs_off
    db7_off
    db6_off
    db5_on
    db4_on
    enable
    nanoSleep timeZero, time_150_micro
    

    @set_display  0, 0, 0, 1, 1
    rs_off
    db7_off
    db6_off
    db5_on
    db4_on
    enable
.endm




@ ===================================================== Setar Letra H =====================================================
@

.macro set_h
    @rs, d7, d6, d5, d4
    @set_display 1, 0, 1, 0, 0
    rs_on
    db7_off
    db6_on
    db5_off
    db4_off
    enable

    @set_display 1, 1, 0, 0, 0
    rs_on
    db7_on
    db6_off
    db5_off
    db4_off
    enable
.endm




@ =========================================== Inicializar display ===========================================
@
.macro inicializar_display
    e_off
    
    @rs, d7, d6, d5, d4
    
    @set_display 0, 0, 0, 1, 1
    rs_off
    db7_off
    db6_off
    db5_on
    db4_on
    enable
    nanoSleep timeZero, time_5_mili


    @set_display 0, 0, 0, 1, 1
    rs_off
    db7_off
    db6_off
    db5_on
    db4_on
    enable
    nanoSleep timeZero, time_150_micro
    

    @set_display  0, 0, 0, 1, 1
    rs_off
    db7_off
    db6_off
    db5_on
    db4_on
    enable


    
    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 1, 0
    rs_off
    db7_off
    db6_off
    db5_on
    db4_off
    enable

    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 1, 0
    rs_off
    db7_off
    db6_off
    db5_on
    db4_off
    enable

    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 0, 0
    rs_off
    db7_off
    db6_off
    db5_off
    db4_off
    enable


    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 0, 0
    rs_off
    db7_off
    db6_off
    db5_off
    db4_off
    enable


    @rs, d7, d6, d5, d4
    @set_display 0, 1, 0, 0, 0
    rs_off
    db7_on
    db6_off
    db5_off
    db4_off
    enable

    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 0, 0
    rs_off
    db7_off
    db6_off
    db5_off
    db4_off
    enable

    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 0, 1
    rs_off
    db7_off
    db6_off
    db5_off
    db4_on
    enable

    @rs, d7, d6, d5, d4
    @set_display 0, 0, 0, 0, 0
    rs_off
    db7_off
    db6_off
    db5_off
    db4_off
    enable

    @rs, d7, d6, d5, d4
    @set_display 0, 0, 1, 1, 0
    rs_off
    db7_off
    db6_on
    db5_on
    db4_off
    enable


    @display_off

    @clear_display

    display_on
    
    @Ligar display

    @Modo de setar
    @entry_mode_set

    @set h
    @set_h
    @clear_display

.endm
