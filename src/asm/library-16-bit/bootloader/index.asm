%include "library-16-bit/bootloader/header-usb.asm"
%include "library-16-bit/bootloader/setup.asm"
%include "library-16-bit/bootloader/main.asm"
%include "library-16-bit/bootloader/teardown.asm"
%include "library-16-bit/bootloader/data.asm"

switch_to_protected_mode:
  mov bx, 0x1000 ; This is the location where the code is loaded from disk
  mov ah, 0x02
  mov al, 30  ; The number of sectors to read from disk
  mov ch, 0x00
  mov dh, 0x00
  mov cl, 0x02
  int 0x13

  cli   ; turn off interrupts
  lgdt [gdt_descriptor] ; load the gdt table
  mov eax, cr0
  or eax, 0x1
  mov cr0, eax ; Make the switch

  jmp code_seg:protected_start

[bits 32]
protected_start:
  mov ax, data_seg
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  ; update the stack pointer
  mov ebp, 0x90000
  mov esp, ebp

  call 0x1000

  jmp $

gdt_begin:
gdt_null_descriptor:
  dd 0x00
  dd 0x00
gdt_code_seg:
  dw 0xffff
  dw 0x00
  db 0x00
  db 10011010b
  db 11001111b
  db 0x00
gdt_data_seg:
  dw 0xffff
  dw 0x00
  db 0x00
  db 10010010b
  db 11001111b
  db 0x00
gdt_end:
gdt_descriptor:
  dw gdt_end - gdt_begin -1
  dd gdt_begin

code_seg equ gdt_code_seg - gdt_begin
data_seg equ gdt_data_seg - gdt_begin

%include "library-16-bit/bootloader/footer.asm"
