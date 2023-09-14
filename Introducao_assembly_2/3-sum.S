.section .rodata

fmt:    .string "Soma: %ld\n"

.data

    # Definição das variáveis aqui...
    .globl sum
    .align 8
    sum: .quad 0

    .globl vet
    .align 8
    vet: .quad 10, 20, 30, 40, 50


.text

.globl main
main:

   pushq %rbp
   movq  %rsp, %rbp

   # Inicializações de 'i' e 'ptr' aqui...
   
   # i == ecx
   movl $0, %ecx # i=0;
   
   # ptr == r8 
   movq $vet, %r8 # *ptr = vet


beginwhile:

   cmpl $5, %ecx

   jge  endwhile      # while() {

    movq sum, %rax # eax = sum
    addq (%r8), %rax # eax += *r8
    movq %rax, sum # sum = eax

    addq $8, %r8 # r8++
    addl $1, %ecx # ecx++

   jmp beginwhile     # }

endwhile:

   movq $fmt, %rdi    # printf()

   movq sum, %rsi

   movl $0, %eax

   call printf

   movl $0, %eax      # return 0

   leave

   ret