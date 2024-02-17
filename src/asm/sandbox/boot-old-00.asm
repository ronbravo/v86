; ------------------------------------------
; PROTO
[org 0x00]
[bits 16]

section.text

main:
  mov eax, 0xb800
  mov es, eax

  mov byte [es:0x00], 'T'
  mov byte [es:0x01], 0x30

  mov byte [es:0x02], 'a'
  mov byte [es:0x03], 0x30

  mov byte [es:0x04], 'm'
  mov byte [es:0x05], 0x30

  mov byte [es:0x06], 'e'
  mov byte [es:0x07], 0x30

  mov byte [es:0x08], 'd'
  mov byte [es:0x09], 0x30

  mov byte [es:0x0a], 'O'
  mov byte [es:0x0b], 0x30

  mov byte [es:0x0c], 'S'
  mov byte [es:0x0d], 0x30

end:
  jmp end

; ; ------------------------------------------
; ; PROTO
; [org 0x00]
; [bits 16]

; section.text

; main:
;   mov eax, 0xb800
;   mov es, eax

;   mov byte [es:0x00], 'T'
;   mov byte [es:0x01], 0x30

;   mov byte [es:0x02], 'a'
;   mov byte [es:0x03], 0x30

;   mov byte [es:0x04], 'm'
;   mov byte [es:0x05], 0x30

;   mov byte [es:0x06], 'e'
;   mov byte [es:0x07], 0x30

;   mov byte [es:0x08], 'd'
;   mov byte [es:0x09], 0x30

;   mov byte [es:0x0a], 'O'
;   mov byte [es:0x0b], 0x30

;   mov byte [es:0x0c], 'S'
;   mov byte [es:0x0d], 0x30

; end:
;   jmp end

; ; ------------------------------------------
; ; PROTO
; ; [bits 16]

; [org 0x7c00]
; [bits 16]

; _start:
;   jmp short start
;   nop

; times 33 db 0

; start:
;   jmp step2

; step2:
;   mov ah, 0x0e
;   mov al, [car]
;   int 0x10

;   mov al, [car+1]
;   int 0x10

;   mov al, [car+2]
;   int 0x10

;   mov al, [car+3]
;   int 0x10

;   mov al, [car+4]
;   int 0x10

;   jmp $

; car: db "Hello World!", 0
; ; ------------------------------------------
; ; PROTO
; [org 0x7c00]
; [bits 16]

; jmp short start
; nop

; times 33 db 0

; start:

; section.text

; .init
;   mov eax, 0xb800
;   mov es, eax
;   mov eax, 0

; .main
;   mov byte [es:0x00], 'H'
;   mov byte [es:0x01], 0x30

;   mov byte [es:0x02], 'a'
;   mov byte [es:0x03], 0x30

;   mov byte [es:0x04], 'l'
;   mov byte [es:0x05], 0x30

;   mov byte [es:0x06], 'l'
;   mov byte [es:0x07], 0x30

;   mov byte [es:0x08], 'o'
;   mov byte [es:0x09], 0x30

; jmp $

; ; ------------------------------------------
; ; PROTO
; ; [bits 16]

; [org 0x7c00]
; [bits 16]

; _start:
;   jmp short start
;   nop

; times 33 db 0

; start:
;   jmp step2

; step2:
;   mov ah, 0x0e
;   mov al, [car]
;   int 0x10

;   jmp $

; car: db "Hello World!", 0
; ; ------------------------------------------
; ; PROTO
; [org 0x7c00]
; [bits 16]


; ; mov al, byte [bob]   ; set bx to address of bob
; ; mov ax, 0x0e35
; ; int 0x10

; mov ax, 0xb800
; mov es, ax

; ; mov bx, [bob]   ; set bx to address of bob
; ; mov byte [bx], 10    ; set value 10 as a byte in whatever cell bx is pointing to (bob)

; ; mov ax, [bob]   ; set cx to address of bob
; ; mov bl, al      ; set value 10 as a byte in whatever cell bx is pointing to (bob)

; ; mov si, 0
; ; mov si, 'h'
; ; mov es, CELL_COLOR


; ; mov si, msg
; ; mov al, [si]
; ; mov al:1], CELL_COLOR

; ; mov [es], [al]

; ; mov byte [es:0], 'H'

; mov byte [es:0], 'H'
; mov byte [es:1], CELL_COLOR

; mov byte [es:2], 'z'
; mov byte [es:3], CELL_COLOR

; ; mov si, msg
; ; mov ah, 0x0e

; ; mov al, [si]
; ; inc si
; ; int 0x10

; ; mov al, [si]
; ; inc si
; ; int 0x10

; end:
;   jmp end

; msg: db 'hi', 0
; bob db 35
; cal db 10

; ; Constants
; CELL_COLOR equ 0x30



; ; ------------------------------------------
; ; PROTO
; [org 0x00]
; [bits 16]


; main:
;   mov ax, 0
;   mov ds, ax
;   mov es, ax
;   mov ss, ax

;   mov sp, 0x7c00
;   mov si, msg
;   call print
;   hlt

; halt:
;   jmp halt

; print:
;   mov ax, si

;   mov ah, 0x0e
;   mov bh, 0
;   int 0x10
;   ; push si
;   ; push ax
;   ; push bx
;   ret

; print_loop:


; msg: db 'Our OS', 0

; section.text
; mov ah, 0x0e

; mov al, 97
; int 0x10

; mov al, byte [bob]   ; set bx to address of bob
; mov ax, 0x0e35
; int 0x10

; mov ax, 0xb800
; mov es, ax

; mov bx, [bob]   ; set bx to address of bob
; mov byte [bx], 10    ; set value 10 as a byte in whatever cell bx is pointing to (bob)

