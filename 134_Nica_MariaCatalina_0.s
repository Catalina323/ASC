.data



	fc: .asciz "%d"

	fa: .asciz "%d\n"

	fafis: .asciz "%d "

	aux: .space 4

	n: .space 4

	vec: .space 400

	matrice: .space 40000

	var2: .space 4

	i: .space 4

	indexlin: .space 4

	indexcol: .space 4

	rand_nou: .asciz "\n"

	k: .space 4

	ns: .space 4

	nd: .space 4

	cerinta: .space 4

	m1: .space 40000

	m2: .space 40000

	mres: .space 40000

	loop: .space 4

	nr_drumuri: .space 4

	

.text



matrix_mult:

	pushl %ebp

	movl %esp, %ebp

	

	pushl %ebx

	pushl %edi

	

	subl $28, %esp		

	

	# -12(%ebp) = var pt for 1

	# -16(%ebp) = var pt for 2

	# -20(%ebp) = var pt for 3

	# -24(%ebp) = var in care fac suma

	# -28(%ebp) = var auxuliara

	

	movl 8(%ebp), %ebx	

	movl 12(%ebp), %ecx		

	xor %edi, %edi

	movl 16(%ebp), %edi 

	

	movl $0, -12(%ebp)

	movl $0, -24(%ebp)

	et_mul:

		

		mov -12(%ebp), %eax

		mov 20(%ebp), %edx

		cmp %eax, %edx

		je et_final

		

		movl $0, -16(%ebp)

		

		et_lin:

			movl -16(%ebp), %eax

			movl 20(%ebp), %edx

			cmp %eax, %edx

			je et_reia

			

			movl $0, -20(%ebp)

			

			et_valoare:

				

				movl -20(%ebp), %eax

				movl 20(%ebp), %edx

				cmp %eax, %edx

				je et_reia0

				

				xor %edx, %edx

				

				movl -12(%ebp), %eax

				mull 20(%ebp)

				addl -20(%ebp), %eax

				mov %eax, -28(%ebp)		

				

				xor %edx, %edx

				

				movl -20(%ebp), %eax

				mull 20(%ebp)

				addl -16(%ebp), %eax		

				

				movl (%ecx, %eax, 4), %eax	

				

				movl -28(%ebp), %edx

				movl (%ebx, %edx, 4), %edx

				

				mull %edx			

				

				addl %eax, -24(%ebp)

				

				movl -20(%ebp), %edx

				incl %edx

				movl %edx, -20(%ebp)

				jmp et_valoare

			

			et_reia0:

			

			movl -12(%ebp), %eax

			mull 20(%ebp)

			addl -16(%ebp), %eax

			

			movl -24(%ebp), %edx

			addl %edx, (%edi, %eax, 4)

			

			movl $0, -24(%ebp)

			

			movl -16(%ebp), %edx

			incl %edx

			movl %edx, -16(%ebp)

			jmp et_lin

		

		et_reia:

		movl -12(%ebp), %edx

		incl %edx

		movl %edx, -12(%ebp)

		jmp et_mul

	

	et_final:

	

	addl $28, %esp

	

	popl %edi

	popl %ebx

	

	popl %ebp

	ret



.globl main

main:



	pushl $cerinta

	pushl $fc

	call scanf

	popl %ebx

	popl %ebx

	

	pushl $n

	pushl $fc

	call scanf

	popl %ebx

	popl %ebx



	movl n, %eax

	movl n, %ecx

	mull %ecx		

	movl $0, %ebx

	

et_init_matrice:

	

	cmp %ebx, %eax

	je et_cont

	

	lea matrice, %esi

	movl $0, (%esi, %ebx, 4)

	

	inc %ebx

	jmp et_init_matrice	

	

et_cont:



	mov $0, %ebx

	lea vec, %edi

	

et_citire_leg_noduri:

	

	cmp %ebx, n

	je et_continua

	

	pushl $aux

	pushl $fc

	call scanf

	popl %eax

	popl %eax

	

	movl aux, %eax

	movl %eax, (%edi, %ebx, 4)

	

	inc %ebx

	jmp et_citire_leg_noduri

	

et_continua:

	

	mov $0, %ebx

	

et_citire_drumuri:	

	

	cmp %ebx, n

	je et_cerinta

	

	movl (%edi, %ebx, 4), %ecx

	mov %ecx, var2

	cmp $0, %ecx

	je et_egalcuz

	

	movl $0, %ecx

	movl %ecx, i

	

	et_citire_nod:

		

		movl i, %ecx

		cmp var2, %ecx

		je et_egalcuz

		

		pushl $aux

		pushl $fc

		call scanf

		popl %ecx

		popl %ecx

		

		mov $0, %edx

		mov %ebx, %eax

		movl n, %ecx

		mull %ecx

		add aux, %eax 	

		

		lea matrice, %esi

		movl $1, (%esi, %eax, 4)

		

		movl i, %ecx

		inc %ecx

		movl %ecx, i

		jmp et_citire_nod

		

	et_egalcuz:

	

	inc %ebx

	jmp et_citire_drumuri

	

