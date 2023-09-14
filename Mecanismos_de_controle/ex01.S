.section .rodata

.data
    .globl a
    .align 4
    a: .long 30

    .globl b
    .align 4
    b: .long 45

    .globl c
    .align 4
    c: .long -60

    .globl d
    .align 4
    d: .long 25

.text

.globl ex01

ex01:

   pushq %rbp

   movq  %rsp, %rbp

    movl a, %eax           # Move o valor de 'a' para o registrador %eax
    cmpl b, %eax           # Compara o valor de 'b' com o valor em %eax
    jle else_block         # Salta para else_block se 'a' não for maior que 'b'

    negl c                 # Negativa o valor de 'c'
    movl c, %eax           # Move o valor de 'c' para %eax
    imull $3, %eax         # Multiplica %eax (c) por 3
    movl %eax, d           # Move o resultado para 'd'
    jmp end_if             # Pula para o fim do bloco if

else_block:
    movl a, %eax           # Move o valor de 'a' para o registrador %eax
    cmpl b, %eax           # Compara o valor de 'b' com o valor de 'a'
    jl end_if              # Pula para o fim do bloco if se 'b' não for maior ou igual a 'a'

    movl a, %eax           # Move o valor de 'a' para %eax
    addl b, %eax           # Adiciona o valor de 'b' a %eax
    imull c, %eax          # Multiplica o valor em %eax pelo valor de 'c'
    movl %eax, c           # Move o resultado para 'c'
    movl $1024, d          # Move o valor 1024 para 'd'

end_if:

   leave

   ret