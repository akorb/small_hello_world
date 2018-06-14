BITS 32

; System call IDs
sys_exit    equ     1
sys_read    equ     3
sys_write   equ     4
  
            org     0x08048000
  
  ehdr:                                           ; Elf32_Ehdr
            db    0x7F, "ELF", 1, 1, 1, 0         ;   e_ident
    times 8 db    0
            dw    2                               ;   e_type
            dw    3                               ;   e_machine
            dd    1                               ;   e_version
            dd    _start                          ;   e_entry
            dd    phdr - $$                       ;   e_phoff
            dd    0                               ;   e_shoff
            dd    0                               ;   e_flags
            dw    ehdrsize                        ;   e_ehsize
            dw    phdrsize                        ;   e_phentsize
            dw    1                               ;   e_phnum
            dw    0                               ;   e_shentsize
            dw    0                               ;   e_shnum
            dw    0                               ;   e_shstrndx
  
  ehdrsize  equ   $ - ehdr
  
  phdr:                                           ; Elf32_Phdr
            dd    1                               ;   p_type
            dd    0                               ;   p_offset
            dd    $$                              ;   p_vaddr
            dd    $$                              ;   p_paddr
            dd    filesize                        ;   p_filesz
            dd    filesize                        ;   p_memsz
            dd    5                               ;   p_flags
            dd    0x1000                          ;   p_align
  
  phdrsize  equ   $ - phdr
  

  _start:
   ;write
   mov al, sys_write
   inc ebx ; to 1 = stdout
   mov ecx, outStr
   mov dl, length
   int 80h

   ;exit
   sub al,10 ; eax contains result of previous syscall to write. 11 bytes have been written, so we have to subtract 10 to get the value 1 (code for sys_exit)
   ;xor al,0000_1010b could be used instead of subtraction. Might be neglectable faster, but sub is easier to read/understand
   xor ebx,ebx ; Result = 0
   int 80h
  
  outStr:   db     "Hallo Welt",10
  length    equ    $ - outStr

filesize    equ    $ - $$