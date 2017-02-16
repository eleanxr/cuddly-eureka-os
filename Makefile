AS=as
CPP=cpp
CC=gcc
LD=ld

disk.img: boot.bin
	qemu-img create disk.img 1440k
	dd status=noxfer conv=notrunc if=boot.bin of=disk.img

boot.o: boot.s
	$(CPP) boot.s | $(AS) -o boot.o

boot.out: boot.o
	$(LD) -o boot.out boot.o -Ttext 0x7c00

boot.bin: boot.out
	objcopy -O binary -j .text boot.out boot.bin

clean:
	rm -f *.img *.bin *.o *.out
