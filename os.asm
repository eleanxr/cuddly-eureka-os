BITS 64

start:
  ; set up 4K of stack space after the bootloader.
  mov ax, 0x07c0
  add ax, 288
  mov ss, ax
  mov sp, 4096

  ; Set the data segment to the beginning of code execution.
  mov ax, 0x07c0
  mov ds, ax

  ; Put string position into SI
  mov si, text_string
  call print_string
  mov si, text_string_2
  call print_string

  ; Infinite loop
  jmp $

  text_string db 'We made it here!', 0
  text_string_2 db 'And then here!', 0

; Output the string residing in SI to the screen using the BIOS
print_string:
  mov ah, 0x0e
.repeat:
  lodsb
  cmp al, 0
  je .done
  int 0x10
  jmp .repeat
.done:
  ret

  times 510-($-$$) db 0
  dw 0xAA55
