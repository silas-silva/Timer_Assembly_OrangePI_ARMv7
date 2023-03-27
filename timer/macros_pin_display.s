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
    #Setar pins do d7 e d6 como saida
    ldr r10, =pins_d7_d6_saida
    ldr r10, [r10]
    str r10, [r8, #0x8D8]

    #Setar d5 e d4 como saida
    ldr r10, =pins_d5_d4_saida
    ldr r10, [r10]
    str r10, [r8, #0x8DC]

    #Setar E e RS como saida
    ldr r10, =pins_E_RS_saida
    ldr r10, [r10]
    str r10, [r8, #0x808] #E
    str r10, [r8, #0x800] #RS
.endm




@ ====================================== Pinos do Display como padrão ======================================
@
.macro pins_display_padrao
    ldr r10, =padraoPin
    ldr r10, [r10]
    
    #Setar pins do d7 e d6 como padrão
    str r10, [r8, #0x8D8]

    #Setar d5 e d4 como padrão
    str r10, [r8, #0x8DC]

    #Setar E e RS como padrão
    str r10, [r8, #0x808] #E
    str r10, [r8, #0x800] #RS
.endm

@ =========================================== Inicializar display ===========================================
@
.macro inicializar_display
    @ function set
    setDisplay 0b, 0b, 0b, 0100b, 1000b
    nanoSleep timeZero, timespecnano5

    @ function set
    setDisplay 0b, 0b, 0b, 0100b, 1000b
    nanoSleep timeZero, timespecnano120  

    @ function set
    setDisplay  0b, 0b, 0b, 0100b, 1000b


    setDisplay 0b, 0b, 0b, 0100b, 0b
    nanoSleep timeZero, timespecnano120  

    .ltorg 

    @ function set
    setDisplay 0b, 0b, 0b, 0100b, 0b 
    setDisplay 0b, 0b, 0b, 0b, 0b
    nanoSleep timeZero, timespecnano120 

    @ display off
    setDisplay 0b, 0b, 0b, 0b, 0b 
    setDisplay 0b, 1b, 0b, 0b, 0b  
    nanoSleep timeZero, timespecnano120

    @ display clear
    setDisplay 0b, 0b, 0b, 0b, 0b  
    setDisplay 0b, 0b, 0b, 0b, 1000b  
    nanoSleep timeZero, timespecnano120 

    @ entry mode set
    setDisplay 0b, 0b, 0b, 0b, 0b
    setDisplay 0b, 0b, 10b, 100b, 0b 
    nanoSleep timeZero, timespecnano120
    .ltorg

.endm




@ ============================================== Setar display ==============================================
@
.macro set_display RS, DB7, DB6, DB5, DB4
    mov r11, #0x0
    add r11, \DB4 @Se db4 for saida alta, vem o numero 1000, se for baixa é 0
    add r11, \DB5 @Se db5 for saida alta, vem o numero 0100, se for baixa é 0
    add r11, \DB6 @Se db6 for saida alta, vem o numero 0010, se for baixa é 0
    add r11, \DB7 @Se db7 for saida alta, vem o numero 0001, se for baixa é 0
    @Manipulado os dados carregar as configurações no PG_Data
    lsl r11, r11, #6
    str r11, [r8, #0x8E8]

    mov r11, #0x0
    add r11, \RS
    lsl r11, r11, #2
    str r11, [r8, #0x810] 
.endm



@ =========================================== deslocamento do cursor ===========================================
@
.macro displayShift
    setDisplay 0b, 0b, 0b, 0b, 1000b
    setDisplay 0b, 0b, 10b, 0b, 0b
    nanoSleep timeZero, timespecnano120
.endm



@ =============================================== Limpar Display ===============================================
@
.macro clearDisplay
    setDisplay 0b, 0b, 0b, 0b, 0b
    setDisplay 0b, 0b, 0b, 0b, 1000b
    nanoSleep timeZero, timespecnano120
.endm