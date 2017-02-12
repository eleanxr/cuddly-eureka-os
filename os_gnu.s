.code16
.intel_syntax noprefix
.text
.org 0x0

LOAD_SEGMENT = 0x1000

.global main
main:
  jmp short start
  nop

start:
  cli # Clear interrupts
  mov ax, cs
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7c00 # Stack grows down from 0x7c00
  sti # Enable interrupts

  # Write startup message.
  lea si, loadmsg
  call print_string

  # Infinite loop
  jmp $

# Output the string residing in SI to the screen using the BIOS
.func print_string
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
.endfunc

# Program Data
loadmsg: .asciz "Loading OS...rn"

# Magic string to make this a bootable segment. Pad what remains of 510 bytes
# with zeroes and place the magic bytes 0xAA55 at the end of the segment.
.fill (510-(.-main)), 1, 0
boot_magic: .int 0xAA55
