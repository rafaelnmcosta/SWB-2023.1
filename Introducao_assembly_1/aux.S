.data

    .globl c
    c: .byte -20

    .globl i
    .align 4
    i: .int -256

    .globl j
    .align 4
    j: .int 512

    .globl l
    .align 8
    l: .quad 128

    .globl us
    .align 2
    us: .word 111

    .globl ui
    .align 4
    ui: .int 1024

    .globl ul
    .align 8
    ul: .quad 2048

.text

.globl aux
aux:
    pushq %rbp
    movq %rsp, %rbp

    # ---------- Atribuições simples ----------
    # Não podem ser realizadas operações com memória&memória
    # Para fazer isso o valor deve ser temporariamente guardado
    # em um registrador intermediário
    #
    # O registrador precisa ser usado de acordo com o tamanho da variável
    # %rax = 8 bytes
    # %eax = 4 
    # %ax  = 2
    # %al  = 1 byte

    movl $68000, j      # j = 68000;

    movq $4096, l       # l = 4096;

    movl i, %eax        # eax = i
    movl %eax, j        # j = eax

    # ---------- Expressões ---------- 
    # 

    subl $5, i          # i = i - 5
    addl $10, i         # i = i + 10
    movl i, %eax        # eax = i
    movl %eax, j        # j = eax 

    addl $5, j          # j = j + 5
    imull $2, i         # i = i * 2
    movl i, %eax        # eax = i
    subl j, %eax        # eax = eax - j
    movl %eax, i        # i = eax

    # ---------- Casts ---------- 
    # Para mover para um signed:
    # movs + tipo_original (b/w/l) + tipo_final (w/l/q)
    # Para mover para um unsigned:
    # movz + tipo_original (b/w/l) + tipo_final (w/l/q)

    movl i, %eax        # eax = i
    movl %eax, ui       # ui = eax


    movb c, %al         # al = c
    movsbl %al, j       # j = eax

    movl ui, %eax       # eax = ui
    mov

    leave
    ret