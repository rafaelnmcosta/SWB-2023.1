.section .rodata



.data

    .globl i
    .align 4
    i: .int 0

    .globl bias
    .align 8
    bias: .quad 256

    .globl vet
    vet: .byte 12,3,20,8

.text



.globl main

main:

    pushq %rbp

    movq  %rsp, %rbp


    movl $0, i
  loop:
    #Compara i com 4
    cmpl $4, i
    #Pula pra after se i for >=
    jge after

    #Guarda o endereço do vetor em r8
    movq $vet, %r8 
    #Alarga o i e move para r9
    movslq i, %r9
    
    #Soma i alargado com o endereço de vet (em r8) e guarda em r9
    addq %r8, %r9

    #Move o byte atual do vetor apontado por r9 pra par1
    movb (%r9), %dil
    #Move 10 para par2
    movl $10, %esi
    #Move bias para par3
    movq bias, %rdx

    #Chama filtro
    call filtro
    
    #Guarda o retorno de filtro de rax para bias
    movq %rax, bias

    #Aumenta 1 no contador
    incl i
    #Reinicia o loop
    jmp loop

  after:
    #Move 0 para rax, para o return 0
    movl $0, %eax

    leave

    ret