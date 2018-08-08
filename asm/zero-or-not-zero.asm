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

section .bss
	num resb 8

section .text

	_start:
	; Print greeting to stdout
	mov	edx, greetingLen	; Arg 3: Length of string
	mov	ecx, greeting		; Arg 2: Location of string
	mov	ebx, 1				; Arg 1: File descriptor
	mov	eax, 4				; Syscall: write(2)
	int	0x80				; Kernel interrupt 0x80

	; Read user input and store it in ecx register
	mov	edx, 8		; Arg 3: Size of user input
	mov	ecx, num	; Arg 2: Store user input in ecx
	mov	ebx, 2		; Arg 1: idk it's like something
	mov	eax, 3		; Syscall: read i guess? i just learned assembly today
	int	0x80		; Kernel interrupt 0x80

	; If ecx == 0 then setZero else setNotZero
	cmp	byte[ecx], '0'	; Compare character value of user input to ascii char 0
	je	setZero			; Jump to setZero if equal
	jmp	setNotZero		; Jump to setNotZero

	; Set edx and ecx registers to print zero message
	setZero:
	mov	edx, zeroLen
	mov	ecx, zero
	jmp	print

	; Set edx and ecx registers to print notzero message
	setNotZero:
	mov	edx, notzeroLen
	mov	ecx, notzero
	jmp	print

	; Print whatever is in edx and ecx registers to stdout
	print:
	mov	ebx, 1		; Arg 1: File descriptor (1 = stdout)
	mov	eax, 4		; Syscall: 4 = write(2)
	int	0x80		; Kernel interrupt 0x80
	call	exit	; Exit program

	; Exit the program
	exit:
	mov	ebx, 0		; Arg 1: status
	mov	eax, 1		; Syscall: 1 = exit(3)
	int	0x80		; Kernel interrupt 0x80
