@ main.s


.include "gpiomacros.s"

.global _start

_start: 
     GPIOExport pin17
     GPIOExport pin27
     GPIOExport pin22
     nanoSleep
     GPIODirectionOut pin17
     GPIODirectionOut pin27
     GPIODirectionOut pin22
     @ set up a loop counter for 10 iterations
     mov r6, #10

loop: GPIOWrite pin17, high
     nanoSleep
     GPIOWrite pin17, low
     GPIOWrite pin27, high
     nanoSleep
     GPIOWrite pin27, low
     GPIOWrite pin22, high
     nanoSleep
     GPIOWrite pin22, low
     @decrement loop counter and see if we loop
     @ Subtract 1 from loop register
     @ setting status register.
     subs r6, #1
     @ If we haven't counted down to 0 then loop
     bne loop

_end: 
    mov R0, #0 @ Use 0 return code
    mov R7, #1 @ Command code 1 terminates
    svc 0 @ Linux command to terminate

pin17: .asciz "17"
pin27: .asciz "27"
pin22: .asciz "22"
low: .asciz "0"
high: .asciz "1"