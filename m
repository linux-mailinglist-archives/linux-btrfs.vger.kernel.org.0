Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307F33018C3
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 23:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbhAWW6l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 17:58:41 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47950 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWW6d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 17:58:33 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4EA01951B7E; Sat, 23 Jan 2021 17:57:43 -0500 (EST)
Date:   Sat, 23 Jan 2021 17:57:43 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     mail@hartmark.se
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: kernel BUG at fs/btrfs/relocation.c:3494
Message-ID: <20210123225743.GR31381@hungrycats.org>
References: <b7a45b0ec2f6d034822321734de635f5@hartmark.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a45b0ec2f6d034822321734de635f5@hartmark.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 21, 2021 at 03:31:58PM +0100, mail@hartmark.se wrote:
> I'm new to this so I don't know where I should post the bug.
> 
> I have created a but on the bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=211311
> 
> Best regards,
> Markus Hartugn
> 
> --
> Details from the bugzilla ticket.
> 
> I have an old btrfs / filesystem on single-disk which I had outgrew.
> 
> I added a new disk and wanted to instead having DUP for metadata and system
> convert it to raid1.
> 
> The data I wished to retain having in single mode as it's not so critical.
> 
> so I did this command:
> 
>   balance: start -dusage=100 -mconvert=raid1 -sconvert=raid1
> 
> I did get a kernel error and filesystem went ro.

You don't have enough space to convert metadata yet, and you also don't
have enough space to lock one of your 3 metadata block groups without
running out of global reserve space, so this balance command forces the
filesystem read-only due to lack of space.

> Attached kernel log.
> 
> % uname -a
> Linux staropramen 5.10.9-arch1-1 #1 SMP PREEMPT Tue, 19 Jan 2021 22:06:06
> +0000 x86_64 GNU/Linux
> 
> % btrfs --version
> btrfs-progs v5.10
> 
> % sudo btrfs filesystem usage /
> [sudo] password for markus:
> Overall:
>     Device size:                 576.55GiB
>     Device allocated:            134.61GiB
>     Device unallocated:          441.94GiB
>     Device missing:                  0.00B
>     Used:                        132.72GiB
>     Free (estimated):            442.17GiB      (min: 221.20GiB)
>     Free (statfs, df):           442.16GiB
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              342.38MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:128.55GiB, Used:128.32GiB (99.82%)
>    /dev/nvme1n1p2         93.55GiB
>    /dev/nvme0n1   35.00GiB
> 
> Metadata,DUP: Size:3.00GiB, Used:2.20GiB (73.31%)
>    /dev/nvme1n1p2          6.00GiB
> 
> System,DUP: Size:32.00MiB, Used:16.00KiB (0.05%)
>    /dev/nvme1n1p2         64.00MiB
> 
> Unallocated:
>    /dev/nvme1n1p2          1.00MiB
>    /dev/nvme0n1  441.94GiB
> 
> % sudo btrfs device usage /
> /dev/nvme1n1p2, ID: 1
>    Device size:           119.14GiB
>    Device slack:           19.53GiB
>    Data,single:            93.55GiB
>    Metadata,DUP:            6.00GiB
>    System,DUP:             64.00MiB
>    Unallocated:             1.00MiB

First you need to get some unallocated space on devid 1, e.g.

	btrfs balance start -dlimit=12 /

I picked 12 chunks here because your new disk is about 4x the size of
your old one, so you can expect metadata to expand from 3 GB to 15 GB.
By moving 12 data chunks to the new disk (plus 3 more from converting
from dup to raid1), we ensure that space is available for the metadata
later on.

Once you have some unallocated space on two devices, you can do the
metadata conversion balance:

	btrfs balance start -mconvert=raid1,soft /

Every dup chunk converted to raid1 will release more space on devid 1,
so the balance will complete (as long as you aren't writing hundreds
of GB of new data at the same time).

