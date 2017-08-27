OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)

SECTIONS
{
  . = 0x8000;
  .text : { *(.text) }
  . = 0x8000000;
  .data : { *(.data) }
  .bss : { *(.bss) }

  /* FIXME: I just made these up to make it link. It's likely very broken. */
  . = 0x80000000;
  __exidx_start = .;
  __exidx_end = .;
  _end = .;
}
