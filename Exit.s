// Propósito: Programa simples que sai e retorna um código de saída para o kernel
// Pode ser visualizado com: echo $?
// Para macOS em Apple Silicon (ARM64)

.global _main
.align 2

_main:
    mov x0, #0          // Código de retorno
    ret                 // Retorna para o caller (libc)

// Para compilar e executar:
// as -o exit_simple.o exit_simple.s
// clang -o exit_simple exit_simple.o
// ./exit_simple
// echo $?
