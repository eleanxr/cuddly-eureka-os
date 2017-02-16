.code16
.text
.org 0x0

#define MSG(x) leaw x, %si; call print_string

LOAD_SEGMENT = 0x1000

.global main
main:
  jmp start
  nop

start:
  cli # Clear interrupts
  movw %cs, %ax
  movw %ax, %ds
  movw %ax, %es
  movw %ax, %ss
  movw $0x7c00, %sp # Stack grows down from 0x7c00
  sti # Enable interrupts

  # Write startup message.
  MSG(loadmsg)

  # Infinite loop
  jmp .

# Output the string residing in SI to the screen using the BIOS
print_string:
  movb $0x0e, %ah
  .repeat:
    lodsb
    cmp $0x0, %al
    je .done
    int $0x10
    jmp .repeat
  .done:
    ret

# Program Data
loadmsg: .asciz "Starting up EmmaOS...\r\n"

# Magic string to make this a bootable segment. Pad what remains of 510 bytes
# with zeroes and place the magic bytes 0xAA55 at the end of the segment.
.fill (510-(.-main)), 1, 0
boot_magic: .short 0xAA55
