/* Define .uk_bootinfo section that depending on the boot protocol can
 * be populated by with boot information
 */
SECTIONS {
	. = ALIGN(8);
	.uk_bootinfo :
	{
		KEEP(*(.uk_bootinfo))
	}
	. = ALIGN(16);
	__bootinfo_end = .;
}
INSERT AFTER .tbss
