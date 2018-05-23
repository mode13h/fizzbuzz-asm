;
; Fizzbuzz for 8086 processors running DOS
;	COM version - link with -t option in TASM
;	Minimal version with no procedure calls
;	 to save a few bytes here and there.

.model tiny
.code

org 100h

start:
	mov cx, 1			

test3:
	xor dx, dx
	mov ax, cx			
	mov bl, 3
	div bl
	cmp ah, 0			
	jnz test5
	mov dl, 1
	push ax dx
	mov dx, OFFSET fizz
	mov ah, 9
	int 21h
	pop dx ax

test5:
	mov ax, cx
	mov bl, 5			 
	div bl
	cmp ah, 0		
	jnz do_crlf
	mov dh, 1
	push ax dx
	mov dx, OFFSET buzz
	mov ah, 9
	int 21h
	pop dx ax

do_crlf:
	cmp dx, 0
	jnz newline
	mov ax, cx
	mov bl, 10
	div bl
	cmp al, 0
	jz print_units
	push ax
	mov dl, al
	add dl, 48
	mov ah, 2
	int 21h
	pop ax
print_units:
	mov dl, ah
	add dl, 48
	mov ah, 2
	int 21h

newline:
	mov dx, OFFSET crlf
	mov ah, 9
	int 21h
	inc cx
	cmp cx, 100
	jle test3

	mov ax, 4c00h
	int 21h

fizz	db 'fizz','$'
buzz	db 'buzz','$'
crlf	db 13,10,'$'

end start
