.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_SHARED, 1
.equ S_RDWR, 0666

.macro mapMem    
    ldr r0, =devmem
	mov r1, #2
	mov r2, #S_RDWR
	mov r7, #5          @sys_open
	svc 0

    @sys_mmap2
    mov r0, #0
    ldr r1, =pagelen
    ldr r1, [r1]
    mov r2, #(PROT_READ + PROT_WRITE)
    mov r3, #MAP_SHARED
    ldr r5, =gpioaddr
    ldr r5, [r5]
    mov r7, #192       @sys_mmap2
    svc 0
    
    movs r8, r0
.endm


.macro print variavel, len_variavel
    mov r0, #1              @ atribui 1 ao r0 para escrever no stdout
    ldr r1, =\variavel      @ dado para impressao
    mov r2, #\len_variavel  @ tamanho da palavra a ser exidido
    mov r7, #4          @ chamada de sistema para escrita
    svc 0 
.endm


.data
    timespecsec: .word 0
    timespecnano: .word 100000000
    devmem: .asciz "/dev/mem"
    gpioaddr: .word 0x1000
    gpioaddr: .word 0x1C20    @0x01C20800 / 0x1000 (4096)   @Endereço base do GPIO / 0x1000
