SECTIONS
{
	_thread_inittab_size = SIZEOF(.uk_thread_inittab);
	_succ_start = . + _thread_inittab_size;
	_succ_start = ALIGN(0x1000);
	. = _succ_start - _thread_inittab_size;
	.uk_thread_inittab : {
		PROVIDE(_uk_thread_inittab_start = .);
		KEEP (*(.uk_thread_inittab0))
		KEEP (*(.uk_thread_inittab0.*))
		KEEP (*(.uk_thread_inittab1))
		KEEP (*(.uk_thread_inittab1.*))
		KEEP (*(.uk_thread_inittab2))
		KEEP (*(.uk_thread_inittab2.*))
		KEEP (*(.uk_thread_inittab3))
		KEEP (*(.uk_thread_inittab3.*))
		KEEP (*(.uk_thread_inittab4))
		KEEP (*(.uk_thread_inittab4.*))
		KEEP (*(.uk_thread_inittab5))
		KEEP (*(.uk_thread_inittab5.*))
		KEEP (*(.uk_thread_inittab6))
		KEEP (*(.uk_thread_inittab6.*))
		KEEP (*(.uk_thread_inittab7))
		KEEP (*(.uk_thread_inittab7.*))
		KEEP (*(.uk_thread_inittab8))
		KEEP (*(.uk_thread_inittab8.*))
		KEEP (*(.uk_thread_inittab9))
		KEEP (*(.uk_thread_inittab9.*))
		PROVIDE(_uk_thread_inittab_end = .);
	}
}
INSERT BEFORE .tdata;
