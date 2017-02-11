ASM=nasm

disk.img: os.bin
	qemu-img create disk.img 1440k
	dd status=noxfer conv=notrunc if=os.bin of=disk.img

os.bin: os.asm
	$(ASM) -f bin -o os.bin os.asm

clean:
	rm disk.img os.bin
