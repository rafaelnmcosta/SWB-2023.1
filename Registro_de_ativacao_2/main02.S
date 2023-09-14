.section .rodata

.data

    .globl v1
    .align 2
    v1: .short 1,2

    .globl v2
    .align 8
    v2: .quad 1,2,3

.text

.globl aux

aux:

    pushq %rbp
    movq  %rsp, %rbp

    subq $32, %rsp

    #Guarda 2 em ecx (será o i de aux)
    movl $2, %ecx
    
    for:
        cmpl $0, %ecx


    movq (v2), %rdx

.globl main

main:

   pushq %rbp
   movq  %rsp, %rbp

   movl $1, %r10d

   leave

   ret