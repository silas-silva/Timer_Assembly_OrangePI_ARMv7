@Configuração de pinos para o led
@PG07 -> db7   -> PG07 : Pino -> 30:28 : Bits de configuração -> 0xD8 : Offset
@PG06 -> db6   -> PG06 : Pino -> 26:24 : Bits de configuração -> 0xD8 : Offset
@PG09 -> db5   -> PG09 : Pino -> 06:04 : Bits de configuração -> 0xDC : Offset
@PG08 -> db4   -> PG08 : Pino -> 02:00 : Bits de configuração -> 0xDC : Offset
@ PG_DATA -> 0xE8 : Offset -> Bits para mandar sinal alto ou baixo pro pino

@PA18 -> E    -> PA18 : Pino -> 10:08 : Bits de configuração -> 0x08 : Offset
@PA02 -> RS   -> PA02 : Pino -> 10:08 : Bits de configuração -> 0x00 : Offset
@ PA_DATA -> 0x10 : Offset -> Bits para mandar sinal alto ou baixo pro pino



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
    nanoSleep timeZero, time_1_mili

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
    nanoSleep timeZero, time_100_micro
    

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
    
    @setar função de 4 bits
    function_set
    
    @
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


    @Desligar display
    display_off

    @clear
    clear_display

    @Modo para setar caracteres
    entry_mode_set


    @Ligar display
    display_on
    
.endm
