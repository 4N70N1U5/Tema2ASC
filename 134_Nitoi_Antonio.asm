.data
    formatPrintf: .asciz "%d"
    LF: .asciz "\n"
    sep: .asciz " "
    input: .space 300
    n: .space 4
    m: .space 4
    n3: .space 4
    a: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    b: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    c: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    pos: .long 0
    afis: .long 0

.text

afisare:
    ret

solutie:
    ret

ok:
    ret

back:
    ret

.global main

main:
    pushl $input
    call gets
    popl %ebx

    pushl $sep
    pushl $input
    call strtok
    popl %ebx
    popl %ebx

    pushl %eax
    call atoi
    popl %ebx

    movl %eax, n

    pushl $sep
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    pushl %eax
    call atoi
    popl %ebx

    movl %eax, m

    lea c, %edi

for_citire:
    pushl $sep
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    cmp $0, %eax
    je cont_main

    pushl %eax
    call atoi
    popl %ebx

    cmp $0, %eax
    jne cont_for

    incl (%edi, %eax, 4)

cont_for:
    jmp for_citire

cont_main:
    movl n, %eax
    movl $3, %ebx
    mull %ebx
    movl %eax, n3

exit:
    pushl $LF
    call printf
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