> /dev/nvme0n1, ID: 2
>    Device size:           476.94GiB
>    Device slack:              0.00B
>    Data,single:            35.00GiB
>    Unallocated:           441.94GiB
> 
> % sudo btrfs device stats /
> [/dev/nvme1n1p2].write_io_errs    0
> [/dev/nvme1n1p2].read_io_errs     0
> [/dev/nvme1n1p2].flush_io_errs    0
> [/dev/nvme1n1p2].corruption_errs  0
> [/dev/nvme1n1p2].generation_errs  0
> [/dev/nvme0n1].write_io_errs    0
> [/dev/nvme0n1].read_io_errs     0
> [/dev/nvme0n1].flush_io_errs    0
> [/dev/nvme0n1].corruption_errs  0
> [/dev/nvme0n1].generation_errs  0
> 
> kernel log since boot:
> -- Journal begins at Wed 2020-01-29 01:00:26 CET, ends at Thu 2021-01-21
> 14:32:09 CET. --
> Jan 21 02:26:48 staropramen kernel: microcode: microcode updated early to
> revision 0xde, date = 2020-05-26
> Jan 21 02:26:48 staropramen kernel: Linux version 5.10.9-arch1-1
> (linux@archlinux) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 SMP
> PREEMPT Tue, 19 Jan 2021 22:06:06 +0000
> Jan 21 02:26:48 staropramen kernel: Command line:
> BOOT_IMAGE=/@root/boot/vmlinuz-linux
> root=UUID=7ad0f342-b9e9-47df-90a7-e383d955862f rw rootflags=subvol=@root
> loglevel=3 quiet
> Jan 21 02:26:48 staropramen kernel: x86/fpu: Supporting XSAVE feature 0x001:
> 'x87 floating point registers'
> Jan 21 02:26:48 staropramen kernel: x86/fpu: Supporting XSAVE feature 0x002:
> 'SSE registers'
> Jan 21 02:26:48 staropramen kernel: x86/fpu: Supporting XSAVE feature 0x008:
> 'MPX bounds registers'
> Jan 21 02:26:48 staropramen kernel: x86/fpu: Supporting XSAVE feature 0x010:
> 'MPX CSR'
> Jan 21 02:26:48 staropramen kernel: x86/fpu: xstate_offset[3]:  576,
> xstate_sizes[3]:   64
> Jan 21 02:26:48 staropramen kernel: x86/fpu: xstate_offset[4]:  640,
> xstate_sizes[4]:   64
> Jan 21 02:26:48 staropramen kernel: x86/fpu: Enabled xstate features 0x1b,
> context size is 704 bytes, using 'compacted' format.
> Jan 21 02:26:48 staropramen kernel: BIOS-provided physical RAM map:
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x0000000000000000-0x0000000000057fff] usable
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x0000000000058000-0x0000000000058fff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x0000000000059000-0x000000000009efff] usable
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x000000000009f000-0x00000000000fffff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x0000000000100000-0x00000000b3f70fff] usable
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000b3f71000-0x00000000b3fa7fff] ACPI data
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000b3fa8000-0x00000000b4357fff] usable
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000b4358000-0x00000000b4358fff] ACPI NVS
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000b4359000-0x00000000b4359fff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000b435a000-0x00000000c10a0fff] usable
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000c10a1000-0x00000000c28f8fff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000c28f9000-0x00000000c290cfff] ACPI data
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000c290d000-0x00000000c2a08fff] usable
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000c2a09000-0x00000000c2d30fff] ACPI NVS
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000c2d31000-0x00000000c3330fff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000c3331000-0x00000000c33a1fff] type 20
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000c33a2000-0x00000000c33fffff] usable
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000c3400000-0x00000000c7ffffff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000f8000000-0x00000000fbffffff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000fe000000-0x00000000fe010fff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000fec00000-0x00000000fec00fff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000fed00000-0x00000000fed00fff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000fee00000-0x00000000fee00fff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x00000000ff000000-0x00000000ffffffff] reserved
> Jan 21 02:26:48 staropramen kernel: BIOS-e820: [mem
> 0x0000000100000000-0x0000000236ffffff] usable
> Jan 21 02:26:48 staropramen kernel: NX (Execute Disable) protection: active
> Jan 21 02:26:48 staropramen kernel: efi: EFI v2.60 by American Megatrends
> Jan 21 02:26:48 staropramen kernel: efi: ACPI 2.0=0xb3f71000 ACPI=0xb3f71000
> SMBIOS=0xc3291000 SMBIOS 3.0=0xc3290000 ESRT=0xbece6a98
> Jan 21 02:26:48 staropramen kernel: SMBIOS 3.0.0 present.
> Jan 21 02:26:48 staropramen kernel: DMI: System manufacturer System Product
> Name/PRIME B250M-A, BIOS 1205 05/11/2018
> Jan 21 02:26:48 staropramen kernel: tsc: Detected 3500.000 MHz processor
> Jan 21 02:26:48 staropramen kernel: tsc: Detected 3499.912 MHz TSC
> Jan 21 02:26:48 staropramen kernel: e820: update [mem 0x00000000-0x00000fff]
> usable ==> reserved
> Jan 21 02:26:48 staropramen kernel: e820: remove [mem 0x000a0000-0x000fffff]
> usable
> Jan 21 02:26:48 staropramen kernel: last_pfn = 0x237000 max_arch_pfn =
> 0x400000000
> Jan 21 02:26:48 staropramen kernel: MTRR default type: write-back
> Jan 21 02:26:48 staropramen kernel: MTRR fixed ranges enabled:
> Jan 21 02:26:48 staropramen kernel:   00000-9FFFF write-back
> Jan 21 02:26:48 staropramen kernel:   A0000-BFFFF uncachable
> Jan 21 02:26:48 staropramen kernel:   C0000-FFFFF write-protect
> Jan 21 02:26:48 staropramen kernel: MTRR variable ranges enabled:
> Jan 21 02:26:48 staropramen kernel:   0 base 00E0000000 mask 7FE0000000
> uncachable
> Jan 21 02:26:48 staropramen kernel:   1 base 00D0000000 mask 7FF0000000
> uncachable
> Jan 21 02:26:48 staropramen kernel:   2 base 00C8000000 mask 7FF8000000
> uncachable
> Jan 21 02:26:48 staropramen kernel:   3 base 00C4000000 mask 7FFC000000
> uncachable
> Jan 21 02:26:48 staropramen kernel:   4 base 00C3800000 mask 7FFF800000
> uncachable
> Jan 21 02:26:48 staropramen kernel:   5 disabled
> Jan 21 02:26:48 staropramen kernel:   6 disabled
> Jan 21 02:26:48 staropramen kernel:   7 disabled
> Jan 21 02:26:48 staropramen kernel:   8 disabled
> Jan 21 02:26:48 staropramen kernel:   9 disabled
> Jan 21 02:26:48 staropramen kernel: x86/PAT: Configuration [0-7]: WB  WC
> UC- UC  WB  WP  UC- WT
> Jan 21 02:26:48 staropramen kernel: last_pfn = 0xc3400 max_arch_pfn =
> 0x400000000
> Jan 21 02:26:48 staropramen kernel: found SMP MP-table at [mem
> 0x000fcca0-0x000fccaf]
> Jan 21 02:26:48 staropramen kernel: esrt: Reserving ESRT space from
> 0x00000000bece6a98 to 0x00000000bece6ad0.
> Jan 21 02:26:48 staropramen kernel: e820: update [mem 0xbece6000-0xbece6fff]
> usable ==> reserved
> Jan 21 02:26:48 staropramen kernel: check: Scanning 1 areas for low memory
> corruption
> Jan 21 02:26:48 staropramen kernel: Using GB pages for direct mapping
> Jan 21 02:26:48 staropramen kernel: Secure boot could not be determined
> Jan 21 02:26:48 staropramen kernel: RAMDISK: [mem 0x3688b000-0x3743cfff]
> Jan 21 02:26:48 staropramen kernel: ACPI: Early table checksum verification
> disabled
> Jan 21 02:26:48 staropramen kernel: ACPI: RSDP 0x00000000B3F71000 000024
> (v02 ALASKA)
> Jan 21 02:26:48 staropramen kernel: ACPI: XSDT 0x00000000B3F710B0 0000DC
> (v01 ALASKA A M I    01072009 AMI  00010013)
> Jan 21 02:26:48 staropramen kernel: ACPI: FACP 0x00000000B3F9B1E0 000114
> (v06 ALASKA A M I    01072009 AMI  00010013)
> Jan 21 02:26:48 staropramen kernel: ACPI: DSDT 0x00000000B3F71228 029FB5
> (v02 ALASKA A M I    01072009 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: FACS 0x00000000C2D30F00 000040
> Jan 21 02:26:48 staropramen kernel: ACPI: APIC 0x00000000B3F9B2F8 000084
> (v03 ALASKA A M I    01072009 AMI  00010013)
> Jan 21 02:26:48 staropramen kernel: ACPI: FPDT 0x00000000B3F9B380 000044
> (v01 ALASKA A M I    01072009 AMI  00010013)
> Jan 21 02:26:48 staropramen kernel: ACPI: FIDT 0x00000000B3F9B3C8 00009C
> (v01 ALASKA A M I    01072009 AMI  00010013)
> Jan 21 02:26:48 staropramen kernel: ACPI: WSMT 0x00000000B3FA71A8 000028
> (v01 ALASKA A M I    01072009 AMI  00010013)
> Jan 21 02:26:48 staropramen kernel: ACPI: MCFG 0x00000000B3F9B4C0 00003C
> (v01 ALASKA A M I    01072009 MSFT 00000097)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3F9B500 0003A3
> (v01 SataRe SataTabl 00001000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3F9B8A8 003063
> (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3F9E910 0025A5
> (v02 PegSsd PegSsdt  00001000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: HPET 0x00000000B3FA0EB8 000038
> (v01 INTEL  KBL      00000001 MSFT 0000005F)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3FA0EF0 000024
> (v02 INTEL  OEM_RTD3 00001000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3FA0F18 000DE5
> (v02 INTEL  Ther_Rvp 00001000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3FA1D00 000B1D
> (v02 INTEL  xh_rvp08 00000000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: UEFI 0x00000000B3FA2820 000042
> (v01 ALASKA A M I    00000002      01000013)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3FA2868 000EDE
> (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: LPIT 0x00000000B3FA3748 000094
> (v01 INTEL  KBL      00000000 MSFT 0000005F)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3FA37E0 000141
> (v02 INTEL  HdaDsp   00000000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3FA3928 00029F
> (v02 INTEL  sensrhub 00000000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3FA3BC8 003002
> (v02 INTEL  PtidDevc 00001000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0x00000000B3FA6BD0 00050D
> (v02 INTEL  TbtTypeC 00000000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: DBGP 0x00000000B3FA70E0 000034
> (v01 INTEL           00000002 MSFT 0000005F)
> Jan 21 02:26:48 staropramen kernel: ACPI: DBG2 0x00000000B3FA7118 000054
> (v00 INTEL           00000002 MSFT 0000005F)
> Jan 21 02:26:48 staropramen kernel: ACPI: BGRT 0x00000000B3FA7170 000038
> (v01 ALASKA A M I    01072009 AMI  00010013)
> Jan 21 02:26:48 staropramen kernel: ACPI: Local APIC address 0xfee00000
> Jan 21 02:26:48 staropramen kernel: No NUMA configuration found
> Jan 21 02:26:48 staropramen kernel: Faking a node at [mem
> 0x0000000000000000-0x0000000236ffffff]
> Jan 21 02:26:48 staropramen kernel: NODE_DATA(0) allocated [mem
> 0x236ffa000-0x236ffdfff]
> Jan 21 02:26:48 staropramen kernel: Zone ranges:
> Jan 21 02:26:48 staropramen kernel:   DMA      [mem
> 0x0000000000001000-0x0000000000ffffff]
> Jan 21 02:26:48 staropramen kernel:   DMA32    [mem
> 0x0000000001000000-0x00000000ffffffff]
> Jan 21 02:26:48 staropramen kernel:   Normal   [mem
> 0x0000000100000000-0x0000000236ffffff]
> Jan 21 02:26:48 staropramen kernel:   Device   empty
> Jan 21 02:26:48 staropramen kernel: Movable zone start for each node
> Jan 21 02:26:48 staropramen kernel: Early memory node ranges
> Jan 21 02:26:48 staropramen kernel:   node   0: [mem
> 0x0000000000001000-0x0000000000057fff]
> Jan 21 02:26:48 staropramen kernel:   node   0: [mem
> 0x0000000000059000-0x000000000009efff]
> Jan 21 02:26:48 staropramen kernel:   node   0: [mem
> 0x0000000000100000-0x00000000b3f70fff]
> Jan 21 02:26:48 staropramen kernel:   node   0: [mem
> 0x00000000b3fa8000-0x00000000b4357fff]
> Jan 21 02:26:48 staropramen kernel:   node   0: [mem
> 0x00000000b435a000-0x00000000c10a0fff]
> Jan 21 02:26:48 staropramen kernel:   node   0: [mem
> 0x00000000c290d000-0x00000000c2a08fff]
> Jan 21 02:26:48 staropramen kernel:   node   0: [mem
> 0x00000000c33a2000-0x00000000c33fffff]
> Jan 21 02:26:48 staropramen kernel:   node   0: [mem
> 0x0000000100000000-0x0000000236ffffff]
> Jan 21 02:26:48 staropramen kernel: Zeroed struct page in unavailable
> ranges: 32417 pages
> Jan 21 02:26:48 staropramen kernel: Initmem setup node 0 [mem
> 0x0000000000001000-0x0000000236ffffff]
> Jan 21 02:26:48 staropramen kernel: On node 0 totalpages: 2064735
> Jan 21 02:26:48 staropramen kernel:   DMA zone: 64 pages used for memmap
> Jan 21 02:26:48 staropramen kernel:   DMA zone: 27 pages reserved
> Jan 21 02:26:48 staropramen kernel:   DMA zone: 3997 pages, LIFO batch:0
> Jan 21 02:26:48 staropramen kernel:   DMA32 zone: 12296 pages used for
> memmap
> Jan 21 02:26:48 staropramen kernel:   DMA32 zone: 786882 pages, LIFO
> batch:63
> Jan 21 02:26:48 staropramen kernel:   Normal zone: 19904 pages used for
> memmap
> Jan 21 02:26:48 staropramen kernel:   Normal zone: 1273856 pages, LIFO
> batch:63
> Jan 21 02:26:48 staropramen kernel: Reserving Intel graphics memory at [mem
> 0xc4000000-0xc7ffffff]
> Jan 21 02:26:48 staropramen kernel: ACPI: PM-Timer IO Port: 0x1808
> Jan 21 02:26:48 staropramen kernel: ACPI: Local APIC address 0xfee00000
> Jan 21 02:26:48 staropramen kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge
> lint[0x1])
> Jan 21 02:26:48 staropramen kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge
> lint[0x1])
> Jan 21 02:26:48 staropramen kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge
> lint[0x1])
> Jan 21 02:26:48 staropramen kernel: ACPI: LAPIC_NMI (acpi_id[0x04] high edge
> lint[0x1])
> Jan 21 02:26:48 staropramen kernel: IOAPIC[0]: apic_id 2, version 32,
> address 0xfec00000, GSI 0-119
> Jan 21 02:26:48 staropramen kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
> global_irq 2 dfl dfl)
> Jan 21 02:26:48 staropramen kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
> global_irq 9 high level)
> Jan 21 02:26:48 staropramen kernel: ACPI: IRQ0 used by override.
> Jan 21 02:26:48 staropramen kernel: ACPI: IRQ9 used by override.
> Jan 21 02:26:48 staropramen kernel: Using ACPI (MADT) for SMP configuration
> information
> Jan 21 02:26:48 staropramen kernel: ACPI: HPET id: 0x8086a201 base:
> 0xfed00000
> Jan 21 02:26:48 staropramen kernel: e820: update [mem 0xbde38000-0xbde7dfff]
> usable ==> reserved
> Jan 21 02:26:48 staropramen kernel: TSC deadline timer available
> Jan 21 02:26:48 staropramen kernel: smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0x00000000-0x00000fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0x00058000-0x00058fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0x0009f000-0x000fffff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xb3f71000-0xb3fa7fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xb4358000-0xb4358fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xb4359000-0xb4359fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xbde38000-0xbde7dfff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xbece6000-0xbece6fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xc10a1000-0xc28f8fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xc28f9000-0xc290cfff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xc2a09000-0xc2d30fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xc2d31000-0xc3330fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xc3331000-0xc33a1fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xc3400000-0xc7ffffff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xc8000000-0xf7ffffff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xf8000000-0xfbffffff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xfc000000-0xfdffffff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xfe000000-0xfe010fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xfe011000-0xfebfffff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xfec00000-0xfec00fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xfec01000-0xfecfffff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xfed00000-0xfed00fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xfed01000-0xfedfffff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xfee00000-0xfee00fff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xfee01000-0xfeffffff]
> Jan 21 02:26:48 staropramen kernel: PM: hibernation: Registered nosave
> memory: [mem 0xff000000-0xffffffff]
> Jan 21 02:26:48 staropramen kernel: [mem 0xc8000000-0xf7ffffff] available
> for PCI devices
> Jan 21 02:26:48 staropramen kernel: Booting paravirtualized kernel on bare
> hardware
> Jan 21 02:26:48 staropramen kernel: clocksource: refined-jiffies: mask:
> 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
> Jan 21 02:26:48 staropramen kernel: setup_percpu: NR_CPUS:320
> nr_cpumask_bits:320 nr_cpu_ids:4 nr_node_ids:1
> Jan 21 02:26:48 staropramen kernel: percpu: Embedded 56 pages/cpu s192512
> r8192 d28672 u524288
> Jan 21 02:26:48 staropramen kernel: pcpu-alloc: s192512 r8192 d28672 u524288
> alloc=1*2097152
> Jan 21 02:26:48 staropramen kernel: pcpu-alloc: [0] 0 1 2 3
> Jan 21 02:26:48 staropramen kernel: Built 1 zonelists, mobility grouping on.
> Total pages: 2032444
> Jan 21 02:26:48 staropramen kernel: Policy zone: Normal
> Jan 21 02:26:48 staropramen kernel: Kernel command line:
> BOOT_IMAGE=/@root/boot/vmlinuz-linux
> root=UUID=7ad0f342-b9e9-47df-90a7-e383d955862f rw rootflags=subvol=@root
> loglevel=3 quiet
> Jan 21 02:26:48 staropramen kernel: Dentry cache hash table entries: 1048576
> (order: 11, 8388608 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: Inode-cache hash table entries: 524288
> (order: 10, 4194304 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: mem auto-init: stack:byref_all(zero),
> heap alloc:on, heap free:off
> Jan 21 02:26:48 staropramen kernel: Memory: 7785472K/8258940K available
> (14344K kernel code, 2040K rwdata, 8856K rodata, 1716K init, 4288K bss,
> 473208K reserved, 0K cma-reserved)
> Jan 21 02:26:48 staropramen kernel: random: get_random_u64 called from
> __kmem_cache_create+0x26/0x520 with crng_init=0
> Jan 21 02:26:48 staropramen kernel: SLUB: HWalign=64, Order=0-3,
> MinObjects=0, CPUs=4, Nodes=1
> Jan 21 02:26:48 staropramen kernel: Kernel/User page tables isolation:
> enabled
> Jan 21 02:26:48 staropramen kernel: ftrace: allocating 41846 entries in 164
> pages
> Jan 21 02:26:48 staropramen kernel: ftrace: allocated 164 pages with 3
> groups
> Jan 21 02:26:48 staropramen kernel: rcu: Preemptible hierarchical RCU
> implementation.
> Jan 21 02:26:48 staropramen kernel: rcu:         RCU dyntick-idle
> grace-period acceleration is enabled.
> Jan 21 02:26:48 staropramen kernel: rcu:         RCU restricting CPUs from
> NR_CPUS=320 to nr_cpu_ids=4.
> Jan 21 02:26:48 staropramen kernel: rcu:         RCU priority boosting:
> priority 1 delay 500 ms.
> Jan 21 02:26:48 staropramen kernel:         Trampoline variant of Tasks RCU
> enabled.
> Jan 21 02:26:48 staropramen kernel:         Rude variant of Tasks RCU
> enabled.
> Jan 21 02:26:48 staropramen kernel:         Tracing variant of Tasks RCU
> enabled.
> Jan 21 02:26:48 staropramen kernel: rcu: RCU calculated value of
> scheduler-enlistment delay is 30 jiffies.
> Jan 21 02:26:48 staropramen kernel: rcu: Adjusting geometry for
> rcu_fanout_leaf=16, nr_cpu_ids=4
> Jan 21 02:26:48 staropramen kernel: NR_IRQS: 20736, nr_irqs: 1024,
> preallocated irqs: 16
> Jan 21 02:26:48 staropramen kernel: Console: colour dummy device 80x25
> Jan 21 02:26:48 staropramen kernel: printk: console [tty0] enabled
> Jan 21 02:26:48 staropramen kernel: ACPI: Core revision 20200925
> Jan 21 02:26:48 staropramen kernel: clocksource: hpet: mask: 0xffffffff
> max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> Jan 21 02:26:48 staropramen kernel: APIC: Switch to symmetric I/O mode setup
> Jan 21 02:26:48 staropramen kernel: x2apic: IRQ remapping doesn't support
> X2APIC mode
> Jan 21 02:26:48 staropramen kernel: ..TIMER: vector=0x30 apic1=0 pin1=2
> apic2=-1 pin2=-1
> Jan 21 02:26:48 staropramen kernel: clocksource: tsc-early: mask:
> 0xffffffffffffffff max_cycles: 0x3272fd97217, max_idle_ns: 440795241220 ns
> Jan 21 02:26:48 staropramen kernel: Calibrating delay loop (skipped), value
> calculated using timer frequency.. 7002.48 BogoMIPS (lpj=11666373)
> Jan 21 02:26:48 staropramen kernel: pid_max: default: 32768 minimum: 301
> Jan 21 02:26:48 staropramen kernel: LSM: Security Framework initializing
> Jan 21 02:26:48 staropramen kernel: Yama: becoming mindful.
> Jan 21 02:26:48 staropramen kernel: Mount-cache hash table entries: 16384
> (order: 5, 131072 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: Mountpoint-cache hash table entries:
> 16384 (order: 5, 131072 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: x86/cpu: VMX (outside TXT) disabled by
> BIOS
> Jan 21 02:26:48 staropramen kernel: mce: CPU0: Thermal monitoring enabled
> (TM1)
> Jan 21 02:26:48 staropramen kernel: process: using mwait in idle threads
> Jan 21 02:26:48 staropramen kernel: Last level iTLB entries: 4KB 64, 2MB 8,
> 4MB 8
> Jan 21 02:26:48 staropramen kernel: Last level dTLB entries: 4KB 64, 2MB 0,
> 4MB 0, 1GB 4
> Jan 21 02:26:48 staropramen kernel: Spectre V1 : Mitigation: usercopy/swapgs
> barriers and __user pointer sanitization
> Jan 21 02:26:48 staropramen kernel: Spectre V2 : Mitigation: Full generic
> retpoline
> Jan 21 02:26:48 staropramen kernel: Spectre V2 : Spectre v2 / SpectreRSB
> mitigation: Filling RSB on context switch
> Jan 21 02:26:48 staropramen kernel: Spectre V2 : Enabling Restricted
> Speculation for firmware calls
> Jan 21 02:26:48 staropramen kernel: Spectre V2 : mitigation: Enabling
> conditional Indirect Branch Prediction Barrier
> Jan 21 02:26:48 staropramen kernel: Spectre V2 : User space: Mitigation:
> STIBP via seccomp and prctl
> Jan 21 02:26:48 staropramen kernel: Speculative Store Bypass: Mitigation:
> Speculative Store Bypass disabled via prctl and seccomp
> Jan 21 02:26:48 staropramen kernel: SRBDS: Mitigation: Microcode
> Jan 21 02:26:48 staropramen kernel: MDS: Mitigation: Clear CPU buffers
> Jan 21 02:26:48 staropramen kernel: Freeing SMP alternatives memory: 36K
> Jan 21 02:26:48 staropramen kernel: smpboot: CPU0: Intel(R) Pentium(R) CPU
> G4560 @ 3.50GHz (family: 0x6, model: 0x9e, stepping: 0x9)
> Jan 21 02:26:48 staropramen kernel: Performance Events: PEBS fmt3+, Skylake
> events, 32-deep LBR, full-width counters, Intel PMU driver.
> Jan 21 02:26:48 staropramen kernel: ... version:                4
> Jan 21 02:26:48 staropramen kernel: ... bit width:              48
> Jan 21 02:26:48 staropramen kernel: ... generic registers:      4
> Jan 21 02:26:48 staropramen kernel: ... value mask:
> 0000ffffffffffff
> Jan 21 02:26:48 staropramen kernel: ... max period:
> 00007fffffffffff
> Jan 21 02:26:48 staropramen kernel: ... fixed-purpose events:   3
> Jan 21 02:26:48 staropramen kernel: ... event mask:
> 000000070000000f
> Jan 21 02:26:48 staropramen kernel: rcu: Hierarchical SRCU implementation.
> Jan 21 02:26:48 staropramen kernel: NMI watchdog: Enabled. Permanently
> consumes one hw-PMU counter.
> Jan 21 02:26:48 staropramen kernel: smp: Bringing up secondary CPUs ...
> Jan 21 02:26:48 staropramen kernel: x86: Booting SMP configuration:
> Jan 21 02:26:48 staropramen kernel: .... node  #0, CPUs:      #1 #2
> Jan 21 02:26:48 staropramen kernel: MDS CPU bug present and SMT on, data
> leak possible. See
> https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more
> details.
> Jan 21 02:26:48 staropramen kernel:  #3
> Jan 21 02:26:48 staropramen kernel: smp: Brought up 1 node, 4 CPUs
> Jan 21 02:26:48 staropramen kernel: smpboot: Max logical packages: 1
> Jan 21 02:26:48 staropramen kernel: smpboot: Total of 4 processors activated
> (28010.93 BogoMIPS)
> Jan 21 02:26:48 staropramen kernel: devtmpfs: initialized
> Jan 21 02:26:48 staropramen kernel: x86/mm: Memory block size: 128MB
> Jan 21 02:26:48 staropramen kernel: PM: Registering ACPI NVS region [mem
> 0xb4358000-0xb4358fff] (4096 bytes)
> Jan 21 02:26:48 staropramen kernel: PM: Registering ACPI NVS region [mem
> 0xc2a09000-0xc2d30fff] (3309568 bytes)
> Jan 21 02:26:48 staropramen kernel: clocksource: jiffies: mask: 0xffffffff
> max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
> Jan 21 02:26:48 staropramen kernel: futex hash table entries: 1024 (order:
> 4, 65536 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: pinctrl core: initialized pinctrl
> subsystem
> Jan 21 02:26:48 staropramen kernel: PM: RTC time: 01:26:45, date: 2021-01-21
> Jan 21 02:26:48 staropramen kernel: NET: Registered protocol family 16
> Jan 21 02:26:48 staropramen kernel: DMA: preallocated 1024 KiB GFP_KERNEL
> pool for atomic allocations
> Jan 21 02:26:48 staropramen kernel: DMA: preallocated 1024 KiB
> GFP_KERNEL|GFP_DMA pool for atomic allocations
> Jan 21 02:26:48 staropramen kernel: DMA: preallocated 1024 KiB
> GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> Jan 21 02:26:48 staropramen kernel: audit: initializing netlink subsys
> (disabled)
> Jan 21 02:26:48 staropramen kernel: audit: type=2000
> audit(1611192405.029:1): state=initialized audit_enabled=0 res=1
> Jan 21 02:26:48 staropramen kernel: thermal_sys: Registered thermal governor
> 'fair_share'
> Jan 21 02:26:48 staropramen kernel: thermal_sys: Registered thermal governor
> 'bang_bang'
> Jan 21 02:26:48 staropramen kernel: thermal_sys: Registered thermal governor
> 'step_wise'
> Jan 21 02:26:48 staropramen kernel: thermal_sys: Registered thermal governor
> 'user_space'
> Jan 21 02:26:48 staropramen kernel: thermal_sys: Registered thermal governor
> 'power_allocator'
> Jan 21 02:26:48 staropramen kernel: cpuidle: using governor ladder
> Jan 21 02:26:48 staropramen kernel: cpuidle: using governor menu
> Jan 21 02:26:48 staropramen kernel: ACPI FADT declares the system doesn't
> support PCIe ASPM, so disable it
> Jan 21 02:26:48 staropramen kernel: ACPI: bus type PCI registered
> Jan 21 02:26:48 staropramen kernel: acpiphp: ACPI Hot Plug PCI Controller
> Driver version: 0.5
> Jan 21 02:26:48 staropramen kernel: PCI: MMCONFIG for domain 0000 [bus
> 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
> Jan 21 02:26:48 staropramen kernel: PCI: MMCONFIG at [mem
> 0xf8000000-0xfbffffff] reserved in E820
> Jan 21 02:26:48 staropramen kernel: PCI: Using configuration type 1 for base
> access
> Jan 21 02:26:48 staropramen kernel: HugeTLB registered 1.00 GiB page size,
> pre-allocated 0 pages
> Jan 21 02:26:48 staropramen kernel: HugeTLB registered 2.00 MiB page size,
> pre-allocated 0 pages
> Jan 21 02:26:48 staropramen kernel: ACPI: Added _OSI(Module Device)
> Jan 21 02:26:48 staropramen kernel: ACPI: Added _OSI(Processor Device)
> Jan 21 02:26:48 staropramen kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
> Jan 21 02:26:48 staropramen kernel: ACPI: Added _OSI(Processor Aggregator
> Device)
> Jan 21 02:26:48 staropramen kernel: ACPI: Added _OSI(Linux-Dell-Video)
> Jan 21 02:26:48 staropramen kernel: ACPI: Added
> _OSI(Linux-Lenovo-NV-HDMI-Audio)
> Jan 21 02:26:48 staropramen kernel: ACPI: Added
> _OSI(Linux-HPI-Hybrid-Graphics)
> Jan 21 02:26:48 staropramen kernel: ACPI: 12 ACPI AML tables successfully
> acquired and loaded
> Jan 21 02:26:48 staropramen kernel: ACPI: Dynamic OEM Table Load:
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0xFFFF91B600908800 000717
> (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: \_PR_.CPU0: _OSC native thermal
> LVT Acked
> Jan 21 02:26:48 staropramen kernel: ACPI: Dynamic OEM Table Load:
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0xFFFF91B600C1F800 0003FF
> (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: Dynamic OEM Table Load:
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0xFFFF91B60090D000 00065C
> (v02 PmRef  ApIst    00003000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: Dynamic OEM Table Load:
> Jan 21 02:26:48 staropramen kernel: ACPI: SSDT 0xFFFF91B600D2C800 00018A
> (v02 PmRef  ApCst    00003000 INTL 20160422)
> Jan 21 02:26:48 staropramen kernel: ACPI: Interpreter enabled
> Jan 21 02:26:48 staropramen kernel: ACPI: (supports S0 S3 S4 S5)
> Jan 21 02:26:48 staropramen kernel: ACPI: Using IOAPIC for interrupt routing
> Jan 21 02:26:48 staropramen kernel: PCI: Using host bridge windows from
> ACPI; if necessary, use "pci=nocrs" and report a bug
> Jan 21 02:26:48 staropramen kernel: ACPI: Enabled 6 GPEs in block 00 to 7F
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [PG00] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [PG01] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [PG02] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [WRST] (on)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [FN00] (off)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [FN01] (off)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [FN02] (off)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [FN03] (off)
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Resource [FN04] (off)
> Jan 21 02:26:48 staropramen kernel: ACPI: PCI Root Bridge [PCI0] (domain
> 0000 [bus 00-3e])
> Jan 21 02:26:48 staropramen kernel: acpi PNP0A08:00: _OSC: OS supports
> [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> Jan 21 02:26:48 staropramen kernel: acpi PNP0A08:00: _OSC: platform does not
> support [PCIeHotplug SHPCHotplug PME]
> Jan 21 02:26:48 staropramen kernel: acpi PNP0A08:00: _OSC: OS now controls
> [AER PCIeCapability LTR DPC]
> Jan 21 02:26:48 staropramen kernel: acpi PNP0A08:00: FADT indicates ASPM is
> unsupported, using BIOS configuration
> Jan 21 02:26:48 staropramen kernel: PCI host bridge to bus 0000:00
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: root bus resource [io
> 0x0000-0x0cf7 window]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: root bus resource [io
> 0x0d00-0xffff window]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: root bus resource [mem
> 0x000a0000-0x000bffff window]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: root bus resource [mem
> 0xc8000000-0xf7ffffff window]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: root bus resource [mem
> 0xfd000000-0xfe7fffff window]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: root bus resource [bus
> 00-3e]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:00.0: [8086:590f] type 00
> class 0x060000
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:01.0: [8086:1901] type 01
> class 0x060400
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:01.0: PME# supported from D0
> D3hot D3cold
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:02.0: [8086:5902] type 00
> class 0x030000
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:02.0: reg 0x10: [mem
> 0xf6000000-0xf6ffffff 64bit]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:02.0: reg 0x18: [mem
> 0xe0000000-0xefffffff 64bit pref]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:02.0: reg 0x20: [io
> 0xf000-0xf03f]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:02.0: BAR 2: assigned to
> efifb
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:14.0: [8086:a2af] type 00
> class 0x0c0330
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:14.0: reg 0x10: [mem
> 0xf7310000-0xf731ffff 64bit]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:14.0: PME# supported from
> D3hot D3cold
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:16.0: [8086:a2ba] type 00
> class 0x078000
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:16.0: reg 0x10: [mem
> 0xf732d000-0xf732dfff 64bit]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:16.0: PME# supported from
> D3hot
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:17.0: [8086:a282] type 00
> class 0x010601
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:17.0: reg 0x10: [mem
> 0xf7328000-0xf7329fff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:17.0: reg 0x14: [mem
> 0xf732c000-0xf732c0ff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:17.0: reg 0x18: [io
> 0xf090-0xf097]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:17.0: reg 0x1c: [io
> 0xf080-0xf083]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:17.0: reg 0x20: [io
> 0xf060-0xf07f]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:17.0: reg 0x24: [mem
> 0xf732b000-0xf732b7ff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:17.0: PME# supported from
> D3hot
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1b.0: [8086:a2eb] type 01
> class 0x060400
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1b.0: PME# supported from D0
> D3hot D3cold
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0: [8086:a294] type 01
> class 0x060400
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0: PME# supported from D0
> D3hot D3cold
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.5: [8086:a295] type 01
> class 0x060400
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.5: PME# supported from D0
> D3hot D3cold
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.7: [8086:a297] type 01
> class 0x060400
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.7: PME# supported from D0
> D3hot D3cold
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0: [8086:a298] type 01
> class 0x060400
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0: PME# supported from D0
> D3hot D3cold
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1f.0: [8086:a2c8] type 00
> class 0x060100
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1f.2: [8086:a2a1] type 00
> class 0x058000
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1f.2: reg 0x10: [mem
> 0xf7324000-0xf7327fff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1f.3: [8086:a2f0] type 00
> class 0x040300
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1f.3: reg 0x10: [mem
> 0xf7320000-0xf7323fff 64bit]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1f.3: reg 0x20: [mem
> 0xf7300000-0xf730ffff 64bit]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1f.3: PME# supported from
> D3hot D3cold
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1f.4: [8086:a2a3] type 00
> class 0x0c0500
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1f.4: reg 0x10: [mem
> 0xf732a000-0xf732a0ff 64bit]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1f.4: reg 0x20: [io
> 0xf040-0xf05f]
> Jan 21 02:26:48 staropramen kernel: pci 0000:01:00.0: [1344:5410] type 00
> class 0x010802
> Jan 21 02:26:48 staropramen kernel: pci 0000:01:00.0: reg 0x10: [mem
> 0xf7200000-0xf7203fff 64bit]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:01.0:   bridge window [mem
> 0xf7200000-0xf72fffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:02:00.0: [144d:a802] type 00
> class 0x010802
> Jan 21 02:26:48 staropramen kernel: pci 0000:02:00.0: reg 0x10: [mem
> 0xf7100000-0xf7103fff 64bit]
> Jan 21 02:26:48 staropramen kernel: pci 0000:02:00.0: reg 0x18: [io
> 0xe000-0xe0ff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1b.0: PCI bridge to [bus 02]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1b.0:   bridge window [io
> 0xe000-0xefff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1b.0:   bridge window [mem
> 0xf7100000-0xf71fffff]
> Jan 21 02:26:48 staropramen kernel: acpiphp: Slot [1] registered
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0: PCI bridge to [bus 03]
> Jan 21 02:26:48 staropramen kernel: pci 0000:04:00.0: [8086:10d3] type 00
> class 0x020000
> Jan 21 02:26:48 staropramen kernel: pci 0000:04:00.0: reg 0x10: [mem
> 0xf70c0000-0xf70dffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:04:00.0: reg 0x14: [mem
> 0xf7000000-0xf707ffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:04:00.0: reg 0x18: [io
> 0xd000-0xd01f]
> Jan 21 02:26:48 staropramen kernel: pci 0000:04:00.0: reg 0x1c: [mem
> 0xf70e0000-0xf70e3fff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:04:00.0: reg 0x30: [mem
> 0xf7080000-0xf70bffff pref]
> Jan 21 02:26:48 staropramen kernel: pci 0000:04:00.0: PME# supported from D0
> D3hot D3cold
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.5: PCI bridge to [bus 04]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.5:   bridge window [io
> 0xd000-0xdfff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.5:   bridge window [mem
> 0xf7000000-0xf70fffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.7: PCI bridge to [bus 05]
> Jan 21 02:26:48 staropramen kernel: acpiphp: Slot [1-1] registered
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0: PCI bridge to [bus 06]
> Jan 21 02:26:48 staropramen kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3
> 4 5 6 10 *11 12 14 15)
> Jan 21 02:26:48 staropramen kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3
> 4 5 6 *10 11 12 14 15)
> Jan 21 02:26:48 staropramen kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3
> 4 5 6 10 *11 12 14 15)
> Jan 21 02:26:48 staropramen kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3
> 4 5 6 10 *11 12 14 15)
> Jan 21 02:26:48 staropramen kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3
> 4 5 6 10 *11 12 14 15)
> Jan 21 02:26:48 staropramen kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3
> 4 5 6 10 *11 12 14 15)
> Jan 21 02:26:48 staropramen kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3
> 4 5 6 10 *11 12 14 15)
> Jan 21 02:26:48 staropramen kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3
> 4 5 6 10 *11 12 14 15)
> Jan 21 02:26:48 staropramen kernel: iommu: Default domain type: Translated
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:02.0: vgaarb: setting as
> boot VGA device
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:02.0: vgaarb: VGA device
> added: decodes=io+mem,owns=io+mem,locks=none
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:02.0: vgaarb: bridge control
> possible
> Jan 21 02:26:48 staropramen kernel: vgaarb: loaded
> Jan 21 02:26:48 staropramen kernel: SCSI subsystem initialized
> Jan 21 02:26:48 staropramen kernel: libata version 3.00 loaded.
> Jan 21 02:26:48 staropramen kernel: ACPI: bus type USB registered
> Jan 21 02:26:48 staropramen kernel: usbcore: registered new interface driver
> usbfs
> Jan 21 02:26:48 staropramen kernel: usbcore: registered new interface driver
> hub
> Jan 21 02:26:48 staropramen kernel: usbcore: registered new device driver
> usb
> Jan 21 02:26:48 staropramen kernel: pps_core: LinuxPPS API ver. 1 registered
> Jan 21 02:26:48 staropramen kernel: pps_core: Software ver. 5.3.6 -
> Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> Jan 21 02:26:48 staropramen kernel: PTP clock support registered
> Jan 21 02:26:48 staropramen kernel: EDAC MC: Ver: 3.0.0
> Jan 21 02:26:48 staropramen kernel: Registered efivars operations
> Jan 21 02:26:48 staropramen kernel: NetLabel: Initializing
> Jan 21 02:26:48 staropramen kernel: NetLabel:  domain hash size = 128
> Jan 21 02:26:48 staropramen kernel: NetLabel:  protocols = UNLABELED CIPSOv4
> CALIPSO
> Jan 21 02:26:48 staropramen kernel: NetLabel:  unlabeled traffic allowed by
> default
> Jan 21 02:26:48 staropramen kernel: PCI: Using ACPI for IRQ routing
> Jan 21 02:26:48 staropramen kernel: PCI: pci_cache_line_size set to 64 bytes
> Jan 21 02:26:48 staropramen kernel: e820: reserve RAM buffer [mem
> 0x00058000-0x0005ffff]
> Jan 21 02:26:48 staropramen kernel: e820: reserve RAM buffer [mem
> 0x0009f000-0x0009ffff]
> Jan 21 02:26:48 staropramen kernel: e820: reserve RAM buffer [mem
> 0xb3f71000-0xb3ffffff]
> Jan 21 02:26:48 staropramen kernel: e820: reserve RAM buffer [mem
> 0xb4358000-0xb7ffffff]
> Jan 21 02:26:48 staropramen kernel: e820: reserve RAM buffer [mem
> 0xbde38000-0xbfffffff]
> Jan 21 02:26:48 staropramen kernel: e820: reserve RAM buffer [mem
> 0xbece6000-0xbfffffff]
> Jan 21 02:26:48 staropramen kernel: e820: reserve RAM buffer [mem
> 0xc10a1000-0xc3ffffff]
> Jan 21 02:26:48 staropramen kernel: e820: reserve RAM buffer [mem
> 0xc2a09000-0xc3ffffff]
> Jan 21 02:26:48 staropramen kernel: e820: reserve RAM buffer [mem
> 0xc3400000-0xc3ffffff]
> Jan 21 02:26:48 staropramen kernel: e820: reserve RAM buffer [mem
> 0x237000000-0x237ffffff]
> Jan 21 02:26:48 staropramen kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0,
> 0, 0, 0, 0, 0
> Jan 21 02:26:48 staropramen kernel: hpet0: 8 comparators, 64-bit 24.000000
> MHz counter
> Jan 21 02:26:48 staropramen kernel: clocksource: Switched to clocksource
> tsc-early
> Jan 21 02:26:48 staropramen kernel: VFS: Disk quotas dquot_6.6.0
> Jan 21 02:26:48 staropramen kernel: VFS: Dquot-cache hash table entries: 512
> (order 0, 4096 bytes)
> Jan 21 02:26:48 staropramen kernel: pnp: PnP ACPI init
> Jan 21 02:26:48 staropramen kernel: system 00:00: [io  0x0290-0x029f] has
> been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:00: Plug and Play ACPI device,
> IDs PNP0c02 (active)
> Jan 21 02:26:48 staropramen kernel: pnp 00:01: [dma 0 disabled]
> Jan 21 02:26:48 staropramen kernel: pnp 00:01: Plug and Play ACPI device,
> IDs PNP0400 (active)
> Jan 21 02:26:48 staropramen kernel: pnp 00:02: [dma 0 disabled]
> Jan 21 02:26:48 staropramen kernel: pnp 00:02: Plug and Play ACPI device,
> IDs PNP0501 (active)
> Jan 21 02:26:48 staropramen kernel: pnp 00:03: Plug and Play ACPI device,
> IDs PNP0303 PNP030b (active)
> Jan 21 02:26:48 staropramen kernel: system 00:04: [io  0x0680-0x069f] has
> been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:04: [io  0xffff] has been
> reserved
> Jan 21 02:26:48 staropramen kernel: system 00:04: [io  0xffff] has been
> reserved
> Jan 21 02:26:48 staropramen kernel: system 00:04: [io  0xffff] has been
> reserved
> Jan 21 02:26:48 staropramen kernel: system 00:04: [io  0x1800-0x18fe] has
> been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:04: [io  0x164e-0x164f] has
> been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:04: Plug and Play ACPI device,
> IDs PNP0c02 (active)
> Jan 21 02:26:48 staropramen kernel: system 00:05: [io  0x0800-0x087f] has
> been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:05: Plug and Play ACPI device,
> IDs PNP0c02 (active)
> Jan 21 02:26:48 staropramen kernel: pnp 00:06: Plug and Play ACPI device,
> IDs PNP0b00 (active)
> Jan 21 02:26:48 staropramen kernel: system 00:07: [io  0x1854-0x1857] has
> been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:07: Plug and Play ACPI device,
> IDs INT3f0d PNP0c02 (active)
> Jan 21 02:26:48 staropramen kernel: system 00:08: [mem
> 0xfed10000-0xfed17fff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:08: [mem
> 0xfed18000-0xfed18fff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:08: [mem
> 0xfed19000-0xfed19fff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:08: [mem
> 0xf8000000-0xfbffffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:08: [mem
> 0xfed20000-0xfed3ffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:08: [mem
> 0xfed90000-0xfed93fff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:08: [mem
> 0xfed45000-0xfed8ffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:08: [mem
> 0xff000000-0xffffffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:08: [mem
> 0xfee00000-0xfeefffff] could not be reserved
> Jan 21 02:26:48 staropramen kernel: system 00:08: [mem
> 0xf7fe0000-0xf7ffffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:08: Plug and Play ACPI device,
> IDs PNP0c02 (active)
> Jan 21 02:26:48 staropramen kernel: system 00:09: [mem
> 0xfd000000-0xfdabffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:09: [mem
> 0xfdad0000-0xfdadffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:09: [mem
> 0xfdac0000-0xfdacffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:09: [mem
> 0xfdae0000-0xfdaeffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:09: [mem
> 0xfdaf0000-0xfdafffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:09: [mem
> 0xfdb00000-0xfdffffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:09: [mem
> 0xfe000000-0xfe01ffff] could not be reserved
> Jan 21 02:26:48 staropramen kernel: system 00:09: [mem
> 0xfe036000-0xfe03bfff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:09: [mem
> 0xfe03d000-0xfe3fffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:09: [mem
> 0xfe410000-0xfe7fffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:09: Plug and Play ACPI device,
> IDs PNP0c02 (active)
> Jan 21 02:26:48 staropramen kernel: system 00:0a: [io  0xfe00-0xfefe] has
> been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:0a: Plug and Play ACPI device,
> IDs PNP0c02 (active)
> Jan 21 02:26:48 staropramen kernel: system 00:0b: [mem
> 0xfdaf0000-0xfdafffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:0b: [mem
> 0xfdae0000-0xfdaeffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:0b: [mem
> 0xfdac0000-0xfdacffff] has been reserved
> Jan 21 02:26:48 staropramen kernel: system 00:0b: Plug and Play ACPI device,
> IDs PNP0c02 (active)
> Jan 21 02:26:48 staropramen kernel: pnp: PnP ACPI: found 12 devices
> Jan 21 02:26:48 staropramen kernel: clocksource: acpi_pm: mask: 0xffffff
> max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> Jan 21 02:26:48 staropramen kernel: NET: Registered protocol family 2
> Jan 21 02:26:48 staropramen kernel: tcp_listen_portaddr_hash hash table
> entries: 4096 (order: 4, 65536 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: TCP established hash table entries:
> 65536 (order: 7, 524288 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: TCP bind hash table entries: 65536
> (order: 8, 1048576 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: TCP: Hash tables configured (established
> 65536 bind 65536)
> Jan 21 02:26:48 staropramen kernel: MPTCP token hash table entries: 8192
> (order: 5, 196608 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: UDP hash table entries: 4096 (order: 5,
> 131072 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: UDP-Lite hash table entries: 4096
> (order: 5, 131072 bytes, linear)
> Jan 21 02:26:48 staropramen kernel: NET: Registered protocol family 1
> Jan 21 02:26:48 staropramen kernel: NET: Registered protocol family 44
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0: bridge window [io
> 0x1000-0x0fff] to [bus 03] add_size 1000
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0: bridge window [mem
> 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align
> 100000
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0: bridge window [mem
> 0x00100000-0x000fffff] to [bus 03] add_size 200000 add_align 100000
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0: bridge window [io
> 0x1000-0x0fff] to [bus 06] add_size 1000
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0: bridge window [mem
> 0x00100000-0x000fffff 64bit pref] to [bus 06] add_size 200000 add_align
> 100000
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0: bridge window [mem
> 0x00100000-0x000fffff] to [bus 06] add_size 200000 add_align 100000
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0: BAR 14: assigned [mem
> 0xc8000000-0xc81fffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0: BAR 15: assigned [mem
> 0xc8200000-0xc83fffff 64bit pref]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0: BAR 14: assigned [mem
> 0xc8400000-0xc85fffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0: BAR 15: assigned [mem
> 0xc8600000-0xc87fffff 64bit pref]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0: BAR 13: assigned [io
> 0x2000-0x2fff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0: BAR 13: assigned [io
> 0x3000-0x3fff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:01.0:   bridge window [mem
> 0xf7200000-0xf72fffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1b.0: PCI bridge to [bus 02]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1b.0:   bridge window [io
> 0xe000-0xefff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1b.0:   bridge window [mem
> 0xf7100000-0xf71fffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0: PCI bridge to [bus 03]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0:   bridge window [io
> 0x2000-0x2fff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0:   bridge window [mem
> 0xc8000000-0xc81fffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.0:   bridge window [mem
> 0xc8200000-0xc83fffff 64bit pref]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.5: PCI bridge to [bus 04]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.5:   bridge window [io
> 0xd000-0xdfff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.5:   bridge window [mem
> 0xf7000000-0xf70fffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1c.7: PCI bridge to [bus 05]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0: PCI bridge to [bus 06]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0:   bridge window [io
> 0x3000-0x3fff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0:   bridge window [mem
> 0xc8400000-0xc85fffff]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:1d.0:   bridge window [mem
> 0xc8600000-0xc87fffff 64bit pref]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: resource 4 [io
> 0x0000-0x0cf7 window]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: resource 5 [io
> 0x0d00-0xffff window]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: resource 6 [mem
> 0x000a0000-0x000bffff window]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: resource 7 [mem
> 0xc8000000-0xf7ffffff window]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:00: resource 8 [mem
> 0xfd000000-0xfe7fffff window]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:01: resource 1 [mem
> 0xf7200000-0xf72fffff]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:02: resource 0 [io
> 0xe000-0xefff]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:02: resource 1 [mem
> 0xf7100000-0xf71fffff]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:03: resource 0 [io
> 0x2000-0x2fff]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:03: resource 1 [mem
> 0xc8000000-0xc81fffff]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:03: resource 2 [mem
> 0xc8200000-0xc83fffff 64bit pref]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:04: resource 0 [io
> 0xd000-0xdfff]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:04: resource 1 [mem
> 0xf7000000-0xf70fffff]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:06: resource 0 [io
> 0x3000-0x3fff]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:06: resource 1 [mem
> 0xc8400000-0xc85fffff]
> Jan 21 02:26:48 staropramen kernel: pci_bus 0000:06: resource 2 [mem
> 0xc8600000-0xc87fffff 64bit pref]
> Jan 21 02:26:48 staropramen kernel: pci 0000:00:02.0: Video device with
> shadowed ROM at [mem 0x000c0000-0x000dffff]
> Jan 21 02:26:48 staropramen kernel: PCI: CLS 64 bytes, default 64
> Jan 21 02:26:48 staropramen kernel: Trying to unpack rootfs image as
> initramfs...
> Jan 21 02:26:48 staropramen kernel: Freeing initrd memory: 11976K
> Jan 21 02:26:48 staropramen kernel: PCI-DMA: Using software bounce buffering
> for IO (SWIOTLB)
> Jan 21 02:26:48 staropramen kernel: software IO TLB: mapped [mem
> 0x00000000aff71000-0x00000000b3f71000] (64MB)
> Jan 21 02:26:48 staropramen kernel: check: Scanning for low memory
> corruption every 60 seconds
> Jan 21 02:26:48 staropramen kernel: Initialise system trusted keyrings
> Jan 21 02:26:48 staropramen kernel: Key type blacklist registered
> Jan 21 02:26:48 staropramen kernel: workingset: timestamp_bits=41
> max_order=21 bucket_order=0
> Jan 21 02:26:48 staropramen kernel: zbud: loaded
> Jan 21 02:26:48 staropramen kernel: Key type asymmetric registered
> Jan 21 02:26:48 staropramen kernel: Asymmetric key parser 'x509' registered
> Jan 21 02:26:48 staropramen kernel: Block layer SCSI generic (bsg) driver
> version 0.4 loaded (major 243)
> Jan 21 02:26:48 staropramen kernel: io scheduler mq-deadline registered
> Jan 21 02:26:48 staropramen kernel: io scheduler kyber registered
> Jan 21 02:26:48 staropramen kernel: io scheduler bfq registered
> Jan 21 02:26:48 staropramen kernel: atomic64_test: passed for x86-64
> platform with CX8 and with SSE
> Jan 21 02:26:48 staropramen kernel: pcieport 0000:00:1b.0: AER: enabled with
> IRQ 121
> Jan 21 02:26:48 staropramen kernel: pcieport 0000:00:1c.5: AER: enabled with
> IRQ 123
> Jan 21 02:26:48 staropramen kernel: pcieport 0000:00:1c.7: AER: enabled with
> IRQ 124
> Jan 21 02:26:48 staropramen kernel: shpchp: Standard Hot Plug PCI Controller
> Driver version: 0.4
> Jan 21 02:26:48 staropramen kernel: efifb: probing for efifb
> Jan 21 02:26:48 staropramen kernel: efifb: showing boot graphics
> Jan 21 02:26:48 staropramen kernel: efifb: framebuffer at 0xe0000000, using
> 3072k, total 3072k
> Jan 21 02:26:48 staropramen kernel: efifb: mode is 1024x768x32,
> linelength=4096, pages=1
> Jan 21 02:26:48 staropramen kernel: efifb: scrolling: redraw
> Jan 21 02:26:48 staropramen kernel: efifb: Truecolor: size=8:8:8:8,
> shift=24:16:8:0
> Jan 21 02:26:48 staropramen kernel: fbcon: Deferring console take-over
> Jan 21 02:26:48 staropramen kernel: fb0: EFI VGA frame buffer device
> Jan 21 02:26:48 staropramen kernel: intel_idle: MWAIT substates: 0x142120
> Jan 21 02:26:48 staropramen kernel: intel_idle: v0.5.1 model 0x9E
> Jan 21 02:26:48 staropramen kernel: intel_idle: Local APIC timer is reliable
> in all C-states
> Jan 21 02:26:48 staropramen kernel: input: Sleep Button as
> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
> Jan 21 02:26:48 staropramen kernel: ACPI: Sleep Button [SLPB]
> Jan 21 02:26:48 staropramen kernel: input: Power Button as
> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Button [PWRB]
> Jan 21 02:26:48 staropramen kernel: input: Power Button as
> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> Jan 21 02:26:48 staropramen kernel: ACPI: Power Button [PWRF]
> Jan 21 02:26:48 staropramen kernel: thermal LNXTHERM:00: registered as
> thermal_zone0
> Jan 21 02:26:48 staropramen kernel: ACPI: Thermal Zone [TZ00] (28 C)
> Jan 21 02:26:48 staropramen kernel: thermal LNXTHERM:01: registered as
> thermal_zone1
> Jan 21 02:26:48 staropramen kernel: ACPI: Thermal Zone [TZ01] (30 C)
> Jan 21 02:26:48 staropramen kernel: Serial: 8250/16550 driver, 32 ports, IRQ
> sharing enabled
> Jan 21 02:26:48 staropramen kernel: 00:02: ttyS0 at I/O 0x3f8 (irq = 4,
> base_baud = 115200) is a 16550A
> Jan 21 02:26:48 staropramen kernel: Non-volatile memory driver v1.3
> Jan 21 02:26:48 staropramen kernel: AMD-Vi: AMD IOMMUv2 driver by Joerg
> Roedel <jroedel@suse.de>
> Jan 21 02:26:48 staropramen kernel: AMD-Vi: AMD IOMMUv2 functionality not
> available on this system
> Jan 21 02:26:48 staropramen kernel: nvme nvme0: pci function 0000:01:00.0
> Jan 21 02:26:48 staropramen kernel: nvme nvme1: pci function 0000:02:00.0
> Jan 21 02:26:48 staropramen kernel: ahci 0000:00:17.0: version 3.0
> Jan 21 02:26:48 staropramen kernel: ahci 0000:00:17.0: AHCI 0001.0301 32
> slots 6 ports 6 Gbps 0x3f impl SATA mode
> Jan 21 02:26:48 staropramen kernel: ahci 0000:00:17.0: flags: 64bit ncq sntf
> led clo only pio slum part ems deso sadm sds apst
> Jan 21 02:26:48 staropramen kernel: nvme nvme1: 4/0/0 default/read/poll
> queues
> Jan 21 02:26:48 staropramen kernel:  nvme1n1: p1 p2
> Jan 21 02:26:48 staropramen kernel: nvme nvme0: 4/0/0 default/read/poll
> queues
> Jan 21 02:26:48 staropramen kernel: scsi host0: ahci
> Jan 21 02:26:48 staropramen kernel: scsi host1: ahci
> Jan 21 02:26:48 staropramen kernel: scsi host2: ahci
> Jan 21 02:26:48 staropramen kernel: scsi host3: ahci
> Jan 21 02:26:48 staropramen kernel: scsi host4: ahci
> Jan 21 02:26:48 staropramen kernel: scsi host5: ahci
> Jan 21 02:26:48 staropramen kernel: ata1: SATA max UDMA/133 abar
> m2048@0xf732b000 port 0xf732b100 irq 128
> Jan 21 02:26:48 staropramen kernel: ata2: SATA max UDMA/133 abar
> m2048@0xf732b000 port 0xf732b180 irq 128
> Jan 21 02:26:48 staropramen kernel: ata3: SATA max UDMA/133 abar
> m2048@0xf732b000 port 0xf732b200 irq 128
> Jan 21 02:26:48 staropramen kernel: ata4: SATA max UDMA/133 abar
> m2048@0xf732b000 port 0xf732b280 irq 128
> Jan 21 02:26:48 staropramen kernel: ata5: SATA max UDMA/133 abar
> m2048@0xf732b000 port 0xf732b300 irq 128
> Jan 21 02:26:48 staropramen kernel: ata6: SATA max UDMA/133 abar
> m2048@0xf732b000 port 0xf732b380 irq 128
> Jan 21 02:26:48 staropramen kernel: ehci_hcd: USB 2.0 'Enhanced' Host
> Controller (EHCI) Driver
> Jan 21 02:26:48 staropramen kernel: ehci-pci: EHCI PCI platform driver
> Jan 21 02:26:48 staropramen kernel: ohci_hcd: USB 1.1 'Open' Host Controller
> (OHCI) Driver
> Jan 21 02:26:48 staropramen kernel: ohci-pci: OHCI PCI platform driver
> Jan 21 02:26:48 staropramen kernel: uhci_hcd: USB Universal Host Controller
> Interface driver
> Jan 21 02:26:48 staropramen kernel: usbcore: registered new interface driver
> usbserial_generic
> Jan 21 02:26:48 staropramen kernel: usbserial: USB Serial support registered
> for generic
> Jan 21 02:26:48 staropramen kernel: i8042: PNP: PS/2 Controller
> [PNP0303:PS2K] at 0x60,0x64 irq 1
> Jan 21 02:26:48 staropramen kernel: i8042: PNP: PS/2 appears to have AUX
> port disabled, if this is incorrect please boot with i8042.nopnp
> Jan 21 02:26:48 staropramen kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> Jan 21 02:26:48 staropramen kernel: rtc_cmos 00:06: RTC can wake from S4
> Jan 21 02:26:48 staropramen kernel: rtc_cmos 00:06: registered as rtc0
> Jan 21 02:26:48 staropramen kernel: rtc_cmos 00:06: setting system clock to
> 2021-01-21T01:26:46 UTC (1611192406)
> Jan 21 02:26:48 staropramen kernel: rtc_cmos 00:06: alarms up to one month,
> y3k, 242 bytes nvram, hpet irqs
> Jan 21 02:26:48 staropramen kernel: intel_pstate: Intel P-state driver
> initializing
> Jan 21 02:26:48 staropramen kernel: intel_pstate: Disabling energy
> efficiency optimization
> Jan 21 02:26:48 staropramen kernel: intel_pstate: HWP enabled
> Jan 21 02:26:48 staropramen kernel: ledtrig-cpu: registered to indicate
> activity on CPUs
> Jan 21 02:26:48 staropramen kernel: input: AT Translated Set 2 keyboard as
> /devices/platform/i8042/serio0/input/input3
> Jan 21 02:26:48 staropramen kernel: pstore: Registered efi as persistent
> store backend
> Jan 21 02:26:48 staropramen kernel: hid: raw HID events driver (C) Jiri
> Kosina
> Jan 21 02:26:48 staropramen kernel: resource sanity check: requesting [mem
> 0xfdffe800-0xfe0007ff], which spans more than pnp 00:09 [mem
> 0xfdb00000-0xfdffffff]
> Jan 21 02:26:48 staropramen kernel: caller pmc_core_probe+0x85/0x380 mapping
> multiple BARs
> Jan 21 02:26:48 staropramen kernel: intel_pmc_core INT33A1:00:  initialized
> Jan 21 02:26:48 staropramen kernel: drop_monitor: Initializing network drop
> monitor service
> Jan 21 02:26:48 staropramen kernel: Initializing XFRM netlink socket
> Jan 21 02:26:48 staropramen kernel: NET: Registered protocol family 10
> Jan 21 02:26:48 staropramen kernel: Segment Routing with IPv6
> Jan 21 02:26:48 staropramen kernel: RPL Segment Routing with IPv6
> Jan 21 02:26:48 staropramen kernel: NET: Registered protocol family 17
> Jan 21 02:26:48 staropramen kernel: microcode: sig=0x906e9, pf=0x2,
> revision=0xde
> Jan 21 02:26:48 staropramen kernel: microcode: Microcode Update Driver:
> v2.2.
> Jan 21 02:26:48 staropramen kernel: IPI shorthand broadcast: enabled
> Jan 21 02:26:48 staropramen kernel: sched_clock: Marking stable (415979253,
> 499051)->(419934922, -3456618)
> Jan 21 02:26:48 staropramen kernel: registered taskstats version 1
> Jan 21 02:26:48 staropramen kernel: Loading compiled-in X.509 certificates
> Jan 21 02:26:48 staropramen kernel: Loaded X.509 cert 'Build time
> autogenerated kernel key: ec46ce7d495bae40674ea78e153b310deaf828e0'
> Jan 21 02:26:48 staropramen kernel: zswap: loaded using pool lz4/z3fold
> Jan 21 02:26:48 staropramen kernel: Key type ._fscrypt registered
> Jan 21 02:26:48 staropramen kernel: Key type .fscrypt registered
> Jan 21 02:26:48 staropramen kernel: Key type fscrypt-provisioning registered
> Jan 21 02:26:48 staropramen kernel: pstore: Using crash dump compression:
> zstd
> Jan 21 02:26:48 staropramen kernel: PM:   Magic number: 5:25:408
> Jan 21 02:26:48 staropramen kernel: RAS: Correctable Errors collector
> initialized.
> Jan 21 02:26:48 staropramen kernel: ata3: SATA link down (SStatus 0 SControl
> 300)
> Jan 21 02:26:48 staropramen kernel: ata5: SATA link up 6.0 Gbps (SStatus 133
> SControl 300)
> Jan 21 02:26:48 staropramen kernel: ata4: SATA link up 6.0 Gbps (SStatus 133
> SControl 300)
> Jan 21 02:26:48 staropramen kernel: ata1: SATA link down (SStatus 0 SControl
> 300)
> Jan 21 02:26:48 staropramen kernel: ata6: SATA link up 6.0 Gbps (SStatus 133
> SControl 300)
> Jan 21 02:26:48 staropramen kernel: ata5.00: ACPI cmd ef/10:06:00:00:00:00
> (SET FEATURES) succeeded
> Jan 21 02:26:48 staropramen kernel: ata5.00: ACPI cmd f5/00:00:00:00:00:00
> (SECURITY FREEZE LOCK) filtered out
> Jan 21 02:26:48 staropramen kernel: ata5.00: ACPI cmd b1/c1:00:00:00:00:00
> (DEVICE CONFIGURATION OVERLAY) filtered out
> Jan 21 02:26:48 staropramen kernel: ata2: SATA link down (SStatus 0 SControl
> 300)
> Jan 21 02:26:48 staropramen kernel: ata6.00: ACPI cmd ef/10:06:00:00:00:00
> (SET FEATURES) succeeded
> Jan 21 02:26:48 staropramen kernel: ata6.00: ACPI cmd f5/00:00:00:00:00:00
> (SECURITY FREEZE LOCK) filtered out
> Jan 21 02:26:48 staropramen kernel: ata6.00: ACPI cmd b1/c1:00:00:00:00:00
> (DEVICE CONFIGURATION OVERLAY) filtered out
> Jan 21 02:26:48 staropramen kernel: ata4.00: ACPI cmd ef/10:06:00:00:00:00
> (SET FEATURES) succeeded
> Jan 21 02:26:48 staropramen kernel: ata4.00: ACPI cmd f5/00:00:00:00:00:00
> (SECURITY FREEZE LOCK) filtered out
> Jan 21 02:26:48 staropramen kernel: ata4.00: ACPI cmd b1/c1:00:00:00:00:00
> (DEVICE CONFIGURATION OVERLAY) filtered out
> Jan 21 02:26:48 staropramen kernel: ata5.00: ATA-10: WDC WD40EFRX-68N32N0,
> 82.00A82, max UDMA/133
> Jan 21 02:26:48 staropramen kernel: ata5.00: 7814037168 sectors, multi 16:
> LBA48 NCQ (depth 32), AA
> Jan 21 02:26:48 staropramen kernel: ata6.00: ATA-10: WDC WD40EFRX-68N32N0,
> 82.00A82, max UDMA/133
> Jan 21 02:26:48 staropramen kernel: ata6.00: 7814037168 sectors, multi 16:
> LBA48 NCQ (depth 32), AA
> Jan 21 02:26:48 staropramen kernel: ata5.00: ACPI cmd ef/10:06:00:00:00:00
> (SET FEATURES) succeeded
> Jan 21 02:26:48 staropramen kernel: ata5.00: ACPI cmd f5/00:00:00:00:00:00
> (SECURITY FREEZE LOCK) filtered out
> Jan 21 02:26:48 staropramen kernel: ata5.00: ACPI cmd b1/c1:00:00:00:00:00
> (DEVICE CONFIGURATION OVERLAY) filtered out
> Jan 21 02:26:48 staropramen kernel: ata6.00: ACPI cmd ef/10:06:00:00:00:00
> (SET FEATURES) succeeded
> Jan 21 02:26:48 staropramen kernel: ata6.00: ACPI cmd f5/00:00:00:00:00:00
> (SECURITY FREEZE LOCK) filtered out
> Jan 21 02:26:48 staropramen kernel: ata6.00: ACPI cmd b1/c1:00:00:00:00:00
> (DEVICE CONFIGURATION OVERLAY) filtered out
> Jan 21 02:26:48 staropramen kernel: ata4.00: ATA-8: HGST HDN724030ALE640,
> MJ8OA5E0, max UDMA/133
> Jan 21 02:26:48 staropramen kernel: ata4.00: 5860533168 sectors, multi 16:
> LBA48 NCQ (depth 32), AA
> Jan 21 02:26:48 staropramen kernel: ata5.00: configured for UDMA/133
> Jan 21 02:26:48 staropramen kernel: ata6.00: configured for UDMA/133
> Jan 21 02:26:48 staropramen kernel: ata4.00: ACPI cmd ef/10:06:00:00:00:00
> (SET FEATURES) succeeded
> Jan 21 02:26:48 staropramen kernel: ata4.00: ACPI cmd f5/00:00:00:00:00:00
> (SECURITY FREEZE LOCK) filtered out
> Jan 21 02:26:48 staropramen kernel: ata4.00: ACPI cmd b1/c1:00:00:00:00:00
> (DEVICE CONFIGURATION OVERLAY) filtered out
> Jan 21 02:26:48 staropramen kernel: ata4.00: configured for UDMA/133
> Jan 21 02:26:48 staropramen kernel: scsi 3:0:0:0: Direct-Access     ATA
> HGST HDN724030AL A5E0 PQ: 0 ANSI: 5
> Jan 21 02:26:48 staropramen kernel: sd 3:0:0:0: [sda] 5860533168 512-byte
> logical blocks: (3.00 TB/2.73 TiB)
> Jan 21 02:26:48 staropramen kernel: sd 3:0:0:0: [sda] 4096-byte physical
> blocks
> Jan 21 02:26:48 staropramen kernel: sd 3:0:0:0: [sda] Write Protect is off
> Jan 21 02:26:48 staropramen kernel: sd 3:0:0:0: [sda] Mode Sense: 00 3a 00
> 00
> Jan 21 02:26:48 staropramen kernel: scsi 4:0:0:0: Direct-Access     ATA
> WDC WD40EFRX-68N 0A82 PQ: 0 ANSI: 5
> Jan 21 02:26:48 staropramen kernel: sd 3:0:0:0: [sda] Write cache: enabled,
> read cache: enabled, doesn't support DPO or FUA
> Jan 21 02:26:48 staropramen kernel: sd 4:0:0:0: [sdb] 7814037168 512-byte
> logical blocks: (4.00 TB/3.64 TiB)
> Jan 21 02:26:48 staropramen kernel: sd 4:0:0:0: [sdb] 4096-byte physical
> blocks
> Jan 21 02:26:48 staropramen kernel: sd 4:0:0:0: [sdb] Write Protect is off
> Jan 21 02:26:48 staropramen kernel: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00
> 00
> Jan 21 02:26:48 staropramen kernel: scsi 5:0:0:0: Direct-Access     ATA
> WDC WD40EFRX-68N 0A82 PQ: 0 ANSI: 5
> Jan 21 02:26:48 staropramen kernel: sd 4:0:0:0: [sdb] Write cache: enabled,
> read cache: enabled, doesn't support DPO or FUA
> Jan 21 02:26:48 staropramen kernel: sd 5:0:0:0: [sdc] 7814037168 512-byte
> logical blocks: (4.00 TB/3.64 TiB)
> Jan 21 02:26:48 staropramen kernel: sd 5:0:0:0: [sdc] 4096-byte physical
> blocks
> Jan 21 02:26:48 staropramen kernel: sd 5:0:0:0: [sdc] Write Protect is off
> Jan 21 02:26:48 staropramen kernel: sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00
> 00
> Jan 21 02:26:48 staropramen kernel: sd 5:0:0:0: [sdc] Write cache: enabled,
> read cache: enabled, doesn't support DPO or FUA
> Jan 21 02:26:48 staropramen kernel: sd 5:0:0:0: [sdc] Attached SCSI disk
> Jan 21 02:26:48 staropramen kernel: sd 4:0:0:0: [sdb] Attached SCSI disk
> Jan 21 02:26:48 staropramen kernel: sd 3:0:0:0: [sda] Attached SCSI disk
> Jan 21 02:26:48 staropramen kernel: Freeing unused decrypted memory: 2036K
> Jan 21 02:26:48 staropramen kernel: Freeing unused kernel image (initmem)
> memory: 1716K
> Jan 21 02:26:48 staropramen kernel: Write protecting the kernel read-only
> data: 26624k
> Jan 21 02:26:48 staropramen kernel: Freeing unused kernel image (text/rodata
> gap) memory: 2036K
> Jan 21 02:26:48 staropramen kernel: Freeing unused kernel image (rodata/data
> gap) memory: 1384K
> Jan 21 02:26:48 staropramen kernel: x86/mm: Checked W+X mappings: passed, no
> W+X pages found.
> Jan 21 02:26:48 staropramen kernel: rodata_test: all tests were successful
> Jan 21 02:26:48 staropramen kernel: x86/mm: Checking user space page tables
> Jan 21 02:26:48 staropramen kernel: x86/mm: Checked W+X mappings: passed, no
> W+X pages found.
> Jan 21 02:26:48 staropramen kernel: Run /init as init process
> Jan 21 02:26:48 staropramen kernel:   with arguments:
> Jan 21 02:26:48 staropramen kernel:     /init
> Jan 21 02:26:48 staropramen kernel:   with environment:
> Jan 21 02:26:48 staropramen kernel:     HOME=/
> Jan 21 02:26:48 staropramen kernel:     TERM=linux
> Jan 21 02:26:48 staropramen kernel:     BOOT_IMAGE=/@root/boot/vmlinuz-linux
> Jan 21 02:26:48 staropramen kernel: fbcon: Taking over console
> Jan 21 02:26:48 staropramen kernel: Console: switching to colour frame
> buffer device 128x48
> Jan 21 02:26:48 staropramen kernel: xhci_hcd 0000:00:14.0: xHCI Host
> Controller
> Jan 21 02:26:48 staropramen kernel: xhci_hcd 0000:00:14.0: new USB bus
> registered, assigned bus number 1
> Jan 21 02:26:48 staropramen kernel: xhci_hcd 0000:00:14.0: hcc params
> 0x200077c1 hci version 0x100 quirks 0x0000000000009810
> Jan 21 02:26:48 staropramen kernel: xhci_hcd 0000:00:14.0: cache line size
> of 64 is not supported
> Jan 21 02:26:48 staropramen kernel: usb usb1: New USB device found,
> idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
> Jan 21 02:26:48 staropramen kernel: usb usb1: New USB device strings: Mfr=3,
> Product=2, SerialNumber=1
> Jan 21 02:26:48 staropramen kernel: usb usb1: Product: xHCI Host Controller
> Jan 21 02:26:48 staropramen kernel: usb usb1: Manufacturer: Linux
> 5.10.9-arch1-1 xhci-hcd
> Jan 21 02:26:48 staropramen kernel: usb usb1: SerialNumber: 0000:00:14.0
> Jan 21 02:26:48 staropramen kernel: hub 1-0:1.0: USB hub found
> Jan 21 02:26:48 staropramen kernel: hub 1-0:1.0: 12 ports detected
> Jan 21 02:26:48 staropramen kernel: xhci_hcd 0000:00:14.0: xHCI Host
> Controller
> Jan 21 02:26:48 staropramen kernel: xhci_hcd 0000:00:14.0: new USB bus
> registered, assigned bus number 2
> Jan 21 02:26:48 staropramen kernel: xhci_hcd 0000:00:14.0: Host supports USB
> 3.0 SuperSpeed
> Jan 21 02:26:48 staropramen kernel: usb usb2: New USB device found,
> idVendor=1d6b, idProduct=0003, bcdDevice= 5.10
> Jan 21 02:26:48 staropramen kernel: usb usb2: New USB device strings: Mfr=3,
> Product=2, SerialNumber=1
> Jan 21 02:26:48 staropramen kernel: usb usb2: Product: xHCI Host Controller
> Jan 21 02:26:48 staropramen kernel: usb usb2: Manufacturer: Linux
> 5.10.9-arch1-1 xhci-hcd
> Jan 21 02:26:48 staropramen kernel: usb usb2: SerialNumber: 0000:00:14.0
> Jan 21 02:26:48 staropramen kernel: hub 2-0:1.0: USB hub found
> Jan 21 02:26:48 staropramen kernel: hub 2-0:1.0: 6 ports detected
> Jan 21 02:26:48 staropramen kernel: raid6: skip pq benchmark and using
> algorithm sse2x4
> Jan 21 02:26:48 staropramen kernel: raid6: using ssse3x2 recovery algorithm
> Jan 21 02:26:48 staropramen kernel: xor: measuring software checksum speed
> Jan 21 02:26:48 staropramen kernel:    prefetch64-sse  : 15533 MB/sec
> Jan 21 02:26:48 staropramen kernel:    generic_sse     : 13601 MB/sec
> Jan 21 02:26:48 staropramen kernel: xor: using function: prefetch64-sse
> (15533 MB/sec)
> Jan 21 02:26:48 staropramen kernel: random: fast init done
> Jan 21 02:26:48 staropramen kernel: Btrfs loaded, crc32c=crc32c-intel
> Jan 21 02:26:48 staropramen kernel: BTRFS: device label system devid 2
> transid 1518471 /dev/nvme0n1 scanned by systemd-udevd (149)
> Jan 21 02:26:48 staropramen kernel: BTRFS: device label system devid 1
> transid 1518471 /dev/nvme1n1p2 scanned by systemd-udevd (150)
> Jan 21 02:26:48 staropramen kernel: BTRFS: device label data1908 devid 1
> transid 1197709 /dev/sdb scanned by systemd-udevd (151)
> Jan 21 02:26:48 staropramen kernel: BTRFS: device label data1908 devid 2
> transid 1197709 /dev/sdc scanned by systemd-udevd (153)
> Jan 21 02:26:48 staropramen kernel: BTRFS info (device nvme1n1p2): disk
> space caching is enabled
> Jan 21 02:26:48 staropramen kernel: BTRFS info (device nvme1n1p2): has
> skinny extents
> Jan 21 02:26:48 staropramen kernel: tsc: Refined TSC clocksource
> calibration: 3504.012 MHz
> Jan 21 02:26:48 staropramen kernel: clocksource: tsc: mask:
> 0xffffffffffffffff max_cycles: 0x32821ec1205, max_idle_ns: 440795243129 ns
> Jan 21 02:26:48 staropramen kernel: clocksource: Switched to clocksource tsc
> Jan 21 02:26:48 staropramen kernel: BTRFS info (device nvme1n1p2): enabling
> ssd optimizations
> Jan 21 02:26:48 staropramen kernel: usb 1-10: new high-speed USB device
> number 2 using xhci_hcd
> Jan 21 02:26:48 staropramen kernel: usb 1-10: New USB device found,
> idVendor=8644, idProduct=800a, bcdDevice= 1.00
> Jan 21 02:26:48 staropramen kernel: usb 1-10: New USB device strings: Mfr=1,
> Product=2, SerialNumber=3
> Jan 21 02:26:48 staropramen kernel: usb 1-10: Product: USB Flash Disk
> Jan 21 02:26:48 staropramen kernel: usb 1-10: Manufacturer: General
> Jan 21 02:26:48 staropramen kernel: usb 1-10: SerialNumber: 00000000000012BD
> Jan 21 02:26:48 staropramen systemd[1]: systemd 247.2-1-arch running in
> system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP
> +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS
> +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> Jan 21 02:26:48 staropramen systemd[1]: Detected architecture x86-64.
> Jan 21 02:26:48 staropramen systemd[1]: Set hostname to <staropramen>.
> Jan 21 02:26:48 staropramen systemd[1]: Queued start job for default target
> Graphical Interface.
> Jan 21 02:26:48 staropramen systemd[1]: Created slice system-getty.slice.
> Jan 21 02:26:48 staropramen systemd[1]: Created slice system-modprobe.slice.
> Jan 21 02:26:48 staropramen systemd[1]: Created slice
> system-qbittorrent\x2dnox.slice.
> Jan 21 02:26:48 staropramen systemd[1]: Created slice
> system-systemd\x2dfsck.slice.
> Jan 21 02:26:48 staropramen systemd[1]: Created slice User and Session
> Slice.
> Jan 21 02:26:48 staropramen systemd[1]: Started Dispatch Password Requests
> to Console Directory Watch.
> Jan 21 02:26:48 staropramen systemd[1]: Started Forward Password Requests to
> Wall Directory Watch.
> Jan 21 02:26:48 staropramen systemd[1]: Set up automount Arbitrary
> Executable File Formats File System Automount Point.
> Jan 21 02:26:48 staropramen systemd[1]: Reached target Local Encrypted
> Volumes.
> Jan 21 02:26:48 staropramen systemd[1]: Reached target Paths.
> Jan 21 02:26:48 staropramen systemd[1]: Reached target Remote File Systems.
> Jan 21 02:26:48 staropramen systemd[1]: Reached target Slices.
> Jan 21 02:26:48 staropramen systemd[1]: Reached target Swap.
> Jan 21 02:26:48 staropramen systemd[1]: Reached target System Time Set.
> Jan 21 02:26:48 staropramen systemd[1]: Reached target System Time
> Synchronized.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on Device-mapper event
> daemon FIFOs.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on LVM2 metadata daemon
> socket.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on LVM2 poll daemon
> socket.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on RPCbind Server
> Activation Socket.
> Jan 21 02:26:48 staropramen systemd[1]: Reached target RPC Port Mapper.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on Syslog Socket.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on Process Core Dump
> Socket.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on Journal Audit Socket.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on Journal Socket
> (/dev/log).
> Jan 21 02:26:48 staropramen systemd[1]: Listening on Journal Socket.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on Network Service Netlink
> Socket.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on udev Control Socket.
> Jan 21 02:26:48 staropramen systemd[1]: Listening on udev Kernel Socket.
> Jan 21 02:26:48 staropramen systemd[1]: Mounting Huge Pages File System...
> Jan 21 02:26:48 staropramen systemd[1]: Mounting POSIX Message Queue File
> System...
> Jan 21 02:26:48 staropramen systemd[1]: Mounting NFSD configuration
> filesystem...
> Jan 21 02:26:48 staropramen systemd[1]: Mounting Kernel Debug File System...
> Jan 21 02:26:48 staropramen systemd[1]: Mounting Kernel Trace File System...
> Jan 21 02:26:48 staropramen systemd[1]: Mounting Temporary Directory
> (/tmp)...
> Jan 21 02:26:48 staropramen systemd[1]: Condition check resulted in Kernel
> Module supporting RPCSEC_GSS being skipped.
> Jan 21 02:26:48 staropramen systemd[1]: Starting Create list of static
> device nodes for the current kernel...
> Jan 21 02:26:48 staropramen systemd[1]: Starting Monitoring of LVM2 mirrors,
> snapshots etc. using dmeventd or progress polling...
> Jan 21 02:26:48 staropramen systemd[1]: Starting Load Kernel Module
> configfs...
> Jan 21 02:26:48 staropramen systemd[1]: Starting Load Kernel Module drm...
> Jan 21 02:26:48 staropramen systemd[1]: Starting Load Kernel Module fuse...
> Jan 21 02:26:48 staropramen systemd[1]: Starting Load Kernel Module zram...
> Jan 21 02:26:48 staropramen systemd[1]: Condition check resulted in Set Up
> Additional Binary Formats being skipped.
> Jan 21 02:26:48 staropramen systemd[1]: Starting Journal Service...
> Jan 21 02:26:48 staropramen systemd[1]: Condition check resulted in Load
> Kernel Modules being skipped.
> Jan 21 02:26:48 staropramen systemd[1]: Starting Remount Root and Kernel
> File Systems...
> Jan 21 02:26:48 staropramen systemd[1]: Condition check resulted in
> Repartition Root Disk being skipped.
> Jan 21 02:26:48 staropramen systemd[1]: Starting Apply Kernel Variables...
> Jan 21 02:26:48 staropramen systemd[1]: Starting Coldplug All udev
> Devices...
> Jan 21 02:26:48 staropramen systemd[1]: Mounted Huge Pages File System.
> Jan 21 02:26:48 staropramen systemd[1]: Mounted POSIX Message Queue File
> System.
> Jan 21 02:26:48 staropramen systemd[1]: Mounted Kernel Debug File System.
> Jan 21 02:26:48 staropramen systemd[1]: Mounted Kernel Trace File System.
> Jan 21 02:26:48 staropramen systemd[1]: Mounted Temporary Directory (/tmp).
> Jan 21 02:26:48 staropramen systemd[1]: Finished Create list of static
> device nodes for the current kernel.
> Jan 21 02:26:48 staropramen systemd[1]: modprobe@configfs.service:
> Succeeded.
> Jan 21 02:26:48 staropramen systemd[1]: Finished Load Kernel Module
> configfs.
> Jan 21 02:26:48 staropramen kernel: random: lvm: uninitialized urandom read
> (4 bytes read)
> Jan 21 02:26:48 staropramen systemd[1]: Mounting Kernel Configuration File
> System...
> Jan 21 02:26:48 staropramen systemd[1]: Finished Apply Kernel Variables.
> Jan 21 02:26:48 staropramen systemd[1]: Mounted Kernel Configuration File
> System.
> Jan 21 02:26:48 staropramen kernel: zram: Added device: zram0
> Jan 21 02:26:48 staropramen kernel: Linux agpgart interface v0.103
> Jan 21 02:26:48 staropramen kernel: fuse: init (API version 7.32)
> Jan 21 02:26:48 staropramen systemd[1]: modprobe@zram.service: Succeeded.
> Jan 21 02:26:48 staropramen systemd[1]: Finished Load Kernel Module zram.
> Jan 21 02:26:48 staropramen systemd[1]: modprobe@fuse.service: Succeeded.
> Jan 21 02:26:48 staropramen systemd[1]: Finished Load Kernel Module fuse.
> Jan 21 02:26:48 staropramen systemd[1]: Mounting FUSE Control File System...
> Jan 21 02:26:48 staropramen systemd[1]: Mounted FUSE Control File System.
> Jan 21 02:26:48 staropramen kernel: RPC: Registered named UNIX socket
> transport module.
> Jan 21 02:26:48 staropramen kernel: RPC: Registered udp transport module.
> Jan 21 02:26:48 staropramen kernel: RPC: Registered tcp transport module.
> Jan 21 02:26:48 staropramen kernel: RPC: Registered tcp NFSv4.1 backchannel
> transport module.
> Jan 21 02:26:48 staropramen systemd[1]: modprobe@drm.service: Succeeded.
> Jan 21 02:26:48 staropramen systemd[1]: Finished Load Kernel Module drm.
> Jan 21 02:26:48 staropramen kernel: audit: type=1130
> audit(1611192408.064:2): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=modprobe@drm comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:26:48 staropramen kernel: audit: type=1131
> audit(1611192408.064:3): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=modprobe@drm comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:26:48 staropramen systemd[1]: Started Journal Service.
> Jan 21 02:26:48 staropramen kernel: audit: type=1130
> audit(1611192408.070:4): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:26:48 staropramen kernel: audit: type=1130
> audit(1611192408.077:5): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:26:48 staropramen kernel: Installing knfsd (copyright (C) 1996
> okir@monad.swb.de).
> Jan 21 02:26:48 staropramen kernel: random: crng init done
> Jan 21 02:26:49 staropramen kernel: BTRFS info (device nvme1n1p2): setting
> incompat feature flag for COMPRESS_ZSTD (0x10)
> Jan 21 02:26:49 staropramen kernel: BTRFS info (device nvme1n1p2): use zstd
> compression, level 3
> Jan 21 02:26:49 staropramen kernel: BTRFS info (device nvme1n1p2): disk
> space caching is enabled
> Jan 21 02:26:49 staropramen kernel: audit: type=1130
> audit(1611192409.677:6): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-remount-fs comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:26:50 staropramen kernel: audit: type=1130
> audit(1611192409.734:7): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-random-seed comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:26:50 staropramen kernel: audit: type=1130
> audit(1611192409.910:8): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-sysusers comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:26:50 staropramen kernel: audit: type=1130
> audit(1611192409.950:9): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-tmpfiles-setup-dev comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 02:26:50 staropramen kernel: audit: type=1334
> audit(1611192409.954:10): prog-id=13 op=LOAD
> Jan 21 02:26:50 staropramen kernel: usb-storage 1-10:1.0: USB Mass Storage
> device detected
> Jan 21 02:26:50 staropramen kernel: parport_pc 00:01: reported by Plug and
> Play ACPI
> Jan 21 02:26:50 staropramen kernel: parport0: PC-style at 0x378, irq 5
> [PCSPP]
> Jan 21 02:26:50 staropramen kernel: scsi host6: usb-storage 1-10:1.0
> Jan 21 02:26:50 staropramen kernel: usbcore: registered new interface driver
> usb-storage
> Jan 21 02:26:50 staropramen kernel: e1000e: Intel(R) PRO/1000 Network Driver
> Jan 21 02:26:50 staropramen kernel: e1000e: Copyright(c) 1999 - 2015 Intel
> Corporation.
> Jan 21 02:26:50 staropramen kernel: e1000e 0000:04:00.0: Interrupt
> Throttling Rate (ints/sec) set to dynamic conservative mode
> Jan 21 02:26:50 staropramen kernel: mei_me 0000:00:16.0: enabling device
> (0000 -> 0002)
> Jan 21 02:26:50 staropramen kernel: usbcore: registered new interface driver
> uas
> Jan 21 02:26:50 staropramen kernel: i801_smbus 0000:00:1f.4: SPD Write
> Disable is set
> Jan 21 02:26:50 staropramen kernel: i801_smbus 0000:00:1f.4: SMBus using PCI
> interrupt
> Jan 21 02:26:50 staropramen kernel: i2c i2c-0: 2/4 memory slots populated
> (from DMI)
> Jan 21 02:26:50 staropramen kernel: i2c i2c-0: Successfully instantiated SPD
> at 0x51
> Jan 21 02:26:50 staropramen kernel: i2c i2c-0: Successfully instantiated SPD
> at 0x53
> Jan 21 02:26:50 staropramen kernel: e1000e 0000:04:00.0 0000:04:00.0
> (uninitialized): registered PHC clock
> Jan 21 02:26:50 staropramen kernel: RAPL PMU: API unit is 2^-32 Joules, 4
> fixed counters, 655360 ms ovfl timer
> Jan 21 02:26:50 staropramen kernel: RAPL PMU: hw unit of domain pp0-core
> 2^-14 Joules
> Jan 21 02:26:50 staropramen kernel: RAPL PMU: hw unit of domain package
> 2^-14 Joules
> Jan 21 02:26:50 staropramen kernel: RAPL PMU: hw unit of domain dram 2^-14
> Joules
> Jan 21 02:26:50 staropramen kernel: RAPL PMU: hw unit of domain pp1-gpu
> 2^-14 Joules
> Jan 21 02:26:50 staropramen kernel: cryptd: max_cpu_qlen set to 1000
> Jan 21 02:26:50 staropramen kernel: e1000e 0000:04:00.0 eth0: (PCI
> Express:2.5GT/s:Width x1) 68:05:ca:b3:a4:3d
> Jan 21 02:26:50 staropramen kernel: e1000e 0000:04:00.0 eth0: Intel(R)
> PRO/1000 Network Connection
> Jan 21 02:26:50 staropramen kernel: e1000e 0000:04:00.0 eth0: MAC: 3, PHY:
> 8, PBA No: E46981-008
> Jan 21 02:26:50 staropramen kernel: SSE version of gcm_enc/dec engaged.
> Jan 21 02:26:50 staropramen kernel: BTRFS info (device sdb): use zstd
> compression, level 3
> Jan 21 02:26:50 staropramen kernel: BTRFS info (device sdb): disk space
> caching is enabled
> Jan 21 02:26:50 staropramen kernel: BTRFS info (device sdb): has skinny
> extents
> Jan 21 02:26:50 staropramen kernel: ee1004 0-0051: 512 byte EE1004-compliant
> SPD EEPROM, read-only
> Jan 21 02:26:50 staropramen kernel: ee1004 0-0053: 512 byte EE1004-compliant
> SPD EEPROM, read-only
> Jan 21 02:26:50 staropramen kernel: e1000e 0000:04:00.0 enp4s0: renamed from
> eth0
> Jan 21 02:26:50 staropramen kernel: iTCO_vendor_support: vendor-support=0
> Jan 21 02:26:50 staropramen kernel: ppdev: user-space parallel port driver
> Jan 21 02:26:50 staropramen kernel: iTCO_wdt: Intel TCO WatchDog Timer
> Driver v1.11
> Jan 21 02:26:50 staropramen kernel: iTCO_wdt: Found a Intel PCH TCO device
> (Version=4, TCOBASE=0x0400)
> Jan 21 02:26:50 staropramen kernel: iTCO_wdt: initialized. heartbeat=30 sec
> (nowayout=0)
> Jan 21 02:26:50 staropramen kernel: asus_wmi: ASUS WMI generic driver loaded
> Jan 21 02:26:50 staropramen kernel: asus_wmi: Initialization: 0x0
> Jan 21 02:26:50 staropramen kernel: asus_wmi: BIOS WMI version: 0.9
> Jan 21 02:26:50 staropramen kernel: asus_wmi: SFUN value: 0x0
> Jan 21 02:26:50 staropramen kernel: eeepc-wmi eeepc-wmi: Detected ASUSWMI,
> use DCTS
> Jan 21 02:26:50 staropramen kernel: input: Eee PC WMI hotkeys as
> /devices/platform/eeepc-wmi/input/input4
> Jan 21 02:26:51 staropramen kernel: checking generic (e0000000 300000) vs hw
> (f6000000 1000000)
> Jan 21 02:26:51 staropramen kernel: checking generic (e0000000 300000) vs hw
> (e0000000 10000000)
> Jan 21 02:26:51 staropramen kernel: fb0: switching to inteldrmfb from EFI
> VGA
> Jan 21 02:26:51 staropramen kernel: Console: switching to colour dummy
> device 80x25
> Jan 21 02:26:51 staropramen kernel: i915 0000:00:02.0: vgaarb: deactivate
> vga console
> Jan 21 02:26:51 staropramen kernel: i915 0000:00:02.0: vgaarb: changed VGA
> decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> Jan 21 02:26:51 staropramen kernel: mei_hdcp
> 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops
> i915_hdcp_component_ops [i915])
> Jan 21 02:26:51 staropramen kernel: i915 0000:00:02.0: [drm] Finished
> loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> Jan 21 02:26:51 staropramen kernel: [drm] Initialized i915 1.6.0 20200917
> for 0000:00:02.0 on minor 0
> Jan 21 02:26:51 staropramen kernel: ACPI: Video Device [GFX0] (multi-head:
> yes  rom: no  post: no)
> Jan 21 02:26:51 staropramen kernel: input: Video Bus as
> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
> Jan 21 02:26:51 staropramen kernel: fbcon: i915drmfb (fb0) is primary device
> Jan 21 02:26:51 staropramen kernel: Console: switching to colour frame
> buffer device 240x67
> Jan 21 02:26:51 staropramen kernel: i915 0000:00:02.0: [drm] fb0: i915drmfb
> frame buffer device
> Jan 21 02:26:51 staropramen kernel: intel_rapl_common: Found RAPL domain
> package
> Jan 21 02:26:51 staropramen kernel: intel_rapl_common: Found RAPL domain
> core
> Jan 21 02:26:51 staropramen kernel: intel_rapl_common: Found RAPL domain
> uncore
> Jan 21 02:26:51 staropramen kernel: intel_rapl_common: Found RAPL domain
> dram
> Jan 21 02:26:51 staropramen kernel: snd_hda_intel 0000:00:1f.3: enabling
> device (0000 -> 0002)
> Jan 21 02:26:51 staropramen kernel: snd_hda_intel 0000:00:1f.3: bound
> 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> Jan 21 02:26:51 staropramen kernel: snd_hda_codec_realtek hdaudioC0D0:
> autoconfig for ALC887-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
> Jan 21 02:26:51 staropramen kernel: snd_hda_codec_realtek hdaudioC0D0:
> speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> Jan 21 02:26:51 staropramen kernel: snd_hda_codec_realtek hdaudioC0D0:
> hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> Jan 21 02:26:51 staropramen kernel: snd_hda_codec_realtek hdaudioC0D0:
> mono: mono_out=0x0
> Jan 21 02:26:51 staropramen kernel: snd_hda_codec_realtek hdaudioC0D0:
> dig-out=0x11/0x0
> Jan 21 02:26:51 staropramen kernel: snd_hda_codec_realtek hdaudioC0D0:
> inputs:
> Jan 21 02:26:51 staropramen kernel: snd_hda_codec_realtek hdaudioC0D0:
> Front Mic=0x19
> Jan 21 02:26:51 staropramen kernel: snd_hda_codec_realtek hdaudioC0D0:
> Rear Mic=0x18
> Jan 21 02:26:51 staropramen kernel: snd_hda_codec_realtek hdaudioC0D0:
> Line=0x1a
> Jan 21 02:26:51 staropramen kernel: input: HDA Intel PCH Front Mic as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input6
> Jan 21 02:26:51 staropramen kernel: input: HDA Intel PCH Rear Mic as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input7
> Jan 21 02:26:51 staropramen kernel: input: HDA Intel PCH Line as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
> Jan 21 02:26:51 staropramen kernel: input: HDA Intel PCH Line Out as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
> Jan 21 02:26:51 staropramen kernel: input: HDA Intel PCH Front Headphone as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
> Jan 21 02:26:51 staropramen kernel: input: HDA Intel PCH HDMI/DP,pcm=3 as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
> Jan 21 02:26:51 staropramen kernel: input: HDA Intel PCH HDMI/DP,pcm=7 as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
> Jan 21 02:26:51 staropramen kernel: input: HDA Intel PCH HDMI/DP,pcm=8 as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
> Jan 21 02:26:51 staropramen kernel: scsi 6:0:0:0: Direct-Access     General
> USB Flash Disk   1.00 PQ: 0 ANSI: 2
> Jan 21 02:26:51 staropramen kernel: sd 6:0:0:0: [sdd] 3913728 512-byte
> logical blocks: (2.00 GB/1.87 GiB)
> Jan 21 02:26:51 staropramen kernel: sd 6:0:0:0: [sdd] Write Protect is off
> Jan 21 02:26:51 staropramen kernel: sd 6:0:0:0: [sdd] Mode Sense: 0b 00 00
> 08
> Jan 21 02:26:51 staropramen kernel: sd 6:0:0:0: [sdd] No Caching mode page
> found
> Jan 21 02:26:51 staropramen kernel: sd 6:0:0:0: [sdd] Assuming drive cache:
> write through
> Jan 21 02:26:51 staropramen kernel:  sdd: sdd1 sdd2
> Jan 21 02:26:51 staropramen kernel: sd 6:0:0:0: [sdd] Attached SCSI
> removable disk
> Jan 21 02:26:53 staropramen kernel: e1000e 0000:04:00.0 enp4s0: NIC Link is
> Up 1000 Mbps Full Duplex, Flow Control: None
> Jan 21 02:26:53 staropramen kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp4s0:
> link becomes ready
> Jan 21 02:26:59 staropramen kernel: SGI XFS with ACLs, security attributes,
> realtime, scrub, repair, quota, no debug enabled
> Jan 21 02:26:59 staropramen kernel: XFS (sda): Mounting V5 Filesystem
> Jan 21 02:27:00 staropramen kernel: XFS (sda): Ending clean mount
> Jan 21 02:27:00 staropramen kernel: xfs filesystem being mounted at
> /data/backup supports timestamps until 2038 (0x7fffffff)
> Jan 21 02:27:00 staropramen kernel: kauditd_printk_skb: 7 callbacks
> suppressed
> Jan 21 02:27:00 staropramen kernel: audit: type=1130
> audit(1611192420.250:18): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-tmpfiles-setup comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:00 staropramen kernel: audit: type=1127
> audit(1611192420.274:19): pid=402 uid=0 auid=4294967295 ses=4294967295 msg='
> comm="systemd-update-utmp" exe="/usr/lib/systemd/systemd-update-utmp"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:00 staropramen kernel: audit: type=1130
> audit(1611192420.284:20): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-update-utmp comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:00 staropramen kernel: audit: type=1130
> audit(1611192420.290:21): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=nfsdcld comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 02:27:00 staropramen kernel: audit: type=1130
> audit(1611192420.290:22): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=nfs-idmapd comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:00 staropramen kernel: audit: type=1130
> audit(1611192420.297:23): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-journal-catalog-update comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:00 staropramen kernel: audit: type=1130
> audit(1611192420.360:24): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-resolved comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:01 staropramen kernel: audit: type=1130
> audit(1611192421.994:25): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=ldconfig comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 02:27:02 staropramen kernel: audit: type=1130
> audit(1611192421.997:26): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-update-done comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:02 staropramen kernel: audit: type=1130
> audit(1611192422.040:27): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=dbus comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 02:27:09 staropramen kernel: kauditd_printk_skb: 32 callbacks
> suppressed
> Jan 21 02:27:09 staropramen kernel: audit: type=1130
> audit(1611192425.637:60): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-swap comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:09 staropramen kernel: audit: type=1130
> audit(1611192426.034:61): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=smartd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 02:27:09 staropramen kernel: usb 1-10: USB disconnect, device number
> 2
> Jan 21 02:27:09 staropramen kernel: audit: type=1334
> audit(1611192429.744:62): prog-id=20 op=UNLOAD
> Jan 21 02:27:09 staropramen kernel: audit: type=1334
> audit(1611192429.744:63): prog-id=19 op=UNLOAD
> Jan 21 02:27:09 staropramen kernel: NFSD: Using nfsdcld client tracking
> operations.
> Jan 21 02:27:09 staropramen kernel: NFSD: starting 90-second grace period
> (net f0000098)
> Jan 21 02:27:09 staropramen kernel: audit: type=1130
> audit(1611192429.950:64): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=nfs-server comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:09 staropramen kernel: audit: type=1130
> audit(1611192429.964:65): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=rpc-statd-notify comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:10 staropramen kernel: bridge: filtering via arp/ip/ip6tables
> is no longer available by default. Update your scripts to load br_netfilter
> if you need this.
> Jan 21 02:27:10 staropramen kernel: Bridge firewalling registered
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.147:66): table=nat family=2 entries=0 op=xt_register
> pid=742 comm="modprobe"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.167:67): table=filter family=2 entries=0 op=xt_register
> pid=747 comm="modprobe"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.204:68): table=nat family=2 entries=5 op=xt_replace pid=767
> comm="iptables"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.224:69): table=filter family=2 entries=4 op=xt_replace
> pid=769 comm="iptables"
> Jan 21 02:27:10 staropramen kernel: kauditd_printk_skb: 15 callbacks
> suppressed
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.624:85): table=filter family=2 entries=18 op=xt_replace
> pid=806 comm="iptables"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.650:86): table=nat family=2 entries=11 op=xt_replace
> pid=809 comm="iptables"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.664:87): table=nat family=2 entries=12 op=xt_replace
> pid=813 comm="iptables"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.687:88): table=filter family=2 entries=19 op=xt_replace
> pid=816 comm="iptables"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.717:89): table=filter family=2 entries=20 op=xt_replace
> pid=818 comm="iptables"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.757:90): table=filter family=2 entries=21 op=xt_replace
> pid=824 comm="iptables"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.777:91): table=filter family=2 entries=22 op=xt_replace
> pid=826 comm="iptables"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.790:92): table=filter family=2 entries=23 op=xt_replace
> pid=828 comm="iptables"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.824:93): table=filter family=2 entries=22 op=xt_replace
> pid=829 comm="iptables"
> Jan 21 02:27:10 staropramen kernel: audit: type=1325
> audit(1611192430.840:94): table=filter family=2 entries=23 op=xt_replace
> pid=831 comm="iptables"
> Jan 21 02:27:13 staropramen kernel: docker0: port 1(veth5afb930) entered
> blocking state
> Jan 21 02:27:13 staropramen kernel: docker0: port 1(veth5afb930) entered
> disabled state
> Jan 21 02:27:13 staropramen kernel: device veth5afb930 entered promiscuous
> mode
> Jan 21 02:27:14 staropramen kernel: cgroup: cgroup: disabling cgroup2 socket
> matching due to net_prio or net_cls activation
> Jan 21 02:27:14 staropramen kernel: eth0: renamed from veth294cdd8
> Jan 21 02:27:14 staropramen kernel: IPv6: ADDRCONF(NETDEV_CHANGE):
> veth5afb930: link becomes ready
> Jan 21 02:27:14 staropramen kernel: docker0: port 1(veth5afb930) entered
> blocking state
> Jan 21 02:27:14 staropramen kernel: docker0: port 1(veth5afb930) entered
> forwarding state
> Jan 21 02:27:14 staropramen kernel: IPv6: ADDRCONF(NETDEV_CHANGE): docker0:
> link becomes ready
> Jan 21 02:27:16 staropramen kernel: kauditd_printk_skb: 120 callbacks
> suppressed
> Jan 21 02:27:16 staropramen kernel: audit: type=1130
> audit(1611192436.170:215): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=polkit comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 02:27:16 staropramen kernel: audit: type=1130
> audit(1611192436.174:216): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=packagekit comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:32 staropramen kernel: audit: type=1131
> audit(1611192452.234:217): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:27:32 staropramen kernel: audit: type=1334
> audit(1611192452.410:218): prog-id=18 op=UNLOAD
> Jan 21 02:27:32 staropramen kernel: audit: type=1334
> audit(1611192452.410:219): prog-id=17 op=UNLOAD
> Jan 21 02:27:52 staropramen kernel: audit: type=1100
> audit(1611192472.504:220): pid=2143 uid=1000 auid=1000 ses=1
> msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock
> acct="markus" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 02:27:52 staropramen kernel: audit: type=1101
> audit(1611192472.504:221): pid=2143 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 02:27:52 staropramen kernel: audit: type=1110
> audit(1611192472.504:222): pid=2143 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 02:27:52 staropramen kernel: audit: type=1105
> audit(1611192472.504:223): pid=2143 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 02:27:52 staropramen kernel: audit: type=1106
> audit(1611192472.507:224): pid=2143 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 02:27:52 staropramen kernel: audit: type=1104
> audit(1611192472.507:225): pid=2143 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 02:28:17 staropramen kernel: audit: type=1101
> audit(1611192497.717:226): pid=2671 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 02:28:17 staropramen kernel: audit: type=1110
> audit(1611192497.717:227): pid=2671 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 02:28:17 staropramen kernel: audit: type=1105
> audit(1611192497.717:228): pid=2671 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 02:28:17 staropramen kernel: audit: type=1106
> audit(1611192497.724:229): pid=2671 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 02:28:17 staropramen kernel: audit: type=1104
> audit(1611192497.724:230): pid=2671 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 02:29:46 staropramen kernel: audit: type=1100
> audit(1611192586.634:231): pid=4306 uid=1000 auid=1000 ses=1
> msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock
> acct="markus" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0
> res=success'
> Jan 21 02:29:46 staropramen kernel: audit: type=1101
> audit(1611192586.634:232): pid=4306 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
> Jan 21 02:29:46 staropramen kernel: audit: type=1110
> audit(1611192586.634:233): pid=4306 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0
> res=success'
> Jan 21 02:29:46 staropramen kernel: audit: type=1105
> audit(1611192586.634:234): pid=4306 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
> Jan 21 02:29:47 staropramen kernel: audit: type=1106
> audit(1611192587.367:235): pid=4306 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0
> res=success'
> Jan 21 02:29:47 staropramen kernel: audit: type=1104
> audit(1611192587.367:236): pid=4306 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0
> res=success'
> Jan 21 02:30:02 staropramen kernel: audit: type=1334
> audit(1611192602.207:237): prog-id=16 op=UNLOAD
> Jan 21 02:30:02 staropramen kernel: audit: type=1334
> audit(1611192602.207:238): prog-id=15 op=UNLOAD
> Jan 21 02:30:02 staropramen kernel: audit: type=1334
> audit(1611192602.207:239): prog-id=12 op=UNLOAD
> Jan 21 02:30:02 staropramen kernel: audit: type=1334
> audit(1611192602.207:240): prog-id=11 op=UNLOAD
> Jan 21 02:30:02 staropramen kernel: audit: type=1334
> audit(1611192602.207:241): prog-id=14 op=UNLOAD
> Jan 21 02:30:02 staropramen kernel: audit: type=1334
> audit(1611192602.207:242): prog-id=13 op=UNLOAD
> Jan 21 02:30:02 staropramen kernel: audit: type=1334
> audit(1611192602.340:243): prog-id=22 op=LOAD
> Jan 21 02:30:02 staropramen kernel: audit: type=1334
> audit(1611192602.340:244): prog-id=23 op=LOAD
> Jan 21 02:30:02 staropramen kernel: audit: type=1334
> audit(1611192602.340:245): prog-id=24 op=LOAD
> Jan 21 02:30:02 staropramen kernel: audit: type=1334
> audit(1611192602.340:246): prog-id=25 op=LOAD
> Jan 21 02:30:02 staropramen kernel: Adding 262140k swap on
> /var/lib/systemd-swap/swapfc/1.  Priority:50 extents:1 across:262140k FS
> Jan 21 02:32:43 staropramen kernel: kauditd_printk_skb: 2 callbacks
> suppressed
> Jan 21 02:32:43 staropramen kernel: audit: type=1101
> audit(1611192763.780:249): pid=5965 uid=0 auid=4294967295 ses=4294967295
> msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:32:43 staropramen kernel: audit: type=1103
> audit(1611192763.780:250): pid=5965 uid=0 auid=4294967295 ses=4294967295
> msg='op=PAM:setcred
> grantors=pam_shells,pam_faillock,pam_permit,pam_env,pam_faillock
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:32:43 staropramen kernel: audit: type=1006
> audit(1611192763.780:251): pid=5965 uid=0 old-auid=4294967295 auid=1000
> tty=(none) old-ses=4294967295 ses=3 res=1
> Jan 21 02:32:43 staropramen kernel: audit: type=1105
> audit(1611192763.807:252): pid=5965 uid=0 auid=1000 ses=3
> msg='op=PAM:session_open grantors=pam_loginuid,pam_keyinit,pam_limits,pam_unix,pam_permit,pam_mail,pam_systemd,pam_env
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:32:43 staropramen kernel: audit: type=1103
> audit(1611192763.810:253): pid=5967 uid=0 auid=1000 ses=3
> msg='op=PAM:setcred
> grantors=pam_shells,pam_faillock,pam_permit,pam_env,pam_faillock
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:33:35 staropramen kernel: audit: type=1131
> audit(1611192815.797:254): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=borg-backup comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:33:37 staropramen kernel: audit: type=1100
> audit(1611192817.327:255): pid=6718 uid=1000 auid=1000 ses=1
> msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock
> acct="markus" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/3
> res=success'
> Jan 21 02:33:37 staropramen kernel: audit: type=1101
> audit(1611192817.330:256): pid=6718 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/3 res=success'
> Jan 21 02:33:37 staropramen kernel: audit: type=1110
> audit(1611192817.330:257): pid=6718 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/3
> res=success'
> Jan 21 02:33:37 staropramen kernel: audit: type=1105
> audit(1611192817.330:258): pid=6718 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/3 res=success'
> Jan 21 02:34:01 staropramen kernel: audit: type=1106
> audit(1611192841.857:259): pid=6718 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/3
> res=success'
> Jan 21 02:34:01 staropramen kernel: audit: type=1104
> audit(1611192841.857:260): pid=6718 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/3
> res=success'
> Jan 21 02:34:51 staropramen kernel: audit: type=1131
> audit(1611192891.170:261): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=packagekit comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:35:03 staropramen kernel: audit: type=1106
> audit(1611192903.737:262): pid=5965 uid=0 auid=1000 ses=3
> msg='op=PAM:session_close grantors=pam_loginuid,pam_keyinit,pam_limits,pam_unix,pam_permit,pam_mail,pam_systemd,pam_env
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:35:03 staropramen kernel: audit: type=1104
> audit(1611192903.737:263): pid=5965 uid=0 auid=1000 ses=3
> msg='op=PAM:setcred
> grantors=pam_shells,pam_faillock,pam_permit,pam_env,pam_faillock
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:37:24 staropramen kernel: audit: type=1130
> audit(1611193044.107:264): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-cleanup comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:37:24 staropramen kernel: audit: type=1130
> audit(1611193044.124:265): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 02:37:36 staropramen kernel: audit: type=1131
> audit(1611193056.787:266): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-cleanup comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 02:38:36 staropramen kernel: audit: type=1131
> audit(1611193116.814:267): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 02:40:04 staropramen kernel: audit: type=1101
> audit(1611193204.300:268): pid=11029 uid=0 auid=4294967295 ses=4294967295
> msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:40:04 staropramen kernel: audit: type=1103
> audit(1611193204.304:269): pid=11029 uid=0 auid=4294967295 ses=4294967295
> msg='op=PAM:setcred
> grantors=pam_shells,pam_faillock,pam_permit,pam_env,pam_faillock
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:40:04 staropramen kernel: audit: type=1006
> audit(1611193204.304:270): pid=11029 uid=0 old-auid=4294967295 auid=1000
> tty=(none) old-ses=4294967295 ses=4 res=1
> Jan 21 02:40:04 staropramen kernel: audit: type=1105
> audit(1611193204.310:271): pid=11029 uid=0 auid=1000 ses=4
> msg='op=PAM:session_open grantors=pam_loginuid,pam_keyinit,pam_limits,pam_unix,pam_permit,pam_mail,pam_systemd,pam_env
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:40:04 staropramen kernel: audit: type=1103
> audit(1611193204.310:272): pid=11031 uid=0 auid=1000 ses=4
> msg='op=PAM:setcred
> grantors=pam_shells,pam_faillock,pam_permit,pam_env,pam_faillock
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:40:55 staropramen kernel: audit: type=1100
> audit(1611193255.240:273): pid=11767 uid=1000 auid=1000 ses=1
> msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock
> acct="markus" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 02:40:55 staropramen kernel: audit: type=1101
> audit(1611193255.240:274): pid=11767 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 02:40:55 staropramen kernel: audit: type=1110
> audit(1611193255.240:275): pid=11767 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 02:40:55 staropramen kernel: audit: type=1105
> audit(1611193255.240:276): pid=11767 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 02:41:58 staropramen kernel: audit: type=1130
> audit(1611193318.107:277): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-tmpfiles-clean comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 02:41:58 staropramen kernel: audit: type=1131
> audit(1611193318.107:278): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-tmpfiles-clean comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 02:42:30 staropramen kernel: audit: type=1106
> audit(1611193350.410:279): pid=11029 uid=0 auid=1000 ses=4
> msg='op=PAM:session_close grantors=pam_loginuid,pam_keyinit,pam_limits,pam_unix,pam_permit,pam_mail,pam_systemd,pam_env
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:42:30 staropramen kernel: audit: type=1104
> audit(1611193350.410:280): pid=11029 uid=0 auid=1000 ses=4
> msg='op=PAM:setcred
> grantors=pam_shells,pam_faillock,pam_permit,pam_env,pam_faillock
> acct="markus" exe="/usr/bin/sshd"
> hostname=2a02:aa1:1607:a117:45df:8618:2a17:10db
> addr=2a02:aa1:1607:a117:45df:8618:2a17:10db terminal=ssh res=success'
> Jan 21 02:45:27 staropramen kernel: audit: type=1106
> audit(1611193527.824:281): pid=11767 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 02:45:27 staropramen kernel: audit: type=1104
> audit(1611193527.824:282): pid=11767 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 03:00:02 staropramen kernel: audit: type=1130
> audit(1611194402.614:283): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 03:00:02 staropramen kernel: audit: type=1130
> audit(1611194402.644:284): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 03:00:04 staropramen kernel: audit: type=1131
> audit(1611194404.964:285): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 03:01:04 staropramen kernel: audit: type=1131
> audit(1611194464.987:286): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 04:00:24 staropramen kernel: audit: type=1130
> audit(1611198024.297:287): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 04:00:24 staropramen kernel: audit: type=1130
> audit(1611198024.354:288): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 04:00:25 staropramen kernel: audit: type=1131
> audit(1611198025.447:289): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 04:01:25 staropramen kernel: audit: type=1131
> audit(1611198085.480:290): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 05:00:22 staropramen kernel: audit: type=1130
> audit(1611201622.454:291): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 05:00:22 staropramen kernel: audit: type=1130
> audit(1611201622.474:292): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 05:00:23 staropramen kernel: audit: type=1131
> audit(1611201623.711:293): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 05:01:23 staropramen kernel: audit: type=1131
> audit(1611201683.747:294): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 06:00:24 staropramen kernel: audit: type=1130
> audit(1611205224.297:295): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 06:00:24 staropramen kernel: audit: type=1130
> audit(1611205224.351:296): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 06:00:25 staropramen kernel: audit: type=1131
> audit(1611205225.334:297): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 06:01:25 staropramen kernel: audit: type=1131
> audit(1611205285.367:298): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 07:00:22 staropramen kernel: audit: type=1130
> audit(1611208822.244:299): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 07:00:22 staropramen kernel: audit: type=1130
> audit(1611208822.281:300): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 07:00:23 staropramen kernel: audit: type=1131
> audit(1611208823.398:301): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 07:01:23 staropramen kernel: audit: type=1131
> audit(1611208883.418:302): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 08:00:24 staropramen kernel: audit: type=1130
> audit(1611212424.298:303): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 08:00:24 staropramen kernel: audit: type=1130
> audit(1611212424.318:304): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 08:00:25 staropramen kernel: audit: type=1131
> audit(1611212425.231:305): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 08:01:25 staropramen kernel: audit: type=1131
> audit(1611212485.264:306): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 09:00:24 staropramen kernel: audit: type=1130
> audit(1611216024.295:307): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 09:00:24 staropramen kernel: audit: type=1130
> audit(1611216024.308:308): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 09:00:25 staropramen kernel: audit: type=1131
> audit(1611216025.125:309): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 09:01:25 staropramen kernel: audit: type=1131
> audit(1611216085.155:310): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 10:00:24 staropramen kernel: audit: type=1130
> audit(1611219624.295:311): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 10:00:24 staropramen kernel: audit: type=1130
> audit(1611219624.321:312): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 10:00:25 staropramen kernel: audit: type=1131
> audit(1611219625.128:313): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 10:01:25 staropramen kernel: audit: type=1131
> audit(1611219685.155:314): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 11:00:24 staropramen kernel: audit: type=1130
> audit(1611223224.298:315): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 11:00:24 staropramen kernel: audit: type=1130
> audit(1611223224.322:316): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 11:00:25 staropramen kernel: audit: type=1131
> audit(1611223225.155:317): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 11:01:25 staropramen kernel: audit: type=1131
> audit(1611223285.178:318): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 12:00:16 staropramen kernel: audit: type=1130
> audit(1611226816.525:319): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 12:00:16 staropramen kernel: audit: type=1130
> audit(1611226816.552:320): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 12:00:17 staropramen kernel: audit: type=1131
> audit(1611226817.502:321): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 12:01:17 staropramen kernel: audit: type=1131
> audit(1611226877.532:322): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 13:00:16 staropramen kernel: audit: type=1130
> audit(1611230416.555:323): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 13:00:16 staropramen kernel: audit: type=1130
> audit(1611230416.595:324): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 13:00:17 staropramen kernel: audit: type=1131
> audit(1611230417.289:325): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 13:01:17 staropramen kernel: audit: type=1131
> audit(1611230477.322:326): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 13:54:58 staropramen kernel: audit: type=1100
> audit(1611233698.682:327): pid=363390 uid=0 auid=4294967295 ses=4294967295
> msg='op=PAM:authentication
> grantors=pam_shells,pam_faillock,pam_permit,pam_faillock acct="markus"
> exe="/usr/bin/sshd" hostname=192.168.1.1 addr=192.168.1.1 terminal=ssh
> res=success'
> Jan 21 13:54:58 staropramen kernel: audit: type=1101
> audit(1611233698.692:328): pid=363390 uid=0 auid=4294967295 ses=4294967295
> msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time
> acct="markus" exe="/usr/bin/sshd" hostname=192.168.1.1 addr=192.168.1.1
> terminal=ssh res=success'
> Jan 21 13:54:58 staropramen kernel: audit: type=1103
> audit(1611233698.695:329): pid=363390 uid=0 auid=4294967295 ses=4294967295
> msg='op=PAM:setcred grantors=pam_shells,pam_faillock,pam_permit,pam_faillock
> acct="markus" exe="/usr/bin/sshd" hostname=192.168.1.1 addr=192.168.1.1
> terminal=ssh res=success'
> Jan 21 13:54:58 staropramen kernel: audit: type=1006
> audit(1611233698.695:330): pid=363390 uid=0 old-auid=4294967295 auid=1000
> tty=(none) old-ses=4294967295 ses=5 res=1
> Jan 21 13:54:58 staropramen kernel: audit: type=1105
> audit(1611233698.719:331): pid=363390 uid=0 auid=1000 ses=5
> msg='op=PAM:session_open grantors=pam_loginuid,pam_keyinit,pam_limits,pam_unix,pam_permit,pam_mail,pam_systemd,pam_env
> acct="markus" exe="/usr/bin/sshd" hostname=192.168.1.1 addr=192.168.1.1
> terminal=ssh res=success'
> Jan 21 13:54:58 staropramen kernel: audit: type=1103
> audit(1611233698.722:332): pid=363427 uid=0 auid=1000 ses=5
> msg='op=PAM:setcred grantors=pam_shells,pam_faillock,pam_permit,pam_faillock
> acct="markus" exe="/usr/bin/sshd" hostname=192.168.1.1 addr=192.168.1.1
> terminal=ssh res=success'
> Jan 21 13:55:09 staropramen kernel: audit: type=1100
> audit(1611233709.672:333): pid=363598 uid=1000 auid=1000 ses=1
> msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock
> acct="markus" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 13:55:09 staropramen kernel: audit: type=1101
> audit(1611233709.675:334): pid=363598 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 13:55:09 staropramen kernel: audit: type=1110
> audit(1611233709.675:335): pid=363598 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 13:55:09 staropramen kernel: audit: type=1105
> audit(1611233709.675:336): pid=363598 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 13:55:09 staropramen kernel: audit: type=1106
> audit(1611233709.699:337): pid=363598 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 13:55:09 staropramen kernel: audit: type=1104
> audit(1611233709.699:338): pid=363598 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 13:55:18 staropramen kernel: audit: type=1101
> audit(1611233718.339:339): pid=363802 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 13:55:18 staropramen kernel: audit: type=1110
> audit(1611233718.339:340): pid=363802 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 13:55:18 staropramen kernel: audit: type=1105
> audit(1611233718.339:341): pid=363802 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 13:55:18 staropramen kernel: audit: type=1106
> audit(1611233718.342:342): pid=363802 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 13:55:18 staropramen kernel: audit: type=1104
> audit(1611233718.342:343): pid=363802 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 14:00:44 staropramen kernel: audit: type=1130
> audit(1611234044.285:344): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 14:00:44 staropramen kernel: audit: type=1130
> audit(1611234044.295:345): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 14:00:45 staropramen kernel: audit: type=1131
> audit(1611234045.065:346): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 14:01:45 staropramen kernel: audit: type=1131
> audit(1611234105.095:347): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?
> addr=? terminal=? res=success'
> Jan 21 14:13:28 staropramen kernel: audit: type=1100
> audit(1611234808.692:348): pid=381929 uid=1000 auid=1000 ses=1
> msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock
> acct="markus" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 14:13:28 staropramen kernel: audit: type=1101
> audit(1611234808.692:349): pid=381929 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 14:13:28 staropramen kernel: audit: type=1110
> audit(1611234808.692:350): pid=381929 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 14:13:28 staropramen kernel: audit: type=1105
> audit(1611234808.692:351): pid=381929 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 14:13:28 staropramen kernel: audit: type=1106
> audit(1611234808.695:352): pid=381929 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 14:13:28 staropramen kernel: audit: type=1104
> audit(1611234808.695:353): pid=381929 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 14:13:35 staropramen kernel: audit: type=1101
> audit(1611234815.505:354): pid=382101 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 14:13:35 staropramen kernel: audit: type=1110
> audit(1611234815.509:355): pid=382101 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 14:13:35 staropramen kernel: audit: type=1105
> audit(1611234815.509:356): pid=382101 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> Jan 21 14:13:35 staropramen kernel: BTRFS info (device nvme1n1p2): balance:
> start -dusage=100 -mconvert=raid1 -sconvert=raid1
> Jan 21 14:13:35 staropramen kernel: ------------[ cut here ]------------
> Jan 21 14:13:35 staropramen kernel: BTRFS: Transaction aborted (error -28)
> Jan 21 14:13:35 staropramen kernel: WARNING: CPU: 3 PID: 382102 at
> fs/btrfs/free-space-cache.c:281 btrfs_truncate_free_space_cache+0x1c0/0x1f0
> [btrfs]
> Jan 21 14:13:35 staropramen kernel: Modules linked in: veth xt_nat xt_tcpudp
> xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
> iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> br_netfilter bridge stp llc xfs snd_hda_codec_hdmi snd_hda_codec_realtek
> snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg
> soundwire_intel soundwire_generic_allocation soundwire_cadence
> intel_rapl_msr intel_rapl_common snd_hda_codec x86_pkg_temp_thermal
> snd_hda_core eeepc_wmi intel_powerclamp coretemp snd_hwdep asus_wmi
> soundwire_bus iTCO_wdt i915 crct10dif_pclmul sparse_keymap vfat
> intel_pmc_bxt crc32_pclmul fat ppdev ghash_clmulni_intel iTCO_vendor_support
> ee1004 mei_hdcp rfkill snd_soc_core mxm_wmi wmi_bmof aesni_intel crypto_simd
> i2c_algo_bit cryptd glue_helper drm_kms_helper rapl snd_compress
> intel_cstate ac97_bus snd_pcm_dmaengine intel_uncore snd_pcm cec snd_timer
> i2c_i801 intel_gtt snd soundcore i2c_smbus uas e1000e mei_me syscopyarea
> sysfillrect usb_storage parport_pc
> Jan 21 14:13:35 staropramen kernel:  sysimgblt mei fb_sys_fops parport wmi
> video mac_hid acpi_pad nfsd auth_rpcgss drm nfs_acl lockd grace agpgart
> sunrpc fuse zram nfs_ssc bpf_preload ip_tables x_tables btrfs
> blake2b_generic libcrc32c crc32c_generic xor crc32c_intel raid6_pq serio_raw
> xhci_pci xhci_pci_renesas
> Jan 21 14:13:35 staropramen kernel: CPU: 3 PID: 382102 Comm: btrfs Not
> tainted 5.10.9-arch1-1 #1
> Jan 21 14:13:35 staropramen kernel: Hardware name: System manufacturer
> System Product Name/PRIME B250M-A, BIOS 1205 05/11/2018
> Jan 21 14:13:35 staropramen kernel: RIP:
> 0010:btrfs_truncate_free_space_cache+0x1c0/0x1f0 [btrfs]
> Jan 21 14:13:35 staropramen kernel: Code: 55 50 f0 48 0f ba aa 40 0a 00 00
> 02 72 22 83 f8 fb 74 40 83 f8 e2 74 3b 89 c6 48 c7 c7 88 59 54 c0 89 44 24
> 04 e8 9a 88 94 f0 <0f> 0b 8b 44 24 04 89 c1 ba 19 01 00 00 48 89 ef 89 44 24
> 04 48 c7
> Jan 21 14:13:35 staropramen kernel: RSP: 0018:ffff9f290cc4bcf8 EFLAGS:
> 00010282
> Jan 21 14:13:35 staropramen kernel: RAX: 0000000000000000 RBX:
> ffff91b68e7c0400 RCX: ffff91b72ed98bb8
> Jan 21 14:13:35 staropramen kernel: RDX: 00000000ffffffd8 RSI:
> 0000000000000027 RDI: ffff91b72ed98bb0
> Jan 21 14:13:35 staropramen kernel: RBP: ffff91b6b5abff70 R08:
> 0000000000000000 R09: ffff9f290cc4bb30
> Jan 21 14:13:35 staropramen kernel: R10: ffff9f290cc4bb28 R11:
> ffffffffb1ecb228 R12: ffff91b6b59ca258
> Jan 21 14:13:35 staropramen kernel: R13: ffff91b65a5670e0 R14:
> ffff91b60455b800 R15: ffff91b68e7c0410
> Jan 21 14:13:35 staropramen kernel: FS:  00007f8a24ae68c0(0000)
> GS:ffff91b72ed80000(0000) knlGS:0000000000000000
> Jan 21 14:13:35 staropramen kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jan 21 14:13:35 staropramen kernel: CR2: 000055db4cefc2cc CR3:
> 00000000196de002 CR4: 00000000003706e0
> Jan 21 14:13:35 staropramen kernel: Call Trace:
> Jan 21 14:13:35 staropramen kernel:  delete_block_group_cache+0x6f/0xb0
> [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_relocate_block_group+0xd3/0x300
> [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_relocate_chunk+0x27/0xc0 [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_balance+0x739/0xf00 [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_ioctl_balance+0x2c9/0x380 [btrfs]
> Jan 21 14:13:35 staropramen kernel:  __x64_sys_ioctl+0x83/0xb0
> Jan 21 14:13:35 staropramen kernel:  do_syscall_64+0x33/0x40
> Jan 21 14:13:35 staropramen kernel:
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Jan 21 14:13:35 staropramen kernel: RIP: 0033:0x7f8a24c13f6b
> Jan 21 14:13:35 staropramen kernel: Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39
> c4 72 b5 e8 1c ff ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8
> 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 ae 0c 00 f7 d8 64
> 89 01 48
> Jan 21 14:13:35 staropramen kernel: RSP: 002b:00007fffa80dd188 EFLAGS:
> 00000246 ORIG_RAX: 0000000000000010
> Jan 21 14:13:35 staropramen kernel: RAX: ffffffffffffffda RBX:
> 0000000000000000 RCX: 00007f8a24c13f6b
> Jan 21 14:13:35 staropramen kernel: RDX: 00007fffa80dd230 RSI:
> 00000000c4009420 RDI: 0000000000000003
> Jan 21 14:13:35 staropramen kernel: RBP: 0000000000000003 R08:
> 0000000000000000 R09: 00007f8a24ca40c0
> Jan 21 14:13:35 staropramen kernel: R10: 0000000000000000 R11:
> 0000000000000246 R12: 00007fffa80de872
> Jan 21 14:13:35 staropramen kernel: R13: 0000000000000001 R14:
> 00007fffa80dd230 R15: 0000000000000003
> Jan 21 14:13:35 staropramen kernel: ---[ end trace 6aa131643b83585b ]---
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS info (device nvme1n1p2): skipping
> relocation of block group 203168940032 due to active swapfile
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_truncate_free_space_cache:281: Aborting unused transaction(No space
> left).
> Jan 21 14:13:35 staropramen kernel: ------------[ cut here ]------------
> Jan 21 14:13:35 staropramen kernel: kernel BUG at
> fs/btrfs/relocation.c:3494!
> Jan 21 14:13:35 staropramen kernel: invalid opcode: 0000 [#1] PREEMPT SMP
> PTI
> Jan 21 14:13:35 staropramen kernel: CPU: 3 PID: 382102 Comm: btrfs Tainted:
> G        W         5.10.9-arch1-1 #1
> Jan 21 14:13:35 staropramen kernel: Hardware name: System manufacturer
> System Product Name/PRIME B250M-A, BIOS 1205 05/11/2018
> Jan 21 14:13:35 staropramen kernel: RIP: 0010:create_reloc_inode+0x117/0x250
> [btrfs]
> Jan 21 14:13:35 staropramen kernel: Code: e8 0e 29 f8 ff 48 89 c3 48 85 c0
> 74 1d 4c 89 f9 48 89 c2 48 89 ee 4c 89 e7 e8 55 95 f9 ff 85 c0 74 0a 48 89
> df e8 09 2d f8 ff <0f> 0b 48 63 43 40 4c 8b 33 ba 11 00 00 00 48 8d 04 80 4c
> 89 f7 48
> Jan 21 14:13:35 staropramen kernel: RSP: 0018:ffff9f290cc4bd18 EFLAGS:
> 00010282
> Jan 21 14:13:35 staropramen kernel: RAX: 0000000000000000 RBX:
> ffff91b65a5670e0 RCX: 00000000851dbc03
> Jan 21 14:13:35 staropramen kernel: RDX: 00000000851dba03 RSI:
> ffffffffc04e98b7 RDI: 0000000000033d80
> Jan 21 14:13:35 staropramen kernel: RBP: ffff91b603ac5000 R08:
> 0000000000000000 R09: 0000000000000000
> Jan 21 14:13:35 staropramen kernel: R10: 0000000000000001 R11:
> 0000000000000000 R12: ffff91b6b5abff70
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: R13: ffff91b60478b000 R14:
> 0000000000000000 R15: 0000000000000101
> Jan 21 14:13:35 staropramen kernel: FS:  00007f8a24ae68c0(0000)
> GS:ffff91b72ed80000(0000) knlGS:0000000000000000
> Jan 21 14:13:35 staropramen kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jan 21 14:13:35 staropramen kernel: CR2: 000055db4cefc2cc CR3:
> 00000000196de002 CR4: 00000000003706e0
> Jan 21 14:13:35 staropramen kernel: Call Trace:
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS warning (device nvme1n1p2):
> btrfs_finish_ordered_io:2730: Aborting unused transaction(No space left).
> Jan 21 14:13:35 staropramen kernel: BTRFS: error (device nvme1n1p2) in
> cleanup_transaction:1941: errno=-30 Readonly filesystem
> Jan 21 14:13:35 staropramen kernel: BTRFS info (device nvme1n1p2): forced
> readonly
> Jan 21 14:13:35 staropramen kernel:  btrfs_relocate_block_group+0xfc/0x300
> [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_relocate_chunk+0x27/0xc0 [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_balance+0x739/0xf00 [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_ioctl_balance+0x2c9/0x380 [btrfs]
> Jan 21 14:13:35 staropramen kernel:  __x64_sys_ioctl+0x83/0xb0
> Jan 21 14:13:35 staropramen kernel:  do_syscall_64+0x33/0x40
> Jan 21 14:13:35 staropramen kernel:
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Jan 21 14:13:35 staropramen kernel: RIP: 0033:0x7f8a24c13f6b
> Jan 21 14:13:35 staropramen kernel: Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39
> c4 72 b5 e8 1c ff ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8
> 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 ae 0c 00 f7 d8 64
> 89 01 48
> Jan 21 14:13:35 staropramen kernel: RSP: 002b:00007fffa80dd188 EFLAGS:
> 00000246 ORIG_RAX: 0000000000000010
> Jan 21 14:13:35 staropramen kernel: RAX: ffffffffffffffda RBX:
> 0000000000000000 RCX: 00007f8a24c13f6b
> Jan 21 14:13:35 staropramen kernel: RDX: 00007fffa80dd230 RSI:
> 00000000c4009420 RDI: 0000000000000003
> Jan 21 14:13:35 staropramen kernel: RBP: 0000000000000003 R08:
> 0000000000000000 R09: 00007f8a24ca40c0
> Jan 21 14:13:35 staropramen kernel: R10: 0000000000000000 R11:
> 0000000000000246 R12: 00007fffa80de872
> Jan 21 14:13:35 staropramen kernel: R13: 0000000000000001 R14:
> 00007fffa80dd230 R15: 0000000000000003
> Jan 21 14:13:35 staropramen kernel: Modules linked in: veth xt_nat xt_tcpudp
> xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
> iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> br_netfilter bridge stp llc xfs snd_hda_codec_hdmi snd_hda_codec_realtek
> snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg
> soundwire_intel soundwire_generic_allocation soundwire_cadence
> intel_rapl_msr intel_rapl_common snd_hda_codec x86_pkg_temp_thermal
> snd_hda_core eeepc_wmi intel_powerclamp coretemp snd_hwdep asus_wmi
> soundwire_bus iTCO_wdt i915 crct10dif_pclmul sparse_keymap vfat
> intel_pmc_bxt crc32_pclmul fat ppdev ghash_clmulni_intel iTCO_vendor_support
> ee1004 mei_hdcp rfkill snd_soc_core mxm_wmi wmi_bmof aesni_intel crypto_simd
> i2c_algo_bit cryptd glue_helper drm_kms_helper rapl snd_compress
> intel_cstate ac97_bus snd_pcm_dmaengine intel_uncore snd_pcm cec snd_timer
> i2c_i801 intel_gtt snd soundcore i2c_smbus uas e1000e mei_me syscopyarea
> sysfillrect usb_storage parport_pc
> Jan 21 14:13:35 staropramen kernel:  sysimgblt mei fb_sys_fops parport wmi
> video mac_hid acpi_pad nfsd auth_rpcgss drm nfs_acl lockd grace agpgart
> sunrpc fuse zram nfs_ssc bpf_preload ip_tables x_tables btrfs
> blake2b_generic libcrc32c crc32c_generic xor crc32c_intel raid6_pq serio_raw
> xhci_pci xhci_pci_renesas
> Jan 21 14:13:35 staropramen kernel: ---[ end trace 6aa131643b83585c ]---
> Jan 21 14:13:35 staropramen kernel: ------------[ cut here ]------------
> Jan 21 14:13:35 staropramen kernel: WARNING: CPU: 1 PID: 382102 at
> kernel/rcu/tree_plugin.h:297 rcu_note_context_switch+0x42/0x480
> Jan 21 14:13:35 staropramen kernel: Modules linked in: veth xt_nat xt_tcpudp
> xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
> iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> br_netfilter bridge stp llc xfs snd_hda_codec_hdmi snd_hda_codec_realtek
> snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg
> soundwire_intel soundwire_generic_allocation soundwire_cadence
> intel_rapl_msr intel_rapl_common snd_hda_codec x86_pkg_temp_thermal
> snd_hda_core eeepc_wmi intel_powerclamp coretemp snd_hwdep asus_wmi
> soundwire_bus iTCO_wdt i915 crct10dif_pclmul sparse_keymap vfat
> intel_pmc_bxt crc32_pclmul fat ppdev ghash_clmulni_intel iTCO_vendor_support
> ee1004 mei_hdcp rfkill snd_soc_core mxm_wmi wmi_bmof aesni_intel crypto_simd
> i2c_algo_bit cryptd glue_helper drm_kms_helper rapl snd_compress
> intel_cstate ac97_bus snd_pcm_dmaengine intel_uncore snd_pcm cec snd_timer
> i2c_i801 intel_gtt snd soundcore i2c_smbus uas e1000e mei_me syscopyarea
> sysfillrect usb_storage parport_pc
> Jan 21 14:13:35 staropramen kernel:  sysimgblt mei fb_sys_fops parport wmi
> video mac_hid acpi_pad nfsd auth_rpcgss drm nfs_acl lockd grace agpgart
> sunrpc fuse zram nfs_ssc bpf_preload ip_tables x_tables btrfs
> blake2b_generic libcrc32c crc32c_generic xor crc32c_intel raid6_pq serio_raw
> xhci_pci xhci_pci_renesas
> Jan 21 14:13:35 staropramen kernel: CPU: 1 PID: 382102 Comm: btrfs Tainted:
> G      D W         5.10.9-arch1-1 #1
> Jan 21 14:13:35 staropramen kernel: Hardware name: System manufacturer
> System Product Name/PRIME B250M-A, BIOS 1205 05/11/2018
> Jan 21 14:13:35 staropramen kernel: RIP:
> 0010:rcu_note_context_switch+0x42/0x480
> Jan 21 14:13:35 staropramen kernel: Code: c3 40 cf 02 00 65 48 03 1d 13 ef
> af 4f 0f 1f 44 00 00 40 84 ed 75 15 65 48 8b 04 25 c0 7b 01 00 8b 90 b0 03
> 00 00 85 d2 7e 02 <0f> 0b 65 48 8b 04 25 c0 7b 01 00 8b 80 b0 03 00 00 85 c0
> 7e 0a 41
> Jan 21 14:13:35 staropramen kernel: RSP: 0018:ffff9f290cc4b760 EFLAGS:
> 00010002
> Jan 21 14:13:35 staropramen kernel: RAX: ffff91b600b00000 RBX:
> ffff91b72ecacf40 RCX: 0000000000000000
> Jan 21 14:13:35 staropramen kernel: RDX: 0000000000000001 RSI:
> ffffffffb0e7ecbb RDI: 0000000000000000
> Jan 21 14:13:35 staropramen kernel: RBP: 0000000000000000 R08:
> 0000000000000001 R09: ffff91b72ed2c2b0
> Jan 21 14:13:35 staropramen kernel: R10: 0000000000001c09 R11:
> 0000000000000000 R12: 000000000002c180
> Jan 21 14:13:35 staropramen kernel: R13: ffff91b600b00000 R14:
> ffff91b600b00000 R15: ffff91b72ecac180
> Jan 21 14:13:35 staropramen kernel: FS:  00007f8a24ae68c0(0000)
> GS:ffff91b72ec80000(0000) knlGS:0000000000000000
> Jan 21 14:13:35 staropramen kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jan 21 14:13:35 staropramen kernel: CR2: 00007f9c20032058 CR3:
> 00000000196de003 CR4: 00000000003706e0
> Jan 21 14:13:35 staropramen kernel: Call Trace:
> Jan 21 14:13:35 staropramen kernel:  __schedule+0xae/0x810
> Jan 21 14:13:35 staropramen kernel:  schedule+0x5b/0xc0
> Jan 21 14:13:35 staropramen kernel:  schedule_timeout+0x11c/0x160
> Jan 21 14:13:35 staropramen kernel:  wait_for_completion+0x9e/0x100
> Jan 21 14:13:35 staropramen kernel:
> virt_efi_query_variable_info+0x141/0x150
> Jan 21 14:13:35 staropramen kernel:  efi_query_variable_store+0x7b/0x1e0
> Jan 21 14:13:35 staropramen kernel:  ? vsnprintf+0x6e/0x4f0
> Jan 21 14:13:35 staropramen kernel:  efivar_entry_set_safe+0xbd/0x210
> Jan 21 14:13:35 staropramen kernel:  efi_pstore_write+0x12d/0x1a0
> Jan 21 14:13:35 staropramen kernel:  pstore_dump+0x1b3/0x2f0
> Jan 21 14:13:35 staropramen kernel:  kmsg_dump+0xa8/0xd0
> Jan 21 14:13:35 staropramen kernel:  oops_end+0x61/0xd0
> Jan 21 14:13:35 staropramen kernel:  do_trap+0x8d/0x110
> Jan 21 14:13:35 staropramen kernel:  ? create_reloc_inode+0x117/0x250
> [btrfs]
> Jan 21 14:13:35 staropramen kernel:  do_error_trap+0x64/0xa0
> Jan 21 14:13:35 staropramen kernel:  ? create_reloc_inode+0x117/0x250
> [btrfs]
> Jan 21 14:13:35 staropramen kernel:  exc_invalid_op+0x4e/0x70
> Jan 21 14:13:35 staropramen kernel:  ? create_reloc_inode+0x117/0x250
> [btrfs]
> Jan 21 14:13:35 staropramen kernel:  asm_exc_invalid_op+0x12/0x20
> Jan 21 14:13:35 staropramen kernel: RIP: 0010:create_reloc_inode+0x117/0x250
> [btrfs]
> Jan 21 14:13:35 staropramen kernel: Code: e8 0e 29 f8 ff 48 89 c3 48 85 c0
> 74 1d 4c 89 f9 48 89 c2 48 89 ee 4c 89 e7 e8 55 95 f9 ff 85 c0 74 0a 48 89
> df e8 09 2d f8 ff <0f> 0b 48 63 43 40 4c 8b 33 ba 11 00 00 00 48 8d 04 80 4c
> 89 f7 48
> Jan 21 14:13:35 staropramen kernel: RSP: 0018:ffff9f290cc4bd18 EFLAGS:
> 00010282
> Jan 21 14:13:35 staropramen kernel: RAX: 0000000000000000 RBX:
> ffff91b65a5670e0 RCX: 00000000851dbc03
> Jan 21 14:13:35 staropramen kernel: RDX: 00000000851dba03 RSI:
> ffffffffc04e98b7 RDI: 0000000000033d80
> Jan 21 14:13:35 staropramen kernel: RBP: ffff91b603ac5000 R08:
> 0000000000000000 R09: 0000000000000000
> Jan 21 14:13:35 staropramen kernel: R10: 0000000000000001 R11:
> 0000000000000000 R12: ffff91b6b5abff70
> Jan 21 14:13:35 staropramen kernel: R13: ffff91b60478b000 R14:
> 0000000000000000 R15: 0000000000000101
> Jan 21 14:13:35 staropramen kernel:  ? create_reloc_inode+0x117/0x250
> [btrfs]
> Jan 21 14:13:35 staropramen kernel:  ? create_reloc_inode+0x117/0x250
> [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_relocate_block_group+0xfc/0x300
> [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_relocate_chunk+0x27/0xc0 [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_balance+0x739/0xf00 [btrfs]
> Jan 21 14:13:35 staropramen kernel:  btrfs_ioctl_balance+0x2c9/0x380 [btrfs]
> Jan 21 14:13:35 staropramen kernel:  __x64_sys_ioctl+0x83/0xb0
> Jan 21 14:13:35 staropramen kernel:  do_syscall_64+0x33/0x40
> Jan 21 14:13:35 staropramen kernel:
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Jan 21 14:13:35 staropramen kernel: RIP: 0033:0x7f8a24c13f6b
> Jan 21 14:13:35 staropramen kernel: Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39
> c4 72 b5 e8 1c ff ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8
> 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 ae 0c 00 f7 d8 64
> 89 01 48
> Jan 21 14:13:35 staropramen kernel: RSP: 002b:00007fffa80dd188 EFLAGS:
> 00000246 ORIG_RAX: 0000000000000010
> Jan 21 14:13:35 staropramen kernel: RAX: ffffffffffffffda RBX:
> 0000000000000000 RCX: 00007f8a24c13f6b
> Jan 21 14:13:35 staropramen kernel: RDX: 00007fffa80dd230 RSI:
> 00000000c4009420 RDI: 0000000000000003
> Jan 21 14:13:35 staropramen kernel: RBP: 0000000000000003 R08:
> 0000000000000000 R09: 00007f8a24ca40c0
> Jan 21 14:13:35 staropramen kernel: R10: 0000000000000000 R11:
> 0000000000000246 R12: 00007fffa80de872
> Jan 21 14:13:35 staropramen kernel: R13: 0000000000000001 R14:
> 00007fffa80dd230 R15: 0000000000000003
> Jan 21 14:13:35 staropramen kernel: ---[ end trace 6aa131643b83585d ]---
> Jan 21 14:13:36 staropramen kernel: RIP: 0010:create_reloc_inode+0x117/0x250
> [btrfs]
> Jan 21 14:13:36 staropramen kernel: Code: e8 0e 29 f8 ff 48 89 c3 48 85 c0
> 74 1d 4c 89 f9 48 89 c2 48 89 ee 4c 89 e7 e8 55 95 f9 ff 85 c0 74 0a 48 89
> df e8 09 2d f8 ff <0f> 0b 48 63 43 40 4c 8b 33 ba 11 00 00 00 48 8d 04 80 4c
> 89 f7 48
> Jan 21 14:13:36 staropramen kernel: RSP: 0018:ffff9f290cc4bd18 EFLAGS:
> 00010282
> Jan 21 14:13:36 staropramen kernel: RAX: 0000000000000000 RBX:
> ffff91b65a5670e0 RCX: 00000000851dbc03
> Jan 21 14:13:36 staropramen kernel: RDX: 00000000851dba03 RSI:
> ffffffffc04e98b7 RDI: 0000000000033d80
> Jan 21 14:13:36 staropramen kernel: RBP: ffff91b603ac5000 R08:
> 0000000000000000 R09: 0000000000000000
> Jan 21 14:13:36 staropramen kernel: R10: 0000000000000001 R11:
> 0000000000000000 R12: ffff91b6b5abff70
> Jan 21 14:13:36 staropramen kernel: R13: ffff91b60478b000 R14:
> 0000000000000000 R15: 0000000000000101
> Jan 21 14:13:36 staropramen kernel: FS:  00007f8a24ae68c0(0000)
> GS:ffff91b72ed80000(0000) knlGS:0000000000000000
> Jan 21 14:13:36 staropramen kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jan 21 14:13:36 staropramen kernel: CR2: 000055db4cefc2cc CR3:
> 00000000196de002 CR4: 00000000003706e0
> Jan 21 14:22:29 staropramen kernel: audit: type=1106
> audit(1611234816.135:357): pid=382101 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1104
> audit(1611234816.135:358): pid=382101 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1
> res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1701
> audit(1611234816.135:359): auid=1000 uid=1000 gid=0 ses=1 pid=382101
> comm="sudo" exe="/usr/bin/sudo" sig=11 res=1
> Jan 21 14:22:29 staropramen kernel: audit: type=1334
> audit(1611234816.199:360): prog-id=28 op=LOAD
> Jan 21 14:22:29 staropramen kernel: audit: type=1334
> audit(1611234816.199:361): prog-id=29 op=LOAD
> Jan 21 14:22:29 staropramen kernel: audit: type=1130
> audit(1611234816.202:362): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-coredump@1-382112-0 comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1131
> audit(1611234816.309:363): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-coredump@1-382112-0 comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 14:22:29 staropramen kernel: kauditd_printk_skb: 2 callbacks
> suppressed
> Jan 21 14:22:29 staropramen kernel: audit: type=1701
> audit(1611234988.792:366): auid=4294967295 uid=0 gid=0 ses=4294967295
> pid=248 comm="systemd-journal" exe="/usr/lib/systemd/systemd-journald" sig=6
> res=1
> Jan 21 14:22:29 staropramen kernel: audit: type=1100
> audit(1611234997.522:367): pid=385133 uid=1000 auid=1000 ses=1
> msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock
> acct="markus" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2
> res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1101
> audit(1611234997.525:368): pid=385133 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1110
> audit(1611234997.525:369): pid=385133 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2
> res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1105
> audit(1611234997.525:370): pid=385133 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
> Jan 21 14:22:29 staropramen kernel: BTRFS info (device nvme1n1p2): disk
> space caching is enabled
> Jan 21 14:22:29 staropramen kernel: BTRFS error (device nvme1n1p2):
> Remounting read-write after error is not allowed
> Jan 21 14:22:29 staropramen kernel: audit: type=1106
> audit(1611234997.555:371): pid=385133 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2
> res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1104
> audit(1611234997.555:372): pid=385133 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2
> res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1101
> audit(1611235036.129:373): pid=385838 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1110
> audit(1611235036.129:374): pid=385838 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2
> res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1105
> audit(1611235036.129:375): pid=385838 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
> Jan 21 14:22:29 staropramen kernel: BTRFS info (device nvme1n1p2): disk
> space caching is enabled
> Jan 21 14:22:29 staropramen kernel: BTRFS error (device nvme1n1p2):
> Remounting read-write after error is not allowed
> Jan 21 14:22:29 staropramen kernel: audit: type=1106
> audit(1611235036.135:376): pid=385838 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2
> res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1104
> audit(1611235036.135:377): pid=385838 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2
> res=success'
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: State
> 'stop-watchdog' timed out. Killing.
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: Killing
> process 248 (systemd-journal) with signal SIGKILL.
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: Killing
> process 382104 (journal-offline) with signal SIGKILL.
> Jan 21 14:22:29 staropramen kernel: audit: type=1101
> audit(1611235079.002:378): pid=386559 uid=1000 auid=1000 ses=1
> msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="markus"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1110
> audit(1611235079.002:379): pid=386559 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2
> res=success'
> Jan 21 14:22:29 staropramen kernel: BTRFS info (device nvme1n1p2): disk
> space caching is enabled
> Jan 21 14:22:29 staropramen kernel: audit: type=1105
> audit(1611235079.002:380): pid=386559 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
> Jan 21 14:22:29 staropramen kernel: BTRFS error (device nvme1n1p2):
> Remounting read-write after error is not allowed
> Jan 21 14:22:29 staropramen kernel: audit: type=1106
> audit(1611235079.005:381): pid=386559 uid=1000 auid=1000 ses=1
> msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2
> res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1104
> audit(1611235079.005:382): pid=386559 uid=1000 auid=1000 ses=1
> msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock
> acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2
> res=success'
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: Processes
> still around after SIGKILL. Ignoring.
> Jan 21 14:22:29 staropramen kernel: audit: type=1701
> audit(1611235179.755:383): auid=4294967295 uid=0 gid=0 ses=4294967295
> pid=388248 comm="lpqd" exe="/usr/bin/smbd" sig=6 res=1
> Jan 21 14:22:29 staropramen kernel: audit: type=1334
> audit(1611235179.792:384): prog-id=30 op=LOAD
> Jan 21 14:22:29 staropramen kernel: audit: type=1334
> audit(1611235179.792:385): prog-id=31 op=LOAD
> Jan 21 14:22:29 staropramen systemd[1]: Started Process Core Dump (PID
> 388251/UID 0).
> Jan 21 14:22:29 staropramen kernel: audit: type=1130
> audit(1611235179.795:386): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-coredump@2-388251-0 comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 14:22:29 staropramen systemd[1]: systemd-coredump@2-388251-0.service:
> Succeeded.
> Jan 21 14:22:29 staropramen kernel: audit: type=1131
> audit(1611235179.885:387): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-coredump@2-388251-0 comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1334
> audit(1611235179.902:388): prog-id=31 op=UNLOAD
> Jan 21 14:22:29 staropramen kernel: audit: type=1334
> audit(1611235179.902:389): prog-id=30 op=UNLOAD
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: State
> 'final-sigterm' timed out. Killing.
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: Killing
> process 248 (systemd-journal) with signal SIGKILL.
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: Killing
> process 382104 (journal-offline) with signal SIGKILL.
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: Processes
> still around after final SIGKILL. Entering failed mode.
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: Failed
> with result 'watchdog'.
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: Unit
> process 248 (systemd-journal) remains running after unit stopped.
> Jan 21 14:22:29 staropramen kernel: audit: type=1131
> audit(1611235349.542:390): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=failed'
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: Scheduled
> restart job, restart counter is at 1.
> Jan 21 14:22:29 staropramen systemd[1]: Stopping Flush Journal to Persistent
> Storage...
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journal-flush.service:
> Succeeded.
> Jan 21 14:22:29 staropramen systemd[1]: Stopped Flush Journal to Persistent
> Storage.
> Jan 21 14:22:29 staropramen kernel: audit: type=1131
> audit(1611235349.552:391): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-journal-flush comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 14:22:29 staropramen systemd[1]: Stopped Journal Service.
> Jan 21 14:22:29 staropramen kernel: audit: type=1130
> audit(1611235349.555:392): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 14:22:29 staropramen systemd[1]: systemd-journald.service: Found
> left-over process 248 (systemd-journal) in control group while starting
> unit. Ignoring.
> Jan 21 14:22:29 staropramen kernel: audit: type=1131
> audit(1611235349.555:393): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 14:22:29 staropramen systemd[1]: This usually indicates unclean
> termination of a previous run, or service implementation deficiencies.
> Jan 21 14:22:29 staropramen systemd[1]: Starting Journal Service...
> Jan 21 14:22:29 staropramen kernel: audit: type=1305
> audit(1611235349.599:394): op=set audit_enabled=1 old=1 auid=4294967295
> ses=4294967295 res=1
> Jan 21 14:22:29 staropramen systemd[1]: Started Journal Service.
> Jan 21 14:22:29 staropramen kernel: audit: type=1130
> audit(1611235349.622:395): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> Jan 21 14:22:29 staropramen kernel: audit: type=1130
> audit(1611235349.629:396): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-journal-flush comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 14:32:09 staropramen kernel: audit: type=1701
> audit(1611235929.829:397): auid=4294967295 uid=0 gid=0 ses=4294967295
> pid=400756 comm="lpqd" exe="/usr/bin/smbd" sig=6 res=1
> Jan 21 14:32:09 staropramen kernel: audit: type=1334
> audit(1611235929.865:398): prog-id=32 op=LOAD
> Jan 21 14:32:09 staropramen kernel: audit: type=1334
> audit(1611235929.865:399): prog-id=33 op=LOAD
> Jan 21 14:32:09 staropramen kernel: audit: type=1130
> audit(1611235929.869:400): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-coredump@3-400758-0 comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 14:32:09 staropramen kernel: audit: type=1131
> audit(1611235929.962:401): pid=1 uid=0 auid=4294967295 ses=4294967295
> msg='unit=systemd-coredump@3-400758-0 comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Jan 21 14:32:09 staropramen kernel: audit: type=1334
> audit(1611235929.982:402): prog-id=33 op=UNLOAD
> Jan 21 14:32:09 staropramen kernel: audit: type=1334
> audit(1611235929.982:403): prog-id=32 op=UNLOAD
