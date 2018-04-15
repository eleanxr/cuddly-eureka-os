
.global _start

_start:
  // Initialize the interrupt vector table, which the ARM processor expects to
  // be at the beginning of the binary.
  b _reset // power reset
  b . // undefined instruction
  b . // software interrupt
  b . // prefetch abort
  b . // data abort
  b . // unused handler
  b . // interrupt vector
  b . // fast interrupt vector

_reset:
  ldr sp, =0x8000
  bl kernel_main
  b .

_hang:
  b hang
