.data
    input: .space 300
    n: .space 4
    m: .space 4
    n3: .space 4
    a: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    b: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    c: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    k: .long 1
    val: .space 4
    afis: .long 0
    impos: .long -1
    formatPrintf: .asciz "%d "
    LF: .asciz "\n"
    sep: .asciz " "

.text

afisare:
    movl $1, afis

    xorl %ecx, %ecx
    incl %ecx

for_afisare:
    cmp n3, %ecx
    jg exit_afisare

    pushl %ecx
    pushl %edx

    //pushl (%edi, %ecx, 4)
    
    movl (%edi, %ecx, 4), %edx

    pushl %edx
    pushl $formatPrintf
    call printf
    popl %ecx
    popl %ecx

    popl %edx
    popl %ecx

    incl %ecx
    jmp for_afisare

exit_afisare:
    ret

solutie:
    pushl %ebp
    movl %esp, %ebp

    pushl %ebx

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
    popl %ebx
    popl %ebp
    ret

ok:
    pushl %ebp
    movl %esp, %ebp

    pushl %ebx
    pushl %esi

    movl 8(%ebp), %ebx

    movl %ebx, %ecx
    decl %ecx

    movl (%edi, %ebx, 4), %edx

    movl %edx, val

    //val = a[k]

    xorl %edx, %edx

while:
    cmp $1, %ecx
    jl exit_while

    movl (%edi, %ecx, 4), %eax

    cmp val, %eax
    je exit_while

    incl %edx
    decl %ecx

    jmp while

exit_while:
    //movl %edx, d
    //movl %ecx, i

    //movl val, %ecx

    lea c, %esi
    movl val, %eax
    movl (%esi, %eax, 4), %eax
    //movl (%esi, %ecx, 4), %eax

    cmp $3, %eax
    jge gresit

    //movl d, %edx

    cmp m, %edx
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
    popl %esi
    popl %ebx
    popl %ebp
    ret

back:
    pushl %ebp
    movl %esp, %ebp

    pushl %ebx
    pushl %esi

    movl 8(%ebp), %ebx

    cmpl $0, afis
    jne exit_back

    lea b, %esi

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
    popl %ebx

    popl %edx
    popl %ecx

    cmp $0, %eax
    je cont_for

    pushl %ecx
    pushl %edx

    pushl %ebx
    call solutie
    popl %ebx

    popl %edx
    popl %ecx

    cmp $0, %eax
    je reapelare

    pushl %ecx
    pushl %edx

    call afisare
    
    popl %edx
    popl %ecx

cont_for:
    incl %ecx
    jmp for

punct_fix:
    lea b, %esi
    movl (%esi, %ebx, 4), %edx
    movl %edx, (%edi, %ebx, 4)

    lea c, %esi
    decl (%esi, %edx, 4)
    
    pushl %ecx
    pushl %edx

    pushl %ebx
    call ok
    popl %ebx

    popl %edx
    popl %ecx

    incl (%esi, %edx, 4)

    cmp $0, %eax
    je exit_back

    pushl %ecx
    pushl %edx

    pushl %ebx
    call solutie
    popl %ebx

    popl %edx
    popl %ecx

    cmp $0, %eax
    je reapelare_fix

    pushl %ecx
    pushl %edx

    call afisare
    
    popl %edx
    popl %ecx

    jmp exit_back

reapelare_fix:
    movl %ebx, k
    incl k

    pushl %ecx
    pushl %edx

    pushl k
    call back
    popl %eax
    
    popl %edx
    popl %ecx

    jmp exit_back

reapelare:
    lea c, %esi
    incl (%esi, %ecx, 4)

    movl %ebx, k
    incl k

    pushl %ecx
    pushl %edx

    pushl k
    call back
    popl %eax

    popl %edx
    popl %ecx

    lea c, %esi
    decl (%esi, %ecx, 4)

    jmp cont_for

exit_back:
    popl %esi
    popl %ebx
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

    pushl k
    call back
    popl %ebx

iesire_back:
    cmpl $0, afis
    jne exit

    pushl impos
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx

exit:
    pushl $LF
    call printf
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
