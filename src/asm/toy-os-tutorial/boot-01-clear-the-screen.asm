; *************************************************
; specify an origin for the code and address
; specify the bit system
[org 0x00]
[bits 16]

; *************************************************
; Code Module
; specify the section (aka a module)
section.code

; ---------------------------------------------
; Init Function
;  specify label (aka function)
; NOTE: 0xb800 is reserved value to indicate the first
; character on the screen
.init:

  ; move a value to eax register to place in the es register.
  ; It needs an intermediate register move the value from
  ; eax to es register.
  mov eax, 0xb800         ; move the eax register to spot in memory for the start of screen buffer
  mov es, eax             ; set the es register to point to whatever the eax register points to
  mov eax, 0              ; set eax register to empty

; ---------------------------------------------
; Clear Function
.clear:
  ; Move blank character to current text address
  mov byte [es:eax], 0
  inc eax

  ; Move the background color and character color to the next address
  mov byte [es:eax], 0x30
  inc eax

  ; Compare if we have reached the end of the value
  cmp eax, 2 * 25 * 80
  jl .clear

; ---------------------------------------------
; Main Function
.main:

  ; write a value to the first char on screen. (0xb800 + 0x00 = 0xb800)
  ; move to next byte to set the foreground and background color
  mov byte [es:0x00], 'H'   ; write a character to the first item in the screen buffer
  mov byte [es:0x01], 0x30  ; set the foreground and background color

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
