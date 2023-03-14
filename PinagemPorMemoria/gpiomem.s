@ Various macros to access the GPIO pins
@ on the Raspberry Pi.
@
@ R8 - memory map address.
@

.include "fileio.s"

.equ pagelen, 4096
.equ setregoffset, 28
.equ clrregoffset, 40
.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_SHARED, 1

@ Macro to map memory for GPIO Registers
.macro mapMem
    openFile devmem, S_RDWR             @ Abrir /dev/mem com permissão de leitura e escrita
    movs r4, r0                         @ Descritor do arquivo /dev/mem
    
    BPL mapear              @Verificar se ouve erro ao abrir o arquivo, Se não ouver erro pular para a label 1f
    
    @O valor 1 é frequentemente usado como descritor de arquivo para a saída padrão do terminal (stdout), que é o local onde mensagens de erro podem ser exibidas para o usuário
    MOV R1, #1          @Caso dê erro, carrega o 1 em r1, o 1 
    LDR R2, =memOpnsz   @ Error msg
    LDR R2, [R2]        @ Carrega o valor que está na posição de memoria que r2 guarda, em r2
    writeFile R1, memOpnErr, R2  @Escreve arquivo de error (print de error)
    B _end  

    @ A configuração pode chamar o serviço Linux mmap2
    mapear: 
        @r0: passar 0 para deixar o Linux escolher um endereço virtual adequado.
        @r1: passar o tamanho da memória que deseja mapear.
        @r2: passar as permissões que deseja atribuir ao mapeamento (por exemplo, PROT_READ + PROT_WRITE para permissão de leitura e escrita).
        @r3: passar MAP_SHARED para criar um mapeamento compartilhado.
        @r4: passar o descritor de arquivo para /dev/mem.
        @r5: passar o endereço físico da GPIO que deseja mapear.
        @ O endereço virtual será retornado em r0, armazene em outro registrador, exemplo r8

        mov r0, #0                            @ Deixa o linux escolher o endereço virtual
        
        mov r1, #pagelen                      @ Tamano da memoria que queremos 4096
        
        @ Opções de proteção de memoria
        mov r2, #(PROT_READ + PROT_WRITE)     @Colocando permissão de leitura e escrita em r2 combina as permissões com a soma
        
        mov r3, #MAP_SHARED                   @ Opções de compartilhamento de memoria
        
        @r4 está recebendo o descritor do arquivo de dev/mem, na parte que abre o arquivo 

        ldr r5, =gpioaddr       @ Endereço base da GPIO
        ldr r5, [r5]            @ Carrega o endereço no r5
        
        mov r7, #sys_mmap2                    @ mmap2 = 192 numero de serviço (ele pega os dados de r1 a r3 como paramentros)
        
        svc 0                                 @ Chamada de sistema
        
        movs r8, r0                           @ Manter o endereço virtual retornado
        
        @ Checar errors e printar se necessario
        BPL continuar @ arquivo de número aberto ok
        
        MOV R1, #1  @ stdout
        LDR R2, =memMapsz @ Error msg
        LDR R2, [R2]
        writeFile R1, memMapErr, R2     @Escreve arquivo de error (print de error)
        B _end
    continuar:
.endm

@ Macro nanoSleep para esperar 0,1 segundo
@ Chama o ponto de entrada nanosleep do Linux, que é a função 162.
@ Passe uma referência para uma especificação de tempo em r0 e r1
@ Primeiro é o tempo de entrada para esperar em segundos e nanossegundos.
@ Segundo é o tempo restante para esperar se for interrompido (o que ignoramos)
.macro nanoSleep
    ldr r0, =timespecsec
    ldr r1, =timespecsec
    mov r7, #sys_nanosleep
    svc 0
.endm

.macro GPIODirectionOut pin
    ldr r2, =\pin           @ deslocamento (offset) do registro selecionado
    ldr r2, [r2]            @ carrega o valor contido no registrador especificado.
    ldr r1, [r8, r2]        @ Endereço do registrador
    ldr r3, =\pin           @ carrega o endereço da tabela de pinos.
    add r3, #4              @ quantidade de carga para deslocar da tabela
    ldr r3, [r3]            @ valor de carga da quantidade de deslocamento
    mov r0, #0b111          @ máscara para limpar 3 bits
    lsl r0, r3              @ mude para a posição
    bic r1, r0              @ limpar os três bits
    mov r0, #1              @ 1 bit para mudar para posição
    lsl r0, r3              @ deslocamento por valor da tabela
    orr r1, r0              @ setar o bit
    str r1, [r8, r2]        @ salve-o para reg para fazer o trabalho
.endm

.macro GPIOTurnOn pin, value
    mov r2, r8                  @ endereço de gpio regs
    add r2, #setregoffset       @ desligado para definir reg
    mov r0, #1                  @ 1 bit para mudar para posição
    ldr r3, =\pin               @ base da tabela de informações do pino
    add r3, #8                  @ adicionar deslocamento para quantidade de deslocamento
    ldr r3, [r3]                @ deslocamento de carga da mesa
    lsl r0, r3                  @ do the shift
    str r0, [r2]                @ write to the register
.endm

.macro GPIOTurnOff pin, value
    mov r2, r8                  @ endereço de gpio regs
    add r2, #clrregoffset       @ offset of clr reg
    mov r0, #1                  @ 1 bit to shift into pos
    ldr r3, =\pin               @ base da tabela de informações do pino
    add r3, #8                  @ adicionar deslocamento para quantidade de deslocamento
    ldr r3, [r3]                @ Carregar deslocamento da tabela
    lsl r0, r3                  @ do the shift
    str r0, [r2]                @ write to the register
.endm

.data
    timespecsec: .word 0
    timespecnano: .word 100000000
    devmem: .asciz "/dev/mem"
    memOpnErr: .asciz "Failed to open /dev/mem\n"
    memOpnsz: .word .-memOpnErr
    memMapErr: .asciz "Failed to map memory\n"
    memMapsz: .word .-memMapErr
              .align 4 @ realign after strings
    
    @ mem address of gpio register / 4096
    gpioaddr: .word 0x1C20    @  0x01C20800 / 0x1000 (4096)   @Endereço base do GPIO / 0x1000
    pin17: .word 4 @ offset to select register
            .word 21 @ bit offset in select register
            .word 17 @ bit offset in set & clr register
    pin22: .word 8 @ offset to select register
            .word 6 @ bit offset in select register
            .word 22 @ bit offset in set & clr register
    pin27: .word 8 @ offset to select register
            .word 21 @ bit offset in select register
            .word 27 @ bit offset in set & clr register
.text