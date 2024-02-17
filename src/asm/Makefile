all: bootloader

bootloader:
	nasm ./index.asm -f bin -o ../../build/boot.bin

clear:
	rm -f ../../build/boot.bin

run:
	qemu-system-x86_64 -m 64 -fda ../../build/boot.bin

