# Proposito: Esse problema tem como objetivo encontrar o maior número em uma lista de números inteiros.

# Variaveis: Os registros utilizados são:

# %eax - Item Atual
# %ebx - Maior Número Encontrado
# %edi - Mantem o indice do array

# Os seguintes locais de memória são utilizados:
# data_items - Contem os dados do item. Um 0 é usado para indicar o fim da lista.

.section .data

data_items:
  .long 3, 5, 2, 8, 6, 0  # Lista de números inteiros terminada por 0

.section .text

.globl _start
_start:

  movl $0, %edi # move 0 para o índice do array
  movl data_items(,%edi, 4), %eax # Carrega o primeiro Byte de dados
  movl %eax, %ebx # Inicializa o maior número com o primeiro número

start_loop:
  cmpl $0, %eax # Verifica se estamos no final da lista (0 indica o fim)
  je loop_exitk # Se for 0, sai do loop
  incl %edi # Carrega o próximo valor
  movl data_items(,%edi,4), %eax
  cmpl %ebx, %eax # Compara o número atual com o maior número encontrado
  jle start_loop # Se o número atual for menor ou igual ao maior, continua o loop

  movl %eax, %ebx # Atualiza o maior número encontrado
  jmp start_loop # Continua o loop


loop_exit:
  movl $1, %eax # Código de saída para o kernel
  int $0x80 # Chamada de sistema para sair do programa
