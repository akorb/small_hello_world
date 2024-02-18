.PHONY: clean

hello_world: hello_world.asm
	nasm -f bin -o $@ $<
	chmod +x $@

clean:
	rm -f hello_world
