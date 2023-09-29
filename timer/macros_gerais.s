.macro openDevmem
    ldr r0, =devmem       
    mov r1, #2            
    mov r2, #S_RDWR       
    mov r7, #5           
    svc 0
.endm

.macro mapMem 
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

.endm


.macro nanoSleep segundo, miliSegundo
    ldr r0, =\segundo
    ldr r1, =\miliSegundo
    mov r7, #162 @sys_nanosleep
    svc 0
.endm



.macro mod_division num1, num2
    mov r0, \num1                 @Numero a ser dividido
    mov r13, \num2                 @Numero para dividir
    sdiv r3, r0, r13               @Numero divido
    
    @Resto
    mul r3, r13, r3                @Quociente x Divisor
    sub r0, r0, r3                @Dividendo - (Quociente x Divisor)
.endm


.macro num_para_digitos
    mov r9, #0      @Limpar r9
    mov r2, #10     @Numero para dividir e achar o resto

    @ Pegar a unidade
    mod_division r1, r2     @ Chama mod division com os valores de "r1 = numero para separar os bits" 
    mov r9, r0              @ Mod division joga o resto em R0
	lsl r9, r9, #4

    @ Pegar a Dezena
    sdiv r1, r1, r2         @ Divide o numero por 10
    mod_division r1, r2     @ Resto da divisão
    mov r9, r0              @ 
    lsl r9, r9, #4

    @ Pegar centena
    sdiv r1, r1, r2          @ Divide o numero por 10 (Como foi dividido por 10 antes, é como se fosse por 100 agora)
    mod_division r1, r2     @ Resto da divisão
    mov r9, r0              @ 
    lsl r9, r9, #4
	

    @ Pegar Unidade de Milhar
    sdiv r1, r1, r2         @ Divide o numero por 10 (Como foi dividido por 10 2 vezes antes, é como se fosse por 1000 agora)
    mod_division r1, r2     @ Resto da divisão
    mov r9, r0
    lsl r9, r9, #4

	@ Pegar Dezena de Milhar
    sdiv r1, r1, r2         @ Divide o numero por 10
    mod_division r1, r2     @ Resto da divisão
    mov r9, r0
    lsl r9, r9, #4
		

	@ Pegar Centena de Milhar
    sdiv r1, r1, r2         @ Divide o numero por 10
    mod_division r1, r2     @ Resto da divisão
    mov r9, r0
    lsl r9, r9

.endm
