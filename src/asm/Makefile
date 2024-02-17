all: bootloader

bootloader:
	# nasm ./index.asm -f bin -o ../../build/boot.bin

	mkdir -p boot/bin
	nasm ./index.asm -f bin -o boot/bin/boot.bin
	nasm ./library-32-bit/kernel_entry.asm -f elf -o boot/bin/kernel_entry.bin

	gcc -m32 -ffreestanding -c ../c/main.c -o boot/bin/kernel.o
	ld -m elf_i386 -o boot/bin/kernel.img -Ttext 0x1000 boot/bin/kernel_entry.bin boot/bin/kernel.o

	objcopy -O binary -j .text boot/bin/kernel.img boot/bin/kernel.bin
	cat boot/bin/boot.bin boot/bin/kernel.bin > os.img

clear:
	rm -f ../../build/boot.bin

run:
	# qemu-system-x86_64 -m 64 -fda ../../build/boot.bin
	qemu-system-x86_64 -m 64 --drive format=raw,file=os.img

