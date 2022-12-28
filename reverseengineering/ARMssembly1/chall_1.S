	.arch armv8-a
	.file	"chall_1.c"
	.text
	.align	2
	.global	func
	.type	func, %function
func:
	sub	sp, sp, #32
	str	w0, [sp, 12]	## input value to be stored in stack +12 in w0
	mov	w0, 85			## move 85 to w0
	str	w0, [sp, 16]	## store 85 in stack +16
	mov	w0, 6			## move 6 to w0
	str	w0, [sp, 20]	## store 6 in stack +20
	mov	w0, 3			## move 3 to w0
	str	w0, [sp, 24]	## store 3 in stack +24
	ldr	w0, [sp, 20]	## load 6 from stack +20
	ldr	w1, [sp, 16]	## load 85 from stack +16
	lsl	w0, w1, w0		## left shift w1 by w0 and store in w0  85<<6 = 5440
	str	w0, [sp, 28]	## store 5440 in stack +28
	ldr	w1, [sp, 28]	## load 5440 from stack +28
	ldr	w0, [sp, 24]	## load 3 from stack +24
	sdiv	w0, w1, w0 	## divide 5440 by 3 and store in w0  5440/3 = 1813
	str	w0, [sp, 28]	## store 1813 in stack +28
	ldr	w1, [sp, 28]	## load 1813 from stack +28
	ldr	w0, [sp, 12]	## load input value from stack +12
	sub	w0, w1, w0		## subtract 1813 from input value and store in w0
	str	w0, [sp, 28]	## store result in stack +28
	ldr	w0, [sp, 28]	## load result from stack +28
	add	sp, sp, 32
	ret
	.size	func, .-func
	.section	.rodata
	.align	3
.LC0:
	.string	"You win!"
	.align	3
.LC1:
	.string	"You Lose :("
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	stp	x29, x30, [sp, -48]!
	add	x29, sp, 0
	str	w0, [x29, 28]
	str	x1, [x29, 16]
	ldr	x0, [x29, 16]
	add	x0, x0, 8
	ldr	x0, [x0]
	bl	atoi
	str	w0, [x29, 44]
	ldr	w0, [x29, 44]
	bl	func
	cmp	w0, 0			## check if result is 0, so if result is 0, print You win! 
						## so the result should 1813 converted to hex is 715
	bne	.L4				## if not 0, goto .L4	
	adrp	x0, .LC0	## load address of .LC0 into x0
	add	x0, x0, :lo12:.LC0 ## add low 12 bits of address of .LC0 to x0
	bl	puts				## call puts
	b	.L6					## goto .L6
.L4:
	adrp	x0, .LC1	## load address of .LC1 into x0
	add	x0, x0, :lo12:.LC1 ## add low 12 bits of address of .LC1 to x0
	bl	puts
.L6:
	nop
	ldp	x29, x30, [sp], 48
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
