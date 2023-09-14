Prova 3
Rafael Nunes Moreira Costa

Q1:
a)
	Struct X:

	char x:
	1 byte
	não tem alinhamento

	7 de padding

	long y:
	8 bytes
	alinhado para 8
	
	sem padding

	short z:
	2 bytes
	alinhado para 2

	Tamanho da struct: 1 + 7 + 8 + 2 = 18
	alinhamento da struct: 8
	Tamanho alinhada: 24

b)

.section rodata

.data
	.globl varx
	.align 8
	varx: .zero 24
		# 0-1 = x
		# 8-16 = y
		# 16-18 = z

.text

.globl calc
calc:
	pushq %rbp
	movq %rsp, %rbp

	#	Pilha
	#
	#	rdx		= -8
	#	r12		= -16
	#	tmp		= -20
	#	vector	= -30
	#
	#	tamanho da pilha 32
	
	subq	$32, %rsp		# aloca a pilha
	
	movq	%r12, -16(%rbp)	# guarda r12 pois é callee saved
	
	movl 	$3, -20(%rbp)	# tmp = 3
	
	movl	$0, %edx		# i = 0
	
	for_start:
		cmpl	$3, %edx		# i<3
		jge		for_end
		
		movl	%edx, %r12d		# j = i
		addl	$1, %r12d		# j = i+1
		
		movq	%rdx, -8(%rbp)	# salvando rdx (i) na pilha
		
		movq	$varx, %rdi		# passando endereço de varx para rdi
		addq	$16, %rdi		# &varx.z
		
		leaq	-30(%rbp), %rsi	# guardando endereço de vector em rsi
		movslq	%r12d, %r9		# alongando j p/ quad em r9
		imulq	$2, %r9			# j*(sizeof(short))
		addq	%r9, %rsi		# pegando vector[j] em rsi
		
		movsbl	varx,  %edx		# alongando e salvando o varx.x em edx
		
		call process			# process(&varx.z, vector[j], (int)varx.x)
		
		movl	-20(%rbp), %r8d	# r8d = tmp
		addl	%eax, %r8d		# r8d + process
		movl	%r8d, -20(%rbp)	# tmp = r8d
	
		inc		%edx			# i++
	for_end:
	
	movl -20(%rbp), %eax		# salvando tmp em eax para o retorno
	
	
	movq 	-16(%rbp), %r12		# recuperando r12 da pilha
	leave
	ret
	
	


