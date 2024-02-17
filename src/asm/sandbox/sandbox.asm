; *************************************************
; specify an origin for the code and address
; specify the bit system

; ------------------------------------------
; PROTO
org 0
bits 16

; ------------------------------------------
; Offset block of bytes for when using a USB
; drive to prevent BIOS from writing over
; bootloader code.
_start:
  jmp short start_bootloader
  nop

times 33 db 0

start_bootloader:
  jmp 0x7c0:section.code.setup

; *************************************************
; Code Module
; specify the section (aka a module)
; ------------------------------------------
; Bootloader Code
section.code:

; ---------------------------------------------
; Setup procedure - specify label (aka function)
.setup:
  cli
  mov ax, 0x7c0
  mov ds, ax
  mov es, ax
  mov ax, 0x00
  mov ss, ax
  mov sp, 0x7c00
  sti

  ; NOTE: 0xb800 is reserved value to indicate the first
  ; character on the screen

  ; Set the data segment register where the data  is moved
  ; to on a computer
  mov ax, 0x07c0
  mov ds, ax

  ; move a value to eax register to place in the es register.
  ; It needs an intermediate register move the value from
  ; eax to es register.
  mov ax, 0xb800         ; move the eax register to spot in memory for the start of screen buffer
  mov es, ax             ; set the es register to point to whatever the eax register points to
  mov ax, 0              ; set eax register to empty

  ; Set a few other registers
  mov bx, 0    ; Index of the character in the string we are printing
  mov cx, 0    ; Actual address of the character on the screen
  mov dl, 0     ; Store the actual value that we are printing
  call .main
  jmp .end

; ---------------------------------------------
.print:
  mov dl, byte [eax + ebx]

  cmp dl, 0
  je .print_end

  mov byte [es:ecx], dl

  inc ebx
  inc ecx
  inc ecx

  jmp .print

  .print_end:
  ret

; ---------------------------------------------
; Main Bootloader Body
.main:
  call .clear_screen

  mov eax, text
  call .print

  ret

; ---------------------------------------------
; End of Bootloader
.end:
  jmp .end

; *************************************************
; Bootload Data
section.data:
  text: db  'Hello, World!', 0
  text1: db 'This is another text!', 0


; ; ------------------------------------------
; ; PROTO - Working
; [org 0x00]
; [bits 16]

; section.text:
;   .init:
;     mov ax, 0xb800
;     mov es, ax
;     mov ax, 0

;   .clear:
;     mov word [es:eax], 0
;     inc ax
;     mov word [es:eax], 0x30
;     inc ax

;     cmp ax, 2 * 25 * 80
;     jl .clear

;   .main:
;     mov byte [es:0x00], 'H'
;     mov byte [es:0x01], 0x30

;   .end:
;     jmp $

; ; ------------------------------------------
; ; PROTO - Working
; [org 0x7c00]
; [bits 16]

; jmp init

; section.text:
;   init:
;     mov ax, 0xb800
;     mov cx, 0xb800
;     mov es, ax
;     mov ax, 0
;     jmp start

;   move_cursor:
;     mov al, [column]
;     mov dl, CELL_SIZE
;     mul dl
;     ; mov [column], al
;     ; add byte [column], al
;     inc byte [column]
;     ret

;   print_text:
;     ; mov cx, column
;     ; mul cx, column, CELL_SIZE
;     ; mov al, column
;     ; mov dl, CELL_SIZE
;     ; mul dl
;     ; mov cx, ax

;     ; mov column,

;     ; mov cx, 0
;     ; mov cl, ( * CELL_SIZE)

;     ; multiple to move the cursor on the column
;     ; call move_cursor
;     ; call move_cursor
;     ; call move_cursor
;     ; call move_cursor
;     ; call move_cursor

;     mov cx, 0
;     call move_cursor
;     mov cl, al  ;grab the result
;     call print_character

;     mov cx, 0
;     call move_cursor
;     mov cl, al  ;grab the result
;     call print_character

;     mov cx, 0
;     call move_cursor
;     mov cl, al  ;grab the result
;     call print_character


;     ret

;   print_character:
;     mov di, cx
;     mov bl, byte [title + 0]
;     mov byte [es:di], bl

;     inc cx
;     mov di, cx
;     mov bl, byte [screen_color]
;     mov byte [es:di], bl
;     ret

;   start:
;     call print_text
;     jmp end

;   end:
;     jmp end

; section.data:
;   title db 'Welcome to TamedOS', 0
;   screen_color db 0x30
;   column db 0
;   CELL_SIZE equ 2

