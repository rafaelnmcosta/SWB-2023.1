.section rodata

.align 8
tmp01: .double 0.0  # valor a ser atribuido para i

.align 8
tmp02: .double 1.0  # valor a ser somado no for

fmt: .string "value = %f, factor = %d\n"


.data

.text

.globl process
process:
    pushq %rbp
    movq %rsp, %rbp

    #---------------------------
    #   struct Test
    #
    #   int     si  = 4 => 0-4
    #   double  sd  = 8 => 8-16
    #   float   sf  = 4 => 16-20
    #   long    sl  = 8 => 24-32
    #---------------------------
    #      Pilha
    #
    #    limit     = -8
    #    factor    = -12
    #    old       = -24
    #    i         = -32
    #    new[0]    = -192
    #    tmp       = -196
    #    value     = -208
    #---------------------------

    subq $208, %rsp             # alocando o espaço da pilha

    movsd       %xmm0, -8(%rbp)     # guardando o 1o parametro flutuante na pilha
    movl        %edi, -12(%rbp)     # guardando o 1o parametro ñ float na pilha
    movq        %rsi, -24(%rbp)     # guardando o 2o n float na pilha

    # double i = 0.0
    movsd       tmp01, %xmm1        # movendo 0.0 para xmm1
    movsd       %xmm1, -32(%rbp)    # movendo 0.0 de xmm1 para i na pilha

    # init(new)
    leaq        -192(%rbp), %rdi    # passando o endereço de new para o 1o parametro
    call        init

    for_start:
        movsd       -8(%rbp), %xmm1     # pegando limit da pilha
        movsd       -32(%rbp), %xmm2    # pegando 
        #; i < limit
        ucomisd     %xmm1, %xmm2        # compara dois valores double (xmm1 e xmm2)
        jae         for_end

        cvttsd2si   -32(%rbp), %r8d     # convertendo e truncando double i para int em r8

        movl        %r8d, -196(%rbp)    # guardando int i em tmp

        movslq      %r8d, %r9           # passando tmp para quad
        imulq       $32, %r9            # multiplicando tmp por 32 (tamanho da struct)
        movq        %r9, %r11           # salvando tmp*32 para acesso posterior
        addq        -24(%rbp), %r9      # somando o endereço de old + tmp*32 para acessar old[tmp]
        movq        24(%r9), %r10       # pegando old[tmp].sl

        cvtsi2sdq   %r10, %xmm1         # converte e guarda (double)old[tmp].sl em xmm1

        leaq        -192(%rbp), %r9     # guarda o endereço de new em r9
        addq        %r11, %r9           # somando endereço de new + tmp*32 para acessar new[tmp]
        movsd       8(%r9), %xmm2       # guarda new[tmp].sd em xmm2

        divsd       %xmm2, %xmm1        # faz xmm1 = xmm2/xmm1 (old[tmp].sl / new[tmp].sd)

        movsd       %xmm1, -208(%rbp)   # guarda o resultado em value

        movq        $fmt, %rdi          # guardando o 1o parametro do printf
        movsd       -208(%rbp), %xmm0   # guardando o 2o parametro
        movl        -12(%rbp), %esi     # guardando o 3o parametro
        movl        $1, %eax            # guardando a qtd de floats do printf

        call        printf

    if_start:
        movl        -196(%rbp), %r8d    # guardando tmp em r8
        andl        $64, %r8d           # r8d = r8d & 0x40
        cmpl        $0, %r8d            # compara se a máscara deu 0
        je          if_end

        movl        -196(%rbp), %r9d    # guardando tmp em r9
        cvtsi2sd    %r9d, %xmm2         # convertendo int para double em xmm2
        movsd       -208(%rbp), %xmm3   # guardando value em xmm3
        subsd       %xmm2, %xmm3        # fazendo xmm3 = value - tmp

        movsd       %xmm3, -8(%rbp)     # guardando value-tmp em limit
    if_end:

        #; i = i + 1.0
        movsd -32(%rbp), %xmm1          # xmm1 = i
        addsd tmp02, %xmm1              # xmm1 = i + 1.0
        movsd %xmm1, -32(%rbp)          # i = xmm1
    for_end:

    # return (float)limit + new[2].sf - factor

    cvtsd2ss    -8(%rbp), %xmm0     # convertendo para float e guardando limit em xmm0

    leaq        -192(%rbp), %r9     # guarda o endereço de new em r9
    addq        $64, %r9            # acessando new[2]
    movss       16(%r9), %rxmm1     # guarda new[2].sf em xmm1

    addss       %xmm1, %xmm0        # faz xmm0 = xmm0+xmm1 (limit=limit+new.sf)

    cvtsi2ss    -12(%rbp), %xmm2    # convertendo para float e guardando factor em xmm2

    subss       %xmm2, %xmm0        # faz xmm0 = xmm0-xmm2 (limit=limit-factor)

    # o resultado de (float)limit + new[2].sf - factor já está em xmm0 e será retornado

    leave
    ret

