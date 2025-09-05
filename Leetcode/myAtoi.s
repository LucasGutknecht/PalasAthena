// myAtoi(s) -> parses string s to 32-bit signed int (cdecl, returns in %eax)
// Behaviors: skip leading spaces (0x20), optional +/-, parse digits, clamp to INT32 range.
    .text
    .globl myAtoi
    .type myAtoi, @function
myAtoi:
    pushl   %ebp
    movl    %esp, %ebp
    pushl   %ebx
    pushl   %esi

    movl    8(%ebp), %esi      # esi = char *s

    # skip leading spaces (ASCII 0x20)
.skip_spaces:
    movb    (%esi), %al
    cmpb    $0x20, %al
    jne     .after_spaces
    incl    %esi
    jmp     .skip_spaces
.after_spaces:

    # sign flag in bl: 0 => positive, 1 => negative
    xorl    %ebx, %ebx
    movb    (%esi), %al
    cmpb    $'+', %al
    je      .consume_plus
    cmpb    $'-', %al
    jne     .parse_start
    movb    $1, %bl
    incl    %esi
    jmp     .parse_start
.consume_plus:
    incl    %esi

.parse_start:
    xorl    %eax, %eax        # result = 0

.parse_loop:
    movzbl  (%esi), %edx      # edx = byte at *s (0..255)
    cmpl    $'0', %edx
    jb      .finish_parse
    cmpl    $'9', %edx
    ja      .finish_parse

    subl    $'0', %edx        # edx = digit 0..9

    # overflow check:
    movl    %eax, %ecx
    cmpl    $214748364, %ecx
    ja      .overflow_pos
    jb      .mul_add

    # ecx == 214748364 -> check last digit against sign
    testb   %bl, %bl
    je      .check_pos_last
    # negative: allowed last digit <= 8
    cmpl    $8, %edx
    ja      .overflow_neg
    jmp     .mul_add

.check_pos_last:
    cmpl    $7, %edx
    ja      .overflow_pos

.mul_add:
    imull   $10, %eax         # eax *= 10
    addl    %edx, %eax        # eax += digit
    incl    %esi
    jmp     .parse_loop

.overflow_pos:
    movl    $2147483647, %eax
    jmp     .done

.overflow_neg:
    movl    $0x80000000, %eax   # -2147483648
    jmp     .done

.finish_parse:
    # apply sign if negative
    testb   %bl, %bl
    je      .done
    negl    %eax

.done:
    popl    %esi
    popl    %ebx
    leave
    ret
    .size myAtoi, .-myAtoi
