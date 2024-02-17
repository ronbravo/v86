; ---------------------------------------------
; Shared Clear Screen Procedure
draw:

.clear_screen:
  ; ref: https://stackoverflow.com/a/47568731
  ; shows that the `es` register can use the `di`
  ; register when doing a segment offset

  mov di, ax
  mov byte [es:di], 0
  inc ax

  mov di, ax
  mov bl, byte [screen_color]
  mov byte [es:di], bl
  inc ax

  ; Compare if we have reached the end of the value
  cmp ax, 2 * 25 * 80
  jl .clear_screen
  ret

.move_cursor:
  mov al, [column]
  mov dl, CELL_SIZE
  mul dl
  inc byte [column]
  ret

.print_text:
  .loop:
    mov cx, 0
    call .move_cursor

    mov cl, al
    call .print_character
    inc si

    cmp byte [si], 0
    je .done
    jmp .loop
  .done:
    ret

.print_character:
  mov di, cx
  mov bl, byte [si]
  mov byte [es:di], bl

  inc cx
  mov di, cx
  mov bl, byte [screen_color]
  mov byte [es:di], bl
  ret
