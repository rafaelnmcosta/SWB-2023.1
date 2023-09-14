.section .rodata
   str1: .string "Hello"

.data
   .globl val
   .align 4
   val: .int 432

   .globl age
   .align 2
   age: .short 4

   .globl r
   .align 4
   r: .int 0

   .globl err
   .align 8
   err: .quad 2048

.text



.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp


   #Move o endereço da string pro par1
   movq $str1, %rdi 
   #Move o val para par2
   movl val, %esi 
   #Move age para par3
   movw age, %dx 
   #Move o endereço de r para par4
   movq $r, %rcx 
   
   #Chama a função sum
   call sum 

   #Pega o retorn em eax e guarda em val
   movl %eax, val 

   #Move err para par1
   movq err, %rdi 
   #Move val para par2
   movl val, %esi 
   #Move r para par3
   movl r, %edx 

   call show #Chama a função show

   leave

   #Move 0 para o registrador de retorno (return 0)
   movl $0, %eax 

   ret