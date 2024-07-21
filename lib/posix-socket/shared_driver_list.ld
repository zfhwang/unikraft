SECTIONS
{
	. = ALIGN(0x8);
	.posix_socket_driver_list : {
		PROVIDE(posix_socket_driver_list_start = .);
		KEEP(*(SORT_BY_NAME(.posix_socket_driver_*)));
		. = 0x50;
		PROVIDE(posix_socket_driver_list_end = .);
	}
}
INSERT AFTER .bss;
