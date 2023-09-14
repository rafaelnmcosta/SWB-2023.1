.data
    .globl s
    .align 4
    s: .int 0

    .globl nums
    .align 4
    nums: .int 65, -105, 111, 34 

    .globl i
    .align 4
    i: .int 0

.text



.globl sum

sum:

    pushq %rbp

    movq  %rsp, %rbp

    movl i, %eax

    while_start:
        cmpl $4, %eax
        jge while_end

        movq $nums, %rcx
        movslq %eax, %rdx
        imulq $4, %rdx
        addq %rdx, %rcx
        movl (%rcx), %edi
        addl %edi, s

        incl %eax
        jmp while_start

    while_end:
    
    leave

    ret