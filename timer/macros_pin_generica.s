@Configuração de pinos para o led
@PG07 -> d7   -> PG07 : Pino -> 30:28 : Bits de configuração -> 0xD8 : Offset
@PG06 -> d6   -> PG06 : Pino -> 26:24 : Bits de configuração -> 0xD8 : Offset
@PG09 -> d5   -> PG09 : Pino -> 06:04 : Bits de configuração -> 0xDC : Offset
@PG08 -> d4   -> PG08 : Pino -> 02:00 : Bits de configuração -> 0xDC : Offset
@ PG_DATA -> 0xE8 : Offset -> Bits para mandar sinal alto ou baixo pro pino

@PA18 -> E    -> PA18 : Pino -> 10:08 : Bits de configuração -> 0x08 : Offset
@PA02 -> RS   -> PA02 : Pino -> 10:08 : Bits de configuração -> 0x00 : Offset

@Setar o pino como saida -> Forma generica
.macro pin_saida offset, deslocamento
    mov r1, \offset
    add r1, #0x800              @Valor para ir pra posição base do Gpio, e soma com o deslocamento
    ldr r6, [r8, r1]            @Acessar pinos com deslocamento "offset" do endereço base
                                @ Os pinos tem o valor padrão de 0x77777777, se não for mudado no codigo
                                @Para setar pinos como saida seus bits de controle devem ficar como 001
                                @000 input, 001 output
    mov r2, \deslocamento
    lsl r6, r6, #1              @Deslocamento para deixar os ultimos bits como zero
    add r6, #1                  @0x77777771 = 0111 0111 0111 0111 0111 0111 0111 0001
    lsl r6, r6, r2              @deslocamento para colocar os bits de contole onde devem fcar
    str r6, [r8, r1]        @Carrega a configuração
.endm


@Setar pino como saida logica alta -> Forma generica
.macro pin_saida_alta offset, num_pin
    mov r1, \offset 
    add r1, #0x800              @Valor para ir pra posição base do Gpio, e soma com o deslocamento
    ldr r6, [r8, r1]            @Acessar pinos com deslocamento
                                @Valor padrão normalmente é 0x00000000, tudo como saida zero
    add r6, #1                  @0x00000001 = 0000 0000 0000 0000 0000 0000 0000 0001
    mov r2, \num_pin            @Deslocamento para chegar no pino
    lsl r6, r6, r2              
    str r6, [r8, r1]            @Carrega a configuração
.endm


@Setar o pinos como padrão 0x77777777
.macro offset, pin_retornar_padrao
    mov r1, \offset 
    add r1, #0x800
    ldr r6, =padraoPin        
    ldr r6, [r6]                @Carrega o valor 0x77777777 em r6
    str r6, [r8, r1]            @Carrega a configuração para resetar os pinos correspondente ao offset
.endm


@Setar saidas de todos os pinos como padrão "0"
.macro pin_saida_padrao offset
    mov r1, \offset 
    add r1, #0x800              @Valor para ir pra posição base do Gpio, e soma com o deslocamento
    ldr r6, =padraoSaidaPin     
    ldr r6, [r6]                @Carrega o valor 0x00000000    
    str r6, [r8, r1]            @Carrega a configuração
.endm