[org 0x7c00]
mov ah, 0x0e
mov ebx, variableName

printString:
  mov al, [ebx]
  cmp al, 0
  je end
  int 0x10
  inc ebx
  jmp printString
end:

jmp $

variableName: db "But the fool on the hill bob", 0
