dir = target/riscv64imac-unknown-none-elf/debug/
all: clean
	cargo build
	rust-objcopy $(dir)rustsbi-nezha --binary-architecture=riscv64 --strip-all -O binary $(dir)rustsbi-nezha.bin
	xfel ddr ddr3
	xfel write 0x40000000 $(dir)rustsbi-nezha.bin
	xfel exec 0x40000000
clean:
	cargo clean