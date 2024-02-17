main:
  call draw.clear_screen
  mov si, title
  call draw.print_text
  ; call read_disk
  ; jmp end
  jmp switch_to_protected_mode

%include "library-16-bit/utils/draw.asm"

read_disk_old:
  mov ax, 0
  mov es, ax

  mov ah, 2           ; ?
  mov al, 1           ; number of segments to read
  mov ch, 0           ; cylinder number
  mov cl, 2           ; sector number
  mov dh, 0           ; head number
  mov dl, [disk_num]  ; disk number

  mov bx, 0x7e00
  int 0x13

  mov ah, 0x0e
  mov al, [0x7e00]
  int 0x10

; es:bx = 0x7e00    ; where we want to load the sectors
; 0x7e00

  ; TODO: Check both and see if there is an error message
  ; carry flag, 1 = fail
  ; al, register might be wrong

  ret