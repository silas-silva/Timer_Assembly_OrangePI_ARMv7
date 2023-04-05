.include "macros_gerais.s"     @3
.include "display.s"           @2
.include "pins_controle.s"     @5
.include "digitos_display.s"   @1
.include "mostrar_digitos.s"   @4


.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_SHARED, 1
.equ S_RDWR, 0666

.global _start

_start:
    openDevmem      @abrir arquivo devmem
    mapMem          @Mapear
    movs r8, r0     @Jogar o mapeamento em r8

    @ Setar os pinos do display como saida
    pins_display_saida
    
    @ Setar os pinos dos botões como entrada
    pins_botoes_entrada

    @Ligar display
    inicializar_display

    ldr r11, =num
    ldr r11, [r11]

    b loop_digitos




@
@ ======================================== Loop para o timer e mostrar bits ========================================
@

loop_digitos:
    mov r12, #0
    mov r1, r11
    
    @Valor a ser mostrado no LCD tem que estar em r1 e o retorno de "num_para_digitos" está em r9
    num_para_digitos

    @Limpar display
    clear_display
    
    @mostrar digitos
    b digitos


esperar_voltar_loop:
    nanoSleep timeZero, time_900_mili
    
    sub r11, #1 @Diminuir do valor

    @ Pegar dados dos botões
    get_pa20
    get_pa10

    @ Condição de pause
    cmp r9,#0  @Verificar se PA20 foi pressionado
    beq pause
    
    @ Condição de Reiniciar timer
    cmp r1,#0  @Verificar se PA10 foi pressionado
    beq restaura_timer
    
    b loop_digitos


digitos:
    @Mostrar digito
    add r12, #1
    mostrar_e_apagar_digito



@
@ ======================================== PAUSE/REINICIAR e RESETAR ========================================
@
pause:
    get_pa20
    get_pa10
    
    @ Condição para continuar
    cmp r9,#0  @Verificar se PA20 foi pressionado
    beq loop_digitos
    
    @ Condição de Reiniciar timer
    cmp r1,#0       @Verificar se PA10 foi pressionado 
    beq restaura_timer


restaura_timer:
    ldr r11, =num 
    ldr r11, [r11]  @Restaura o contador para valor inicial 




@
@ ======================================== Mostrar Bit especifico ========================================
@

mostrar_0:
    set_0
    voltar_para_outros_digitos

mostrar_1:
    set_1
    voltar_para_outros_digitos

mostrar_2:
    set_2
    voltar_para_outros_digitos

mostrar_3:
    set_3
    voltar_para_outros_digitos

mostrar_4:
    set_4
    voltar_para_outros_digitos

mostrar_5:
    set_5
    voltar_para_outros_digitos

mostrar_6:
    set_6
    voltar_para_outros_digitos

mostrar_7:
    set_7
    voltar_para_outros_digitos

mostrar_8:
    set_8
    voltar_para_outros_digitos

mostrar_9:
    set_9
    voltar_para_outros_digitos




@
@ ======================================== End ========================================
@

end:
    mov r0, #0
    mov r7, #1
    svc 0




@
@ ======================================== .DATA ========================================
@
.data
    devmem: .asciz "/dev/mem"
    pagelen: .word 0x1000
    gpioaddr: .word 0x1C20    @0x01C20800 / 0x1000 (4096)   @Endereço base do GPIO / 0x1000
    
    num: .word 45
    
    second: .word 1                 @ 1 segundo
    timeZero: .word 0
    time_1_mili: .word 1000000
    time_5_mili: .word 5000000
    time_15_mili: .word 15000000
    time_900_mili: .word 900000000
    time_1_micro: .word 1000
    time_100_micro: .word 100000
    time_150_micro: .word 150000 
    time_1_nano: .word 1000000000
    time_100_nano: .word 1000000000
