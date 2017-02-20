
TOOLCHAIN_PREFIX=arm-none-eabi-

AS=$(TOOLCHAIN_PREFIX)as
CC=$(TOOLCHAIN_PREFIX)gcc
LD=$(TOOLCHAIN_PREFIX)ld
OBJDUMP=$(TOOLCHAIN_PREFIX)objdump
OBJCOPY=$(TOOLCHAIN_PREFIX)objcopy

# Raspberry Pi
ARCH=armv6zk

CFLAGS=-O0 -march=$(ARCH)
LDFLAGS=-nostartfiles

DEFINITIONS=-DRPI_TWO

all: kernel.img

print_uart.o: print_uart.c
	$(CC) $(CFLAGS) $(DEFINITIONS) -c -o print_uart.o print_uart.c 

start.o: start.s
	$(AS) -o start.o start.s

kernel.elf: start.o print_uart.o
	$(LD) $(LDFLAGS) -o kernel.elf start.o print_uart.o

kernel.img: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.img

clean:
	rm -rf *.o *.out *.elf *.bin
