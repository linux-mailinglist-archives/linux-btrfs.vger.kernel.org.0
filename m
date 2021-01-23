Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8F301758
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 18:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbhAWRmE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 12:42:04 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:39888 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbhAWRls (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 12:41:48 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 86EB9951533; Sat, 23 Jan 2021 12:40:59 -0500 (EST)
Date:   Sat, 23 Jan 2021 12:40:59 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     aca331s <pleasehelpme@aaathats3as.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Help with restoring a mistakenly wiped with "rsync --delete"
 backup
Message-ID: <20210123174059.GQ31381@hungrycats.org>
References: <5577584.MhkbZ0Pkbq@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5577584.MhkbZ0Pkbq@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 21, 2021 at 04:26:33PM -0600, aca331s wrote:
> Hello, I hope this is being sent to the correct mailing list, I asked on 
> #btrfs on freenode on how to restore and cmurf guided me a bit, but said to 
> ask on the mailing list for potential further help. 
> 
> So essentially I did what's probably pretty common, I had backed up my /home 
> on my laptop as the main system screwed itself over from bad ram, and then was 
> in the process of copying it all back, but accidentally mounted the drive 
> where /home was instead of /mnt and wiped the whole thing.
> 
> I've tried restoring from all 19 trees that btrfs-find-root locates with 
> "btrfs restore -i -o -t x /dev/mapper/cat /home/shorty/test/" and have only 
> got back some empty files and folders. Is there perhaps another thing with 
> btrfs I can do to potentially get back all the content on my home directory or 
> am I down to using photorec and losing all filenames and directory structures?

It's most likely that during the delete, btrfs overwrote recently-freed
metadata pages with new versions that don't have any trace of the files
in them.  If the delete took a few minutes to run, then this has likely
happened several times over, as touching even 0.3% of the filesystem
items is potentially enough to trigger a rewrite of all of the subvol
metadata pages.

Recovery would require a brute-force search of the disk for any metadata
leaf pages that have survived.  The trees that index them are long since
destroyed, so roots will be useless.

You might be able to recover the metadata leaf pages with something
like 'btrfs check --repair --init-extent-tree' (but not _exactly_ that,
because btrfs check will try to reconstruct the most recent transaction,
i.e. the empty trees).  I don't know of an existing tool that does this.

> Help is MUCH appreciated, as just about everything needs to be properly sorted 
> with filenames and directories.
> 
> Advice on other software to use if need be is also appreciated.
> localhost:/home/shorty # uname -a
> Linux localhost.localdomain 5.3.18-lp152.60-default #1 SMP Tue Jan 12 23:10:31 
> UTC 2021 (9898712) x86_64 x86_64 x86_64 GNU/Linux
> localhost:/home/shorty # btrfs --version
> btrfs-progs v5.9 
> localhost:/home/shorty # btrfs fi show
> Label: none  uuid: 43aca663-0462-4b72-a474-d89ac3f8672a
>         Total devices 1 FS bytes used 384.00KiB
>         devid    1 size 931.50GiB used 2.02GiB path /dev/mapper/cat
> localhost:/home/shorty #btrfs restore -l /dev/mapper/cat
>  tree key (EXTENT_TREE ROOT_ITEM 0) 30425088 level 0
>  tree key (DEV_TREE ROOT_ITEM 0) 30441472 level 0
>  tree key (FS_TREE ROOT_ITEM 0) 209043456 level 0
>  tree key (CSUM_TREE ROOT_ITEM 0) 30457856 level 0
>  tree key (UUID_TREE ROOT_ITEM 0) 30507008 level 0
>  tree key (DATA_RELOC_TREE ROOT_ITEM 0) 30490624 level 0
> localhost:/home/shorty # btrfs insp dump-s -f /dev/mapper/cat
> superblock: bytenr=65536, device=/dev/mapper/cat
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x9e250405 [match]
> bytenr                  65536
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    43aca663-0462-4b72-a474-d89ac3f8672a
> metadata_uuid           43aca663-0462-4b72-a474-d89ac3f8672a
> label
> generation              901
> root                    30408704
> sys_array_size          129
> chunk_root_generation   897
> root_level              0
> chunk_root              22020096
> chunk_root_level        0
> log_root                0
> log_root_transid        0
> log_root_level          0
> total_bytes             1000188108800
> bytes_used              393216
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x0
> incompat_flags          0x161
>                         ( MIXED_BACKREF |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           SKINNY_METADATA )
> cache_generation        901
> uuid_tree_generation    901
> dev_item.uuid           fa456d54-33ba-47c7-94a8-b29419f4fd2e
> dev_item.fsid           43aca663-0462-4b72-a474-d89ac3f8672a [match]
> dev_item.type           0
> dev_item.total_bytes    1000188108800
> dev_item.bytes_used     2172649472
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          1
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> sys_chunk_array[2048]:
>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 2 sub_stripes 1
>                         stripe 0 devid 1 offset 22020096
>                         dev_uuid fa456d54-33ba-47c7-94a8-b29419f4fd2e
>                         stripe 1 devid 1 offset 30408704
>                         dev_uuid fa456d54-33ba-47c7-94a8-b29419f4fd2e
> backup_roots[4]:
>         backup 0:
>                 backup_tree_root:       30408704        gen: 901        level: 
> 0
>                 backup_chunk_root:      22020096        gen: 897        level: 
> 0
>                 backup_extent_root:     30425088        gen: 901        level: 
> 0
>                 backup_fs_root:         209043456       gen: 899        level: 
> 0
>                 backup_dev_root:        30441472        gen: 901        level: 
> 0
>                 backup_csum_root:       30457856        gen: 901        level: 
> 0
>                 backup_total_bytes:     1000188108800
>                 backup_bytes_used:      393216
>                 backup_num_devices:     1
>  
>         backup 1:
>                 backup_tree_root:       208994304       gen: 898        level: 
> 0
>                 backup_chunk_root:      22020096        gen: 897        level: 
> 0
>                 backup_extent_root:     209010688       gen: 898        level: 
> 0
>                 backup_fs_root:         197492736       gen: 894        level: 
> 0
>                 backup_dev_root:        208928768       gen: 897        level: 
> 0
>                 backup_csum_root:       209027072       gen: 898        level: 
> 0
>                 backup_total_bytes:     1000188108800
>                 backup_bytes_used:      393216
>                 backup_num_devices:     1
>  
>         backup 2:
>                 backup_tree_root:       209076224       gen: 899        level: 
> 0
>                 backup_chunk_root:      22020096        gen: 897        level: 
> 0
>                 backup_extent_root:     209059840       gen: 899        level: 
> 0
>                 backup_fs_root:         209043456       gen: 899        level: 
> 0
>                 backup_dev_root:        208928768       gen: 897        level: 
> 0
>                 backup_csum_root:       209092608       gen: 899        level: 
> 0
>                 backup_total_bytes:     1000188108800
>                 backup_bytes_used:      393216
>                 backup_num_devices:     1
>  
>         backup 3:
>                 backup_tree_root:       209108992       gen: 900        level: 
> 0
>                 backup_chunk_root:      22020096        gen: 897        level: 
> 0
>                 backup_extent_root:     209125376       gen: 900        level: 
> 0
>                 backup_fs_root:         209043456       gen: 899        level: 
> 0
>                 backup_dev_root:        208928768       gen: 897        level: 
> 0
>                 backup_csum_root:       209141760       gen: 900        level: 
> 0
>                 backup_total_bytes:     1000188108800
>                 backup_bytes_used:      393216
>                 backup_num_devices:     1
> 
> localhost:/home/shorty # btrfs-find-root -a /dev/mapper/cat                            
> Superblock thinks the generation is 901
> Superblock thinks the level is 0
> Well block 30408704(gen: 901 level: 0) seems good, and it matches superblock
> Well block 209108992(gen: 900 level: 0) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 209076224(gen: 899 level: 0) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 208994304(gen: 898 level: 0) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 208945152(gen: 897 level: 0) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 208879616(gen: 896 level: 0) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 208814080(gen: 895 level: 0) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 171163648(gen: 894 level: 1) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 897220608(gen: 893 level: 1) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 606158848(gen: 892 level: 1) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 254181376(gen: 891 level: 1) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 244367360(gen: 890 level: 1) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 30900224(gen: 889 level: 1) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 30883840(gen: 888 level: 0) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 30752768(gen: 888 level: 0) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 30736384(gen: 888 level: 0) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0
> Well block 1010450432(gen: 864 level: 0) seems good, but generation/level 
> doesn't match, want gen: 901 level: 0

> [    0.000000] Linux version 5.3.18-lp152.60-default (geeko@buildhost) (gcc version 7.5.0 (SUSE Linux)) #1 SMP Tue Jan 12 23:10:31 UTC 2021 (9898712)
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.3.18-lp152.60-default root=UUID=f34b3537-5fb9-42c5-be82-68917f4bbb5f splash=silent quiet thinkpad_acpi.fan_control=1 thinkpad_acpi.force_load=1 mitigations=off
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007f71efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007f71f000-0x00000000821fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f3ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed84000-0x00000000fed84fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed90000-0x00000000fed91fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000047ddfffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 3.0 present.
> [    0.000000] DMI: LENOVO ThinkPad T440p/ThinkPad T440p, BIOS 4.13-818-gb9ba0d10a2 01/05/2021
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 2893.575 MHz processor
> [    0.000961] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000962] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000966] last_pfn = 0x47de00 max_arch_pfn = 0x400000000
> [    0.000969] MTRR default type: write-back
> [    0.000970] MTRR fixed ranges enabled:
> [    0.000971]   00000-9FFFF write-back
> [    0.000972]   A0000-BFFFF uncachable
> [    0.000972]   C0000-FFFFF write-back
> [    0.000973] MTRR variable ranges enabled:
> [    0.000974]   0 base 0080000000 mask 7FF0000000 uncachable
> [    0.000975]   1 base 0090000000 mask 7FF0000000 write-combining
> [    0.000975]   2 base 00A0000000 mask 7FE0000000 uncachable
> [    0.000976]   3 base 00C0000000 mask 7FC0000000 uncachable
> [    0.000976]   4 disabled
> [    0.000977]   5 disabled
> [    0.000977]   6 disabled
> [    0.000977]   7 disabled
> [    0.000978]   8 disabled
> [    0.000978]   9 disabled
> [    0.001274] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.001390] last_pfn = 0x7f71f max_arch_pfn = 0x400000000
> [    0.008510] check: Scanning 1 areas for low memory corruption
> [    0.008513] Kernel/User page tables isolation: disabled on command line.
> [    0.008514] Using GB pages for direct mapping
> [    0.008515] BRK [0x429c01000, 0x429c01fff] PGTABLE
> [    0.008517] BRK [0x429c02000, 0x429c02fff] PGTABLE
> [    0.008517] BRK [0x429c03000, 0x429c03fff] PGTABLE
> [    0.008544] BRK [0x429c04000, 0x429c04fff] PGTABLE
> [    0.008546] BRK [0x429c05000, 0x429c05fff] PGTABLE
> [    0.008621] BRK [0x429c06000, 0x429c06fff] PGTABLE
> [    0.008640] BRK [0x429c07000, 0x429c07fff] PGTABLE
> [    0.008675] RAMDISK: [mem 0x3658b000-0x372bcfff]
> [    0.008681] ACPI: Early table checksum verification disabled
> [    0.008683] ACPI: RSDP 0x00000000000F6650 000024 (v02 COREv4)
> [    0.008685] ACPI: XSDT 0x000000007F7420E0 000064 (v01 COREv4 COREBOOT 00000000 CORE 20200717)
> [    0.008689] ACPI: FACP 0x000000007F745920 000114 (v06 COREv4 COREBOOT 00000000 CORE 20200717)
> [    0.008694] ACPI: DSDT 0x000000007F742280 003699 (v02 COREv4 COREBOOT 20141018 INTL 20200717)
> [    0.008696] ACPI: FACS 0x000000007F742240 000040
> [    0.008698] ACPI: FACS 0x000000007F742240 000040
> [    0.008700] ACPI: SSDT 0x000000007F745A40 002CA0 (v02 COREv4 COREBOOT 0000002A CORE 20200717)
> [    0.008702] ACPI: MCFG 0x000000007F7486E0 00003C (v01 COREv4 COREBOOT 00000000 CORE 20200717)
> [    0.008704] ACPI: TCPA 0x000000007F748720 000032 (v02 COREv4 COREBOOT 00000000 CORE 20200717)
> [    0.008706] ACPI: APIC 0x000000007F748760 00008C (v03 COREv4 COREBOOT 00000000 CORE 20200717)
> [    0.008708] ACPI: DMAR 0x000000007F7487F0 0000A0 (v01 COREv4 COREBOOT 00000000 CORE 20200717)
> [    0.008710] ACPI: HPET 0x000000007F748890 000038 (v01 COREv4 COREBOOT 00000000 CORE 20200717)
> [    0.008711] ACPI: SSDT 0x000000007F7488D0 00005C (v02 COREv4 SERIALIO 0000002B CORE 20200717)
> [    0.008717] ACPI: Local APIC address 0xfee00000
> [    0.008802] No NUMA configuration found
> [    0.008803] Faking a node at [mem 0x0000000000000000-0x000000047ddfffff]
> [    0.008808] NODE_DATA(0) allocated [mem 0x47ddea000-0x47ddfffff]
> [    0.008840] Zone ranges:
> [    0.008840]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.008841]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.008842]   Normal   [mem 0x0000000100000000-0x000000047ddfffff]
> [    0.008843]   Device   empty
> [    0.008843] Movable zone start for each node
> [    0.008845] Early memory node ranges
> [    0.008846]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.008846]   node   0: [mem 0x0000000000100000-0x000000007f71efff]
> [    0.008847]   node   0: [mem 0x0000000100000000-0x000000047ddfffff]
> [    0.008876] Zeroed struct page in unavailable ranges: 2371 pages
> [    0.008877] Initmem setup node 0 [mem 0x0000000000001000-0x000000047ddfffff]
> [    0.008878] On node 0 totalpages: 4183229
> [    0.008879]   DMA zone: 64 pages used for memmap
> [    0.008879]   DMA zone: 21 pages reserved
> [    0.008880]   DMA zone: 3998 pages, LIFO batch:0
> [    0.008932]   DMA32 zone: 8093 pages used for memmap
> [    0.008933]   DMA32 zone: 517919 pages, LIFO batch:63
> [    0.017589]   Normal zone: 57208 pages used for memmap
> [    0.017590]   Normal zone: 3661312 pages, LIFO batch:63
> [    0.018003] Reserving Intel graphics memory at [mem 0x80200000-0x821fffff]
> [    0.018211] ACPI: PM-Timer IO Port: 0x508
> [    0.018213] ACPI: Local APIC address 0xfee00000
> [    0.018230] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> [    0.018232] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.018233] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.018234] ACPI: IRQ0 used by override.
> [    0.018235] ACPI: IRQ9 used by override.
> [    0.018236] Using ACPI (MADT) for SMP configuration information
> [    0.018237] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.018240] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> [    0.018249] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.018250] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.018250] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
> [    0.018250] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> [    0.018251] PM: Registered nosave memory: [mem 0x7f71f000-0x821fffff]
> [    0.018252] PM: Registered nosave memory: [mem 0x82200000-0xefffffff]
> [    0.018252] PM: Registered nosave memory: [mem 0xf0000000-0xf3ffffff]
> [    0.018253] PM: Registered nosave memory: [mem 0xf4000000-0xfed0ffff]
> [    0.018253] PM: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
> [    0.018254] PM: Registered nosave memory: [mem 0xfed1a000-0xfed3ffff]
> [    0.018254] PM: Registered nosave memory: [mem 0xfed40000-0xfed44fff]
> [    0.018254] PM: Registered nosave memory: [mem 0xfed45000-0xfed83fff]
> [    0.018255] PM: Registered nosave memory: [mem 0xfed84000-0xfed84fff]
> [    0.018255] PM: Registered nosave memory: [mem 0xfed85000-0xfed8ffff]
> [    0.018256] PM: Registered nosave memory: [mem 0xfed90000-0xfed91fff]
> [    0.018256] PM: Registered nosave memory: [mem 0xfed92000-0xffffffff]
> [    0.018257] [mem 0x82200000-0xefffffff] available for PCI devices
> [    0.018258] Booting paravirtualized kernel on bare hardware
> [    0.018261] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.102326] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
> [    0.102505] percpu: Embedded 57 pages/cpu s196608 r8192 d28672 u262144
> [    0.102509] pcpu-alloc: s196608 r8192 d28672 u262144 alloc=1*2097152
> [    0.102510] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
> [    0.102525] Built 1 zonelists, mobility grouping on.  Total pages: 4117843
> [    0.102525] Policy zone: Normal
> [    0.102527] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.3.18-lp152.60-default root=UUID=f34b3537-5fb9-42c5-be82-68917f4bbb5f splash=silent quiet thinkpad_acpi.fan_control=1 thinkpad_acpi.force_load=1 mitigations=off
> [    0.102627] printk: log_buf_len individual max cpu contribution: 32768 bytes
> [    0.102627] printk: log_buf_len total cpu_extra contributions: 229376 bytes
> [    0.102628] printk: log_buf_len min size: 262144 bytes
> [    0.102679] printk: log_buf_len: 524288 bytes
> [    0.102679] printk: early log buf free: 252832(96%)
> [    0.103432] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.103798] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.103859] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.116196] Memory: 2139608K/16732916K available (12291K kernel code, 1483K rwdata, 4232K rodata, 2164K init, 12980K bss, 409880K reserved, 0K cma-reserved)
> [    0.116202] random: get_random_u64 called from __kmem_cache_create+0x40/0x550 with crng_init=0
> [    0.116309] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> [    0.116320] ftrace: allocating 38719 entries in 152 pages
> [    0.128780] rcu: Hierarchical RCU implementation.
> [    0.128781] rcu: 	RCU event tracing is enabled.
> [    0.128782] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
> [    0.128783] 	Tasks RCU enabled.
> [    0.128783] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.128784] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> [    0.131341] NR_IRQS: 33024, nr_irqs: 488, preallocated irqs: 16
> [    0.131635] random: crng done (trusting CPU's manufacturer)
> [    0.131655] Console: colour dummy device 80x25
> [    0.131658] printk: console [tty0] enabled
> [    0.131671] ACPI: Core revision 20190703
> [    0.131731] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> [    0.131743] APIC: Switch to symmetric I/O mode setup
> [    0.131745] DMAR: Host address width 39
> [    0.131746] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> [    0.131749] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020660462 ecap f0101a
> [    0.131750] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> [    0.131752] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c20660462 ecap f010da
> [    0.131753] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> [    0.131754] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> [    0.131754] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> [    0.132158] DMAR-IR: Enabled IRQ remapping in x2apic mode
> [    0.132159] x2apic enabled
> [    0.132166] Switched APIC routing to cluster x2apic.
> [    0.132648] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.151741] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x29b58d5d7e1, max_idle_ns: 440795237525 ns
> [    0.151744] Calibrating delay loop (skipped), value calculated using timer frequency.. 5787.15 BogoMIPS (lpj=11574300)
> [    0.151746] pid_max: default: 32768 minimum: 301
> [    0.151773] LSM: Security Framework initializing
> [    0.151793] AppArmor: AppArmor initialized
> [    0.151843] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.151869] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.152077] mce: CPU0: Thermal monitoring enabled (TM1)
> [    0.152090] process: using mwait in idle threads
> [    0.152093] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
> [    0.152093] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
> [    0.152096] Speculative Store Bypass: Vulnerable
> [    0.152097] SRBDS: Vulnerable
> [    0.152295] Freeing SMP alternatives memory: 36K
> [    0.153924] TSC deadline timer enabled
> [    0.153927] smpboot: CPU0: Intel(R) Core(TM) i7-4910MQ CPU @ 2.90GHz (family: 0x6, model: 0x3c, stepping: 0x3)
> [    0.154003] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
> [    0.154014] ... version:                3
> [    0.154014] ... bit width:              48
> [    0.154015] ... generic registers:      4
> [    0.154015] ... value mask:             0000ffffffffffff
> [    0.154016] ... max period:             00007fffffffffff
> [    0.154016] ... fixed-purpose events:   3
> [    0.154016] ... event mask:             000000070000000f
> [    0.154041] rcu: Hierarchical SRCU implementation.
> [    0.154632] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.154687] smp: Bringing up secondary CPUs ...
> [    0.154745] x86: Booting SMP configuration:
> [    0.154746] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
> [    0.156102] smp: Brought up 1 node, 8 CPUs
> [    0.156102] smpboot: Max logical packages: 1
> [    0.156102] smpboot: Total of 8 processors activated (46297.20 BogoMIPS)
> [    0.202229] node 0 initialised, 3545857 pages in 48ms
> [    0.204144] devtmpfs: initialized
> [    0.204144] x86/mm: Memory block size: 128MB
> [    0.204664] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.204664] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
> [    0.204664] pinctrl core: initialized pinctrl subsystem
> [    0.204664] PM: RTC time: 21:47:09, date: 2021-01-19
> [    0.204664] NET: Registered protocol family 16
> [    0.204664] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
> [    0.204664] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.204664] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.204664] audit: initializing netlink subsys (disabled)
> [    0.204664] audit: type=2000 audit(1611092829.072:1): state=initialized audit_enabled=0 res=1
> [    0.204664] cpuidle: using governor ladder
> [    0.204664] cpuidle: using governor menu
> [    0.204664] ACPI: bus type PCI registered
> [    0.204664] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.204664] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf0000000-0xf3ffffff] (base 0xf0000000)
> [    0.204664] PCI: MMCONFIG at [mem 0xf0000000-0xf3ffffff] reserved in E820
> [    0.204664] PCI: Using configuration type 1 for base access
> [    0.204664] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
> [    0.207769] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.207769] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.207788] ACPI: Added _OSI(Module Device)
> [    0.207788] ACPI: Added _OSI(Processor Device)
> [    0.207789] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.207790] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.207790] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.207791] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.207792] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.211749] ACPI: 3 ACPI AML tables successfully acquired and loaded
> [    0.211749] ACPI: EC: EC started
> [    0.211749] ACPI: EC: interrupt blocked
> [    0.211749] ACPI: \_SB_.PCI0.LPCB.EC__: Used as first EC
> [    0.211749] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.211749] ACPI: \_SB_.PCI0.LPCB.EC__: Boot DSDT EC used to handle transactions
> [    0.211749] ACPI: Interpreter enabled
> [    0.211749] ACPI: (supports S0 S3 S4 S5)
> [    0.211749] ACPI: Using IOAPIC for interrupt routing
> [    0.211749] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.214083] ACPI: Power Resource [FPWR] (off)
> [    0.214293] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.214297] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    0.214333] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
> [    0.214341] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
> [    0.214394] acpi PNP0A08:00: ignoring host bridge window [mem 0x000c4000-0x000c7fff window] (conflicts with Video ROM [mem 0x000c0000-0x000c6dff])
> [    0.214541] PCI host bridge to bus 0000:00
> [    0.214542] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.214543] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.214544] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.214545] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
> [    0.214546] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
> [    0.214546] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
> [    0.214547] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
> [    0.214548] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
> [    0.214548] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
> [    0.214549] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
> [    0.214550] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> [    0.214550] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> [    0.214551] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
> [    0.214552] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
> [    0.214553] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
> [    0.214553] pci_bus 0000:00: root bus resource [mem 0x82200000-0xefffffff window]
> [    0.214554] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
> [    0.214555] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.214563] pci 0000:00:00.0: [8086:0c04] type 00 class 0x060000
> [    0.214650] pci 0000:00:02.0: [8086:0416] type 00 class 0x030000
> [    0.214659] pci 0000:00:02.0: reg 0x10: [mem 0x82400000-0x827fffff 64bit]
> [    0.214663] pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
> [    0.214666] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x103f]
> [    0.214741] pci 0000:00:03.0: [8086:0c0c] type 00 class 0x040300
> [    0.214748] pci 0000:00:03.0: reg 0x10: [mem 0x82838000-0x8283bfff 64bit]
> [    0.214817] pci 0000:00:04.0: [8086:0c03] type 00 class 0x118000
> [    0.214826] pci 0000:00:04.0: reg 0x10: [mem 0x82830000-0x82837fff 64bit]
> [    0.214917] pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
> [    0.214940] pci 0000:00:14.0: reg 0x10: [mem 0x82820000-0x8282ffff 64bit]
> [    0.215006] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.215106] pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
> [    0.215199] pci 0000:00:16.0: reg 0x10: [mem 0x82845000-0x8284500f 64bit]
> [    0.215505] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> [    0.215744] pci 0000:00:19.0: [8086:153a] type 00 class 0x020000
> [    0.215744] pci 0000:00:19.0: reg 0x10: [mem 0x82800000-0x8281ffff]
> [    0.215744] pci 0000:00:19.0: reg 0x14: [mem 0x82840000-0x82840fff]
> [    0.215744] pci 0000:00:19.0: reg 0x18: [io  0x1040-0x105f]
> [    0.215744] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
> [    0.215781] pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
> [    0.215801] pci 0000:00:1a.0: reg 0x10: [mem 0x82842000-0x828423ff]
> [    0.215878] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> [    0.215940] pci 0000:00:1b.0: [8086:8c20] type 00 class 0x040300
> [    0.215963] pci 0000:00:1b.0: reg 0x10: [mem 0x8283c000-0x8283ffff 64bit]
> [    0.216044] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.216117] pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
> [    0.216210] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.216241] pci 0000:00:1c.1: [8086:8c12] type 01 class 0x060400
> [    0.216241] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> [    0.216241] pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
> [    0.216241] pci 0000:00:1d.0: reg 0x10: [mem 0x82843000-0x828433ff]
> [    0.216241] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.216241] pci 0000:00:1f.0: [8086:8c4f] type 00 class 0x060100
> [    0.216388] pci 0000:00:1f.2: [8086:8c03] type 00 class 0x010601
> [    0.216408] pci 0000:00:1f.2: reg 0x10: [io  0x1080-0x1087]
> [    0.216416] pci 0000:00:1f.2: reg 0x14: [io  0x1090-0x1093]
> [    0.216425] pci 0000:00:1f.2: reg 0x18: [io  0x1088-0x108f]
> [    0.216433] pci 0000:00:1f.2: reg 0x1c: [io  0x1094-0x1097]
> [    0.216441] pci 0000:00:1f.2: reg 0x20: [io  0x1060-0x107f]
> [    0.216450] pci 0000:00:1f.2: reg 0x24: [mem 0x82841000-0x828417ff]
> [    0.216492] pci 0000:00:1f.2: PME# supported from D3hot
> [    0.216560] pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
> [    0.216580] pci 0000:00:1f.3: reg 0x10: [mem 0x82844000-0x828440ff 64bit]
> [    0.216602] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
> [    0.216795] pci 0000:02:00.0: [10ec:5227] type 00 class 0xff0000
> [    0.216899] pci 0000:02:00.0: reg 0x10: [mem 0x82200000-0x82200fff]
> [    0.217439] pci 0000:02:00.0: supports D1 D2
> [    0.217440] pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold
> [    0.217765] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.217771] pci 0000:00:1c.0:   bridge window [mem 0x82200000-0x822fffff]
> [    0.217852] pci 0000:03:00.0: [8086:08b2] type 00 class 0x028000
> [    0.217931] pci 0000:03:00.0: reg 0x10: [mem 0x82300000-0x82301fff 64bit]
> [    0.218187] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
> [    0.218386] pci 0000:00:1c.1: PCI bridge to [bus 03]
> [    0.218391] pci 0000:00:1c.1:   bridge window [mem 0x82300000-0x823fffff]
> [    0.218561] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [    0.218611] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [    0.218658] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [    0.218705] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [    0.218751] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [    0.218798] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [    0.218844] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [    0.218891] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [    0.219763] ACPI: EC: interrupt unblocked
> [    0.219763] ACPI: EC: event unblocked
> [    0.219763] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.219763] ACPI: \_SB_.PCI0.LPCB.EC__: Boot DSDT EC used to handle transactions and events
> [    0.219778] iommu: Default domain type: Passthrough 
> [    0.219778] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.219778] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.219778] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.219778] vgaarb: loaded
> [    0.219778] SCSI subsystem initialized
> [    0.219778] libata version 3.00 loaded.
> [    0.219778] pps_core: LinuxPPS API ver. 1 registered
> [    0.219778] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.219778] PTP clock support registered
> [    0.219778] EDAC MC: Ver: 3.0.0
> [    0.219879] PCI: Using ACPI for IRQ routing
> [    0.221612] PCI: pci_cache_line_size set to 64 bytes
> [    0.221717] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> [    0.221718] e820: reserve RAM buffer [mem 0x7f71f000-0x7fffffff]
> [    0.221719] e820: reserve RAM buffer [mem 0x47de00000-0x47fffffff]
> [    0.223744] NetLabel: Initializing
> [    0.223744] NetLabel:  domain hash size = 128
> [    0.223744] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.223744] NetLabel:  unlabeled traffic allowed by default
> [    0.223789] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    0.223792] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> [    0.223792] clocksource: Switched to clocksource tsc-early
> [    0.233296] VFS: Disk quotas dquot_6.6.0
> [    0.233309] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.233387] AppArmor: AppArmor Filesystem Enabled
> [    0.233399] pnp: PnP ACPI init
> [    0.233477] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    0.233478] system 00:00: [mem 0xfed10000-0xfed17fff] has been reserved
> [    0.233479] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.233480] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.233481] system 00:00: [mem 0xf0000000-0xf3ffffff] has been reserved
> [    0.233482] system 00:00: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.233483] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
> [    0.233484] system 00:00: [mem 0xfed45000-0xfed8ffff] could not be reserved
> [    0.233488] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.233895] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
> [    0.233898] system 00:01: Plug and Play ACPI device, IDs PNP0103 PNP0c01 (active)
> [    0.233934] system 00:02: [io  0x0500-0x05fe] has been reserved
> [    0.233935] system 00:02: [io  0x0480-0x04bf] has been reserved
> [    0.233937] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.233951] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.233972] pnp 00:04: Plug and Play ACPI device, IDs LEN0071 PNP030b (active)
> [    0.233993] pnp 00:05: Plug and Play ACPI device, IDs LEN0036 PNP0f13 (active)
> [    0.234011] pnp 00:06: Plug and Play ACPI device, IDs PNP0c31 (active)
> [    0.234025] pnp: PnP ACPI: found 7 devices
> [    0.234818] thermal_sys: Registered thermal governor 'fair_share'
> [    0.234818] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.234819] thermal_sys: Registered thermal governor 'step_wise'
> [    0.234819] thermal_sys: Registered thermal governor 'user_space'
> [    0.239315] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.239339] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.239345] pci 0000:00:1c.0:   bridge window [mem 0x82200000-0x822fffff]
> [    0.239353] pci 0000:00:1c.1: PCI bridge to [bus 03]
> [    0.239358] pci 0000:00:1c.1:   bridge window [mem 0x82300000-0x823fffff]
> [    0.239366] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.239367] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.239368] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.239369] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
> [    0.239369] pci_bus 0000:00: resource 8 [mem 0x000c8000-0x000cbfff window]
> [    0.239370] pci_bus 0000:00: resource 9 [mem 0x000cc000-0x000cffff window]
> [    0.239371] pci_bus 0000:00: resource 10 [mem 0x000d0000-0x000d3fff window]
> [    0.239372] pci_bus 0000:00: resource 11 [mem 0x000d4000-0x000d7fff window]
> [    0.239373] pci_bus 0000:00: resource 12 [mem 0x000d8000-0x000dbfff window]
> [    0.239373] pci_bus 0000:00: resource 13 [mem 0x000dc000-0x000dffff window]
> [    0.239374] pci_bus 0000:00: resource 14 [mem 0x000e0000-0x000e3fff window]
> [    0.239375] pci_bus 0000:00: resource 15 [mem 0x000e4000-0x000e7fff window]
> [    0.239376] pci_bus 0000:00: resource 16 [mem 0x000e8000-0x000ebfff window]
> [    0.239376] pci_bus 0000:00: resource 17 [mem 0x000ec000-0x000effff window]
> [    0.239377] pci_bus 0000:00: resource 18 [mem 0x000f0000-0x000fffff window]
> [    0.239378] pci_bus 0000:00: resource 19 [mem 0x82200000-0xefffffff window]
> [    0.239379] pci_bus 0000:00: resource 20 [mem 0xfed40000-0xfed44fff window]
> [    0.239380] pci_bus 0000:02: resource 1 [mem 0x82200000-0x822fffff]
> [    0.239381] pci_bus 0000:03: resource 1 [mem 0x82300000-0x823fffff]
> [    0.239450] NET: Registered protocol family 2
> [    0.239543] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    0.239559] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.239673] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [    0.239778] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.239801] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.239828] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.239885] NET: Registered protocol family 1
> [    0.239888] NET: Registered protocol family 44
> [    0.239895] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.240480] PCI: CLS 64 bytes, default 64
> [    0.240505] Trying to unpack rootfs image as initramfs...
> [    1.401895] Freeing initrd memory: 13512K
> [    1.415771] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    1.415773] software IO TLB: mapped [mem 0x7b71f000-0x7f71f000] (64MB)
> [    1.415854] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> [    1.415855] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [    1.415855] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    1.415855] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [    1.415856] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [    1.416037] check: Scanning for low memory corruption every 60 seconds
> [    1.416368] Initialise system trusted keyrings
> [    1.416375] Key type blacklist registered
> [    1.416409] workingset: timestamp_bits=37 max_order=22 bucket_order=0
> [    1.417422] zbud: loaded
> [    1.417757] Platform Keyring initialized
> [    1.421241] Key type asymmetric registered
> [    1.421242] Asymmetric key parser 'x509' registered
> [    1.421249] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
> [    1.421278] io scheduler mq-deadline registered
> [    1.421279] io scheduler kyber registered
> [    1.421298] io scheduler bfq registered
> [    1.421565] pcieport 0000:00:1c.0: PME: Signaling with IRQ 26
> [    1.421610] pcieport 0000:00:1c.0: AER: enabled with IRQ 26
> [    1.421809] pcieport 0000:00:1c.1: PME: Signaling with IRQ 27
> [    1.421848] pcieport 0000:00:1c.1: AER: enabled with IRQ 27
> [    1.421926] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    1.421946] efifb: probing for efifb
> [    1.421956] efifb: framebuffer at 0xa0000, using 64k, total 64k
> [    1.421957] efifb: mode is 640x480x1, linelength=80, pages=1
> [    1.421957] efifb: scrolling: redraw
> [    1.421958] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    1.422015] Console: switching to colour frame buffer device 80x30
> [    1.422744] fb0: EFI VGA frame buffer device
> [    1.422750] intel_idle: MWAIT substates: 0x42120
> [    1.422750] intel_idle: v0.4.1 model 0x3C
> [    1.422786] cpuidle polling time = 30000 ns
> [    1.422827] cpuidle polling time = 30000 ns
> [    1.422855] cpuidle polling time = 30000 ns
> [    1.422903] cpuidle polling time = 30000 ns
> [    1.422930] cpuidle polling time = 30000 ns
> [    1.422974] cpuidle polling time = 30000 ns
> [    1.423002] cpuidle polling time = 30000 ns
> [    1.423045] intel_idle: lapic_timer_reliable_states 0xffffffff
> [    1.423046] cpuidle polling time = 30000 ns
> [    1.423835] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    1.424699] Non-volatile memory driver v1.3
> [    1.424712] Linux agpgart interface v0.103
> [    1.427807] tpm_tis 00:06: 1.2 TPM (device-id 0x0, rev-id 78)
> [    1.478704] ahci 0000:00:1f.2: version 3.0
> [    1.478881] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
> [    1.478912] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x23 impl SATA mode
> [    1.478914] ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pio slum part apst 
> [    1.479280] scsi host0: ahci
> [    1.479418] scsi host1: ahci
> [    1.479524] scsi host2: ahci
> [    1.479592] scsi host3: ahci
> [    1.479641] scsi host4: ahci
> [    1.479689] scsi host5: ahci
> [    1.479714] ata1: SATA max UDMA/133 abar m2048@0x82841000 port 0x82841100 irq 28
> [    1.479716] ata2: SATA max UDMA/133 abar m2048@0x82841000 port 0x82841180 irq 28
> [    1.479717] ata3: DUMMY
> [    1.479717] ata4: DUMMY
> [    1.479717] ata5: DUMMY
> [    1.479719] ata6: SATA max UDMA/133 abar m2048@0x82841000 port 0x82841380 irq 28
> [    1.479766] i8042: PNP: PS/2 Controller [PNP030b:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    1.481581] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.481585] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    1.481673] mousedev: PS/2 mouse device common for all mice
> [    1.481723] rtc_cmos 00:03: RTC can wake from S4
> [    1.481942] rtc_cmos 00:03: registered as rtc0
> [    1.481951] rtc_cmos 00:03: alarms up to one month, 242 bytes nvram, hpet irqs
> [    1.481958] intel_pstate: Intel P-state driver initializing
> [    1.482292] ledtrig-cpu: registered to indicate activity on CPUs
> [    1.482331] hidraw: raw HID events driver (C) Jiri Kosina
> [    1.482498] drop_monitor: Initializing network drop monitor service
> [    1.482921] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    1.483082] NET: Registered protocol family 10
> [    1.494382] Segment Routing with IPv6
> [    1.494764] RAS: Correctable Errors collector initialized.
> [    1.494796] microcode: sig=0x306c3, pf=0x10, revision=0x28
> [    1.494838] microcode: Microcode Update Driver: v2.2.
> [    1.494841] IPI shorthand broadcast: enabled
> [    1.494846] sched_clock: Marking stable (1494521445, 206978)->(1500602728, -5874305)
> [    1.494980] registered taskstats version 1
> [    1.494983] Loading compiled-in X.509 certificates
> [    1.495007] Loaded X.509 cert 'openSUSE Secure Boot Signkey: c8bdc7ac1a1d85966217fd93ebfc14f4a200b814'
> [    1.495023] zswap: loaded using pool lzo/zbud
> [    1.495051] page_owner is disabled
> [    1.497978] Key type big_key registered
> [    1.499407] Key type encrypted registered
> [    1.499409] AppArmor: AppArmor sha1 policy hashing enabled
> [    1.499415] ima: Allocated hash algorithm: sha256
> [    1.592924] ima: No architecture policies found
> [    1.592940] evm: Initialising EVM extended attributes:
> [    1.592941] evm: security.selinux
> [    1.592941] evm: security.apparmor
> [    1.592942] evm: security.ima
> [    1.592942] evm: security.capability
> [    1.592943] evm: HMAC attrs: 0x1
> [    1.593223] PM:   Magic number: 5:860:803
> [    1.593341] rtc_cmos 00:03: setting system clock to 2021-01-19T21:47:11 UTC (1611092831)
> [    1.794954] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.800355] ata1.00: ATA-9: FTM51N325H, S1022A0, max UDMA/133
> [    1.800357] ata1.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    1.808613] ata1.00: configured for UDMA/133
> [    1.808742] scsi 0:0:0:0: Direct-Access     ATA      FTM51N325H       2A0  PQ: 0 ANSI: 5
> [    1.808879] sd 0:0:0:0: [sda] 1000215216 512-byte logical blocks: (512 GB/477 GiB)
> [    1.808885] sd 0:0:0:0: [sda] Write Protect is off
> [    1.808887] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.808898] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.810935]  sda: sda1 sda2
> [    1.811287] sd 0:0:0:0: [sda] Attached SCSI disk
> [    2.122927] ata2: SATA link down (SStatus 0 SControl 300)
> [    2.268333] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4758]
> [    2.298424] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1096..]
> [    2.298428] psmouse serio1: synaptics: Trying to set up SMBus access
> [    2.301133] psmouse serio1: synaptics: SMbus companion is not ready yet
> [    2.360393] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xf004a3/0x943300/0x12e800/0x10000, board id: 3053, fw id: 2560
> [    2.360399] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
> [    2.397942] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input2
> [    2.435806] tsc: Refined TSC clocksource calibration: 2893.298 MHz
> [    2.435813] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29b487c321a, max_idle_ns: 440795245217 ns
> [    2.435836] clocksource: Switched to clocksource tsc
> [    2.438861] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    2.444254] ata6.00: ATA-9: FTM51N325H, S1022A0, max UDMA/133
> [    2.444256] ata6.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    2.452506] ata6.00: configured for UDMA/133
> [    2.452636] scsi 5:0:0:0: Direct-Access     ATA      FTM51N325H       2A0  PQ: 0 ANSI: 5
> [    2.452771] sd 5:0:0:0: [sdb] 1000215216 512-byte logical blocks: (512 GB/477 GiB)
> [    2.452776] sd 5:0:0:0: [sdb] Write Protect is off
> [    2.452777] sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    2.452784] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    2.454930]  sdb: sdb1 sdb2
> [    2.455268] sd 5:0:0:0: [sdb] Attached SCSI disk
> [    2.456084] Freeing unused decrypted memory: 2040K
> [    2.456358] Freeing unused kernel image memory: 2164K
> [    2.467831] Write protecting the kernel read-only data: 20480k
> [    2.468262] Freeing unused kernel image memory: 2036K
> [    2.468505] Freeing unused kernel image memory: 1912K
> [    2.468506] Run /init as init process
> [    2.488296] systemd[1]: systemd 234 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 -IDN default-hierarchy=hybrid)
> [    2.507878] systemd[1]: Detected architecture x86-64.
> [    2.507880] systemd[1]: Running in initial RAM disk.
> [    2.507902] systemd[1]: No hostname configured.
> [    2.507906] systemd[1]: Set hostname to <localhost>.
> [    2.535147] systemd[1]: Reached target Swap.
> [    2.535196] systemd[1]: Listening on Journal Socket (/dev/log).
> [    2.535213] systemd[1]: Listening on Journal Socket.
> [    2.535227] systemd[1]: Listening on udev Kernel Socket.
> [    2.535231] systemd[1]: Reached target Timers.
> [    2.540837] alua: device handler registered
> [    2.541616] emc: device handler registered
> [    2.542466] rdac: device handler registered
> [    2.547580] device-mapper: uevent: version 1.0.3
> [    2.547624] device-mapper: ioctl: 4.40.0-ioctl (2019-01-18) initialised: dm-devel@redhat.com
> [    2.551387] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    2.551415] sd 5:0:0:0: Attached scsi generic sg1 type 0
> [    2.724037] ACPI: bus type USB registered
> [    2.724058] usbcore: registered new interface driver usbfs
> [    2.724066] usbcore: registered new interface driver hub
> [    2.724093] usbcore: registered new device driver usb
> [    2.728227] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    2.728950] ehci-pci: EHCI PCI platform driver
> [    2.729129] ehci-pci 0000:00:1a.0: EHCI Host Controller
> [    2.729134] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
> [    2.729145] ehci-pci 0000:00:1a.0: debug port 2
> [    2.733053] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
> [    2.733071] ehci-pci 0000:00:1a.0: irq 16, io mem 0x82842000
> [    2.734405] cryptd: max_cpu_qlen set to 1000
> [    2.748003] AVX2 version of gcm_enc/dec engaged.
> [    2.748004] AES CTR mode by8 optimization enabled
> [    2.751769] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> [    2.751816] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
> [    2.751818] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.751819] usb usb1: Product: EHCI Host Controller
> [    2.751820] usb usb1: Manufacturer: Linux 5.3.18-lp152.60-default ehci_hcd
> [    2.751822] usb usb1: SerialNumber: 0000:00:1a.0
> [    2.751929] hub 1-0:1.0: USB hub found
> [    2.751934] hub 1-0:1.0: 2 ports detected
> [    2.752431] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    2.752437] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [    2.753497] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
> [    2.753503] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> [    2.753664] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
> [    2.753666] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.753667] usb usb2: Product: xHCI Host Controller
> [    2.753668] usb usb2: Manufacturer: Linux 5.3.18-lp152.60-default xhci-hcd
> [    2.753669] usb usb2: SerialNumber: 0000:00:14.0
> [    2.753884] hub 2-0:1.0: USB hub found
> [    2.753902] hub 2-0:1.0: 15 ports detected
> [    2.754354] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    2.754358] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
> [    2.754361] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [    2.754391] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.03
> [    2.754392] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.754393] usb usb3: Product: xHCI Host Controller
> [    2.754394] usb usb3: Manufacturer: Linux 5.3.18-lp152.60-default xhci-hcd
> [    2.754395] usb usb3: SerialNumber: 0000:00:14.0
> [    2.754485] hub 3-0:1.0: USB hub found
> [    2.754495] hub 3-0:1.0: 6 ports detected
> [    2.754835] ehci-pci 0000:00:1d.0: EHCI Host Controller
> [    2.754842] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
> [    2.754853] ehci-pci 0000:00:1d.0: debug port 2
> [    2.758749] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
> [    2.758768] ehci-pci 0000:00:1d.0: irq 23, io mem 0x82843000
> [    2.771757] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> [    2.771802] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
> [    2.771803] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.771805] usb usb4: Product: EHCI Host Controller
> [    2.771806] usb usb4: Manufacturer: Linux 5.3.18-lp152.60-default ehci_hcd
> [    2.771807] usb usb4: SerialNumber: 0000:00:1d.0
> [    2.771933] hub 4-0:1.0: USB hub found
> [    2.771939] hub 4-0:1.0: 2 ports detected
> [    2.833697] checking generic (a0000 10000) vs hw (90000000 10000000)
> [    2.833699] fb0: switching to inteldrmfb from EFI VGA
> [    2.833751] Console: switching to colour dummy device 80x25
> [    2.833772] i915 0000:00:02.0: vgaarb: deactivate vga console
> [    2.886358] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    2.886359] [drm] Driver supports precise vblank timestamp query.
> [    2.886386] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [    2.894905] [drm] Initialized i915 1.6.0 20190822 for 0000:00:02.0 on minor 0
> [    2.895067] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [    2.915859] acpi device:0b: registered as cooling_device8
> [    2.915904] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
> [    3.031702] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
> [    3.087777] usb 2-11: new full-speed USB device number 2 using xhci_hcd
> [    3.087783] usb 1-1: new high-speed USB device number 2 using ehci-pci
> [    3.107760] usb 4-1: new high-speed USB device number 2 using ehci-pci
> [    3.121804] fbcon: i915drmfb (fb0) is primary device
> [    3.225527] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input3
> [    3.236804] usb 2-11: New USB device found, idVendor=8087, idProduct=07dc, bcdDevice= 0.01
> [    3.236805] usb 2-11: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    3.244127] usb 1-1: New USB device found, idVendor=8087, idProduct=8008, bcdDevice= 0.05
> [    3.244128] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    3.244277] hub 1-1:1.0: USB hub found
> [    3.244358] hub 1-1:1.0: 6 ports detected
> [    3.264131] usb 4-1: New USB device found, idVendor=8087, idProduct=8000, bcdDevice= 0.05
> [    3.264132] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    3.264305] hub 4-1:1.0: USB hub found
> [    3.264367] hub 4-1:1.0: 8 ports detected
> [    3.363789] usb 2-12: new high-speed USB device number 3 using xhci_hcd
> [    3.579866] usb 2-12: New USB device found, idVendor=04f2, idProduct=b39a, bcdDevice=26.03
> [    3.579867] usb 2-12: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    3.579868] usb 2-12: Product: Integrated Camera
> [    3.579868] usb 2-12: Manufacturer: SunplusIT INC.
> [    4.223151] Console: switching to colour frame buffer device 240x67
> [    4.242319] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
> [    5.055714] NET: Registered protocol family 38
> [    7.463766] raid6: avx2x4   gen() 39249 MB/s
> [    7.531766] raid6: avx2x4   xor() 13799 MB/s
> [    7.599767] raid6: avx2x2   gen() 39217 MB/s
> [    7.667768] raid6: avx2x2   xor() 24489 MB/s
> [    7.735766] raid6: avx2x1   gen() 35193 MB/s
> [    7.803766] raid6: avx2x1   xor() 20103 MB/s
> [    7.871765] raid6: sse2x4   gen() 20781 MB/s
> [    7.939765] raid6: sse2x4   xor() 10374 MB/s
> [    8.007766] raid6: sse2x2   gen() 20414 MB/s
> [    8.075766] raid6: sse2x2   xor() 12680 MB/s
> [    8.143766] raid6: sse2x1   gen() 16298 MB/s
> [    8.211767] raid6: sse2x1   xor() 10194 MB/s
> [    8.211767] raid6: using algorithm avx2x4 gen() 39249 MB/s
> [    8.211768] raid6: .... xor() 13799 MB/s, rmw enabled
> [    8.211768] raid6: using avx2x2 recovery algorithm
> [    8.212430] xor: automatically using best checksumming function   avx       
> [    8.247389] Btrfs loaded, crc32c=crc32c-intel, assert=on
> [    8.247718] BTRFS: device fsid f34b3537-5fb9-42c5-be82-68917f4bbb5f devid 2 transid 3508 /dev/dm-0
> [    8.247885] BTRFS: device fsid f34b3537-5fb9-42c5-be82-68917f4bbb5f devid 1 transid 3508 /dev/dm-1
> [    8.302793] BTRFS info (device dm-1): disk space caching is enabled
> [    8.302794] BTRFS info (device dm-1): has skinny extents
> [    8.313772] BTRFS info (device dm-1): enabling ssd optimizations
> [    8.497939] systemd-journald[213]: Received SIGTERM from PID 1 (systemd).
> [    8.510641] printk: systemd: 17 output lines suppressed due to ratelimiting
> [    8.752714] BTRFS info (device dm-1): disk space caching is enabled
> [    8.845374] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:2a/PNP0C09:00/PNP0C0E:00/input/input5
> [    8.845659] ACPI: Sleep Button [SLPB]
> [    8.845717] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:2a/PNP0C09:00/PNP0C0D:00/input/input6
> [    8.845786] ACPI: Lid Switch [LID]
> [    8.845836] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input7
> [    8.845888] ACPI: Power Button [PWRF]
> [    8.846489] EDAC ie31200: No ECC support
> [    8.847809] thermal LNXTHERM:00: registered as thermal_zone0
> [    8.847811] ACPI: Thermal Zone [THM0] (71 C)
> [    8.848728] thermal LNXTHERM:01: registered as thermal_zone1
> [    8.848730] ACPI: Thermal Zone [THM1] (27 C)
> [    8.858656] mei_me 0000:00:16.0: H_RST is set = 0x80000015
> [    8.861344] ACPI: AC Adapter [AC] (off-line)
> [    8.869723] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    8.869724] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    8.870669] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [    8.884504] battery: ACPI: Battery Slot [BAT0] (battery present)
> [    8.884682] battery: ACPI: Battery Slot [BAT1] (battery absent)
> [    8.916501] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> [    8.916846] input: PC Speaker as /devices/platform/pcspkr/input/input8
> [    8.945782] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
> [    8.968682] thinkpad_acpi: ThinkPad ACPI Extras v0.26
> [    8.968683] thinkpad_acpi: http://ibm-acpi.sf.net/
> [    8.968684] thinkpad_acpi: ThinkPad BIOS 4.13-818-gb9ba0d10a2, EC unknown
> [    8.969041] thinkpad_acpi: radio switch found; radios are enabled
> [    8.969131] thinkpad_acpi: Tablet mode switch found (type: MHKG), currently in laptop mode
> [    8.969141] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
> [    8.969141] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
> [    8.971594] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
> [    8.975476] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    8.975752] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    9.001214] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is unblocked
> [    9.002912] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
> [    9.003012] thinkpad_acpi: Console audio control enabled, mode: monitor (read only)
> [    9.004930] thinkpad_acpi: battery 1 registered (start 0, stop 100)
> [    9.004933] battery: new extension: ThinkPad Battery Extension
> [    9.004975] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input9
> [    9.021211] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> [    9.043979] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 68:f7:28:68:5f:07
> [    9.043980] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
> [    9.044014] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: 1000FF-0FF
> [    9.045058] BTRFS info (device dm-1): device fsid f34b3537-5fb9-42c5-be82-68917f4bbb5f devid 2 moved old:/dev/mapper/cr_root_2 new:/dev/dm-0
> [    9.045247] BTRFS info (device dm-1): device fsid f34b3537-5fb9-42c5-be82-68917f4bbb5f devid 2 moved old:/dev/dm-0 new:/dev/mapper/cr_root_2
> [    9.045258] BTRFS info (device dm-1): device fsid f34b3537-5fb9-42c5-be82-68917f4bbb5f devid 1 moved old:/dev/dm-1 new:/dev/mapper/cr_root
> [    9.059063] gpio_ich gpio_ich.2.auto: GPIO from 436 to 511
> [    9.065666] Intel(R) Wireless WiFi driver for Linux
> [    9.065668] Copyright(c) 2003- 2015 Intel Corporation
> [    9.084701] iwlwifi 0000:03:00.0: loaded firmware version 17.3216344376.0 op_mode iwlmvm
> [    9.136114] audit: type=1400 audit(1611092839.038:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ping" pid=912 comm="apparmor_parser"
> [    9.149091] iTCO_vendor_support: vendor-support=0
> [    9.150491] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [    9.150532] iTCO_wdt: Found a Lynx Point TCO device (Version=2, TCOBASE=0x0560)
> [    9.150704] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [    9.157852] audit: type=1400 audit(1611092839.058:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=934 comm="apparmor_parser"
> [    9.165980] audit: type=1400 audit(1611092839.066:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=944 comm="apparmor_parser"
> [    9.165982] audit: type=1400 audit(1611092839.066:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=944 comm="apparmor_parser"
> [    9.169856] systemd-journald[667]: Received request to flush runtime journal from PID 1
> [    9.173114] audit: type=1400 audit(1611092839.074:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="klogd" pid=953 comm="apparmor_parser"
> [    9.180275] audit: type=1400 audit(1611092839.082:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="syslogd" pid=961 comm="apparmor_parser"
> [    9.188361] audit: type=1400 audit(1611092839.090:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="syslog-ng" pid=969 comm="apparmor_parser"
> [    9.197261] audit: type=1400 audit(1611092839.098:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/lessopen.sh" pid=980 comm="apparmor_parser"
> [    9.206407] audit: type=1400 audit(1611092839.106:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/apache2/mpm-prefork/apache2" pid=987 comm="apparmor_parser"
> [    9.206409] audit: type=1400 audit(1611092839.106:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/apache2/mpm-prefork/apache2//DEFAULT_URI" pid=987 comm="apparmor_parser"
> [    9.216776] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input12
> [    9.216824] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input13
> [    9.216892] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input14
> [    9.216944] input: HDA Intel HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/sound/card0/input15
> [    9.217085] input: HDA Intel HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.0/sound/card0/input16
> [    9.219672] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3232: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [    9.219674] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [    9.219676] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=2 (0x16/0x15/0x0/0x0/0x0)
> [    9.219677] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
> [    9.219678] snd_hda_codec_realtek hdaudioC1D0:    inputs:
> [    9.219680] snd_hda_codec_realtek hdaudioC1D0:      Dock Mic=0x19
> [    9.219681] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x1a
> [    9.219682] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
> [    9.241641] iwlwifi 0000:03:00.0: Detected Intel(R) Wireless N 7260, REV=0x144
> [    9.260527] iwlwifi 0000:03:00.0: base HW address: 5c:c5:d4:90:80:49
> [    9.308168] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card1/input17
> [    9.308231] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input18
> [    9.308279] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input19
> [    9.308321] input: HDA Intel PCH Dock Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input20
> [    9.308353] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input21
> [    9.382692] intel_rapl_common: Found RAPL domain package
> [    9.382693] intel_rapl_common: Found RAPL domain core
> [    9.382703] intel_rapl_common: Found RAPL domain uncore
> [    9.382704] intel_rapl_common: Found RAPL domain dram
> [    9.451938] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
> [    9.909230] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4758]
> [    9.932706] mc: Linux media interface: v0.10
> [    9.937450] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1096..]
> [    9.937453] psmouse serio1: synaptics: Trying to set up SMBus access
> [    9.945152] videodev: Linux video capture interface: v2.00
> [    9.952421] Bluetooth: Core ver 2.22
> [    9.952437] NET: Registered protocol family 31
> [    9.952438] Bluetooth: HCI device and connection manager initialized
> [    9.952441] Bluetooth: HCI socket layer initialized
> [    9.952443] Bluetooth: L2CAP socket layer initialized
> [    9.952445] Bluetooth: SCO socket layer initialized
> [    9.984891] rmi4_smbus 9-002c: registering SMbus-connected sensor
> [   10.037205] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3053-004, fw id: 1741117
> [   10.095307] input: Synaptics TM3053-004 as /devices/rmi4-00/input/input22
> [   10.100717] serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
> [   10.208033] usbcore: registered new interface driver btusb
> [   10.211248] uvcvideo: Found UVC 1.00 device Integrated Camera (04f2:b39a)
> [   10.221059] Bluetooth: hci0: read Intel version: 370710018002030d00
> [   10.222380] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [   10.224061] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   10.224062] Bluetooth: BNEP filters: protocol multicast
> [   10.224065] Bluetooth: BNEP socket layer initialized
> [   10.232564] input: Integrated Camera: Integrated C as /devices/pci0000:00/0000:00:14.0/usb2/2-12/2-12:1.0/input/input24
> [   10.232620] usbcore: registered new interface driver uvcvideo
> [   10.232621] USB Video Class driver (1.1.1)
> [   10.274422] bpfilter: Loaded bpfilter_umh pid 1540
> [   10.274576] Started bpfilter
> [   10.346000] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [   10.361016] Bluetooth: hci0: Intel firmware patch completed and activated
> [   10.454756] psmouse serio3: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
> [   10.503445] input: TPPS/2 IBM TrackPoint as /devices/rmi4-00/rmi4-00.fn03/serio3/input/input23
> [   10.883773] mei_me 0000:00:16.0: wait hw ready failed
> [   10.883775] mei_me 0000:00:16.0: hw_start failed ret = -62
> [   10.883791] mei_me 0000:00:16.0: H_RST is set = 0x80000015
> [   11.261866] NET: Registered protocol family 17
> [   12.384100] broken atomic modeset userspace detected, disabling atomic
> [   12.899764] mei_me 0000:00:16.0: wait hw ready failed
> [   12.899766] mei_me 0000:00:16.0: hw_start failed ret = -62
> [   12.899783] mei_me 0000:00:16.0: H_RST is set = 0x80000015
> [   14.919752] mei_me 0000:00:16.0: wait hw ready failed
> [   14.919757] mei_me 0000:00:16.0: hw_start failed ret = -62
> [   14.919774] mei_me 0000:00:16.0: reset: reached maximal consecutive resets: disabling the device
> [   14.919775] mei_me 0000:00:16.0: reset failed ret = -19
> [   14.919776] mei_me 0000:00:16.0: link layer initialization failed.
> [   14.919776] mei_me 0000:00:16.0: init hw failure.
> [   14.919861] mei_me 0000:00:16.0: initialization failed.
> [   15.060861] Bluetooth: RFCOMM TTY layer initialized
> [   15.060868] Bluetooth: RFCOMM socket layer initialized
> [   15.060871] Bluetooth: RFCOMM ver 1.11
> [   15.412666] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [   15.415914] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [   15.433392] wlan0: authenticated
> [   15.439749] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [   15.461258] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [   15.469849] wlan0: associated
> [   15.591576] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [  220.296822] fuse: init (API version 7.31)
> [  617.323841] BTRFS info (device dm-1): qgroup scan completed (inconsistency flag cleared)
> [ 1827.560305] usb 2-9: new high-speed USB device number 4 using xhci_hcd
> [ 1827.713404] usb 2-9: New USB device found, idVendor=17ef, idProduct=1010, bcdDevice=50.30
> [ 1827.713407] usb 2-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 1827.713409] usb 2-9: Product: Lenovo ThinkPad Dock   
> [ 1827.713410] usb 2-9: Manufacturer: LENOVO                 
> [ 1827.714406] hub 2-9:1.0: USB hub found
> [ 1827.714729] hub 2-9:1.0: 4 ports detected
> [ 1828.024308] usb 2-9.4: new high-speed USB device number 5 using xhci_hcd
> [ 1828.136590] usb 2-9.4: New USB device found, idVendor=17ef, idProduct=100f, bcdDevice= 0.01
> [ 1828.136593] usb 2-9.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 1828.136594] usb 2-9.4: Product: Lenovo ThinkPad Dock
> [ 1828.136595] usb 2-9.4: Manufacturer: Lenovo
> [ 1828.136596] usb 2-9.4: SerialNumber: Rev1.2
> [ 1828.137655] hub 2-9.4:1.0: USB hub found
> [ 1828.137678] hub 2-9.4:1.0: 3 ports detected
> [ 1828.428301] usb 2-9.4.1: new full-speed USB device number 6 using xhci_hcd
> [ 1828.529546] usb 2-9.4.1: New USB device found, idVendor=2034, idProduct=0105, bcdDevice= 1.00
> [ 1828.529549] usb 2-9.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 1828.529550] usb 2-9.4.1: Product: BWA19HO011
> [ 1828.529551] usb 2-9.4.1: Manufacturer: BlackWeb
> [ 1828.529552] usb 2-9.4.1: SerialNumber: IM10000011
> [ 1828.760316] usb 2-9.4.2: new high-speed USB device number 7 using xhci_hcd
> [ 1828.876211] usb 2-9.4.2: New USB device found, idVendor=413c, idProduct=1010, bcdDevice=32.98
> [ 1828.876214] usb 2-9.4.2: New USB device strings: Mfr=0, Product=11, SerialNumber=0
> [ 1828.876215] usb 2-9.4.2: Product: USB 2.0 Hub [MTT]
> [ 1828.877590] hub 2-9.4.2:1.0: USB hub found
> [ 1828.879140] hub 2-9.4.2:1.0: 4 ports detected
> [ 1828.960291] usb 2-9.4.3: new high-speed USB device number 8 using xhci_hcd
> [ 1829.072012] usb 2-9.4.3: New USB device found, idVendor=1004, idProduct=633e, bcdDevice= 3.18
> [ 1829.072016] usb 2-9.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 1829.072017] usb 2-9.4.3: Product: LM-X212(G)
> [ 1829.072018] usb 2-9.4.3: Manufacturer: LGE
> [ 1829.072019] usb 2-9.4.3: SerialNumber: LMX212Gc2e16edc
> [ 1829.172301] usb 2-9.4.2.2: new low-speed USB device number 9 using xhci_hcd
> [ 1829.279755] usb 2-9.4.2.2: New USB device found, idVendor=0461, idProduct=4d15, bcdDevice= 2.00
> [ 1829.279760] usb 2-9.4.2.2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [ 1829.279762] usb 2-9.4.2.2: Product: USB Optical Mouse
> [ 1829.360313] usb 2-9.4.2.4: new low-speed USB device number 10 using xhci_hcd
> [ 1829.480621] usb 2-9.4.2.4: New USB device found, idVendor=413c, idProduct=2110, bcdDevice= 0.06
> [ 1829.480626] usb 2-9.4.2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 1829.480628] usb 2-9.4.2.4: Product: Dell Wired Multimedia Keyboard
> [ 1829.480629] usb 2-9.4.2.4: Manufacturer: Dell
> [ 1829.630128] usbcore: registered new interface driver usbhid
> [ 1829.630133] usbhid: USB HID core driver
> [ 1829.634597] input: BlackWeb BWA19HO011 as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.1/2-9.4.1:1.2/0003:2034:0105.0001/input/input25
> [ 1829.640554] usbcore: registered new interface driver snd-usb-audio
> [ 1829.692526] hid-generic 0003:2034:0105.0001: input,hidraw0: USB HID v1.00 Device [BlackWeb BWA19HO011] on usb-0000:00:14.0-9.4.1/input2
> [ 1829.692756] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.2/2-9.4.2.2:1.0/0003:0461:4D15.0002/input/input26
> [ 1829.692848] hid-generic 0003:0461:4D15.0002: input,hidraw1: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-9.4.2.2/input0
> [ 1829.693017] input: Dell Dell Wired Multimedia Keyboard as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.0/0003:413C:2110.0003/input/input27
> [ 1829.752645] hid-generic 0003:413C:2110.0003: input,hidraw2: USB HID v1.10 Keyboard [Dell Dell Wired Multimedia Keyboard] on usb-0000:00:14.0-9.4.2.4/input0
> [ 1829.753030] input: Dell Dell Wired Multimedia Keyboard Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0004/input/input28
> [ 1829.753182] input: Dell Dell Wired Multimedia Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0004/input/input29
> [ 1829.812631] input: Dell Dell Wired Multimedia Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0004/input/input30
> [ 1829.812999] hid-generic 0003:413C:2110.0004: input,hiddev96,hidraw3: USB HID v1.10 Mouse [Dell Dell Wired Multimedia Keyboard] on usb-0000:00:14.0-9.4.2.4/input1
> [ 1831.557824] e1000e 0000:00:19.0 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [ 1831.557873] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [ 5182.009341] usb 2-9: USB disconnect, device number 4
> [ 5182.009343] usb 2-9.4: USB disconnect, device number 5
> [ 5182.009345] usb 2-9.4.1: USB disconnect, device number 6
> [ 5182.091318] usb 2-9.4.2: USB disconnect, device number 7
> [ 5182.091331] usb 2-9.4.2.2: USB disconnect, device number 9
> [ 5182.175091] usb 2-9.4.2.4: USB disconnect, device number 10
> [ 5182.354471] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [ 5182.568537] usb 2-9.4.3: USB disconnect, device number 8
> [ 5211.676827] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [ 5211.689730] PM: suspend entry (deep)
> [ 5211.839652] Filesystems sync: 0.149 seconds
> [ 5211.840097] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [ 5211.841790] OOM killer disabled.
> [ 5211.841790] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [ 5211.842982] printk: Suspending console(s) (use no_console_suspend to debug)
> [ 5211.918630] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [ 5211.938339] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [ 5211.942177] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [ 5211.942206] sd 0:0:0:0: [sda] Stopping disk
> [ 5211.944588] sd 5:0:0:0: [sdb] Stopping disk
> [ 5212.110425] e1000e: EEE TX LPI TIMER: 00000011
> [ 5212.402618] ACPI: EC: interrupt blocked
> [ 5212.442479] ACPI: Preparing to enter system sleep state S3
> [ 5212.444448] ACPI: EC: event blocked
> [ 5212.444449] ACPI: EC: EC stopped
> [ 5212.444449] PM: Saving platform NVS memory
> [ 5212.444450] Disabling non-boot CPUs ...
> [ 5212.444724] IRQ 28: no longer affine to CPU1
> [ 5212.445852] smpboot: CPU 1 is now offline
> [ 5212.447336] smpboot: CPU 2 is now offline
> [ 5212.447850] IRQ 23: no longer affine to CPU3
> [ 5212.447854] IRQ 31: no longer affine to CPU3
> [ 5212.448858] smpboot: CPU 3 is now offline
> [ 5212.450284] smpboot: CPU 4 is now offline
> [ 5212.450776] IRQ 18: no longer affine to CPU5
> [ 5212.451784] smpboot: CPU 5 is now offline
> [ 5212.453552] smpboot: CPU 6 is now offline
> [ 5212.453950] IRQ 26: no longer affine to CPU7
> [ 5212.453954] IRQ 30: no longer affine to CPU7
> [ 5212.453958] IRQ 36: no longer affine to CPU7
> [ 5212.454966] smpboot: CPU 7 is now offline
> [ 5212.455771] ACPI: Low-level resume complete
> [ 5212.455807] ACPI: EC: EC started
> [ 5212.455807] PM: Restoring platform NVS memory
> [ 5212.456148] Enabling non-boot CPUs ...
> [ 5212.456181] x86: Booting SMP configuration:
> [ 5212.456182] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 5212.456899] CPU1 is up
> [ 5212.456922] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 5212.457576] CPU2 is up
> [ 5212.457596] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 5212.458233] CPU3 is up
> [ 5212.458253] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 5212.458915] CPU4 is up
> [ 5212.458933] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 5212.459054] smpboot: Scheduler frequency invariance went wobbly, disabling!
> [ 5212.459595] CPU5 is up
> [ 5212.459643] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 5212.460330] CPU6 is up
> [ 5212.460349] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 5212.461025] CPU7 is up
> [ 5212.463256] ACPI: Waking up from system sleep state S3
> [ 5212.464975] ACPI: EC: interrupt unblocked
> [ 5212.525473] ACPI: EC: event unblocked
> [ 5212.526501] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [ 5212.535626] sd 0:0:0:0: [sda] Starting disk
> [ 5212.535644] sd 5:0:0:0: [sdb] Starting disk
> [ 5212.771384] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [ 5212.850279] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [ 5212.850302] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [ 5212.850320] ata2: SATA link down (SStatus 0 SControl 300)
> [ 5212.863915] ata6.00: configured for UDMA/133
> [ 5212.863925] ata1.00: configured for UDMA/133
> [ 5213.047363] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [ 5213.649623] OOM killer enabled.
> [ 5213.649624] Restarting tasks ... done.
> [ 5213.653801] video LNXVIDEO:00: Restoring backlight state
> [ 5213.667714] Bluetooth: hci0: read Intel version: 370710018002030d00
> [ 5213.667717] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [ 5213.842717] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [ 5213.849934] PM: suspend exit
> [ 5213.858706] Bluetooth: hci0: Intel firmware patch completed and activated
> [ 5214.257714] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [ 5214.337095] PM: suspend entry (deep)
> [ 5214.665191] Filesystems sync: 0.328 seconds
> [ 5217.592627] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [ 5217.594382] OOM killer disabled.
> [ 5217.594383] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
> [ 5217.595149] printk: Suspending console(s) (use no_console_suspend to debug)
> [ 5217.755116] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [ 5217.763105] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [ 5217.763209] sd 0:0:0:0: [sda] Stopping disk
> [ 5217.774329] sd 5:0:0:0: [sdb] Stopping disk
> [ 5217.833470] e1000e: EEE TX LPI TIMER: 00000011
> [ 5218.115525] ACPI: EC: interrupt blocked
> [ 5218.155368] ACPI: Preparing to enter system sleep state S3
> [ 5218.157434] ACPI: EC: event blocked
> [ 5218.157434] ACPI: EC: EC stopped
> [ 5218.157435] PM: Saving platform NVS memory
> [ 5218.157436] Disabling non-boot CPUs ...
> [ 5218.159006] smpboot: CPU 1 is now offline
> [ 5218.160456] smpboot: CPU 2 is now offline
> [ 5218.161954] smpboot: CPU 3 is now offline
> [ 5218.163591] smpboot: CPU 4 is now offline
> [ 5218.164942] smpboot: CPU 5 is now offline
> [ 5218.166313] smpboot: CPU 6 is now offline
> [ 5218.167731] smpboot: CPU 7 is now offline
> [ 5218.168440] ACPI: Low-level resume complete
> [ 5218.168476] ACPI: EC: EC started
> [ 5218.168477] PM: Restoring platform NVS memory
> [ 5218.168830] Enabling non-boot CPUs ...
> [ 5218.168864] x86: Booting SMP configuration:
> [ 5218.168865] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 5218.169685] CPU1 is up
> [ 5218.169710] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 5218.170391] CPU2 is up
> [ 5218.170410] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 5218.171069] CPU3 is up
> [ 5218.171088] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 5218.171781] CPU4 is up
> [ 5218.171800] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 5218.172483] CPU5 is up
> [ 5218.172503] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 5218.173210] CPU6 is up
> [ 5218.173228] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 5218.173924] CPU7 is up
> [ 5218.176149] ACPI: Waking up from system sleep state S3
> [ 5218.177869] ACPI: EC: interrupt unblocked
> [ 5218.217941] ACPI: EC: event unblocked
> [ 5218.218481] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [ 5218.228155] sd 0:0:0:0: [sda] Starting disk
> [ 5218.228167] sd 5:0:0:0: [sdb] Starting disk
> [ 5218.468178] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [ 5218.543143] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [ 5218.543163] ata2: SATA link down (SStatus 0 SControl 300)
> [ 5218.543187] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [ 5218.556782] ata6.00: configured for UDMA/133
> [ 5218.556792] ata1.00: configured for UDMA/133
> [ 5218.744266] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [ 5219.347333] OOM killer enabled.
> [ 5219.347333] Restarting tasks ... done.
> [ 5219.353040] video LNXVIDEO:00: Restoring backlight state
> [ 5219.359620] Bluetooth: hci0: read Intel version: 370710018002030d00
> [ 5219.359623] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [ 5219.542643] PM: suspend exit
> [ 5219.555571] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [ 5219.570602] Bluetooth: hci0: Intel firmware patch completed and activated
> [ 5220.496612] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [ 5220.498556] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [ 5220.507860] wlan0: authenticated
> [ 5220.511924] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [ 5220.533362] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [ 5220.534414] wlan0: associated
> [ 5220.641295] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [ 5541.254459] pci 0000:00:16.0: Refused to change power state, currently in D3
> [ 5542.228255] usb 3-5: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> [ 5542.249641] usb 3-5: New USB device found, idVendor=17ef, idProduct=1010, bcdDevice=50.31
> [ 5542.249643] usb 3-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 5542.249643] usb 3-5: Product: Lenovo ThinkPad Dock   
> [ 5542.249644] usb 3-5: Manufacturer: LENOVO                 
> [ 5542.251233] hub 3-5:1.0: USB hub found
> [ 5542.251369] hub 3-5:1.0: 4 ports detected
> [ 5542.416001] usb 2-9: new high-speed USB device number 11 using xhci_hcd
> [ 5542.573107] usb 2-9: New USB device found, idVendor=17ef, idProduct=1010, bcdDevice=50.30
> [ 5542.573109] usb 2-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 5542.573110] usb 2-9: Product: Lenovo ThinkPad Dock   
> [ 5542.573110] usb 2-9: Manufacturer: LENOVO                 
> [ 5542.574070] hub 2-9:1.0: USB hub found
> [ 5542.574210] hub 2-9:1.0: 4 ports detected
> [ 5542.880018] usb 2-9.4: new high-speed USB device number 12 using xhci_hcd
> [ 5542.996377] usb 2-9.4: New USB device found, idVendor=17ef, idProduct=100f, bcdDevice= 0.01
> [ 5542.996379] usb 2-9.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 5542.996380] usb 2-9.4: Product: Lenovo ThinkPad Dock
> [ 5542.996380] usb 2-9.4: Manufacturer: Lenovo
> [ 5542.996381] usb 2-9.4: SerialNumber: Rev1.2
> [ 5542.997319] hub 2-9.4:1.0: USB hub found
> [ 5542.997347] hub 2-9.4:1.0: 3 ports detected
> [ 5543.284050] usb 2-9.4.1: new full-speed USB device number 13 using xhci_hcd
> [ 5543.385469] usb 2-9.4.1: New USB device found, idVendor=2034, idProduct=0105, bcdDevice= 1.00
> [ 5543.385470] usb 2-9.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 5543.385471] usb 2-9.4.1: Product: BWA19HO011
> [ 5543.385471] usb 2-9.4.1: Manufacturer: BlackWeb
> [ 5543.385472] usb 2-9.4.1: SerialNumber: IM10000011
> [ 5543.394104] input: BlackWeb BWA19HO011 as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.1/2-9.4.1:1.2/0003:2034:0105.0005/input/input31
> [ 5543.452264] hid-generic 0003:2034:0105.0005: input,hidraw0: USB HID v1.00 Device [BlackWeb BWA19HO011] on usb-0000:00:14.0-9.4.1/input2
> [ 5543.676003] usb 2-9.4.2: new high-speed USB device number 14 using xhci_hcd
> [ 5543.792137] usb 2-9.4.2: New USB device found, idVendor=413c, idProduct=1010, bcdDevice=32.98
> [ 5543.792139] usb 2-9.4.2: New USB device strings: Mfr=0, Product=11, SerialNumber=0
> [ 5543.792140] usb 2-9.4.2: Product: USB 2.0 Hub [MTT]
> [ 5543.793628] hub 2-9.4.2:1.0: USB hub found
> [ 5543.795225] hub 2-9.4.2:1.0: 4 ports detected
> [ 5543.875994] usb 2-9.4.3: new high-speed USB device number 15 using xhci_hcd
> [ 5543.977762] usb 2-9.4.3: New USB device found, idVendor=1004, idProduct=633e, bcdDevice= 3.18
> [ 5543.977768] usb 2-9.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 5543.977769] usb 2-9.4.3: Product: LM-X212(G)
> [ 5543.977771] usb 2-9.4.3: Manufacturer: LGE
> [ 5543.977772] usb 2-9.4.3: SerialNumber: LMX212Gc2e16edc
> [ 5544.100014] usb 2-9.4.2.2: new low-speed USB device number 16 using xhci_hcd
> [ 5544.207358] usb 2-9.4.2.2: New USB device found, idVendor=0461, idProduct=4d15, bcdDevice= 2.00
> [ 5544.207361] usb 2-9.4.2.2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [ 5544.207362] usb 2-9.4.2.2: Product: USB Optical Mouse
> [ 5544.213803] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.2/2-9.4.2.2:1.0/0003:0461:4D15.0006/input/input32
> [ 5544.214012] hid-generic 0003:0461:4D15.0006: input,hidraw1: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-9.4.2.2/input0
> [ 5544.292016] usb 2-9.4.2.4: new low-speed USB device number 17 using xhci_hcd
> [ 5544.400223] usb 2-9.4.2.4: New USB device found, idVendor=413c, idProduct=2110, bcdDevice= 0.06
> [ 5544.400225] usb 2-9.4.2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 5544.400226] usb 2-9.4.2.4: Product: Dell Wired Multimedia Keyboard
> [ 5544.400226] usb 2-9.4.2.4: Manufacturer: Dell
> [ 5544.413921] input: Dell Dell Wired Multimedia Keyboard as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.0/0003:413C:2110.0007/input/input33
> [ 5544.472311] hid-generic 0003:413C:2110.0007: input,hidraw2: USB HID v1.10 Keyboard [Dell Dell Wired Multimedia Keyboard] on usb-0000:00:14.0-9.4.2.4/input0
> [ 5544.483357] input: Dell Dell Wired Multimedia Keyboard Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0008/input/input34
> [ 5544.483529] input: Dell Dell Wired Multimedia Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0008/input/input35
> [ 5544.544129] input: Dell Dell Wired Multimedia Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0008/input/input36
> [ 5544.544318] hid-generic 0003:413C:2110.0008: input,hiddev96,hidraw3: USB HID v1.10 Mouse [Dell Dell Wired Multimedia Keyboard] on usb-0000:00:14.0-9.4.2.4/input1
> [ 5547.392494] e1000e 0000:00:19.0 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [ 5547.392534] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [ 7240.907122] usb 2-1: new high-speed USB device number 18 using xhci_hcd
> [ 7241.057133] usb 2-1: New USB device found, idVendor=058f, idProduct=6331, bcdDevice= 1.32
> [ 7241.057135] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 7241.057136] usb 2-1: Product: Mass Storage Device
> [ 7241.057136] usb 2-1: Manufacturer: Generic
> [ 7241.057137] usb 2-1: SerialNumber: 6333031111B1
> [ 7241.576128] usb-storage 2-1:1.0: USB Mass Storage device detected
> [ 7241.576208] scsi host6: usb-storage 2-1:1.0
> [ 7241.576285] usbcore: registered new interface driver usb-storage
> [ 7241.578015] usbcore: registered new interface driver uas
> [ 7242.599772] scsi 6:0:0:0: Direct-Access     Multi    Flash Reader     1.00 PQ: 0 ANSI: 0
> [ 7242.599994] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [ 7243.275955] sd 6:0:0:0: [sdc] 250085376 512-byte logical blocks: (128 GB/119 GiB)
> [ 7243.276325] sd 6:0:0:0: [sdc] Write Protect is off
> [ 7243.276327] sd 6:0:0:0: [sdc] Mode Sense: 03 00 00 00
> [ 7243.276683] sd 6:0:0:0: [sdc] No Caching mode page found
> [ 7243.276683] sd 6:0:0:0: [sdc] Assuming drive cache: write through
> [ 7243.294366]  sdc:
> [ 7243.296116] sd 6:0:0:0: [sdc] Attached SCSI removable disk
> [ 7248.696849] FAT-fs (sdc): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
> [ 7303.864073] VFS: busy inodes on changed media or resized disk sdc
> [ 7340.527165] VFS: busy inodes on changed media or resized disk sdc
> [ 7881.997937]  sdc:
> [ 7882.015009] sd 6:0:0:0: [sdc] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [ 7882.015011] sd 6:0:0:0: [sdc] tag#0 Sense Key : Not Ready [current] 
> [ 7882.015013] sd 6:0:0:0: [sdc] tag#0 Add. Sense: Medium not present
> [ 7882.015014] sd 6:0:0:0: [sdc] tag#0 CDB: Read(10) 28 00 0e e7 fe f8 00 00 08 00
> [ 7882.015017] blk_update_request: I/O error, dev sdc, sector 250085112 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [ 7882.015356] sdc: detected capacity change from 128043712512 to 0
> [ 7882.015362] sd 6:0:0:0: [sdc] tag#0 device offline or changed
> [ 7882.015364] blk_update_request: I/O error, dev sdc, sector 250085112 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [ 7882.015365] Buffer I/O error on dev sdc, logical block 31260639, async page read
> [ 7887.361936] usb 2-1: USB disconnect, device number 18
> [ 9016.803596] usb 2-1: new high-speed USB device number 19 using xhci_hcd
> [ 9016.953463] usb 2-1: New USB device found, idVendor=058f, idProduct=6331, bcdDevice= 1.32
> [ 9016.953465] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 9016.953465] usb 2-1: Product: Mass Storage Device
> [ 9016.953466] usb 2-1: Manufacturer: Generic
> [ 9016.953466] usb 2-1: SerialNumber: 6333031111B1
> [ 9016.955803] usb-storage 2-1:1.0: USB Mass Storage device detected
> [ 9016.955967] scsi host6: usb-storage 2-1:1.0
> [ 9017.984300] scsi 6:0:0:0: Direct-Access     Multi    Flash Reader     1.00 PQ: 0 ANSI: 0
> [ 9017.984532] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [ 9018.826307] sd 6:0:0:0: [sdc] 250085376 512-byte logical blocks: (128 GB/119 GiB)
> [ 9018.826649] sd 6:0:0:0: [sdc] Write Protect is off
> [ 9018.826650] sd 6:0:0:0: [sdc] Mode Sense: 03 00 00 00
> [ 9018.826939] sd 6:0:0:0: [sdc] No Caching mode page found
> [ 9018.826940] sd 6:0:0:0: [sdc] Assuming drive cache: write through
> [ 9018.850880]  sdc:
> [ 9018.852817] sd 6:0:0:0: [sdc] Attached SCSI removable disk
> [ 9036.171129] FAT-fs (sdc): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
> [10402.752786] sdc: detected capacity change from 128043712512 to 0
> [10507.523802] usb 2-1: USB disconnect, device number 19
> [10515.405030] usb 2-1: new high-speed USB device number 20 using xhci_hcd
> [10515.555035] usb 2-1: New USB device found, idVendor=058f, idProduct=6331, bcdDevice= 1.32
> [10515.555037] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [10515.555038] usb 2-1: Product: Mass Storage Device
> [10515.555039] usb 2-1: Manufacturer: Generic
> [10515.555039] usb 2-1: SerialNumber: 6333031111B1
> [10515.557383] usb-storage 2-1:1.0: USB Mass Storage device detected
> [10515.557586] scsi host6: usb-storage 2-1:1.0
> [10516.569832] scsi 6:0:0:0: Direct-Access     Multi    Flash Reader     1.00 PQ: 0 ANSI: 0
> [10516.570144] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [10516.585746] sd 6:0:0:0: [sdc] Attached SCSI removable disk
> [10523.211690] usb 2-1: USB disconnect, device number 20
> [10526.553026] usb 2-1: new high-speed USB device number 21 using xhci_hcd
> [10526.703058] usb 2-1: New USB device found, idVendor=058f, idProduct=6331, bcdDevice= 1.32
> [10526.703060] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [10526.703061] usb 2-1: Product: Mass Storage Device
> [10526.703062] usb 2-1: Manufacturer: Generic
> [10526.703062] usb 2-1: SerialNumber: 6333031111B1
> [10526.705628] usb-storage 2-1:1.0: USB Mass Storage device detected
> [10526.705823] scsi host6: usb-storage 2-1:1.0
> [10527.737739] scsi 6:0:0:0: Direct-Access     Multi    Flash Reader     1.00 PQ: 0 ANSI: 0
> [10527.738044] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [10528.875469] sd 6:0:0:0: [sdc] 250085376 512-byte logical blocks: (128 GB/119 GiB)
> [10528.875799] sd 6:0:0:0: [sdc] Write Protect is off
> [10528.875800] sd 6:0:0:0: [sdc] Mode Sense: 03 00 00 00
> [10528.876157] sd 6:0:0:0: [sdc] No Caching mode page found
> [10528.876157] sd 6:0:0:0: [sdc] Assuming drive cache: write through
> [10528.891970]  sdc:
> [10528.893496] sd 6:0:0:0: [sdc] Attached SCSI removable disk
> [10531.742228] FAT-fs (sdc): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
> [10649.380118] sdc: detected capacity change from 128043712512 to 0
> [11188.620610] usb 2-1: USB disconnect, device number 21
> [11189.624934] usb 2-9: USB disconnect, device number 11
> [11189.624936] usb 2-9.4: USB disconnect, device number 12
> [11189.624938] usb 2-9.4.1: USB disconnect, device number 13
> [11189.714954] usb 2-9.4.2: USB disconnect, device number 14
> [11189.714966] usb 2-9.4.2.2: USB disconnect, device number 16
> [11189.766077] usb 3-5: USB disconnect, device number 2
> [11189.806900] usb 2-9.4.2.4: USB disconnect, device number 17
> [11189.978235] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [11190.087673] usb 2-9.4.3: USB disconnect, device number 15
> [11193.088582] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [11193.103699] PM: suspend entry (deep)
> [11193.269444] Filesystems sync: 0.165 seconds
> [11193.270297] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [11193.272789] OOM killer disabled.
> [11193.272790] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [11193.274165] printk: Suspending console(s) (use no_console_suspend to debug)
> [11193.348726] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [11193.454118] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [11193.454178] sd 0:0:0:0: [sda] Stopping disk
> [11193.458096] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [11193.458137] sd 5:0:0:0: [sdb] Stopping disk
> [11193.534320] e1000e: EEE TX LPI TIMER: 00000011
> [11193.818500] ACPI: EC: interrupt blocked
> [11193.858373] ACPI: Preparing to enter system sleep state S3
> [11193.860652] ACPI: EC: event blocked
> [11193.860652] ACPI: EC: EC stopped
> [11193.860652] PM: Saving platform NVS memory
> [11193.860654] Disabling non-boot CPUs ...
> [11193.860930] IRQ 28: no longer affine to CPU1
> [11193.862235] smpboot: CPU 1 is now offline
> [11193.863719] smpboot: CPU 2 is now offline
> [11193.864238] IRQ 23: no longer affine to CPU3
> [11193.864242] IRQ 31: no longer affine to CPU3
> [11193.865247] smpboot: CPU 3 is now offline
> [11193.866658] smpboot: CPU 4 is now offline
> [11193.867129] IRQ 30: no longer affine to CPU5
> [11193.868134] smpboot: CPU 5 is now offline
> [11193.869781] smpboot: CPU 6 is now offline
> [11193.870201] IRQ 18: no longer affine to CPU7
> [11193.870208] IRQ 26: no longer affine to CPU7
> [11193.870219] IRQ 36: no longer affine to CPU7
> [11193.871229] smpboot: CPU 7 is now offline
> [11193.872113] ACPI: Low-level resume complete
> [11193.872150] ACPI: EC: EC started
> [11193.872150] PM: Restoring platform NVS memory
> [11193.872507] Enabling non-boot CPUs ...
> [11193.872540] x86: Booting SMP configuration:
> [11193.872541] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [11193.873344] CPU1 is up
> [11193.873368] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [11193.874026] CPU2 is up
> [11193.874046] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [11193.874692] CPU3 is up
> [11193.874711] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [11193.875390] CPU4 is up
> [11193.875412] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [11193.876077] CPU5 is up
> [11193.876096] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [11193.876788] CPU6 is up
> [11193.876807] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [11193.877487] CPU7 is up
> [11193.879700] ACPI: Waking up from system sleep state S3
> [11193.881409] ACPI: EC: interrupt unblocked
> [11193.927794] ACPI: EC: event unblocked
> [11193.928247] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [11193.938012] sd 0:0:0:0: [sda] Starting disk
> [11193.938025] sd 5:0:0:0: [sdb] Starting disk
> [11194.167222] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [11194.253921] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [11194.253945] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [11194.253963] ata2: SATA link down (SStatus 0 SControl 300)
> [11194.267585] ata1.00: configured for UDMA/133
> [11194.267595] ata6.00: configured for UDMA/133
> [11194.447334] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [11195.046786] OOM killer enabled.
> [11195.046787] Restarting tasks ... done.
> [11195.051659] video LNXVIDEO:00: Restoring backlight state
> [11195.064555] Bluetooth: hci0: read Intel version: 370710018002030d00
> [11195.064588] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [11195.228732] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [11195.243756] Bluetooth: hci0: Intel firmware patch completed and activated
> [11195.250193] PM: suspend exit
> [11197.010709] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [11197.012580] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [11197.022836] wlan0: authenticated
> [11197.026981] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [11197.052850] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [11197.061654] wlan0: associated
> [11197.157961] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [11510.125881] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [11510.476612] PM: suspend entry (deep)
> [11510.540956] Filesystems sync: 0.064 seconds
> [11510.541550] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [11510.543447] OOM killer disabled.
> [11510.543447] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [11510.544792] printk: Suspending console(s) (use no_console_suspend to debug)
> [11510.628894] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [11510.739240] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [11510.739316] sd 0:0:0:0: [sda] Stopping disk
> [11510.747272] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [11510.747358] sd 5:0:0:0: [sdb] Stopping disk
> [11510.816556] e1000e: EEE TX LPI TIMER: 00000011
> [11511.103698] ACPI: EC: interrupt blocked
> [11511.143557] ACPI: Preparing to enter system sleep state S3
> [11511.145738] ACPI: EC: event blocked
> [11511.145738] ACPI: EC: EC stopped
> [11511.145739] PM: Saving platform NVS memory
> [11511.145739] Disabling non-boot CPUs ...
> [11511.146015] IRQ 28: no longer affine to CPU1
> [11511.147318] smpboot: CPU 1 is now offline
> [11511.148778] smpboot: CPU 2 is now offline
> [11511.149315] IRQ 23: no longer affine to CPU3
> [11511.149320] IRQ 31: no longer affine to CPU3
> [11511.150323] smpboot: CPU 3 is now offline
> [11511.151741] smpboot: CPU 4 is now offline
> [11511.152215] IRQ 30: no longer affine to CPU5
> [11511.153220] smpboot: CPU 5 is now offline
> [11511.154616] smpboot: CPU 6 is now offline
> [11511.155024] IRQ 18: no longer affine to CPU7
> [11511.155028] IRQ 26: no longer affine to CPU7
> [11511.155035] IRQ 36: no longer affine to CPU7
> [11511.156044] smpboot: CPU 7 is now offline
> [11511.156773] ACPI: Low-level resume complete
> [11511.156809] ACPI: EC: EC started
> [11511.156809] PM: Restoring platform NVS memory
> [11511.157176] Enabling non-boot CPUs ...
> [11511.157209] x86: Booting SMP configuration:
> [11511.157210] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [11511.158013] CPU1 is up
> [11511.158038] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [11511.158700] CPU2 is up
> [11511.158720] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [11511.159365] CPU3 is up
> [11511.159385] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [11511.160057] CPU4 is up
> [11511.160077] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [11511.160741] CPU5 is up
> [11511.160761] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [11511.161450] CPU6 is up
> [11511.161468] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [11511.162147] CPU7 is up
> [11511.164375] ACPI: Waking up from system sleep state S3
> [11511.166324] ACPI: EC: interrupt unblocked
> [11511.208925] ACPI: EC: event unblocked
> [11511.219097] sd 5:0:0:0: [sdb] Starting disk
> [11511.219105] sd 0:0:0:0: [sda] Starting disk
> [11511.220517] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [11511.448332] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [11511.535342] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [11511.535364] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [11511.535382] ata2: SATA link down (SStatus 0 SControl 300)
> [11511.548976] ata1.00: configured for UDMA/133
> [11511.548985] ata6.00: configured for UDMA/133
> [11511.724478] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [11512.339890] OOM killer enabled.
> [11512.339891] Restarting tasks ... done.
> [11512.347707] video LNXVIDEO:00: Restoring backlight state
> [11512.356112] Bluetooth: hci0: read Intel version: 370710018002030d00
> [11512.356115] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [11512.531123] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [11512.547094] Bluetooth: hci0: Intel firmware patch completed and activated
> [11512.547194] PM: suspend exit
> [11514.293214] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [11514.295212] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [11514.400141] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 2/3)
> [11514.401836] wlan0: authenticated
> [11514.404118] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [11514.425595] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [11514.427691] wlan0: associated
> [11514.532297] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [12346.942504] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [12347.172002] PM: suspend entry (deep)
> [12347.235516] Filesystems sync: 0.063 seconds
> [12347.236366] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [12347.238547] OOM killer disabled.
> [12347.238548] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [12347.239879] printk: Suspending console(s) (use no_console_suspend to debug)
> [12347.312905] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [12347.415754] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [12347.415850] sd 5:0:0:0: [sdb] Stopping disk
> [12347.427839] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [12347.427935] sd 0:0:0:0: [sda] Stopping disk
> [12347.502191] e1000e: EEE TX LPI TIMER: 00000011
> [12347.788268] ACPI: EC: interrupt blocked
> [12347.828079] ACPI: Preparing to enter system sleep state S3
> [12347.830112] ACPI: EC: event blocked
> [12347.830112] ACPI: EC: EC stopped
> [12347.830112] PM: Saving platform NVS memory
> [12347.830113] Disabling non-boot CPUs ...
> [12347.830395] IRQ 28: no longer affine to CPU1
> [12347.831461] smpboot: CPU 1 is now offline
> [12347.832939] smpboot: CPU 2 is now offline
> [12347.833441] IRQ 23: no longer affine to CPU3
> [12347.833445] IRQ 31: no longer affine to CPU3
> [12347.834448] smpboot: CPU 3 is now offline
> [12347.835857] smpboot: CPU 4 is now offline
> [12347.836299] IRQ 30: no longer affine to CPU5
> [12347.837304] smpboot: CPU 5 is now offline
> [12347.838703] smpboot: CPU 6 is now offline
> [12347.839115] IRQ 18: no longer affine to CPU7
> [12347.839120] IRQ 26: no longer affine to CPU7
> [12347.839127] IRQ 36: no longer affine to CPU7
> [12347.840136] smpboot: CPU 7 is now offline
> [12347.840870] ACPI: Low-level resume complete
> [12347.840906] ACPI: EC: EC started
> [12347.840906] PM: Restoring platform NVS memory
> [12347.841261] Enabling non-boot CPUs ...
> [12347.841294] x86: Booting SMP configuration:
> [12347.841295] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [12347.842093] CPU1 is up
> [12347.842117] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [12347.842774] CPU2 is up
> [12347.842794] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [12347.843435] CPU3 is up
> [12347.843454] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [12347.844123] CPU4 is up
> [12347.844141] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [12347.844817] CPU5 is up
> [12347.844837] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [12347.845521] CPU6 is up
> [12347.845540] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [12347.846216] CPU7 is up
> [12347.848447] ACPI: Waking up from system sleep state S3
> [12347.850368] ACPI: EC: interrupt unblocked
> [12347.897428] ACPI: EC: event unblocked
> [12347.898247] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [12347.907619] sd 0:0:0:0: [sda] Starting disk
> [12347.907646] sd 5:0:0:0: [sdb] Starting disk
> [12348.132943] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [12348.223813] ata2: SATA link down (SStatus 0 SControl 300)
> [12348.223839] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12348.223861] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12348.237518] ata1.00: configured for UDMA/133
> [12348.237528] ata6.00: configured for UDMA/133
> [12348.408934] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [12349.028065] OOM killer enabled.
> [12349.028066] Restarting tasks ... done.
> [12349.040654] video LNXVIDEO:00: Restoring backlight state
> [12349.042426] Bluetooth: hci0: read Intel version: 370710018002030d00
> [12349.042449] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [12349.228426] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [12349.235422] PM: suspend exit
> [12349.244439] Bluetooth: hci0: Intel firmware patch completed and activated
> [12351.398457] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [12351.400320] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [12351.410674] wlan0: authenticated
> [12351.412671] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [12351.436144] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [12351.445175] wlan0: associated
> [12352.543084] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [12436.819045] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [12437.055795] PM: suspend entry (deep)
> [12458.781541] Filesystems sync: 21.725 seconds
> [12458.781970] Freezing user space processes ... (elapsed 0.079 seconds) done.
> [12458.861247] OOM killer disabled.
> [12458.861248] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [12458.862723] printk: Suspending console(s) (use no_console_suspend to debug)
> [12458.914301] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [12459.024406] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [12459.024502] sd 0:0:0:0: [sda] Stopping disk
> [12459.032382] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [12459.037537] sd 5:0:0:0: [sdb] Stopping disk
> [12459.206921] e1000e: EEE TX LPI TIMER: 00000011
> [12459.388821] ACPI: EC: interrupt blocked
> [12459.428660] ACPI: Preparing to enter system sleep state S3
> [12459.430645] ACPI: EC: event blocked
> [12459.430645] ACPI: EC: EC stopped
> [12459.430646] PM: Saving platform NVS memory
> [12459.430647] Disabling non-boot CPUs ...
> [12459.430926] IRQ 28: no longer affine to CPU1
> [12459.432227] smpboot: CPU 1 is now offline
> [12459.433695] smpboot: CPU 2 is now offline
> [12459.434199] IRQ 23: no longer affine to CPU3
> [12459.434204] IRQ 31: no longer affine to CPU3
> [12459.435207] smpboot: CPU 3 is now offline
> [12459.436910] smpboot: CPU 4 is now offline
> [12459.437305] IRQ 30: no longer affine to CPU5
> [12459.438308] smpboot: CPU 5 is now offline
> [12459.439686] smpboot: CPU 6 is now offline
> [12459.440094] IRQ 18: no longer affine to CPU7
> [12459.440098] IRQ 26: no longer affine to CPU7
> [12459.440105] IRQ 36: no longer affine to CPU7
> [12459.441115] smpboot: CPU 7 is now offline
> [12459.441872] ACPI: Low-level resume complete
> [12459.441909] ACPI: EC: EC started
> [12459.441909] PM: Restoring platform NVS memory
> [12459.442261] Enabling non-boot CPUs ...
> [12459.442296] x86: Booting SMP configuration:
> [12459.442296] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [12459.443125] CPU1 is up
> [12459.443149] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [12459.443832] CPU2 is up
> [12459.443851] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [12459.444520] CPU3 is up
> [12459.444539] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [12459.445243] CPU4 is up
> [12459.445274] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [12459.445969] CPU5 is up
> [12459.445991] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [12459.446709] CPU6 is up
> [12459.446731] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [12459.447442] CPU7 is up
> [12459.449687] ACPI: Waking up from system sleep state S3
> [12459.451429] ACPI: EC: interrupt unblocked
> [12459.495215] ACPI: EC: event unblocked
> [12459.505419] sd 5:0:0:0: [sdb] Starting disk
> [12459.505426] sd 0:0:0:0: [sda] Starting disk
> [12459.729523] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [12459.820468] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12459.820490] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12459.820509] ata2: SATA link down (SStatus 0 SControl 300)
> [12459.834102] ata1.00: configured for UDMA/133
> [12459.834122] ata6.00: configured for UDMA/133
> [12460.005540] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [12460.644241] OOM killer enabled.
> [12460.644242] Restarting tasks ... done.
> [12460.656863] Bluetooth: hci0: read Intel version: 370710018002030d00
> [12460.656868] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [12460.657616] video LNXVIDEO:00: Restoring backlight state
> [12460.830916] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [12460.846882] Bluetooth: hci0: Intel firmware patch completed and activated
> [12460.858086] PM: suspend exit
> [12463.090171] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [12463.092055] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [12463.102075] wlan0: authenticated
> [12463.109207] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [12463.130874] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [12463.135690] wlan0: associated
> [12463.235333] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [12533.931822] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [12534.345839] PM: suspend entry (deep)
> [12534.569128] Filesystems sync: 0.223 seconds
> [12534.570036] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [12534.572739] OOM killer disabled.
> [12534.572740] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [12534.574861] printk: Suspending console(s) (use no_console_suspend to debug)
> [12534.645762] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [12534.753063] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [12534.753078] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [12534.753112] sd 0:0:0:0: [sda] Stopping disk
> [12534.753128] sd 5:0:0:0: [sdb] Stopping disk
> [12534.833302] e1000e: EEE TX LPI TIMER: 00000011
> [12535.117475] ACPI: EC: interrupt blocked
> [12535.157336] ACPI: Preparing to enter system sleep state S3
> [12535.159411] ACPI: EC: event blocked
> [12535.159411] ACPI: EC: EC stopped
> [12535.159411] PM: Saving platform NVS memory
> [12535.159412] Disabling non-boot CPUs ...
> [12535.159688] IRQ 28: no longer affine to CPU1
> [12535.160868] smpboot: CPU 1 is now offline
> [12535.162357] smpboot: CPU 2 is now offline
> [12535.162877] IRQ 23: no longer affine to CPU3
> [12535.162882] IRQ 31: no longer affine to CPU3
> [12535.163886] smpboot: CPU 3 is now offline
> [12535.165520] smpboot: CPU 4 is now offline
> [12535.165877] IRQ 30: no longer affine to CPU5
> [12535.166880] smpboot: CPU 5 is now offline
> [12535.168281] smpboot: CPU 6 is now offline
> [12535.168705] IRQ 18: no longer affine to CPU7
> [12535.168709] IRQ 26: no longer affine to CPU7
> [12535.168716] IRQ 36: no longer affine to CPU7
> [12535.169725] smpboot: CPU 7 is now offline
> [12535.170468] ACPI: Low-level resume complete
> [12535.170504] ACPI: EC: EC started
> [12535.170504] PM: Restoring platform NVS memory
> [12535.170864] Enabling non-boot CPUs ...
> [12535.170897] x86: Booting SMP configuration:
> [12535.170898] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [12535.171722] CPU1 is up
> [12535.171747] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [12535.172432] CPU2 is up
> [12535.172451] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [12535.173123] CPU3 is up
> [12535.173143] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [12535.173840] CPU4 is up
> [12535.173859] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [12535.174549] CPU5 is up
> [12535.174570] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [12535.175281] CPU6 is up
> [12535.175300] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [12535.176021] CPU7 is up
> [12535.178307] ACPI: Waking up from system sleep state S3
> [12535.180045] ACPI: EC: interrupt unblocked
> [12535.223880] ACPI: EC: event unblocked
> [12535.224555] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [12535.224709] sd 5:0:0:0: [sdb] Starting disk
> [12535.224723] sd 0:0:0:0: [sda] Starting disk
> [12535.458216] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [12535.537081] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12535.537103] ata2: SATA link down (SStatus 0 SControl 300)
> [12535.537127] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12535.550674] ata6.00: configured for UDMA/133
> [12535.550715] ata1.00: configured for UDMA/133
> [12535.734232] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [12536.357468] OOM killer enabled.
> [12536.357469] Restarting tasks ... done.
> [12536.362123] video LNXVIDEO:00: Restoring backlight state
> [12536.370564] Bluetooth: hci0: read Intel version: 370710018002030d00
> [12536.370594] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [12536.556964] PM: suspend exit
> [12536.564540] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [12536.579553] Bluetooth: hci0: Intel firmware patch completed and activated
> [12538.307216] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [12538.309192] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [12538.320763] wlan0: authenticated
> [12538.325916] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [12538.347402] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [12538.353010] wlan0: associated
> [12538.456842] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [12579.652335] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [12579.904361] PM: suspend entry (deep)
> [12580.352180] Filesystems sync: 0.447 seconds
> [12580.352929] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [12580.355562] OOM killer disabled.
> [12580.355563] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [12580.356964] printk: Suspending console(s) (use no_console_suspend to debug)
> [12580.424413] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [12580.525850] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [12580.525878] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [12580.525951] sd 0:0:0:0: [sda] Stopping disk
> [12580.525968] sd 5:0:0:0: [sdb] Stopping disk
> [12580.609266] e1000e: EEE TX LPI TIMER: 00000011
> [12580.890250] ACPI: EC: interrupt blocked
> [12580.930103] ACPI: Preparing to enter system sleep state S3
> [12580.932164] ACPI: EC: event blocked
> [12580.932164] ACPI: EC: EC stopped
> [12580.932165] PM: Saving platform NVS memory
> [12580.932165] Disabling non-boot CPUs ...
> [12580.932444] IRQ 28: no longer affine to CPU1
> [12580.933743] smpboot: CPU 1 is now offline
> [12580.935197] smpboot: CPU 2 is now offline
> [12580.935737] IRQ 23: no longer affine to CPU3
> [12580.935741] IRQ 31: no longer affine to CPU3
> [12580.936744] smpboot: CPU 3 is now offline
> [12580.938132] smpboot: CPU 4 is now offline
> [12580.938599] IRQ 30: no longer affine to CPU5
> [12580.939605] smpboot: CPU 5 is now offline
> [12580.940996] smpboot: CPU 6 is now offline
> [12580.941418] IRQ 18: no longer affine to CPU7
> [12580.941423] IRQ 26: no longer affine to CPU7
> [12580.941430] IRQ 36: no longer affine to CPU7
> [12580.942442] smpboot: CPU 7 is now offline
> [12580.943193] ACPI: Low-level resume complete
> [12580.943229] ACPI: EC: EC started
> [12580.943230] PM: Restoring platform NVS memory
> [12580.943582] Enabling non-boot CPUs ...
> [12580.943615] x86: Booting SMP configuration:
> [12580.943615] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [12580.944447] CPU1 is up
> [12580.944472] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [12580.945160] CPU2 is up
> [12580.945181] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [12580.945852] CPU3 is up
> [12580.945870] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [12580.946569] CPU4 is up
> [12580.946589] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [12580.947278] CPU5 is up
> [12580.947298] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [12580.948015] CPU6 is up
> [12580.948034] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [12580.948754] CPU7 is up
> [12580.951046] ACPI: Waking up from system sleep state S3
> [12580.952871] ACPI: EC: interrupt unblocked
> [12580.996673] ACPI: EC: event unblocked
> [12581.006842] sd 5:0:0:0: [sdb] Starting disk
> [12581.006862] sd 0:0:0:0: [sda] Starting disk
> [12581.234913] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [12581.321834] ata2: SATA link down (SStatus 0 SControl 300)
> [12581.321860] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12581.321881] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12581.335504] ata6.00: configured for UDMA/133
> [12581.335513] ata1.00: configured for UDMA/133
> [12581.511009] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [12582.118350] OOM killer enabled.
> [12582.118351] Restarting tasks ... done.
> [12582.129852] video LNXVIDEO:00: Restoring backlight state
> [12582.136549] Bluetooth: hci0: read Intel version: 370710018002030d00
> [12582.136552] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [12582.317621] PM: suspend exit
> [12582.322537] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [12582.337557] Bluetooth: hci0: Intel firmware patch completed and activated
> [12584.067917] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [12584.069796] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [12584.079092] wlan0: authenticated
> [12584.082664] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [12584.106116] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [12584.116077] wlan0: associated
> [12584.219308] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [12601.037286] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [12601.273796] PM: suspend entry (deep)
> [12601.361572] Filesystems sync: 0.087 seconds
> [12601.361831] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [12601.363679] OOM killer disabled.
> [12601.363680] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [12601.365054] printk: Suspending console(s) (use no_console_suspend to debug)
> [12601.418201] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [12601.526712] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [12601.526748] sd 5:0:0:0: [sdb] Stopping disk
> [12601.530661] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [12601.530732] sd 0:0:0:0: [sda] Stopping disk
> [12601.606887] e1000e: EEE TX LPI TIMER: 00000011
> [12601.887183] ACPI: EC: interrupt blocked
> [12601.926944] ACPI: Preparing to enter system sleep state S3
> [12601.928868] ACPI: EC: event blocked
> [12601.928868] ACPI: EC: EC stopped
> [12601.928869] PM: Saving platform NVS memory
> [12601.928869] Disabling non-boot CPUs ...
> [12601.929146] IRQ 28: no longer affine to CPU1
> [12601.930346] smpboot: CPU 1 is now offline
> [12601.931802] smpboot: CPU 2 is now offline
> [12601.932320] IRQ 23: no longer affine to CPU3
> [12601.932325] IRQ 31: no longer affine to CPU3
> [12601.933329] smpboot: CPU 3 is now offline
> [12601.934970] smpboot: CPU 4 is now offline
> [12601.935333] IRQ 30: no longer affine to CPU5
> [12601.936337] smpboot: CPU 5 is now offline
> [12601.937735] smpboot: CPU 6 is now offline
> [12601.938168] IRQ 18: no longer affine to CPU7
> [12601.938173] IRQ 26: no longer affine to CPU7
> [12601.938180] IRQ 36: no longer affine to CPU7
> [12601.939190] smpboot: CPU 7 is now offline
> [12601.939945] ACPI: Low-level resume complete
> [12601.939981] ACPI: EC: EC started
> [12601.939981] PM: Restoring platform NVS memory
> [12601.940343] Enabling non-boot CPUs ...
> [12601.940378] x86: Booting SMP configuration:
> [12601.940379] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [12601.941213] CPU1 is up
> [12601.941238] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [12601.941925] CPU2 is up
> [12601.941945] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [12601.942618] CPU3 is up
> [12601.942637] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [12601.943343] CPU4 is up
> [12601.943361] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [12601.944059] CPU5 is up
> [12601.944080] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [12601.944795] CPU6 is up
> [12601.944814] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [12601.945539] CPU7 is up
> [12601.947833] ACPI: Waking up from system sleep state S3
> [12601.949897] ACPI: EC: interrupt unblocked
> [12601.989490] ACPI: EC: event unblocked
> [12601.999656] sd 0:0:0:0: [sda] Starting disk
> [12601.999658] sd 5:0:0:0: [sdb] Starting disk
> [12602.223850] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [12602.314841] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12602.314863] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12602.314882] ata2: SATA link down (SStatus 0 SControl 300)
> [12602.328471] ata6.00: configured for UDMA/133
> [12602.328480] ata1.00: configured for UDMA/133
> [12602.499852] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [12603.111320] OOM killer enabled.
> [12603.111321] Restarting tasks ... done.
> [12603.122189] video LNXVIDEO:00: Restoring backlight state
> [12603.127264] Bluetooth: hci0: read Intel version: 370710018002030d00
> [12603.127291] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [12603.318302] PM: suspend exit
> [12603.326261] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [12603.341290] Bluetooth: hci0: Intel firmware patch completed and activated
> [12605.525690] wlan0: authenticate with 00:57:c1:f8:87:cb
> [12605.527585] wlan0: send auth to 00:57:c1:f8:87:cb (try 1/3)
> [12605.531681] wlan0: authenticated
> [12605.539513] wlan0: associate with 00:57:c1:f8:87:cb (try 1/3)
> [12605.554835] wlan0: RX AssocResp from 00:57:c1:f8:87:cb (capab=0x431 status=0 aid=1)
> [12605.556523] wlan0: associated
> [12605.575870] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [13316.748362] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [13317.008497] PM: suspend entry (deep)
> [13317.232884] Filesystems sync: 0.224 seconds
> [13317.233580] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [13317.235398] OOM killer disabled.
> [13317.235398] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [13317.236581] printk: Suspending console(s) (use no_console_suspend to debug)
> [13317.309908] wlan0: deauthenticating from 00:57:c1:f8:87:cb by local choice (Reason: 3=DEAUTH_LEAVING)
> [13317.417645] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [13317.417723] sd 0:0:0:0: [sda] Stopping disk
> [13317.437683] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [13317.437753] sd 5:0:0:0: [sdb] Stopping disk
> [13317.495994] e1000e: EEE TX LPI TIMER: 00000011
> [13317.774074] ACPI: EC: interrupt blocked
> [13317.813942] ACPI: Preparing to enter system sleep state S3
> [13317.815900] ACPI: EC: event blocked
> [13317.815900] ACPI: EC: EC stopped
> [13317.815901] PM: Saving platform NVS memory
> [13317.815901] Disabling non-boot CPUs ...
> [13317.816177] IRQ 28: no longer affine to CPU1
> [13317.817322] smpboot: CPU 1 is now offline
> [13317.818794] smpboot: CPU 2 is now offline
> [13317.819304] IRQ 23: no longer affine to CPU3
> [13317.819309] IRQ 31: no longer affine to CPU3
> [13317.820314] smpboot: CPU 3 is now offline
> [13317.821965] smpboot: CPU 4 is now offline
> [13317.822336] IRQ 30: no longer affine to CPU5
> [13317.823339] smpboot: CPU 5 is now offline
> [13317.824771] smpboot: CPU 6 is now offline
> [13317.825187] IRQ 18: no longer affine to CPU7
> [13317.825192] IRQ 26: no longer affine to CPU7
> [13317.825198] IRQ 36: no longer affine to CPU7
> [13317.826204] smpboot: CPU 7 is now offline
> [13317.826972] ACPI: Low-level resume complete
> [13317.827008] ACPI: EC: EC started
> [13317.827008] PM: Restoring platform NVS memory
> [13317.827359] Enabling non-boot CPUs ...
> [13317.827393] x86: Booting SMP configuration:
> [13317.827393] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [13317.828131] CPU1 is up
> [13317.828155] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [13317.828821] CPU2 is up
> [13317.828841] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [13317.829492] CPU3 is up
> [13317.829511] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [13317.830193] CPU4 is up
> [13317.830211] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [13317.830881] CPU5 is up
> [13317.830901] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [13317.831598] CPU6 is up
> [13317.831617] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [13317.832323] CPU7 is up
> [13317.834667] ACPI: Waking up from system sleep state S3
> [13317.836410] ACPI: EC: interrupt unblocked
> [13317.880444] ACPI: EC: event unblocked
> [13317.881338] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [13317.890626] sd 0:0:0:0: [sda] Starting disk
> [13317.890635] sd 5:0:0:0: [sdb] Starting disk
> [13318.118699] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [13318.205204] ata2: SATA link down (SStatus 0 SControl 300)
> [13318.205295] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [13318.205337] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [13318.218856] ata6.00: configured for UDMA/133
> [13318.218919] ata1.00: configured for UDMA/133
> [13318.394883] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [13318.544636] OOM killer enabled.
> [13318.544637] Restarting tasks ... done.
> [13318.546802] video LNXVIDEO:00: Restoring backlight state
> [13318.557265] Bluetooth: hci0: read Intel version: 370710018002030d00
> [13318.557270] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [13318.565206] PM: suspend exit
> [13318.628881] pci 0000:00:16.0: Refused to change power state, currently in D3
> [13318.681252] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [13318.697284] Bluetooth: hci0: Intel firmware patch completed and activated
> [13318.814531] usb 2-9: new high-speed USB device number 22 using xhci_hcd
> [13318.964969] usb 2-9: New USB device found, idVendor=17ef, idProduct=1010, bcdDevice=50.30
> [13318.964971] usb 2-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [13318.964972] usb 2-9: Product: Lenovo ThinkPad Dock   
> [13318.964972] usb 2-9: Manufacturer: LENOVO                 
> [13318.966207] hub 2-9:1.0: USB hub found
> [13318.966565] hub 2-9:1.0: 4 ports detected
> [13319.090763] usb 3-5: new SuperSpeed Gen 1 USB device number 3 using xhci_hcd
> [13319.112290] usb 3-5: New USB device found, idVendor=17ef, idProduct=1010, bcdDevice=50.31
> [13319.112292] usb 3-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [13319.112293] usb 3-5: Product: Lenovo ThinkPad Dock   
> [13319.112293] usb 3-5: Manufacturer: LENOVO                 
> [13319.113889] hub 3-5:1.0: USB hub found
> [13319.114020] hub 3-5:1.0: 4 ports detected
> [13319.270507] usb 2-9.4: new high-speed USB device number 23 using xhci_hcd
> [13319.387007] usb 2-9.4: New USB device found, idVendor=17ef, idProduct=100f, bcdDevice= 0.01
> [13319.387008] usb 2-9.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [13319.387009] usb 2-9.4: Product: Lenovo ThinkPad Dock
> [13319.387010] usb 2-9.4: Manufacturer: Lenovo
> [13319.387011] usb 2-9.4: SerialNumber: Rev1.2
> [13319.387922] hub 2-9.4:1.0: USB hub found
> [13319.387942] hub 2-9.4:1.0: 3 ports detected
> [13319.678538] usb 2-9.4.1: new full-speed USB device number 24 using xhci_hcd
> [13319.779800] usb 2-9.4.1: New USB device found, idVendor=2034, idProduct=0105, bcdDevice= 1.00
> [13319.779802] usb 2-9.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [13319.779803] usb 2-9.4.1: Product: BWA19HO011
> [13319.779804] usb 2-9.4.1: Manufacturer: BlackWeb
> [13319.779805] usb 2-9.4.1: SerialNumber: IM10000011
> [13319.788481] input: BlackWeb BWA19HO011 as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.1/2-9.4.1:1.2/0003:2034:0105.0009/input/input37
> [13319.846686] hid-generic 0003:2034:0105.0009: input,hidraw0: USB HID v1.00 Device [BlackWeb BWA19HO011] on usb-0000:00:14.0-9.4.1/input2
> [13320.070593] usb 2-9.4.2: new high-speed USB device number 25 using xhci_hcd
> [13320.186767] usb 2-9.4.2: New USB device found, idVendor=413c, idProduct=1010, bcdDevice=32.98
> [13320.186769] usb 2-9.4.2: New USB device strings: Mfr=0, Product=11, SerialNumber=0
> [13320.186769] usb 2-9.4.2: Product: USB 2.0 Hub [MTT]
> [13320.188532] hub 2-9.4.2:1.0: USB hub found
> [13320.190142] hub 2-9.4.2:1.0: 4 ports detected
> [13320.413119] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [13320.413570] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [13320.415389] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [13320.424425] wlan0: authenticated
> [13320.425486] PM: suspend entry (deep)
> [13320.426502] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [13320.450263] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [13320.451514] wlan0: associated
> [13320.457859] Filesystems sync: 0.032 seconds
> [13320.482572] usb 2-9.4.2.2: new low-speed USB device number 26 using xhci_hcd
> [13320.557027] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [13320.590109] usb 2-9.4.2.2: New USB device found, idVendor=0461, idProduct=4d15, bcdDevice= 2.00
> [13320.590121] usb 2-9.4.2.2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [13320.590122] usb 2-9.4.2.2: Product: USB Optical Mouse
> [13320.595594] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.2/2-9.4.2.2:1.0/0003:0461:4D15.000A/input/input38
> [13320.595760] hid-generic 0003:0461:4D15.000A: input,hidraw1: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-9.4.2.2/input0
> [13320.674505] usb 2-9.4.2.4: new low-speed USB device number 27 using xhci_hcd
> [13320.782686] usb 2-9.4.2.4: New USB device found, idVendor=413c, idProduct=2110, bcdDevice= 0.06
> [13320.782688] usb 2-9.4.2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [13320.782689] usb 2-9.4.2.4: Product: Dell Wired Multimedia Keyboard
> [13320.782689] usb 2-9.4.2.4: Manufacturer: Dell
> [13320.795679] input: Dell Dell Wired Multimedia Keyboard as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.0/0003:413C:2110.000B/input/input39
> [13320.863251] hid-generic 0003:413C:2110.000B: input,hidraw2: USB HID v1.10 Keyboard [Dell Dell Wired Multimedia Keyboard] on usb-0000:00:14.0-9.4.2.4/input0
> [13320.883935] input: Dell Dell Wired Multimedia Keyboard Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.000C/input/input40
> [13320.884035] input: Dell Dell Wired Multimedia Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.000C/input/input41
> [13320.942886] input: Dell Dell Wired Multimedia Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.000C/input/input42
> [13320.944290] hid-generic 0003:413C:2110.000C: input,hiddev96,hidraw3: USB HID v1.10 Mouse [Dell Dell Wired Multimedia Keyboard] on usb-0000:00:14.0-9.4.2.4/input1
> [13322.496354] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [13322.498654] OOM killer disabled.
> [13322.498655] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [13322.500288] printk: Suspending console(s) (use no_console_suspend to debug)
> [13322.564137] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [13322.574587] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [13322.574708] sd 5:0:0:0: [sdb] Stopping disk
> [13322.578617] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [13322.578668] sd 0:0:0:0: [sda] Stopping disk
> [13322.753946] e1000e: EEE TX LPI TIMER: 00000011
> [13322.855025] ACPI: EC: interrupt blocked
> [13322.898794] ACPI: Preparing to enter system sleep state S3
> [13322.900784] ACPI: EC: event blocked
> [13322.900784] ACPI: EC: EC stopped
> [13322.900784] PM: Saving platform NVS memory
> [13322.900785] Disabling non-boot CPUs ...
> [13322.902349] smpboot: CPU 1 is now offline
> [13322.903776] smpboot: CPU 2 is now offline
> [13322.905285] smpboot: CPU 3 is now offline
> [13322.906668] smpboot: CPU 4 is now offline
> [13322.908118] smpboot: CPU 5 is now offline
> [13322.909522] smpboot: CPU 6 is now offline
> [13322.910939] smpboot: CPU 7 is now offline
> [13322.911658] ACPI: Low-level resume complete
> [13322.911694] ACPI: EC: EC started
> [13322.911695] PM: Restoring platform NVS memory
> [13322.912049] Enabling non-boot CPUs ...
> [13322.912082] x86: Booting SMP configuration:
> [13322.912083] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [13322.912915] CPU1 is up
> [13322.912940] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [13322.913627] CPU2 is up
> [13322.913646] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [13322.914325] CPU3 is up
> [13322.914345] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [13322.915053] CPU4 is up
> [13322.915072] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [13322.915764] CPU5 is up
> [13322.915784] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [13322.916509] CPU6 is up
> [13322.916529] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [13322.917260] CPU7 is up
> [13322.919547] ACPI: Waking up from system sleep state S3
> [13322.921351] pci 0000:00:16.0: Refused to change power state, currently in D3
> [13322.921569] ACPI: EC: interrupt unblocked
> [13322.964425] ACPI: EC: event unblocked
> [13322.971047] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [13322.974612] sd 0:0:0:0: [sda] Starting disk
> [13322.974634] sd 5:0:0:0: [sdb] Starting disk
> [13323.134939] usb 3-5: Disable of device-initiated U1 failed.
> [13323.138464] usb 3-5: Disable of device-initiated U2 failed.
> [13323.215686] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [13323.290201] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [13323.290258] ata2: SATA link down (SStatus 0 SControl 300)
> [13323.290312] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [13323.303828] ata1.00: configured for UDMA/133
> [13323.303894] ata6.00: configured for UDMA/133
> [13323.491629] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [13323.767937] usb 3-5: reset SuperSpeed Gen 1 USB device number 3 using xhci_hcd
> [13323.915714] usb 2-9: reset high-speed USB device number 22 using xhci_hcd
> [13324.379691] usb 2-9.4: reset high-speed USB device number 23 using xhci_hcd
> [13324.787753] usb 2-9.4.1: reset full-speed USB device number 24 using xhci_hcd
> [13324.967712] usb 2-9.4.2: reset high-speed USB device number 25 using xhci_hcd
> [13325.555736] usb 2-9.4.2.4: reset low-speed USB device number 27 using xhci_hcd
> [13326.111699] usb 2-9.4.2.2: reset low-speed USB device number 26 using xhci_hcd
> [13326.404494] OOM killer enabled.
> [13326.404495] Restarting tasks ... done.
> [13326.410048] video LNXVIDEO:00: Restoring backlight state
> [13326.424900] PM: suspend exit
> [13326.428299] Bluetooth: hci0: read Intel version: 370710018002030d00
> [13326.428304] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [13326.588279] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [13326.603285] Bluetooth: hci0: Intel firmware patch completed and activated
> [13329.310504] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [13329.312261] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [13329.321482] wlan0: authenticated
> [13329.323853] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [13329.345339] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [13329.354699] wlan0: associated
> [13329.450144] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [13331.471819] e1000e 0000:00:19.0 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [13331.471857] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [13973.039953] usb 2-9.4.3: new high-speed USB device number 28 using xhci_hcd
> [13973.144844] usb 2-9.4.3: New USB device found, idVendor=1004, idProduct=633e, bcdDevice= 3.18
> [13973.144847] usb 2-9.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [13973.144849] usb 2-9.4.3: Product: LM-X212(G)
> [13973.144850] usb 2-9.4.3: Manufacturer: LGE
> [13973.144852] usb 2-9.4.3: SerialNumber: LMX212Gc2e16edc
> [25717.683670] usb 2-9: USB disconnect, device number 22
> [25717.683671] usb 2-9.4: USB disconnect, device number 23
> [25717.683672] usb 2-9.4.1: USB disconnect, device number 24
> [25717.751340] usb 2-9.4.2: USB disconnect, device number 25
> [25717.751343] usb 2-9.4.2.2: USB disconnect, device number 26
> [25717.863272] usb 2-9.4.2.4: USB disconnect, device number 27
> [25717.878515] usb 3-5: USB disconnect, device number 3
> [25718.038669] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [25718.236882] usb 2-9.4.3: USB disconnect, device number 28
> [25720.941133] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [25724.990019] PM: suspend entry (deep)
> [25725.133816] Filesystems sync: 0.143 seconds
> [25725.134618] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [25725.137179] OOM killer disabled.
> [25725.137180] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [25725.138750] printk: Suspending console(s) (use no_console_suspend to debug)
> [25725.230132] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [25725.338522] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [25725.338561] sd 0:0:0:0: [sda] Stopping disk
> [25725.338732] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [25725.338763] sd 5:0:0:0: [sdb] Stopping disk
> [25725.416896] e1000e: EEE TX LPI TIMER: 00000011
> [25725.706907] ACPI: EC: interrupt blocked
> [25725.746792] ACPI: Preparing to enter system sleep state S3
> [25725.748927] ACPI: EC: event blocked
> [25725.748927] ACPI: EC: EC stopped
> [25725.748927] PM: Saving platform NVS memory
> [25725.748928] Disabling non-boot CPUs ...
> [25725.749211] IRQ 28: no longer affine to CPU1
> [25725.750282] smpboot: CPU 1 is now offline
> [25725.751763] smpboot: CPU 2 is now offline
> [25725.752278] IRQ 23: no longer affine to CPU3
> [25725.752283] IRQ 31: no longer affine to CPU3
> [25725.753287] smpboot: CPU 3 is now offline
> [25725.754726] smpboot: CPU 4 is now offline
> [25725.755184] IRQ 30: no longer affine to CPU5
> [25725.756189] smpboot: CPU 5 is now offline
> [25725.757585] smpboot: CPU 6 is now offline
> [25725.757998] IRQ 18: no longer affine to CPU7
> [25725.758003] IRQ 26: no longer affine to CPU7
> [25725.758010] IRQ 36: no longer affine to CPU7
> [25725.759020] smpboot: CPU 7 is now offline
> [25725.759766] ACPI: Low-level resume complete
> [25725.759803] ACPI: EC: EC started
> [25725.759803] PM: Restoring platform NVS memory
> [25725.760161] Enabling non-boot CPUs ...
> [25725.760195] x86: Booting SMP configuration:
> [25725.760195] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [25725.760994] CPU1 is up
> [25725.761018] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [25725.761679] CPU2 is up
> [25725.761698] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [25725.762342] CPU3 is up
> [25725.762361] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [25725.763037] CPU4 is up
> [25725.763055] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [25725.763721] CPU5 is up
> [25725.763742] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [25725.764427] CPU6 is up
> [25725.764446] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [25725.765135] CPU7 is up
> [25725.767406] ACPI: Waking up from system sleep state S3
> [25725.769134] ACPI: EC: interrupt unblocked
> [25725.813341] ACPI: EC: event unblocked
> [25725.823490] sd 5:0:0:0: [sdb] Starting disk
> [25725.823501] sd 0:0:0:0: [sda] Starting disk
> [25726.047712] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [25726.138546] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [25726.138569] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [25726.138587] ata2: SATA link down (SStatus 0 SControl 300)
> [25726.152175] ata1.00: configured for UDMA/133
> [25726.152185] ata6.00: configured for UDMA/133
> [25726.323674] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [25726.917063] thinkpad_acpi: restoring fan level to 0x40
> [25726.935350] OOM killer enabled.
> [25726.935351] Restarting tasks ... done.
> [25726.940035] video LNXVIDEO:00: Restoring backlight state
> [25726.951138] Bluetooth: hci0: read Intel version: 370710018002030d00
> [25726.951179] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [25727.126132] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [25727.141207] Bluetooth: hci0: Intel firmware patch completed and activated
> [25727.144764] PM: suspend exit
> [25728.989523] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [25728.991431] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [25729.000910] wlan0: authenticated
> [25729.003325] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [25729.027319] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [25729.028899] wlan0: associated
> [25729.132501] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [26063.259425] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [26063.685726] PM: suspend entry (deep)
> [26063.968793] Filesystems sync: 0.283 seconds
> [26063.969546] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [26063.972337] OOM killer disabled.
> [26063.972337] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [26063.974015] printk: Suspending console(s) (use no_console_suspend to debug)
> [26064.052806] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [26064.160950] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [26064.164853] sd 5:0:0:0: [sdb] Stopping disk
> [26064.172887] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [26064.172976] sd 0:0:0:0: [sda] Stopping disk
> [26064.242210] e1000e: EEE TX LPI TIMER: 00000011
> [26064.525316] ACPI: EC: interrupt blocked
> [26064.565172] ACPI: Preparing to enter system sleep state S3
> [26064.567120] ACPI: EC: event blocked
> [26064.567121] ACPI: EC: EC stopped
> [26064.567121] PM: Saving platform NVS memory
> [26064.567122] Disabling non-boot CPUs ...
> [26064.567398] IRQ 28: no longer affine to CPU1
> [26064.568701] smpboot: CPU 1 is now offline
> [26064.570159] smpboot: CPU 2 is now offline
> [26064.570667] IRQ 23: no longer affine to CPU3
> [26064.570672] IRQ 31: no longer affine to CPU3
> [26064.571676] smpboot: CPU 3 is now offline
> [26064.573345] smpboot: CPU 4 is now offline
> [26064.573719] IRQ 30: no longer affine to CPU5
> [26064.574723] smpboot: CPU 5 is now offline
> [26064.576083] smpboot: CPU 6 is now offline
> [26064.576493] IRQ 18: no longer affine to CPU7
> [26064.576498] IRQ 26: no longer affine to CPU7
> [26064.576505] IRQ 36: no longer affine to CPU7
> [26064.577510] smpboot: CPU 7 is now offline
> [26064.578247] ACPI: Low-level resume complete
> [26064.578284] ACPI: EC: EC started
> [26064.578284] PM: Restoring platform NVS memory
> [26064.578650] Enabling non-boot CPUs ...
> [26064.578683] x86: Booting SMP configuration:
> [26064.578684] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [26064.579480] CPU1 is up
> [26064.579504] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [26064.580169] CPU2 is up
> [26064.580189] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [26064.580835] CPU3 is up
> [26064.580854] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [26064.581527] CPU4 is up
> [26064.581547] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [26064.582224] CPU5 is up
> [26064.582245] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [26064.582940] CPU6 is up
> [26064.582960] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [26064.583644] CPU7 is up
> [26064.585938] ACPI: Waking up from system sleep state S3
> [26064.587692] ACPI: EC: interrupt unblocked
> [26064.627750] ACPI: EC: event unblocked
> [26064.628385] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [26064.637935] sd 5:0:0:0: [sdb] Starting disk
> [26064.637962] sd 0:0:0:0: [sda] Starting disk
> [26064.862107] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [26064.953007] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [26064.953027] ata2: SATA link down (SStatus 0 SControl 300)
> [26064.953051] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [26064.966636] ata6.00: configured for UDMA/133
> [26064.966646] ata1.00: configured for UDMA/133
> [26065.138031] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [26065.748984] OOM killer enabled.
> [26065.748984] Restarting tasks ... done.
> [26065.754004] video LNXVIDEO:00: Restoring backlight state
> [26065.774511] Bluetooth: hci0: read Intel version: 370710018002030d00
> [26065.774516] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [26065.915033] pci 0000:00:16.0: Refused to change power state, currently in D3
> [26065.936540] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [26065.943366] PM: suspend exit
> [26065.951510] Bluetooth: hci0: Intel firmware patch completed and activated
> [26067.647264] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [26067.649042] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [26067.658908] wlan0: authenticated
> [26067.665699] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [26067.687117] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [26067.687962] wlan0: associated
> [26067.792341] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [38492.296676] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [38492.651469] PM: suspend entry (deep)
> [38492.707121] Filesystems sync: 0.055 seconds
> [38492.707844] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [38492.709826] OOM killer disabled.
> [38492.709826] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [38492.711140] printk: Suspending console(s) (use no_console_suspend to debug)
> [38492.791344] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [38492.818142] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [38492.818213] sd 0:0:0:0: [sda] Stopping disk
> [38492.822175] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [38492.822251] sd 5:0:0:0: [sdb] Stopping disk
> [38492.978370] e1000e: EEE TX LPI TIMER: 00000011
> [38493.262601] ACPI: EC: interrupt blocked
> [38493.302441] ACPI: Preparing to enter system sleep state S3
> [38493.304331] ACPI: EC: event blocked
> [38493.304331] ACPI: EC: EC stopped
> [38493.304332] PM: Saving platform NVS memory
> [38493.304332] Disabling non-boot CPUs ...
> [38493.304594] IRQ 28: no longer affine to CPU1
> [38493.305894] smpboot: CPU 1 is now offline
> [38493.307347] smpboot: CPU 2 is now offline
> [38493.307853] IRQ 23: no longer affine to CPU3
> [38493.307858] IRQ 31: no longer affine to CPU3
> [38493.308862] smpboot: CPU 3 is now offline
> [38493.310275] smpboot: CPU 4 is now offline
> [38493.310725] IRQ 30: no longer affine to CPU5
> [38493.311730] smpboot: CPU 5 is now offline
> [38493.313123] smpboot: CPU 6 is now offline
> [38493.313534] IRQ 18: no longer affine to CPU7
> [38493.313539] IRQ 26: no longer affine to CPU7
> [38493.313546] IRQ 36: no longer affine to CPU7
> [38493.314556] smpboot: CPU 7 is now offline
> [38493.315290] ACPI: Low-level resume complete
> [38493.315327] ACPI: EC: EC started
> [38493.315327] PM: Restoring platform NVS memory
> [38493.315675] Enabling non-boot CPUs ...
> [38493.315711] x86: Booting SMP configuration:
> [38493.315711] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [38493.316442] CPU1 is up
> [38493.316467] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [38493.317137] CPU2 is up
> [38493.317157] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [38493.317811] CPU3 is up
> [38493.317830] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [38493.318507] CPU4 is up
> [38493.318527] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [38493.319208] CPU5 is up
> [38493.319229] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [38493.319925] CPU6 is up
> [38493.319944] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [38493.320627] CPU7 is up
> [38493.322902] ACPI: Waking up from system sleep state S3
> [38493.324813] pci 0000:00:16.0: Refused to change power state, currently in D3
> [38493.324835] ACPI: EC: interrupt unblocked
> [38493.363974] ACPI: EC: event unblocked
> [38493.364715] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [38493.374801] sd 0:0:0:0: [sda] Starting disk
> [38493.374812] sd 5:0:0:0: [sdb] Starting disk
> [38493.599190] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [38493.689621] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [38493.689766] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [38493.689802] ata2: SATA link down (SStatus 0 SControl 300)
> [38493.703214] ata1.00: configured for UDMA/133
> [38493.703362] ata6.00: configured for UDMA/133
> [38493.875347] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [38494.024645] OOM killer enabled.
> [38494.024646] Restarting tasks ... done.
> [38494.041967] Bluetooth: hci0: read Intel version: 370710018002030d00
> [38494.042002] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [38494.043354] video LNXVIDEO:00: Restoring backlight state
> [38494.235949] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [38494.238486] PM: suspend exit
> [38494.250967] Bluetooth: hci0: Intel firmware patch completed and activated
> [38494.299012] usb 2-9: new high-speed USB device number 29 using xhci_hcd
> [38494.448499] usb 2-9: New USB device found, idVendor=17ef, idProduct=1010, bcdDevice=50.30
> [38494.448501] usb 2-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [38494.448501] usb 2-9: Product: Lenovo ThinkPad Dock   
> [38494.448502] usb 2-9: Manufacturer: LENOVO                 
> [38494.449618] hub 2-9:1.0: USB hub found
> [38494.449733] hub 2-9:1.0: 4 ports detected
> [38494.575199] usb 3-5: new SuperSpeed Gen 1 USB device number 4 using xhci_hcd
> [38494.597126] usb 3-5: New USB device found, idVendor=17ef, idProduct=1010, bcdDevice=50.31
> [38494.597137] usb 3-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [38494.597138] usb 3-5: Product: Lenovo ThinkPad Dock   
> [38494.597139] usb 3-5: Manufacturer: LENOVO                 
> [38494.598924] hub 3-5:1.0: USB hub found
> [38494.599069] hub 3-5:1.0: 4 ports detected
> [38494.763008] usb 2-9.4: new high-speed USB device number 30 using xhci_hcd
> [38494.875583] usb 2-9.4: New USB device found, idVendor=17ef, idProduct=100f, bcdDevice= 0.01
> [38494.875584] usb 2-9.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [38494.875585] usb 2-9.4: Product: Lenovo ThinkPad Dock
> [38494.875586] usb 2-9.4: Manufacturer: Lenovo
> [38494.875587] usb 2-9.4: SerialNumber: Rev1.2
> [38494.876502] hub 2-9.4:1.0: USB hub found
> [38494.876518] hub 2-9.4:1.0: 3 ports detected
> [38495.167027] usb 2-9.4.1: new full-speed USB device number 31 using xhci_hcd
> [38495.272432] usb 2-9.4.1: New USB device found, idVendor=2034, idProduct=0105, bcdDevice= 1.00
> [38495.272434] usb 2-9.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [38495.272435] usb 2-9.4.1: Product: BWA19HO011
> [38495.272435] usb 2-9.4.1: Manufacturer: BlackWeb
> [38495.272436] usb 2-9.4.1: SerialNumber: IM10000011
> [38495.281217] input: BlackWeb BWA19HO011 as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.1/2-9.4.1:1.2/0003:2034:0105.000D/input/input43
> [38495.339296] hid-generic 0003:2034:0105.000D: input,hidraw0: USB HID v1.00 Device [BlackWeb BWA19HO011] on usb-0000:00:14.0-9.4.1/input2
> [38495.563092] usb 2-9.4.2: new high-speed USB device number 32 using xhci_hcd
> [38495.679398] usb 2-9.4.2: New USB device found, idVendor=413c, idProduct=1010, bcdDevice=32.98
> [38495.679400] usb 2-9.4.2: New USB device strings: Mfr=0, Product=11, SerialNumber=0
> [38495.679401] usb 2-9.4.2: Product: USB 2.0 Hub [MTT]
> [38495.681145] hub 2-9.4.2:1.0: USB hub found
> [38495.682792] hub 2-9.4.2:1.0: 4 ports detected
> [38495.763068] usb 2-9.4.3: new high-speed USB device number 33 using xhci_hcd
> [38495.868428] usb 2-9.4.3: New USB device found, idVendor=1004, idProduct=633e, bcdDevice= 3.18
> [38495.868429] usb 2-9.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [38495.868430] usb 2-9.4.3: Product: LM-X212(G)
> [38495.868431] usb 2-9.4.3: Manufacturer: LGE
> [38495.868432] usb 2-9.4.3: SerialNumber: LMX212Gc2e16edc
> [38495.971068] usb 2-9.4.2.2: new low-speed USB device number 34 using xhci_hcd
> [38496.074610] usb 2-9.4.2.2: New USB device found, idVendor=0461, idProduct=4d15, bcdDevice= 2.00
> [38496.074612] usb 2-9.4.2.2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [38496.074613] usb 2-9.4.2.2: Product: USB Optical Mouse
> [38496.077240] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [38496.079022] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [38496.080218] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.2/2-9.4.2.2:1.0/0003:0461:4D15.000E/input/input44
> [38496.080381] hid-generic 0003:0461:4D15.000E: input,hidraw1: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-9.4.2.2/input0
> [38496.088529] wlan0: authenticated
> [38496.091033] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [38496.117193] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [38496.125702] wlan0: associated
> [38496.167003] usb 2-9.4.2.4: new low-speed USB device number 35 using xhci_hcd
> [38496.220773] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [38496.279321] usb 2-9.4.2.4: New USB device found, idVendor=413c, idProduct=2110, bcdDevice= 0.06
> [38496.279323] usb 2-9.4.2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [38496.279325] usb 2-9.4.2.4: Product: Dell Wired Multimedia Keyboard
> [38496.279326] usb 2-9.4.2.4: Manufacturer: Dell
> [38496.302312] input: Dell Dell Wired Multimedia Keyboard as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.0/0003:413C:2110.000F/input/input45
> [38496.359355] hid-generic 0003:413C:2110.000F: input,hidraw2: USB HID v1.10 Keyboard [Dell Dell Wired Multimedia Keyboard] on usb-0000:00:14.0-9.4.2.4/input0
> [38496.373845] input: Dell Dell Wired Multimedia Keyboard Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0010/input/input46
> [38496.374021] input: Dell Dell Wired Multimedia Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0010/input/input47
> [38496.431104] input: Dell Dell Wired Multimedia Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0010/input/input48
> [38496.431209] hid-generic 0003:413C:2110.0010: input,hiddev96,hidraw3: USB HID v1.10 Mouse [Dell Dell Wired Multimedia Keyboard] on usb-0000:00:14.0-9.4.2.4/input1
> [38499.335441] e1000e 0000:00:19.0 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [38499.335498] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [65689.673818] usb 2-9.4.3: USB disconnect, device number 33
> [66328.871436] usb 2-9: USB disconnect, device number 29
> [66328.871438] usb 2-9.4: USB disconnect, device number 30
> [66328.871440] usb 2-9.4.1: USB disconnect, device number 31
> [66328.938778] usb 2-9.4.2: USB disconnect, device number 32
> [66328.938792] usb 2-9.4.2.2: USB disconnect, device number 34
> [66329.006224] usb 2-9.4.2.4: USB disconnect, device number 35
> [66329.049486] usb 3-5: USB disconnect, device number 4
> [66329.229652] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [66330.137134] [drm:intel_dp_start_link_train [i915]] *ERROR* failed to enable link training
> [66330.309494] [drm:intel_mst_pre_enable_dp [i915]] *ERROR* failed to allocate vcpi
> [66333.560156] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [66333.580021] PM: suspend entry (deep)
> [66333.697559] Filesystems sync: 0.117 seconds
> [66333.698306] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [66333.700912] OOM killer disabled.
> [66333.700913] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [66333.702402] printk: Suspending console(s) (use no_console_suspend to debug)
> [66333.784703] wlan0: deauthenticating from 8c:3b:ad:3f:c8:5d by local choice (Reason: 3=DEAUTH_LEAVING)
> [66333.913518] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [66333.913617] sd 0:0:0:0: [sda] Stopping disk
> [66333.917525] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [66333.917620] sd 5:0:0:0: [sdb] Stopping disk
> [66333.973763] e1000e: EEE TX LPI TIMER: 00000011
> [66334.261923] ACPI: EC: interrupt blocked
> [66334.301771] ACPI: Preparing to enter system sleep state S3
> [66334.303808] ACPI: EC: event blocked
> [66334.303809] ACPI: EC: EC stopped
> [66334.303809] PM: Saving platform NVS memory
> [66334.303810] Disabling non-boot CPUs ...
> [66334.304083] IRQ 28: no longer affine to CPU1
> [66334.305305] smpboot: CPU 1 is now offline
> [66334.306769] smpboot: CPU 2 is now offline
> [66334.307292] IRQ 23: no longer affine to CPU3
> [66334.307297] IRQ 31: no longer affine to CPU3
> [66334.308301] smpboot: CPU 3 is now offline
> [66334.309719] smpboot: CPU 4 is now offline
> [66334.310166] IRQ 30: no longer affine to CPU5
> [66334.311172] smpboot: CPU 5 is now offline
> [66334.312601] smpboot: CPU 6 is now offline
> [66334.313012] IRQ 18: no longer affine to CPU7
> [66334.313017] IRQ 26: no longer affine to CPU7
> [66334.313024] IRQ 36: no longer affine to CPU7
> [66334.314030] smpboot: CPU 7 is now offline
> [66334.314781] ACPI: Low-level resume complete
> [66334.314817] ACPI: EC: EC started
> [66334.314818] PM: Restoring platform NVS memory
> [66334.315172] Enabling non-boot CPUs ...
> [66334.315206] x86: Booting SMP configuration:
> [66334.315206] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [66334.316011] CPU1 is up
> [66334.316035] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [66334.316697] CPU2 is up
> [66334.316717] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [66334.317364] CPU3 is up
> [66334.317382] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [66334.318054] CPU4 is up
> [66334.318074] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [66334.318739] CPU5 is up
> [66334.318759] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [66334.319445] CPU6 is up
> [66334.319463] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [66334.320143] CPU7 is up
> [66334.322388] ACPI: Waking up from system sleep state S3
> [66334.324260] ACPI: EC: interrupt unblocked
> [66334.367379] ACPI: EC: event unblocked
> [66334.367822] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
> [66334.377609] sd 0:0:0:0: [sda] Starting disk
> [66334.377617] sd 5:0:0:0: [sdb] Starting disk
> [66334.606516] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [66334.693570] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [66334.693594] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [66334.693612] ata2: SATA link down (SStatus 0 SControl 300)
> [66334.707219] ata1.00: configured for UDMA/133
> [66334.707229] ata6.00: configured for UDMA/133
> [66334.882676] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [66335.505735] OOM killer enabled.
> [66335.505736] Restarting tasks ... done.
> [66335.518020] video LNXVIDEO:00: Restoring backlight state
> [66335.519345] Bluetooth: hci0: read Intel version: 370710018002030d00
> [66335.519350] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [66335.689016] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [66335.703359] PM: suspend exit
> [66335.705043] Bluetooth: hci0: Intel firmware patch completed and activated
> [66337.477416] wlan0: authenticate with 00:57:c1:f8:87:cb
> [66337.479309] wlan0: send auth to 00:57:c1:f8:87:cb (try 1/3)
> [66337.483549] wlan0: authenticated
> [66337.486306] wlan0: associate with 00:57:c1:f8:87:cb (try 1/3)
> [66337.501674] wlan0: RX AssocResp from 00:57:c1:f8:87:cb (capab=0x431 status=0 aid=1)
> [66337.513056] wlan0: associated
> [66337.525115] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [66451.356372] e1000e 0000:00:19.0 eth0: NIC Link is Down
> [66451.603851] PM: suspend entry (deep)
> [66457.645570] Filesystems sync: 6.041 seconds
> [66457.646079] Freezing user space processes ... (elapsed 0.538 seconds) done.
> [66458.184833] OOM killer disabled.
> [66458.184833] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [66458.185895] printk: Suspending console(s) (use no_console_suspend to debug)
> [66458.233921] wlan0: deauthenticating from 00:57:c1:f8:87:cb by local choice (Reason: 3=DEAUTH_LEAVING)
> [66458.341862] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [66458.341863] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [66458.341933] sd 0:0:0:0: [sda] Stopping disk
> [66458.354266] sd 5:0:0:0: [sdb] Stopping disk
> [66458.524342] e1000e: EEE TX LPI TIMER: 00000011
> [66458.706239] ACPI: EC: interrupt blocked
> [66458.746093] ACPI: Preparing to enter system sleep state S3
> [66458.748107] ACPI: EC: event blocked
> [66458.748107] ACPI: EC: EC stopped
> [66458.748108] PM: Saving platform NVS memory
> [66458.748108] Disabling non-boot CPUs ...
> [66458.748382] IRQ 28: no longer affine to CPU1
> [66458.749488] smpboot: CPU 1 is now offline
> [66458.750954] smpboot: CPU 2 is now offline
> [66458.751468] IRQ 23: no longer affine to CPU3
> [66458.751472] IRQ 31: no longer affine to CPU3
> [66458.752476] smpboot: CPU 3 is now offline
> [66458.753875] smpboot: CPU 4 is now offline
> [66458.754324] IRQ 30: no longer affine to CPU5
> [66458.755330] smpboot: CPU 5 is now offline
> [66458.756731] smpboot: CPU 6 is now offline
> [66458.757224] IRQ 18: no longer affine to CPU7
> [66458.757231] IRQ 26: no longer affine to CPU7
> [66458.757241] IRQ 36: no longer affine to CPU7
> [66458.758277] smpboot: CPU 7 is now offline
> [66458.759124] ACPI: Low-level resume complete
> [66458.759161] ACPI: EC: EC started
> [66458.759161] PM: Restoring platform NVS memory
> [66458.759519] Enabling non-boot CPUs ...
> [66458.759552] x86: Booting SMP configuration:
> [66458.759553] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [66458.760391] CPU1 is up
> [66458.760415] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [66458.761109] CPU2 is up
> [66458.761128] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [66458.761810] CPU3 is up
> [66458.761830] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [66458.762536] CPU4 is up
> [66458.762555] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [66458.763253] CPU5 is up
> [66458.763274] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [66458.763998] CPU6 is up
> [66458.764017] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [66458.764729] CPU7 is up
> [66458.766996] ACPI: Waking up from system sleep state S3
> [66458.768774] ACPI: EC: interrupt unblocked
> [66458.808740] ACPI: EC: event unblocked
> [66458.818920] sd 0:0:0:0: [sda] Starting disk
> [66458.818967] sd 5:0:0:0: [sdb] Starting disk
> [66459.042945] usb 2-11: reset full-speed USB device number 2 using xhci_hcd
> [66459.133343] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [66459.133398] ata2: SATA link down (SStatus 0 SControl 300)
> [66459.133448] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [66459.146912] ata6.00: configured for UDMA/133
> [66459.147050] ata1.00: configured for UDMA/133
> [66459.319033] usb 2-12: reset high-speed USB device number 3 using xhci_hcd
> [66459.525003] OOM killer enabled.
> [66459.525004] Restarting tasks ... done.
> [66459.530394] video LNXVIDEO:00: Restoring backlight state
> [66459.540454] Bluetooth: hci0: read Intel version: 370710018002030d00
> [66459.540488] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> [66459.545707] PM: suspend exit
> [66459.662443] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> [66459.677469] Bluetooth: hci0: Intel firmware patch completed and activated
> [66459.798923] usb 3-5: new SuperSpeed Gen 1 USB device number 5 using xhci_hcd
> [66459.820514] usb 3-5: New USB device found, idVendor=17ef, idProduct=1010, bcdDevice=50.31
> [66459.820516] usb 3-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [66459.820517] usb 3-5: Product: Lenovo ThinkPad Dock   
> [66459.820517] usb 3-5: Manufacturer: LENOVO                 
> [66459.822209] hub 3-5:1.0: USB hub found
> [66459.822333] hub 3-5:1.0: 4 ports detected
> [66459.946781] usb 2-9: new high-speed USB device number 36 using xhci_hcd
> [66459.995970] pci 0000:00:16.0: Refused to change power state, currently in D3
> [66460.099909] usb 2-9: New USB device found, idVendor=17ef, idProduct=1010, bcdDevice=50.30
> [66460.099910] usb 2-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [66460.099911] usb 2-9: Product: Lenovo ThinkPad Dock   
> [66460.099912] usb 2-9: Manufacturer: LENOVO                 
> [66460.100907] hub 2-9:1.0: USB hub found
> [66460.101015] hub 2-9:1.0: 4 ports detected
> [66460.406742] usb 2-9.4: new high-speed USB device number 37 using xhci_hcd
> [66460.522977] usb 2-9.4: New USB device found, idVendor=17ef, idProduct=100f, bcdDevice= 0.01
> [66460.522980] usb 2-9.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [66460.522981] usb 2-9.4: Product: Lenovo ThinkPad Dock
> [66460.522982] usb 2-9.4: Manufacturer: Lenovo
> [66460.522983] usb 2-9.4: SerialNumber: Rev1.2
> [66460.523905] hub 2-9.4:1.0: USB hub found
> [66460.523964] hub 2-9.4:1.0: 3 ports detected
> [66460.814723] usb 2-9.4.1: new full-speed USB device number 38 using xhci_hcd
> [66460.920509] usb 2-9.4.1: New USB device found, idVendor=2034, idProduct=0105, bcdDevice= 1.00
> [66460.920510] usb 2-9.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [66460.920511] usb 2-9.4.1: Product: BWA19HO011
> [66460.920511] usb 2-9.4.1: Manufacturer: BlackWeb
> [66460.920512] usb 2-9.4.1: SerialNumber: IM10000011
> [66460.929024] input: BlackWeb BWA19HO011 as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.1/2-9.4.1:1.2/0003:2034:0105.0011/input/input49
> [66460.986983] hid-generic 0003:2034:0105.0011: input,hidraw0: USB HID v1.00 Device [BlackWeb BWA19HO011] on usb-0000:00:14.0-9.4.1/input2
> [66461.218801] usb 2-9.4.2: new high-speed USB device number 39 using xhci_hcd
> [66461.334797] usb 2-9.4.2: New USB device found, idVendor=413c, idProduct=1010, bcdDevice=32.98
> [66461.334799] usb 2-9.4.2: New USB device strings: Mfr=0, Product=11, SerialNumber=0
> [66461.334800] usb 2-9.4.2: Product: USB 2.0 Hub [MTT]
> [66461.336510] hub 2-9.4.2:1.0: USB hub found
> [66461.338116] hub 2-9.4.2:1.0: 4 ports detected
> [66461.371130] wlan0: authenticate with 8c:3b:ad:3f:c8:5d
> [66461.372914] wlan0: send auth to 8c:3b:ad:3f:c8:5d (try 1/3)
> [66461.382143] wlan0: authenticated
> [66461.382722] wlan0: associate with 8c:3b:ad:3f:c8:5d (try 1/3)
> [66461.404651] wlan0: RX AssocResp from 8c:3b:ad:3f:c8:5d (capab=0x411 status=0 aid=1)
> [66461.405501] wlan0: associated
> [66461.511117] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [66461.626738] usb 2-9.4.2.2: new low-speed USB device number 40 using xhci_hcd
> [66461.730561] usb 2-9.4.2.2: New USB device found, idVendor=0461, idProduct=4d15, bcdDevice= 2.00
> [66461.730574] usb 2-9.4.2.2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [66461.730574] usb 2-9.4.2.2: Product: USB Optical Mouse
> [66461.736163] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.2/2-9.4.2.2:1.0/0003:0461:4D15.0012/input/input50
> [66461.736451] hid-generic 0003:0461:4D15.0012: input,hidraw1: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-9.4.2.2/input0
> [66461.818724] usb 2-9.4.2.4: new low-speed USB device number 41 using xhci_hcd
> [66461.926935] usb 2-9.4.2.4: New USB device found, idVendor=413c, idProduct=2110, bcdDevice= 0.06
> [66461.926938] usb 2-9.4.2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [66461.926939] usb 2-9.4.2.4: Product: Dell Wired Multimedia Keyboard
> [66461.926940] usb 2-9.4.2.4: Manufacturer: Dell
> [66461.941668] input: Dell Dell Wired Multimedia Keyboard as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.0/0003:413C:2110.0013/input/input51
> [66461.998984] hid-generic 0003:413C:2110.0013: input,hidraw2: USB HID v1.10 Keyboard [Dell Dell Wired Multimedia Keyboard] on usb-0000:00:14.0-9.4.2.4/input0
> [66462.009988] input: Dell Dell Wired Multimedia Keyboard Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0014/input/input52
> [66462.010123] input: Dell Dell Wired Multimedia Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0014/input/input53
> [66462.066882] input: Dell Dell Wired Multimedia Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb2/2-9/2-9.4/2-9.4.2/2-9.4.2.4/2-9.4.2.4:1.1/0003:413C:2110.0014/input/input54
> [66462.067021] hid-generic 0003:413C:2110.0014: input,hiddev96,hidraw3: USB HID v1.10 Mouse [Dell Dell Wired Multimedia Keyboard] on usb-0000:00:14.0-9.4.2.4/input1
> [66464.779165] e1000e 0000:00:19.0 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [66464.779203] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [66495.397067] show_signal_msg: 2 callbacks suppressed
> [66495.397071] kscreenlocker_g[17984]: segfault at 32000000031 ip 00007fc8ec350534 sp 00007fff4401a608 error 4 in libQt5Qml.so.5.15.2[7fc8ec0ab000+47e000]
> [66495.397091] Code: ee 48 89 c7 e8 4d 3a e1 ff 48 89 5d 08 f0 83 03 01 5b 5d 41 5c c3 48 8b 47 08 8b 40 34 c3 0f 1f 84 00 00 00 00 00 48 8b 47 08 <8b> 40 30 c3 0f 1f 84 00 00 00 00 00 48 83 ec 08 e8 17 2b e1 ff 85
> [66497.560631] kscreenlocker_g[18942]: segfault at 7fa35e2a472f ip 00007fa38e7784b0 sp 00007ffd34522ba0 error 4 in libQt5Core.so.5.15.2[7fa38e46e000+5ae000]
> [66497.560646] Code: 48 8b 7d a8 ff d0 0f 1f 40 00 b8 01 00 00 00 e9 f6 fe ff ff 66 0f 1f 44 00 00 49 8b 45 08 48 85 c0 74 0c 49 8b 45 08 8b 7d 98 <3b> 78 08 7c 2b 48 8d 7d b0 e8 f2 79 00 00 b8 01 00 00 00 31 d2 f0
> [66779.653208] usb 2-9.4.3: new high-speed USB device number 42 using xhci_hcd
> [66779.754248] usb 2-9.4.3: New USB device found, idVendor=1004, idProduct=633e, bcdDevice= 3.18
> [66779.754250] usb 2-9.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [66779.754251] usb 2-9.4.3: Product: LM-X212(G)
> [66779.754252] usb 2-9.4.3: Manufacturer: LGE
> [66779.754252] usb 2-9.4.3: SerialNumber: LMX212Gc2e16edc
> [69169.880852] usb 3-1: new SuperSpeed Gen 1 USB device number 6 using xhci_hcd
> [69169.901641] usb 3-1: New USB device found, idVendor=067b, idProduct=2773, bcdDevice= 1.00
> [69169.901643] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [69169.901643] usb 3-1: Product: USB-SATA Bridge
> [69169.901644] usb 3-1: Manufacturer: Prolific Technology Inc.
> [69169.901645] usb 3-1: SerialNumber: PROLIFICMP00000000B
> [69169.903885] usb 3-1: Set SEL for device-initiated U1 failed.
> [69169.903943] usb 3-1: Set SEL for device-initiated U2 failed.
> [69169.904037] usb-storage 3-1:1.0: USB Mass Storage device detected
> [69169.905904] scsi host6: usb-storage 3-1:1.0
> [69170.968371] scsi 6:0:0:0: Direct-Access     TOSHIBA  DT01ACA200       MX4O PQ: 0 ANSI: 0
> [69170.968590] scsi 6:0:0:1: Direct-Access     ST1000DM 003-1ER162       CC46 PQ: 0 ANSI: 0
> [69170.968887] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [69170.969009] sd 6:0:0:1: Attached scsi generic sg3 type 0
> [69170.969367] sd 6:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
> [69170.969582] sd 6:0:0:1: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
> [69170.969823] sd 6:0:0:1: [sdd] Write Protect is off
> [69170.969825] sd 6:0:0:1: [sdd] Mode Sense: 03 00 00 00
> [69170.970078] sd 6:0:0:0: [sdc] Write Protect is off
> [69170.970079] sd 6:0:0:0: [sdc] Mode Sense: 03 00 00 00
> [69170.970476] sd 6:0:0:1: [sdd] No Caching mode page found
> [69170.970478] sd 6:0:0:1: [sdd] Assuming drive cache: write through
> [69170.971726] sd 6:0:0:0: [sdc] No Caching mode page found
> [69170.971728] sd 6:0:0:0: [sdc] Assuming drive cache: write through
> [69171.040798] sd 6:0:0:0: [sdc] Attached SCSI disk
> [69171.041210] sd 6:0:0:1: [sdd] Attached SCSI disk
> [69181.028814] usb 3-1: USB disconnect, device number 6
> [69181.656831] usb 3-1: new SuperSpeed Gen 1 USB device number 7 using xhci_hcd
> [69181.677526] usb 3-1: New USB device found, idVendor=067b, idProduct=2773, bcdDevice= 1.00
> [69181.677528] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [69181.677537] usb 3-1: Product: USB-SATA Bridge
> [69181.677538] usb 3-1: Manufacturer: Prolific Technology Inc.
> [69181.677539] usb 3-1: SerialNumber: PROLIFICMP00000000B
> [69181.679798] usb 3-1: Set SEL for device-initiated U1 failed.
> [69181.679872] usb 3-1: Set SEL for device-initiated U2 failed.
> [69181.679930] usb-storage 3-1:1.0: USB Mass Storage device detected
> [69181.680220] scsi host6: usb-storage 3-1:1.0
> [69182.727569] scsi 6:0:0:0: Direct-Access     ST1000DM 003-1ER162       CC46 PQ: 0 ANSI: 0
> [69182.727820] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [69182.728049] sd 6:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
> [69182.728241] sd 6:0:0:0: [sdc] Write Protect is off
> [69182.728242] sd 6:0:0:0: [sdc] Mode Sense: 03 00 00 00
> [69182.728438] sd 6:0:0:0: [sdc] No Caching mode page found
> [69182.728439] sd 6:0:0:0: [sdc] Assuming drive cache: write through
> [69182.792020] sd 6:0:0:0: [sdc] Attached SCSI disk
> [69186.596751] usb 3-1: USB disconnect, device number 7
> [69193.052736] usb 3-1: new SuperSpeed Gen 1 USB device number 8 using xhci_hcd
> [69193.077583] usb 3-1: New USB device found, idVendor=067b, idProduct=2773, bcdDevice= 1.00
> [69193.077585] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [69193.077586] usb 3-1: Product: USB-SATA Bridge
> [69193.077586] usb 3-1: Manufacturer: Prolific Technology Inc.
> [69193.077587] usb 3-1: SerialNumber: PROLIFICMP00000000B
> [69193.079758] usb 3-1: Set SEL for device-initiated U1 failed.
> [69193.079830] usb 3-1: Set SEL for device-initiated U2 failed.
> [69193.079895] usb-storage 3-1:1.0: USB Mass Storage device detected
> [69193.080147] scsi host6: usb-storage 3-1:1.0
> [69194.142985] scsi 6:0:0:0: Direct-Access     TOSHIBA  DT01ACA200       MX4O PQ: 0 ANSI: 0
> [69194.143285] scsi 6:0:0:1: Direct-Access     ST1000DM 003-1ER162       CC46 PQ: 0 ANSI: 0
> [69194.143661] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [69194.143904] sd 6:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
> [69194.143987] sd 6:0:0:1: Attached scsi generic sg3 type 0
> [69194.144122] sd 6:0:0:0: [sdc] Write Protect is off
> [69194.144123] sd 6:0:0:0: [sdc] Mode Sense: 03 00 00 00
> [69194.144342] sd 6:0:0:1: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
> [69194.144531] sd 6:0:0:0: [sdc] No Caching mode page found
> [69194.144533] sd 6:0:0:0: [sdc] Assuming drive cache: write through
> [69194.145070] sd 6:0:0:1: [sdd] Write Protect is off
> [69194.145073] sd 6:0:0:1: [sdd] Mode Sense: 03 00 00 00
> [69194.145275] sd 6:0:0:1: [sdd] No Caching mode page found
> [69194.145277] sd 6:0:0:1: [sdd] Assuming drive cache: write through
> [69194.234065] sd 6:0:0:1: [sdd] Attached SCSI disk
> [69194.234254] sd 6:0:0:0: [sdc] Attached SCSI disk
> [69212.904670] usb 3-1: USB disconnect, device number 8
> [69213.524672] usb 3-1: new SuperSpeed Gen 1 USB device number 9 using xhci_hcd
> [69213.549385] usb 3-1: New USB device found, idVendor=067b, idProduct=2773, bcdDevice= 1.00
> [69213.549387] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [69213.549388] usb 3-1: Product: USB-SATA Bridge
> [69213.549388] usb 3-1: Manufacturer: Prolific Technology Inc.
> [69213.549389] usb 3-1: SerialNumber: PROLIFICMP00000000B
> [69213.551359] usb 3-1: Set SEL for device-initiated U1 failed.
> [69213.551436] usb 3-1: Set SEL for device-initiated U2 failed.
> [69213.551495] usb-storage 3-1:1.0: USB Mass Storage device detected
> [69213.551667] scsi host6: usb-storage 3-1:1.0
> [69214.599515] scsi 6:0:0:0: Direct-Access     ST1000DM 003-1ER162       CC46 PQ: 0 ANSI: 0
> [69214.599701] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [69214.599913] sd 6:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
> [69214.600109] sd 6:0:0:0: [sdc] Write Protect is off
> [69214.600111] sd 6:0:0:0: [sdc] Mode Sense: 03 00 00 00
> [69214.600298] sd 6:0:0:0: [sdc] No Caching mode page found
> [69214.600299] sd 6:0:0:0: [sdc] Assuming drive cache: write through
> [69214.671448] sd 6:0:0:0: [sdc] Attached SCSI disk
> [69243.744526] usb 3-1: USB disconnect, device number 9
> [69255.660483] usb 3-1: new SuperSpeed Gen 1 USB device number 10 using xhci_hcd
> [69255.681302] usb 3-1: New USB device found, idVendor=067b, idProduct=2773, bcdDevice= 1.00
> [69255.681303] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [69255.681304] usb 3-1: Product: USB-SATA Bridge
> [69255.681305] usb 3-1: Manufacturer: Prolific Technology Inc.
> [69255.681306] usb 3-1: SerialNumber: PROLIFICMP00000000B
> [69255.683506] usb 3-1: Set SEL for device-initiated U1 failed.
> [69255.683637] usb 3-1: Set SEL for device-initiated U2 failed.
> [69255.683694] usb-storage 3-1:1.0: USB Mass Storage device detected
> [69255.683775] scsi host6: usb-storage 3-1:1.0
> [69256.752770] scsi 6:0:0:0: Direct-Access     WDC WD10 EADS-00M2B0      01.0 PQ: 0 ANSI: 0
> [69256.753207] scsi 6:0:0:1: Direct-Access     ST1000DM 003-1ER162       CC46 PQ: 0 ANSI: 0
> [69256.753661] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [69256.753824] sd 6:0:0:1: Attached scsi generic sg3 type 0
> [69256.753909] sd 6:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
> [69256.754126] sd 6:0:0:1: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
> [69256.754322] sd 6:0:0:0: [sdc] Write Protect is off
> [69256.754324] sd 6:0:0:0: [sdc] Mode Sense: 03 00 00 00
> [69256.754523] sd 6:0:0:1: [sdd] Write Protect is off
> [69256.754525] sd 6:0:0:1: [sdd] Mode Sense: 03 00 00 00
> [69256.754722] sd 6:0:0:0: [sdc] No Caching mode page found
> [69256.754723] sd 6:0:0:0: [sdc] Assuming drive cache: write through
> [69256.754920] sd 6:0:0:1: [sdd] No Caching mode page found
> [69256.754921] sd 6:0:0:1: [sdd] Assuming drive cache: write through
> [69256.842839] sd 6:0:0:1: [sdd] Attached SCSI disk
> [69256.843387] sd 6:0:0:0: [sdc] Attached SCSI disk
> [69309.167922] BTRFS: device fsid 43aca663-0462-4b72-a474-d89ac3f8672a devid 1 transid 901 /dev/dm-2

