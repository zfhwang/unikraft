SECTIONS
{
	.uk_fs_list : {
		PROVIDE(uk_fslist_start = .);
		KEEP (*(.uk_fs_list))
		. = 0x10;
        PROVIDE(uk_fslist_end = .);
	}
}
INSERT AFTER .bss;
