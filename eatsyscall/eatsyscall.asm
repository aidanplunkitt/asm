;   Executable name : EATSYSCALL
;   Version         : 1.0
;   Created date    : 5/18/2019
;   Last update     :
;   Author          : Aidan Plunkitt
;   Description     : Simple asm program demonstrating use of 0x80 for syscalls
;
;   Build:
;       nasm -f elf -g -F stabs eatsyscall.asm
;       ld -o eatsyscall eatsyscall.o
;

SECTION .data   ; initialized data

EatMsg: db "Eat at Joe's!",10       ; db?
EatLen: equ $-EatMsg                ; equ?

SECTION .bss    ; uninitialized data
SECTION .text   ; code

global _start   ; entry point, needed for linker

_start:
    nop                 ; keeps gdb happy?
    mov eax, 4          ; 4 = sys_write syscall num
    mov ebx, 1          ; 1 = file descriptor (fd) for stdout
    mov ecx, EatMsg     ; offset (address) of message
    mov edx, EatLen     ; length of message in bytes
    int 80H

    mov eax, 1          ; 2 = exit syscall num
    mov ebx, 0          ; return code 0 for success
    int 80H
