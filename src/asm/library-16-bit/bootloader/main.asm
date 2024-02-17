main:
  call draw.clear_screen
  mov si, title
  call draw.print_text
  jmp end

%include "library-16-bit/utils/draw.asm"
