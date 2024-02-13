all: bootloader

bootloader:
	nasm ./boot.asm -f bin -o ../../build/boot.bin

clear:
	rm -f ../../boot.bin

run:
	qemu-system-x86_64 -m 64 -fda ../../boot.img

