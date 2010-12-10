; AMD64 assembly code for Blowfish by Michael Mohr <akihana@gmail.com>
; Released under the GPL version 3 or later.

USE64

%define PARR_LEN (16+2)*4
%define SBOX_LEN 256*4

[section .text]

; destroys registers R8, RDI, RAX
global F
F:
	add rdi, PARR_LEN
	mov r8,  rsi
	shr r8,  24
	and r8,  0xFF
	mov eax, [rdi+4*r8]	; y = ctx->S[0][a]
	add rdi, SBOX_LEN
	mov r8,  rsi
	shr r8,  16
	and r8,  0xFF
	add eax, [rdi+4*r8]	; y += ctx->S[1][b]
	add rdi, SBOX_LEN
	mov r8,  rsi
	shr r8,  8
	and r8,  0xFF
	xor eax, [rdi+4*r8]	; y ^= ctx->S[2][c];
	add rdi, SBOX_LEN
	mov r8,  rsi
	and r8,  0xFF
	add eax, [rdi+4*r8]	; y += ctx->S[3][d];
	ret