et_cerinta:



	mov cerinta, %eax

	cmp $1, %eax

	je et_afis

	

	cmp $2, %eax

	je et_nr_drumuri

	

et_afis:

	

	lea matrice, %esi

	movl $0, %ecx

	mov %ecx, indexlin

	

	et_linie:

		movl indexlin, %ecx

		cmp %ecx, n

		je et_exit

		

		movl $0, %ecx

		movl %ecx, indexcol

		

		et_coloana:

			movl indexcol, %ecx

			cmp %ecx, n

			je et_cont_linie

			

			mov $0, %edx

			movl indexlin, %eax

			movl n, %ecx

			mull %ecx

			add indexcol, %eax	

		

			pushl (%esi, %eax, 4)

			pushl $fafis

			call printf

			popl %ecx

			popl %ecx

			

			pushl $0

			call fflush

			popl %ecx

			

			et_verif:

			

			movl indexcol, %ecx

			inc %ecx

			movl %ecx, indexcol

			jmp et_coloana

			

		et_cont_linie:

		

		

		pushl $rand_nou

		call printf

		popl %ecx

		

			

		movl indexlin, %ecx

		inc %ecx

		movl %ecx, indexlin

		jmp et_linie	

		

		

jmp et_exit

		

et_nr_drumuri:



	pushl $k

	pushl $fc

	call scanf

	popl %ecx

	popl %ecx

	

	pushl $ns

	pushl $fc

	call scanf

	popl %ecx

	popl %ecx

	

	pushl $nd

	pushl $fc

	call scanf

	popl %ecx

	popl %ecx

	

	lea m1, %edi

	lea m2, %edi

	lea mres, %edi

	

	# mut matrice in m1

	

	movl $matrice, %esi

	movl $m1, %edi

		

	movl n, %eax

	movl n, %ecx

	xor %edx, %edx

	mull %ecx

		

	xor %ecx, %ecx

	

	loop4:

	

		cmp %eax, %ecx

		je aici4

		

		movl (%esi, %ecx, 4), %edx

		movl %edx, (%edi, %ecx, 4)

		

		inc %ecx

		jmp loop4

	aici4:

	

	# mut matrice in m2

	

	movl $matrice, %esi

	movl $m2, %edi

		

	movl n, %eax

	movl n, %ecx

	xor %edx, %edx

	mull %ecx

		

	xor %ecx, %ecx

	

	loop5:

	

		cmp %eax, %ecx

		je aici5

		

		movl (%esi, %ecx, 4), %edx

		movl %edx, (%edi, %ecx, 4)

		

		inc %ecx

		jmp loop5

	aici5:

		

	xor %ebx, %ebx

	inc %ebx

	

	et_loop:

		

		cmp %ebx, k

		je et_afisare_nr_drumuri

		

		jmp et_mreszero

		mreszero:

		

		pushl n

		pushl $mres

		pushl $m2

		pushl $m1

		call matrix_mult

		popl %ecx

		popl %ecx

		popl %ecx

		popl %ecx

		

		jmp et_interschimba		

		aici2:

		

		inc %ebx

		jmp et_loop

		

et_afisare_nr_drumuri:

	

	movl n, %eax

	movl ns, %ebx

	mull %ebx

	addl nd, %eax

	

	movl $m1, %esi

	

	movl (%esi, %eax, 4), %ebx

	movl %ebx, nr_drumuri

	

	pushl nr_drumuri

	pushl $fc

	call printf

	popl %ecx

	popl %ecx

	

	pushl $0

	call fflush

	popl %ecx

	

et_exit:

	

	mov $1, %eax

	xor %ebx, %ebx

	int $0x80



et_mreszero:

	

	movl n, %eax

	movl n, %ecx

	xor %edx, %edx

	mull %ecx

	movl $mres, %edi

	xor %ecx, %ecx

	

	loop2:

		cmp %eax, %ecx

		je mreszero

		

		xor %edx, %edx

		movl %edx, (%edi, %ecx, 4)

		

		incl %ecx

		jmp loop2

		

et_interschimba:		



	movl $mres, %esi

	movl $m1, %edi

		

	movl n, %eax

	movl n, %ecx

	xor %edx, %edx

	mull %ecx

		

	xor %ecx, %ecx

	

	loop3:

	

		cmp %eax, %ecx

		je aici2

		

		movl (%esi, %ecx, 4), %edx

		movl %edx, (%edi, %ecx, 4)

		

		inc %ecx

		jmp loop3

