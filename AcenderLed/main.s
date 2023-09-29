.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_SHARED, 1
.equ S_RDWR, 0666

.global _start

_start:
    ldr r0, =devmem       
	mov r1, #2            
	mov r2, #S_RDWR       
	mov r7, #5            
	svc 0
    mov r4, r0            
    mov r0, #0            
    ldr r1, =pagelen      
    ldr r1, [r1]          
    mov r2, #(PROT_READ + PROT_WRITE)      
    mov r3, #MAP_SHARED   
    ldr r5, =gpioaddr     
    ldr r5, [r5]          
    mov r7, #192         
    svc 0

    movs r8, r0

    ldr r6, [r8, #0x804] 
    lsl r6, r6, #4             
    add r6, #1                
    str r6, [r8, #0x804]        

    ldr r6, [r8, #0x810]                                      
    add r6, #1                 
    lsl r6, r6, #8              
    str r6, [r8, #0x810]        

    
    mov r0, #0
    mov r7, #1
    svc 0

.data
    timespecsec: .word 1
    timespecnano: .word 100000000
    devmem: .asciz "/dev/mem"
    pagelen: .word 0x1000
    gpioaddr: .word 0x1C20    @0x01C20800 / 0x1000 (4096)   @Endereço base do GPIO / 0x1000
    padraoPin: .word 0x77777777
    padraoSaidaPin: .word 0x00000000