; ; ------------------------------------------
; ; PROTO - Working
; [org 0x7c00]
; [bits 16]

; jmp init

; section.text
;   init:
;     mov ax, 0xb800
;     mov cx, 0xb800
;     mov es, ax
;     mov ax, 0
;     jmp start

;   print_text:
;     mov cx, (1 * CELL_SIZE)
;     call print_character
;     ret

;   print_character:
;     mov di, cx
;     mov bl, byte [title + 0]
;     mov byte [es:di], bl

;     inc cx
;     mov di, cx
;     mov bl, byte [screen_color]
;     mov byte [es:di], bl
;     ret

;     ; mov byte [di], 0x01

;     ; mov byte [es:0x00], bl
;     ; mov bx, 3
;     ; mov es:[bx], 35

;     ; mov cl, 65
;     ; mov di, 0xb800

;     ; mov byte [di], cl
;     ; mov byte [es], 35
;     ; mov byte [si, 'z'


;     ; mov bl, byte [screen_color]
;     ; mov byte [es:0x01], bl

;     ; mov byte [es:0x00], 'H'
;     ; mov byte [es:0x01], 0x30

;     ; mov ah, 0x0e

;     ; mov bl, byte [title + 0]
;     ; mov al, bl
;     ; int 0x10

;     ; mov bl, byte [title + 1]
;     ; mov al, bl
;     ; int 0x10
;     jmp end

;   start:
;     call print_text
;     jmp end

;   end:
;     jmp end

; section.data
;   title db 'Welcome to TamedOS', 0
;   screen_color db 0x30
;   column dw 0
;   CELL_SIZE equ word 2

; ; ------------------------------------------
; ; PROTO - Working
; [org 0x7c00]
; [bits 16]

; jmp start

; section.text
;   start:
;     mov ah, 0x0e

;     mov bl, byte [title + 0]
;     mov al, bl
;     int 0x10

;     mov bl, byte [title + 1]
;     mov al, bl
;     int 0x10

;   end:
;     jmp end

; section.data
;   title db 'Welcome to TamedOS', 0

; ; ------------------------------------------
; ; PROTO
; [org 0x7c00]
; [bits 16]

; jmp start

; section.text
;   start:
;     mov ah, 0x0e

;     ; mov byte [title + 0], 35
;     mov bl, byte [title + 0]
;     mov al, bl
;     int 0x10

;     ; mov byte [title + 1], 64
;     mov bl, byte [title + 1]
;     mov al, bl
;     int 0x10

;     ; mov bl, [tm]
;     ; mov al, bl
;     ; int 0x10

;   end:
;     jmp end

; section.data
;   ; arb times 10 db 0
;   ; arb db 'This is some really', 0
;   ; arb db '12345678', 0
;   title db 'Welcome to TamedOS', 0

; section.text
;   main:
;     mov ax, 0xb800
;     mov es, ax

;     mov ebx, [my_table]
;     mov [ebx], 110

;     ; mov %al, CELL_COLOR
;     ; mov byte [es:0x01], CELL_COLOR
;     ; mov al, CELL_COLOR
;     ; mov byte [es:0x01], CELL_COLOR

;     ; mov byte [es:0x00], 'T'
;     ; mov byte [es:0x01], CELL_COLOR
;     ; inc dl
;     ; mov dl, CELL_COLOR

;   end:
;     jmp end

; section.data
;   CELL_COLOR equ 0x30
;   msg db 'TamedOS', 0
;   my_table times 10 db 0

; ; ------------------------------------------
; ; PROTO
; [org 0x00]
; [bits 16]

; section.text
;   main:
;     mov eax, 0xb800
;     mov es, eax

;     mov byte [es:0x00], 'T'
;     mov byte [es:0x01], CELL_COLOR

;     mov byte [es:0x02], 'a'
;     mov byte [es:0x03], CELL_COLOR

;     mov byte [es:0x04], 'm'
;     mov byte [es:0x05], CELL_COLOR

;     mov byte [es:0x06], 'e'
;     mov byte [es:0x07], CELL_COLOR

;     mov byte [es:0x08], 'd'
;     mov byte [es:0x09], CELL_COLOR

;     mov byte [es:0x0a], 'O'
;     mov byte [es:0x0b], CELL_COLOR

;     mov byte [es:0x0c], 'S'
;     mov byte [es:0x0d], CELL_COLOR

;   end:
;     jmp end

; section.data
;   CELL_COLOR equ 0x30
;   msg db 'TamedOS', 0
