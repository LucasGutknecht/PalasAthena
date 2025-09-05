// Usando como base: Programming from the Ground Up
// Propósito: Programa simples que sai e retorna um código de saída para o kernel
// Pode ser visualizado com: echo $?

.section .data

.section .text
.globl _start

_start:

movl $1, %eax
movl $0, %ebx
int $0x80

