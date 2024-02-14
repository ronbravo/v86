; *************************************************
; specify an origin for the code and address
; specify the bit system
[org 0x00]
[bits 16]

; *************************************************
; specify the section (aka a module)
section.code

; ---------------------------------------------
; specify label (aka function)
; NOTE: 0xb800 is reserved value to indicate the first
; character on the screen
.main:

  ; move a value to eax register to place in the es register.
  ; It needs an intermediate register move the value from
  ; eax to es register.
  mov eax, 0xb800
  mov es, eax

  ; write a value to the first char on screen. (0xb800 + 0x00 = 0xb800)
  ; move to next byte to set the foreground and background color
  mov byte [es:0x00], 'H'
  mov byte [es:0x01], 0x30

; *************************************************
; Jump the instruction pointer back to this line
; of code (infinite loops so machine will not
; turn off)
jmp $

; *************************************************
; Fill the file with 0s so that it will be the
; right size
times 510 - ($ - $$) db 0x00

; *************************************************
; The last two bytes tell the comptuer that this
; file is executable
db 0x55
db 0xaa
