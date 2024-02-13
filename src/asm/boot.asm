[org 0x00]
[bits 16]

; section code

; .main:
  mov eax, 0xb800
  mov es, eax

  mov byte [es:0x00], 'a'
  mov byte [es:0x01], 0x30

jmp $

times 510 - ($ - $$) db 0x00;

db 0x55
db 0xaa

; ; Instruct NASM to generate code that is to be run on CPU that is running in 16 bit mode
; bits 16

; ; Tell NASM that we expect our bootloader to be laoded at this address, hence offsets should be calculated in relation to this address
; org 0x7c00

; ; Set background and foreground colour
; mov ah, 0x06    ; Clear / scroll screen up function
; xor al, al      ; Number of lines by which to scroll up (00h = clear entire window)
; xor cx, cx      ; Row,column of window's upper left corner
; mov dx, 0x184f  ; Row,column of window's lower right corner
; mov bh, 0x4e    ; Background/foreground colour. In our case - red background / yellow foreground (https://en.wikipedia.org/wiki/BIOS_color_attributes)
; int 0x10        ; Issue BIOS video services interrupt with function 0x06

; ; Move label's bootloaderBanner memory address to si
; mov si, bootloaderBanner
; ; Put 0x0e to ah, which stands for "Write Character in TTY mode" when issuing a BIOS Video Services interrupt 0x10
; mov ah, 0x0e
; loop:
;     ; Load byte at address si to al
;     lodsb
;     ; Check if al==0 / a NULL byte, meaning end of a C string
;     test al, al
;     ; If al==0, jump to end, where the bootloader will be halted
;     jz end
;     ; Issue a BIOS interrupt 0x10 for video services
;     int 0x10
;     ; Repeat
;     jmp loop
; end:
;     ; Halt the program until the next interrupt
;     hlt
; bootloaderBanner: db "          uuUUUUUUUUuu",13,10,"     uuUUUUUUUUUUUUUUUUUuu",13,10,"    uUUUUUUUUUUUUUUUUUUUUUu",13,10,"  uUUUUUUUUUUUUUUUUUUUUUUUUUu",13,10,"  uUUUUUUUUUUUUUUUUUUUUUUUUUu",13,10,"  uUUUU       UUU       UUUUu",13,10, "   UUU        uUu        UUU",13,10,"   UUUu      uUUUu     uUUU",13,10,"    UUUUuuUUU     UUUuuUUUU",13,10, "     UUUUUUU       UUUUUUU",13,10, "       uUUUUUUUuUUUUUUUu",13,10,"           uUUUUUUUu",13,10,"         UUUUUuUuUuUUU",13,10,"           UUUUUUUUU",13,10,13,10,"  Hacked by @spotheplanet at ired.team", 0

; ; Fill remaining space of the 512 bytes minus our instrunctions, with 00 bytes
; ; $ - address of the current instruction
; ; $$ - address of the start of the image .text section we're executing this code in
; times 510 - ($-$$) db 0
; ; Bootloader magic number
; dw 0xaa55

; ; So far we've filled 512 bytes. Fill more until we have an entire floppy-size worth's.
; times (163840-512) db 0

; [org 0x00]
; [bits 16]

; ; section code

; ; .main:
; mov eax, 0xb800
; mov es, eax

; mov byte [es:0x00], 'H'     ; 0xb800 + 0x00 = 0xb800
; mov byte [es:0x01], 0x30    ;

; jmp $

; times 510 - ($ - $$) db 0x00  ; pads the file with zeros to right size (512 bytes)

; db 0x55
; db 0xaa

; ; So far we've filled 512 bytes. Fill more until we have an entire floppy-size worth's.
; times (163840-512) db 0
