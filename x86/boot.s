.code16
BITS 16

start:
  mov ax, 07C0h


# Output the string residing in SI to the screen using the BIOS
.func print_string:
  mov ah, 0x0e
  .repeat:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .repeat
  .done:
    ret
.endfunc

# Program Data
loadmsg: .asciz "Starting up EmmaOS...\r\n"

# Magic string to make this a bootable segment. Pad what remains of 510 bytes
# with zeroes and place the magic bytes 0xAA55 at the end of the segment.
.fill (510-(.-main)), 1, 0
boot_magic: .short 0xAA55
