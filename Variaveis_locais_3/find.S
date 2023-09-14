# Tradução para assembly do arquivo find.c

.section rodata

.data

    .globl g0bj
    g0bj:
        .zero 24
        .align 4

.text

    .globl find:
    find:

        pushq %rbp
        movq %rsp, %rbp

        subq $40, %rsp

        movl $0, -4(%rbp) # int found

        movw $0, -6(%rbp) # short pin
        # 2 padding
        movb $0, -16(%rbp) # char part4[8]
        movw $0, -18(%rbp) # short part3
        movw $0, -18(%rbp) # short part2
        movl $0, -22(%rbp) # int part1

    

