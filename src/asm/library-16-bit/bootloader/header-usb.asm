; *************************************************
; specify an origin for the code and address
; specify the bit system

; ------------------------------------------
; PROTO
[org 0]
; [org 0x7c0]
[bits 16]

; ------------------------------------------
; Offset block of bytes for when using a USB
; drive to prevent BIOS from writing over
; bootloader code.
_start:
  jmp short start_bootloader
  nop

times 33 db 0

start_bootloader:
  jmp 0x7c0:setup
  ; jmp setup
