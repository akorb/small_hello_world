all:
	nasm -f bin -o hello_world hello_world.asm
	chmod +x hello_world

clean:
	rm hello_world