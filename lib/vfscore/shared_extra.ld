SECTIONS
{
	.uk_fs_list : {
		PROVIDE(uk_fslist_start = .);
		KEEP (*(.uk_fs_list))
        PROVIDE(uk_fslist_end = .);
	}
}
INSERT AFTER .cluster1.align_vars;
