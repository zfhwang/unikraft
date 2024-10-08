/* SPDX-License-Identifier: ISC */
/*
 * Author(s): Dan Williams <djwillia@us.ibm.com>
 *            Martin Lucina <martin.lucina@docker.com>
 *            Simon Kuenzer <simon.kuenzer@neclab.eu>
 *
 * Copyright (c) 2016, IBM
 *           (c) 2016-2017 Docker, Inc.
 *           (c) 2017-2018, NEC Europe Ltd.
 *
 * Permission to use, copy, modify, and/or distribute this software
 * for any purpose with or without fee is hereby granted, provided
 * that the above copyright notice and this permission notice appear
 * in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 * WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 * AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
 * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
 * OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
 * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include <uk/arch/limits.h> /* for __PAGE_SIZE */
#include <uk/plat/common/common.lds.h>

PHDRS
{
	text PT_LOAD FLAGS(PHDRS_PF_RX);
	rodata PT_LOAD FLAGS(PHDRS_PF_R);
	data PT_LOAD;
#if CONFIG_OPTIMIZE_SHARED
	public_text PT_LOAD FLAGS(PHDRS_PF_RWX);
#if CONFIG_CLUSTER0
	cluster0 PT_LOAD FLAGS(PHDRS_PF_RWX);
	cluster0_text PT_LOAD FLAGS(PHDRS_PF_RX);
	cluster0_rodata PT_LOAD FLAGS(PHDRS_PF_R);
#endif
#if CONFIG_CLUSTER1
	cluster1 PT_LOAD FLAGS(PHDRS_PF_RWX);
	cluster1_text PT_LOAD FLAGS(PHDRS_PF_RX);
	cluster1_rodata PT_LOAD FLAGS(PHDRS_PF_R);
#endif
#if CONFIG_CLUSTER2
	cluster2 PT_LOAD FLAGS(PHDRS_PF_RWX);
	cluster2_text PT_LOAD FLAGS(PHDRS_PF_RX);
	cluster2_rodata PT_LOAD FLAGS(PHDRS_PF_R);
#endif
#if CONFIG_CLUSTER3
	cluster3 PT_LOAD FLAGS(PHDRS_PF_RWX);
	cluster3_text PT_LOAD FLAGS(PHDRS_PF_RX);
	cluster3_rodata PT_LOAD FLAGS(PHDRS_PF_R);
#endif
#if CONFIG_CLUSTER4
	cluster4 PT_LOAD FLAGS(PHDRS_PF_RWX);
	cluster4_text PT_LOAD FLAGS(PHDRS_PF_RX);
	cluster4_rodata PT_LOAD FLAGS(PHDRS_PF_R);
#endif
#if CONFIG_CLUSTER5
	cluster5 PT_LOAD FLAGS(PHDRS_PF_RWX);
	cluster5_text PT_LOAD FLAGS(PHDRS_PF_RX);
	cluster5_rodata PT_LOAD FLAGS(PHDRS_PF_R);
#endif
#if CONFIG_CLUSTER6
	cluster6 PT_LOAD FLAGS(PHDRS_PF_RWX);
	cluster6_text PT_LOAD FLAGS(PHDRS_PF_RX);
	cluster6_rodata PT_LOAD FLAGS(PHDRS_PF_R);
#endif
#if CONFIG_CLUSTER7
	cluster7 PT_LOAD FLAGS(PHDRS_PF_RWX);
	cluster7_text PT_LOAD FLAGS(PHDRS_PF_RX);
	cluster7_rodata PT_LOAD FLAGS(PHDRS_PF_R);
#endif
#if CONFIG_CLUSTER8
	cluster8 PT_LOAD FLAGS(PHDRS_PF_RWX);
	cluster8_text PT_LOAD FLAGS(PHDRS_PF_RX);
	/* cluster8_rodata PT_LOAD FLAGS(PHDRS_PF_R); */
#endif
#if CONFIG_CLUSTER9
	cluster9 PT_LOAD FLAGS(PHDRS_PF_RWX);
	cluster9_text PT_LOAD FLAGS(PHDRS_PF_RX);
	cluster9_rodata PT_LOAD FLAGS(PHDRS_PF_R);
#endif

#endif
	tls PT_TLS;
	tls_load PT_LOAD;
	stack PT_GNU_STACK FLAGS(PHDRS_PF_RW);
}

SECTIONS
{
	. = 0x100000;

	_base_addr = .;		/* Symbol to represent the load base address */

	/* Code */
	_text = .;
	.text :
	{
		/* prevent linker gc from removing multiboot header */
		KEEP (*(.data.boot))
		KEEP (*(.data.boot.*))
		*(.text.boot)
		*(.text.boot.*)

		*(.text)
		*(.text.*)
	} :text
	_etext = .;

	/* Read-only data */
	. = ALIGN(__PAGE_SIZE);
	_rodata = .;
	.rodata :
	{
		*(.rodata)
		*(.rodata.*)
	} :rodata
	_erodata = .;

	EXCEPTION_SECTIONS

	CTORTAB_SECTION

	INITTAB_SECTION

	EVENTTAB_SECTION

	/* Constructor tables (read-only) */
	. = ALIGN(0x8);
	_ctors = .;
	.preinit_array : {
		PROVIDE_HIDDEN (__preinit_array_start = .);
		KEEP (*(.preinit_array))
		PROVIDE_HIDDEN (__preinit_array_end = .);
	}

	. = ALIGN(0x8);
	.init_array : {
		PROVIDE_HIDDEN (__init_array_start = .);
		KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
		KEEP (*(.init_array .ctors))
		PROVIDE_HIDDEN (__init_array_end = .);
	}
	_ectors = .;

	DATA_SECTIONS

	TLS_SECTIONS

	_end = .;

	.comment       0 : { *(.comment) }
	DEBUG_SYMBOLS

	DISCARDS
}
