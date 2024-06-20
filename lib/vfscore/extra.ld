SECTIONS
{
	. = 0x2ca188;
	.uk_fs_list : {
		PROVIDE(uk_fslist_start = .);
		KEEP (*(.uk_fs_list))
                PROVIDE(uk_fslist_end = .);
	}
}
INSERT AFTER .uk_eventtab;
