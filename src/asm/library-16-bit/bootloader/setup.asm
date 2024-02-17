setup:
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
  jmp main
