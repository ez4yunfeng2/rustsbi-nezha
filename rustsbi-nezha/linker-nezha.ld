MEMORY {
    SRAM : ORIGIN = 0x40000000,LENGTH = 128M
}

PROVIDE(stext = 0x40000000);

REGION_ALIAS("REGION_TEXT", SRAM);
REGION_ALIAS("REGION_RODATA", SRAM);
REGION_ALIAS("REGION_DATA", SRAM);
REGION_ALIAS("REGION_BSS", SRAM);

OUTPUT_ARCH(riscv)

ENTRY(_start)

SECTIONS
{
    .text stext : {
        stext = .;
        *(.text.entry)
        *(.text .text.*)
        . = ALIGN(4);
        etext = .;
    } > REGION_TEXT

    .rodata : ALIGN(4) {
        srodata = .;
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
        . = ALIGN(4);
        erodata = .;
    } > REGION_RODATA

    .data : ALIGN(4) {
        sidata = LOADADDR(.data);
        sdata = .;
        *(.data .data.*)
        *(.sdata .sdata.*)
        . = ALIGN(4);
        edata = .;
    } > REGION_DATA

    .bss (NOLOAD) : ALIGN(4) {
        *(.bss.uninit)
        sbss = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
        . = ALIGN(4);
        ebss = .;
    } > REGION_BSS

    /DISCARD/ : {
        *(.eh_frame .eh_frame_hdr)
    }
}
