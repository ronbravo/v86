setup:
  ; Store the currend disk number
  mov [disk_num], dl

  ; NOTE: 0xb800 is reserved value to indicate the first
  ; character on the screen

  cli     ; clear interrupts

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

  mov ss, ax
  mov sp, 0x7c00

  sti     ; enable interrupts

  jmp main
