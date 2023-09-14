.data

# Definição da variável 'str' aqui...
.globl str
str: .string "BEBAMUITOCAFE" 

.text

.globl process

process:

   pushq %rbp

   movq  %rsp, %rbp

   # Inicialização de 'ptr' aqui...
   movq $str, %r8 # ptr = str

beginwhile:

   cmpb $0, (%r8)

   je endwhile            # while() {

   movb (%r8), %al # al = *r8
   addb $32, %al # al += 32
   movb %al, (%r8) # *r8 = al

   addq $1, %r8

   jmp beginwhile         # }

endwhile:

   leave

   ret