; mov ax, [bob]   ; set cx to address of bob
; mov bl, al      ; set value 10 as a byte in whatever cell bx is pointing to (bob)

; mov si, 0
; mov si, 'h'
; mov es, CELL_COLOR

; mov byte [es:0], 'H'
; mov byte [es:1], CELL_COLOR

; mov byte [es:2], 'z'
; mov byte [es:3], bob[0]

; jmp $

; section.data:
;   bob db 35

; ; Constants
; CELL_COLOR equ 0x30
; bob db 35
; cal db 10

; ; ------------------------------------------
; ; PROTO
; [org 0x00]
; [bits 16]

; mov ax, 0xb800
; mov es, ax

; mov byte [es:0], 'H'
; mov byte [es:1], CELL_COLOR

; mov byte [es:2], 'z'
; mov byte [es:3], CELL_COLOR

; jmp $

; ; Constants
; CELL_COLOR equ 100

; ; ------------------------------------------
; ; PROTO

; [org 0x00]
; [bits 16]

; section.text:

; .init:
;   mov ax, 0xb800
;   mov es, ax

; .clear:
;   mov si, 0

;   .loop:
;     mov byte [es:si], 0
;     inc si

;     mov byte [es:si], 0x30
;     inc si

;     cmp si, 2 * 25 * 80
;     jl .loop


; .main:
;   mov ecx, 0
;   mov byte [es:ecx], 'H'
;   mov ecx, 1
;   mov byte [es:ecx], 0x30

; jmp $


; [ORG 0x7c00]      ; add to offsets
;   xor ax, ax    ; make it zero
;   mov ds, ax   ; DS=0
;   mov ss, ax   ; stack starts at 0
;   mov sp, 0x9c00   ; 2000h past code start

;   cld

;   mov ax, 0xb800   ; text video memory
;   mov es, ax

;   mov si, msg   ; show text string

;   mov ah, 0x0e
;   mov cx, ax
;   int 0x10
;   ; mov cx, ax

; msg   db "What are you doing, Dave?", 0

; ; ------------------------------------------
; ; PROTO
; org 0x7c00  ; BIOS loads us here
; bits 16

; start:
;   mov si, message
;   ; mov ah, 0x0e

;   ; lodsb
;   mov ah, 0x0e
;   mov al, [si]
;   int 0x10
;   ; inc si

;   ; mov al, [si]
;   ; int 0x10

;   jmp $

; message: db 'Hello World!', 0

; ; ------------------------------------------
; ; PROTO
; org 0x7c00  ; BIOS loads us here
; bits 16

; start:
;   mov si, message
;   call print
;   jmp $

; print:
;   mov bx, 0

; .loop
;   lodsb
;   cmp al, 0
;   je .done
;   call print_char
;   jmp .loop

; .done:
;   ret

; print_char:
;   mov ah, 0x0e
;   int 0x10
;   ret

; message: db 'Hello World!', 0



; ; ------------------------------------------
; ; PROTO
; [org 0x7c00]

; xor ax, ax    ; make it zero
; mov ds, ax   ; DS=0
; mov ss, ax   ; stack starts at 0
; mov sp, 0x9c00   ; 2000h past code start

; cld

; mov ax, 0xb800   ; text video memory
; mov es, ax

; mov si, msg   ; show text string
; ; call sprint

; stosw

; hang:
; jmp hang

; msg   db "What are you doing, Dave?", 0

; ; ------------------------------------------
; ; PROTO
; [org 0x7c00]
; [bits 16]

; section .data
;   text db 'Hello', 0

; section .text
;   mov ah, 0x0e

;   mov al, 97
;   int 0x10
;   mov al, 98
;   int 0x10
;   mov al, 99
;   int 0x10

;   mov al, 10
;   int 0x10
;   mov al, 13
;   int 0x10

;   mov bx, text
;   mov al, [bx]
;   int 0x10

; end:
;   jmp end

; ; ------------------------------------------
; ; PROTO
; ; [bits 16]

; [org 0x7c00]
; [bits 16]

; _start:
;   jmp short start
;   nop

; times 33 db 0

; start:
;   jmp step2

; step2:
;   mov ah, 0x0e
;   mov al, [car]
;   int 0x10

;   jmp $

; car: db "Hello World!", 0

; ; ------------------------------------------
; ; PROTO
; mov ah, 0x0e

; mov al, 65
; int 0x10

; mov al, 65
; int 0x10

; mov ah, 0x02
; mov dh, 10
; mov dl, 0
; int 0x10

; mov ah, 0x0e

; mov al, 65
; int 0x10

; end:
; jmp end

; ------------------------------------------
; WIP
; [org 0x7c00]

; mov ah, 0x0e
; mov bx, variableName

; print_string:
;   mov al, [bx]
;   cmp al, 0
;   je end

;   int 0x10
;   inc bx
;   jmp print_string

; end:
; jmp $

; variableName: db 'But the fool', 10, 'on the hill', 0

; print_string:
;   mov al, [bx]
;   cmp al, 0
;   je end

;   cmp al, 10
;   je newline

;   jmp render_character

; newline:
;   ;mov al, 0x0a    ; AL is Linefeed
;   ;int 0x10

;   ;inc bx
;   mov al, 35
;   int 0x10

;   ;mov ah, 0x02
;   ;mov bh, 0
;   ;mov dh, 10
;   ;mov dl, 0
;   ;int 0x10
;   ;mov ah, 0x02
;   ;int 0x10


;   ;int 0x10

;   ; MOV dl, 13
;   ; MOV ah, 02h
;   ; INT 21h

;   jmp next_character

; render_character:
;   mov ah, 0x0e
;   int 0x10

; next_character:
;   inc bx
;   jmp print_string

; end:
; jmp $

; variableName: db 'But the fool', 10, 'on the hill', 0
