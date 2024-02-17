; ---------------------------------------------
; Shared Clear Screen Procedure
clear_screen:
  ; Move blank character to current text address
  mov byte [es:eax], 0
  inc ax

  ; Move the background color and character color to the next address
  mov byte [es:eax], 0x30
  inc ax

  ; Compare if we have reached the end of the value
  cmp ax, 2 * 25 * 80
  jl clear_screen
  ret
