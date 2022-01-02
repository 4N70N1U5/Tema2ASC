.data
    formatPrintf: .asciz "%d "
    LF: .asciz "\n"
    sep: .asciz " "
    input: .space 300
    n: .space 4
    m: .space 4
    n3: .space 4
    a: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    b: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    c: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    d: .space 4
    ver: .space 4
    val: .space 4
    pos: .long 0
    afis: .long 0
    impos: .long -1

.text

afisare:
    movl $1, afis
    movl $1, pos

    xorl %ecx, %ecx
    incl %ecx

for_afisare:
    cmp n3, %ecx
    jg exit_afisare

    pushl %ecx

    pushl (%edi, %ecx, 4)
    pushl formatPrintf
    call printf
    popl %ecx
    popl %ecx

    popl %ecx

    incl %ecx
    jmp for_afisare

exit_afisare:
    ret

solutie:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %ebx
    
    cmp n3, %ebx
    je complet
    jne incomplet

complet:
    movl $1, %eax
    jmp exit_solutie

incomplet:
    xorl %eax, %eax
    jmp exit_solutie

exit_solutie:
    popl %ebp
    ret

ok:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %ebx

    movl %ebx, %ecx
    decl %ecx

    pushl %edx

    movl (%edi, %ebx, 4), %edx

    movl %edx, val

    xorl %edx, %edx

while:
    cmp $1, %ecx
    jl exit_while

    movl (%edi, %ecx, 4), %eax

    cmp val, %eax
    je exit_while

    incl %edx
    decl %ecx

exit_while:
    movl %edx, d

    popl %edx

    pushl %ecx

    movl val, %ecx

    movl (%edx, %ecx, 4), %eax
    cmp $3, %eax
    jge gresit

    popl %ecx

    pushl %edx

    movl d, %edx

    cmp m, %edx
    popl %edx
    jge corect

    cmpl $0, %ecx
    je corect

gresit:
    xorl %eax, %eax
    jmp exit_ok

corect:
    movl $1, %eax
    jmp exit_ok

exit_ok:
    popl %ebp
    ret

back:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %ebx

    cmpl $0, afis
    jne exit_back

    cmpl $0, (%esi, %ebx, 4)
    jne punct_fix

    xorl %ecx, %ecx
    incl %ecx

for:
    cmp n, %ecx
    jg exit_back

    movl %ecx, (%edi, %ebx, 4)

    pushl %ecx
    pushl %edx

    pushl %ebx
    call ok
    movl %eax, ver
    popl %eax
    movl ver, %eax

    popl %edx
    popl %ecx

    cmp $0, %eax
    je cont_for

    pushl %ebx
    call solutie
    movl %eax, ver
    popl %eax
    movl ver, %eax

    cmp $0, %eax
    je reapelare

    pushl %ecx
    call afisare
    popl %ecx

cont_for:
    incl %ecx
    jmp for

punct_fix:
    movl (%esi, %ebx, 4), %eax
    movl %eax, (%edi, %ebx, 4)

    decl (%edx, %eax, 4)
    
    pushl %ecx
    pushl %edx

    pushl %ebx
    call ok
    movl %eax, ver
    popl %eax

    popl %edx
    popl %ecx

    movl (%edi, %ebx, 4), %eax

    incl (%edx, %eax, 4)

    movl ver, %eax

    cmp $0, %eax
    je exit_back

    pushl %ebx
    call solutie
    movl %eax, ver
    popl %eax
    movl ver, %eax

    cmp $0, %eax
    je reapelare_fix

    call afisare

reapelare_fix:
    incl %ebx
    pushl %ebx
    call back
    popl %eax

    jmp exit_back

reapelare:
    incl (%edx, %ecx, 4)

    incl %ebx
    pushl %ebx
    call back
    popl %eax

    decl (%edx, %ecx, 4)

exit_back:
    popl %ebp
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

    movl n, %eax
    movl $3, %ebx
    mull %ebx
    movl %eax, n3

    lea b, %edi
    lea c, %esi

    xorl %ecx, %ecx
    incl %ecx

for_citire:
    cmp n3, %ecx
    jg cont_main

    pushl %ecx

    pushl $sep
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    pushl %eax
    call atoi
    popl %ebx

    popl %ecx

    movl %eax, (%edi, %ecx, 4)

    cmp $0, %eax
    je cont_for_citire

    incl (%esi, %eax, 4)

cont_for_citire:
    incl %ecx
    jmp for_citire

cont_main:
    lea a, %edi
    lea b, %esi
    lea c, %edx

    pushl $1
    call back
    popl %ebx

    cmpl $0, pos
    jne exit

    pushl impos
    call printf
    popl %ebx

exit:
    pushl $LF
    call printf
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
