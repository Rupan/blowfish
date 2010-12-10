; AMD64 assembly code for Blowfish by Michael Mohr <akihana@gmail.com>
; Released under the GPL version 3 or later.

USE64

%define WORD_LEN 4
%define PARR_LEN (16 + 2) * WORD_LEN
%define SBOX_LEN 256 * WORD_LEN
%define SBOX(x) PARR_LEN + (x * SBOX_LEN)

[section .text]

; arguments:
;  RDI - Blowfish context
;  RSI - 32-bit value 'x'
; destroys:
;  R8  - temporary storage
;  RAX - return value
global F
F:
	mov r8,  rsi
	shr r8,  24
	and r8,  0xFF
	mov eax, [rdi+SBOX(0)+WORD_LEN*r8]	; y = ctx->S[0][a]
	mov r8,  rsi
	shr r8,  16
	and r8,  0xFF
	add eax, [rdi+SBOX(1)+WORD_LEN*r8]	; y += ctx->S[1][b]
	mov r8,  rsi
	shr r8,  8
	and r8,  0xFF
	xor eax, [rdi+SBOX(2)+WORD_LEN*r8]	; y ^= ctx->S[2][c];
	mov r8,  rsi
	and r8,  0xFF
	add eax, [rdi+SBOX(3)+WORD_LEN*r8]	; y += ctx->S[3][d];
	ret
