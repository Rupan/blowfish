; AMD64 assembly code for Blowfish by Michael Mohr <akihana@gmail.com>
; Released under the GPL version 3 or later.

USE64

[section .text]

; destroys registers R8, RDI, RAX
global F
F:
	add rdi, 72		; skip over P -> [16 + 2] * 4 to access first S-box
	mov r8,  rsi
	shr r8,  24
	and r8,  0xFF
	mov eax, [rdi+4*r8]	; y = ctx->S[0][a]
	add rdi, 1024		; move to next S-box [256 * 4 == 1024]
	mov r8,  rsi
	shr r8,  16
	and r8,  0xFF
	add eax, [rdi+4*r8]	; y += ctx->S[1][b]
	add rdi, 1024
	mov r8,  rsi
	shr r8,  8
	and r8,  0xFF
	xor eax, [rdi+4*r8]
	add rdi, 1024
	mov r8,  rsi
	and r8,  0xFF
	add eax, [rdi+4*r8]
	ret

