
@r0: Carregue o endereço da string com o nome do arquivo a ser aberto.
@r1: Carregue o modo de abertura do arquivo. O modo é um valor inteiro que indica como o arquivo deve ser aberto (por exemplo, leitura, escrita, criação, etc.).
@r7: Carregue o número da chamada do sistema, o valor é 5.
@Chame a instrução svc 0 para executar a chamada do sistema.
.macro openDevmem
    ldr r0, =devmem       @Caminho do devmem, /dev/mem
	mov r1, #2            @
	mov r2, #S_RDWR       @ Direitos de acesso a Leitura e Escrita
	mov r7, #5            @sys_open
	svc 0
.endm


@r0: passar 0 para deixar o Linux escolher um endereço virtual adequado.
@r1: passar o tamanho da memória que deseja mapear.
@r2: passar as permissões que deseja atribuir ao mapeamento (por exemplo, PROT_READ + PROT_WRITE para permissão de leitura e escrita).
@r3: passar MAP_SHARED para criar um mapeamento compartilhado.
@r4: passar o descritor de arquivo para /dev/mem.
@r5: passar o endereço físico da GPIO dividido 0x1000.
@ O endereço virtual será retornado em r0, armazene em outro registrador para uso futuro
.macro mapMem 
    mov r4, r0            @Mover descritor do arquivo de r0 para r4
    mov r0, #0            @Deixar o SO escolher o mapeamento
    ldr r1, =pagelen      @Tamhho da memoria de paginação
    ldr r1, [r1]          @Carrega o valor no r1
    mov r2, #(PROT_READ + PROT_WRITE)      @Proteção de leitra e escrita, valor 3 
    mov r3, #MAP_SHARED   @Valor de MAP_SHARED é 1
    ldr r5, =gpioaddr     @Valor base GPIO dividido por 0x1000
    ldr r5, [r5]          @Carregar valor em r5
    mov r7, #192          @ 192 é a syscall para sys_mmap2
    svc 0
.endm


@ r0: Tempo de entrada para esperar em segundos e nanossegundos.
@ r1: É o tempo restante para esperar se for interrompido
@r7: Chama o ponto de entrada nanosleep do Linux, que é a função 162.
.macro nanoSleep
    ldr r0, =timespecnano
    ldr r1, =timespecnano
    mov r7, 162 @sys_nanosleep
    svc 0
.endm


.macro mod_division num1, num2
    @ r0 - dividendo
    @ r1 - divisor
    @ r2 - quociente
    @ r3 - resto
    
    mov r0, \num1                 @Numero a ser dividido
    mov r1, \num2                 @Numero para dividir
    sdiv r2, r0, r1               @Numero divido
    
    @Resto
    mul r3, r1, r2                @Quociente x Divisor
    sub r3, r0, r3                @Dividendo - (Quociente x Divisor)

.endm
