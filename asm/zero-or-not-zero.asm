global _start

section .data
	; Align to nearest 2 byte boundary
	align 2

	; Greeting string def
	greeting:	db	"Let's play the game!",0xA,"Zero or Not Zero:",0xA
	greetingLen:	equ $-greeting

	; Zero string def
	zero:	db	'That one is ZERO',0xA
	zeroLen:	equ	$-zero

	; Not zero string def
	notzero:	db	'That one is NOTZERO',0xA
	notzeroLen:	equ $-notzero

	; Zero
	equal:	db	30h,0xA

section .bss
	num resb 8

section .text

	_start:

	; Print greeting to stdout
	mov	edx, greetingLen
	mov	ecx, greeting
	mov	ebx, 1
	mov	eax, 4
	int	0x80

	; Read user input and store it in ecx register
	mov	edx, 8
	mov	ecx, num
	mov	ebx, 2
	mov	eax, 3
	int	0x80

	; If ecx == 0 setZero else setNotZero
	cmp	byte[ecx], '0'
	je	setZero
	jmp	setNotZero

	exit:
	mov	ebx, 0		; Arg 1: status
	mov	eax, 1		; Syscall: 1 = exit(3)
	int	0x80		; Kernel interrupt 0x80

	setZero:
	mov	edx, zeroLen
	mov	ecx, zero
	jmp	print

	setNotZero:
	mov	edx, notzeroLen
	mov	ecx, notzero
	jmp	print

	print:
	mov	ebx, 1		; Arg 1: File descriptor (1 = stdout)
	mov	eax, 4		; Syscall: 4 = write(2)
	int	0x80
	call	exit
