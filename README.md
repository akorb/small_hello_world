A small **Hello World** program (113 bytes) with a valid ELF header written in x86-32 assembly.

It requires the `nasm` assembler and a Linux-based operating system.

You can verify the header is valid with the following shell command in that the output does not complain.

```shell
readelf -a hello_world
```

The size of the binary can be calculated with:

```shell
wc -c hello_world
```