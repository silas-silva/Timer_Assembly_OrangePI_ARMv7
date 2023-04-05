.macro dividir_mostrar_digitos
    @Valor a ser mostrado no LCD tem que estar em r1 e o retorno de "num_para_digitos" está em r9
    num_para_digitos

    @Mostrar centena de milhar
    mostrar_e_apagar_digito

    @Mostrar dezena de milhar
    mostrar_e_apagar_digito

    @Mostrar unidade de milhar
    mostrar_e_apagar_digito


    @Mostrar centena
    mostrar_e_apagar_digito

    @Mostrar dezena
    mostrar_e_apagar_digito

    @Mostrar unidade
    mostrar_e_apagar_digito

.endm

.macro mostrar_e_apagar_digito
    mov r7, #0xF
    and r3, r9, r7
    
    @Apagar centena de milhar
    lsr r9, r9, #4                 @Tirar o digito do registrador r9

    mostrar_digitos                @Passar o digito no registrador r3

.endm

.macro mostrar_digitos
    cmp r3, #0
    beq mostrar_0

    cmp r3, #1
    beq mostrar_1

    cmp r3, #2
    beq mostrar_2

    cmp r3, #3
    beq mostrar_3

    cmp r3, #4
    beq mostrar_4

    cmp r3, #5
    beq mostrar_5

    cmp r3, #6
    beq mostrar_6

    cmp r3, #7
    beq mostrar_7

    cmp r3, #8
    beq mostrar_8

    cmp r3, #9
    beq mostrar_9
.endm


.macro voltar_para_outros_digitos
    cmp r12, #6
    beq esperar_voltar_loop
    b digitos

.endm