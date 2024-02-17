; This is the footer file used to pad the resulting
; binary and add two bytes to mark the file as
; executable

; *************************************************
; Fill the file with 0s so that it will be the
; right size
times 510 - ($ - $$) db 0x00

; *************************************************
; The last two bytes tell the comptuer that this
; file is executable
db 0x55
db 0xaa

; --------------------------


; This is probably the most complex part of this
; program. There is a video resource that does
; a great job of breaking this section down
; ref: https://youtu.be/3IDm_14_tAU?si=u9u4MOP5URAUhRdx

times 512 db 'A'

