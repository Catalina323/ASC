.data



v: .space 20

i: .space 4

n: .long 5

format_citire: .asciz "%d"

format_afisare: .asciz "%d \n"

x: .space 4

suma: .space 4



.text



proc:



	pushl %ebp

	movl %esp, %ebp

	

	# 8(%ebp) = n

	# 12(%ebp) = adresa suma

	# 16(%ebp) = adresa vector

	

	#movl 12(%ebp), %eax

	movl 16(%ebp), %esi	

	

	xorl %ebx, %ebx

	xorl %ecx, %ecx

	

	et_aduna:

	cmp %ebx, 8(%ebp)

	je et_final

	

	movl (%esi, %ebx, 4), %edx

	addl %edx, %ecx

	

	incl %ebx

	jmp et_aduna

	

	

	et_final:

	movl %ecx, 12(%ebp)

	popl %ebp

	ret





.globl main

main:



	xorl %eax, %eax

	movl %eax, suma

	movl %eax, i

	movl n, %eax

	

	lea v, %esi

	

et_citire:

	cmp %eax, i

	je et_func

	

	pushl $x

	pushl $format_citire

	call scanf

	popl %ecx

	popl %ecx

	

	movl i, %ecx

	movl x, %edx

	movl %edx, (%esi, %ecx, 4)

	

	incl i

	jmp et_citire

	

et_func:

	pushl $v

	pushl $suma

	pushl n

	call proc

	popl %ecx

	popl %ecx

	popl %ecx

	

	et_debug:

	

	pushl suma

	pushl $format_afisare

	call printf

	popl %ecx

	popl %ecx

	

	pushl $0

	call fflush

	popl %ecx

	





et_exit:

	movl $1, %eax

	xorl %ebx, %ebx

	int $0x80
