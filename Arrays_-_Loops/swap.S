.data

    .globl last
    .align 8
    last: .quad 0

    .globl values
    .align 8
    values: .quad 50, -10, 60, -20, 70

    .globl i
    .align 4
    i: .int 0

    .globl j
    .align 4
    j: .int 4

    .globl tmp
    .align 8
    tmp: .quad 0

.text

.globl swap

swap:

    pushq %rbp
    movq %rsp, %rbp
    
    movl i, %edx
    movl j, %edi

    for_start:
        cmpl %edi, %edx
        jge for_end

        movq $values, %rax  #rax guarda end de values
        movslq %edx, %rcx   #estende 'i' para quad em rcx
        imulq $8, %rcx      #rcx guarda o offset em values[i]
        addq %rcx, %rax     #rax guarda o end de values na pos 'i'
        
        movq (%rax), %rsi   #rsi guarda tmp

        movq $values, %r8   #r8 guarda end de values
        movslq %edi, %rcx   #estende 'j' para quad em rcx
        imulq $8, %rcx      #rcx guarda o offset em values[j]
        addq %rcx, %r8      #r8 guarda o end de values na pos 'j'

        movq (%r8), %r9     #coloca values[j] em r9
        movq %r9, (%rax)    #coloca valor de r9 em values[i]

        movq %rsi, (%r8)    #coloca tmp em values[j]

        incl %edx
        decl %edi

        jmp for_start
    
    for_end:

    movq $values, %rax
    movq 32(%rax), %r8
    movq %r8, last

    leave
    ret