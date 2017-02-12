AS=nasm
CC=gcc
LD=ld

disk.img: os.bin
	qemu-img create disk.img 1440k
	dd status=noxfer conv=notrunc if=os.bin of=disk.img

os.bin: os.asm
	$(AS) -f bin -o os.bin os.asm

os_gnu.o: os_gnu.s
	as -o os_gnu.o os_gnu.s

os_gnu.bin: os_gnu.o
	ld os_gnu.o -o os_gnu.bin --oformat=binary -Ttext 0x7c00

disk_gnu.img: os_gnu.bin
	qemu-img create disk_gnu.img 1440k
	dd status=noxfer conv=notrunc if=os_gnu.bin of=disk_gnu.img

clean:
	rm disk.img os.bin
