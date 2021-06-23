Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277F13B1341
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 07:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhFWFe7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 23 Jun 2021 01:34:59 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40808 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFWFe7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 01:34:59 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5B82BAB4973; Wed, 23 Jun 2021 01:32:41 -0400 (EDT)
Date:   Wed, 23 Jun 2021 01:32:41 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Asif Youssuff <yoasif@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or
 rebalance
Message-ID: <20210623053240.GJ11733@hungrycats.org>
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 19, 2021 at 01:16:50AM -0400, Asif Youssuff wrote:
> Hi Btrfs mailing list,
> 
> I'm running into a weird situation where my filesystem goes readonly soon
> after mount. Removing snapshots or files doesn't help, and the changes are
> not persisted after the filesystem goes readonly and is remounted.
> 
> I made the mistake of starting a large rebalance operation while using an
> expansive balance filter (I don't recall the figure, unfortunately), so I
> can't even add a new disk (given as a solution to disk full errors on
> various places on the web).
> 
> Mounting with skip_balance stops the balance operation, but doesn't *cancel*
> it, so adding a new disk isn't possible.

Do you have pending snapshots waiting to be deleted on this filesystem?
'btrfs sub list -d'

There was a regression between 5.0 and 5.4 where btrfs stopped committing
transactions as often during snapshot deletes compared to previous
kernels.  Snapshot deletes would then run the filesystem out of metadata
space in the first transaction after mount, leading to a situation where a
pending snapshot delete makes the filesystem read-only after every mount.
I don't know the root cause of this--it could be a reservation bug as
Qu suggests, or it could be something else, since I hit my bug on 5.4
which can't have raid1c4 metadata.

I recovered from that by booting kernel 4.19 to do the snapshot delete,
which uses older code that didn't have the new problem.  This will not
work on a filesystem that has raid1c4 on it, as raid1c4 requires kernel
5.5 and later.  (This is also why we aren't using raid1c3 or raid1c4 yet).

You might be able to recover by booting a kernel with a patch to delay
startup of the btrfs-cleaner thread, thereby preventing the snapshot
delete from restarting immediately and breaking the filesystem.  I haven't
tried it, but it was my plan B if reverting to 4.19 hadn't worked.

The basic problem is that the raid1->raid6 data conversion balance has
run without equalizing the unallocated space on all the drives, while
converting from a free-space-equalizing profile to a used-space-equalizing
profile.  This will usually distribute space very badly across the drives,
to the point where metadata allocation fails (it also wastes a lot of
space), and there isn't an existing btrfs tool to do this properly.

The general approach required is to run a loop of balance commands
on a few block groups at a time:

	btrfs balance start -dconvert=raid6,soft,devid=$N,limit=10 /media/camino/

where $N is the device with lowest unallocated space in 'btrfs fi usage
-T' output.  The limit stops the balance after converting 10 block groups,
at which point the next device with the lowest unallocated space must
be selected to maintain equal unallocated space.

> I'm pretty stuck here so any ideas on how to resolve would be great!
> 
> uname -a
> Linux butter-server 5.12.11-051211-generic #202106161201 SMP Wed Jun 16
> 12:32:38 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> 
> btrfs --version
> btrfs-progs v5.4.1
> 
> btrfs fi show
> Label: none  uuid: c8557a6e-4b51-44f1-ba8f-75fce8c7dfcd
>     Total devices 1 FS bytes used 5.38TiB
>     devid    1 size 5.46TiB used 5.46TiB path /dev/sdh1
> 
> Label: none  uuid: 48ed8a66-731d-499b-829e-dd07dd7260cc
>     Total devices 13 FS bytes used 50.79TiB
>     devid    4 size 5.46TiB used 5.46TiB path /dev/sdf
>     devid    5 size 7.28TiB used 7.28TiB path /dev/sdj
>     devid    7 size 12.73TiB used 12.73TiB path /dev/sdg
>     devid    9 size 5.46TiB used 5.46TiB path /dev/sdd
>     devid   10 size 7.28TiB used 7.28TiB path /dev/sdp
>     devid   11 size 7.28TiB used 7.28TiB path /dev/sdl
>     devid   12 size 5.46TiB used 5.46TiB path /dev/sdb
>     devid   14 size 7.28TiB used 7.28TiB path /dev/sda
>     devid   15 size 7.28TiB used 7.28TiB path /dev/sdn
>     devid   17 size 9.10TiB used 7.49TiB path /dev/sde
>     devid   18 size 7.28TiB used 7.28TiB path /dev/sdm
>     devid   20 size 7.28TiB used 7.28TiB path /dev/sdc
>     devid   21 size 7.28TiB used 6.42TiB path /dev/sdo
> 
> 
> sudo btrfs fi df /media/camino/
> Data, RAID1: total=37.59TiB, used=36.98TiB
> Data, RAID6: total=13.77TiB, used=13.75TiB
> System, RAID1C4: total=32.00MiB, used=12.97MiB
> Metadata, RAID1C4: total=66.00GiB, used=65.63GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> After mount, my .allocation looks like (this is rw):
> 
> grep -R . allocation/
> allocation/metadata/disk_used:281696862208
> allocation/metadata/bytes_pinned:17383424
> allocation/metadata/bytes_used:70424215552
> allocation/metadata/total_bytes_pinned:57327616
> allocation/metadata/disk_total:283467841536
> allocation/metadata/total_bytes:70866960384
> allocation/metadata/bytes_reserved:24412160
> allocation/metadata/bytes_readonly:0
> allocation/metadata/raid1c4/used_bytes:70424215552
> allocation/metadata/raid1c4/total_bytes:70866960384
> allocation/metadata/bytes_zone_unusable:0
> allocation/metadata/bytes_may_use:842219520
> allocation/metadata/flags:4
> allocation/system/disk_used:54525952
> allocation/system/bytes_pinned:0
> allocation/system/bytes_used:13631488
> allocation/system/total_bytes_pinned:114688
> allocation/system/disk_total:134217728
> allocation/system/total_bytes:33554432
> allocation/system/bytes_reserved:81920
> allocation/system/bytes_readonly:0
> allocation/system/raid1c4/used_bytes:13631488
> allocation/system/raid1c4/total_bytes:33554432
> allocation/system/bytes_zone_unusable:0
> allocation/system/bytes_may_use:0
> allocation/system/flags:2
> allocation/global_rsv_reserved:535183360
> allocation/data/raid1/used_bytes:40658677952512
> allocation/data/raid1/total_bytes:41329991548928
> allocation/data/disk_used:96436269289472
> allocation/data/bytes_pinned:65359872
> allocation/data/raid6/used_bytes:15118913384448
> allocation/data/raid6/total_bytes:15141606326272
> allocation/data/bytes_used:55777591259136
> allocation/data/total_bytes_pinned:4347092992
> allocation/data/disk_total:97801589424128
> allocation/data/total_bytes:56471597875200
> allocation/data/bytes_reserved:0
> allocation/data/bytes_readonly:2555904
> allocation/data/bytes_zone_unusable:0
> allocation/data/bytes_may_use:0
> allocation/data/flags:1
> allocation/global_rsv_size:536870912
> 
> After the disk goes readonly, my .allocation looks like:
> 
> grep -R . allocation/
> allocation/metadata/disk_used:281865486336
> allocation/metadata/bytes_pinned:0
> allocation/metadata/bytes_used:70466371584
> allocation/metadata/total_bytes_pinned:0
> allocation/metadata/disk_total:283467841536
> allocation/metadata/total_bytes:70866960384
> allocation/metadata/bytes_reserved:0
> allocation/metadata/bytes_readonly:0
> allocation/metadata/raid1c4/used_bytes:70466371584
> allocation/metadata/raid1c4/total_bytes:70866960384
> allocation/metadata/bytes_zone_unusable:0
> allocation/metadata/bytes_may_use:536870912
> allocation/metadata/flags:4
> allocation/system/disk_used:54394880
> allocation/system/bytes_pinned:0
> allocation/system/bytes_used:13598720
> allocation/system/total_bytes_pinned:0
> allocation/system/disk_total:134217728
> allocation/system/total_bytes:33554432
> allocation/system/bytes_reserved:0
> allocation/system/bytes_readonly:0
> allocation/system/raid1c4/used_bytes:13598720
> allocation/system/raid1c4/total_bytes:33554432
> allocation/system/bytes_zone_unusable:0
> allocation/system/bytes_may_use:0
> allocation/system/flags:2
> allocation/global_rsv_reserved:536870912
> allocation/data/raid1/used_bytes:40658677952512
> allocation/data/raid1/total_bytes:41329991548928
> allocation/data/disk_used:96434427817984
> allocation/data/bytes_pinned:0
> allocation/data/raid6/used_bytes:15117071912960
> allocation/data/raid6/total_bytes:15141606326272
> allocation/data/bytes_used:55775749865472
> allocation/data/total_bytes_pinned:0
> allocation/data/disk_total:97801589424128
> allocation/data/total_bytes:56471597875200
> allocation/data/bytes_reserved:0
> allocation/data/bytes_readonly:2555904
> allocation/data/bytes_zone_unusable:0
> allocation/data/bytes_may_use:0
> allocation/data/flags:1
> allocation/global_rsv_size:536870912
> 
> 
> dmesg error (full dmesg attached):
> 
> [ 1043.994674] ------------[ cut here ]------------
> [ 1043.994676] BTRFS: Transaction aborted (error -28)
> [ 1043.994739] WARNING: CPU: 7 PID: 11673 at fs/btrfs/block-group.c:2721
> btrfs_start_dirty_block_groups+0x48c/0x4f0 [btrfs]
> [ 1043.994912] Modules linked in: xt_mark xt_nat veth nf_conntrack_netlink
> nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM
> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp
> llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
> bpfilter ppdev parport_pc parport vmw_vsock_vmci_transport vsock vmw_vmci
> overlay bluetooth ecdh_generic ecc msr binfmt_misc joydev input_leds
> ipmi_ssif dm_crypt intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm rapl intel_cstate intel_pch_thermal
> lpc_ich mei_me mei ie31200_edac acpi_ipmi ipmi_si ipmi_devintf
> ipmi_msghandler mac_hid acpi_pad sch_fq_codel ib_iser rdma_cm iw_cm ib_cm
> ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables
> x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1
> [ 1043.995121]  raid0 multipath linear dm_mirror dm_region_hash dm_log
> hid_generic usbhid hid uas usb_storage ast drm_vram_helper drm_ttm_helper
> ttm crct10dif_pclmul drm_kms_helper crc32_pclmul ghash_clmulni_intel
> aesni_intel syscopyarea sysfillrect sysimgblt fb_sys_fops crypto_simd ahci
> cec cryptd rc_core libahci mpt3sas igb drm dca xhci_pci raid_class e1000e
> i2c_algo_bit scsi_transport_sas xhci_pci_renesas video
> [ 1043.995272] CPU: 7 PID: 11673 Comm: snapperd Not tainted
> 5.12.11-051211-generic #202106161201
> [ 1043.995282] Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 3.0
> 04/24/2015
> [ 1043.995289] RIP: 0010:btrfs_start_dirty_block_groups+0x48c/0x4f0 [btrfs]
> [ 1043.995459] Code: 8b 53 50 f0 48 0f ba aa 48 0a 00 00 03 72 20 83 f8 fb
> 74 46 83 f8 e2 74 41 89 c6 48 c7 c7 e0 1a 85 c0 89 45 8c e8 57 99 9c e9 <0f>
> 0b 8b 45 8c 89 c1 ba a1 0a 00 00 48 89 df 89 45 8c 48 c7 c6 00
> [ 1043.995466] RSP: 0018:ffffb8ba424c3bf8 EFLAGS: 00010282
> [ 1043.995474] RAX: 0000000000000000 RBX: ffff89af68c460d0 RCX:
> ffff89b57fdd85c8
> [ 1043.995478] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI:
> ffff89b57fdd85c0
> [ 1043.995482] RBP: ffffb8ba424c3c70 R08: 0000000000000000 R09:
> ffffb8ba424c39d8
> [ 1043.995489] R10: ffffb8ba424c39d0 R11: ffffffffab5542e8 R12:
> ffff89af9b305000
> [ 1043.995493] R13: ffff89af9b305170 R14: ffff89af06973000 R15:
> ffff89af9b305160
> [ 1043.995498] FS:  00007f5f18556700(0000) GS:ffff89b57fdc0000(0000)
> knlGS:0000000000000000
> [ 1043.995503] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1043.995507] CR2: 00007fdb1af228a0 CR3: 000000027477a002 CR4:
> 00000000001706e0
> [ 1043.995513] Call Trace:
> [ 1043.995521]  btrfs_commit_transaction+0x7ff/0xa20 [btrfs]
> [ 1043.995640]  ? start_transaction+0xd5/0x590 [btrfs]
> [ 1043.995751]  create_snapshot+0x1bb/0x270 [btrfs]
> [ 1043.995894]  btrfs_mksubvol+0x112/0x1f0 [btrfs]
> [ 1043.996037]  btrfs_mksnapshot+0x80/0xb0 [btrfs]
> [ 1043.996178]  __btrfs_ioctl_snap_create+0x176/0x180 [btrfs]
> [ 1043.996320]  btrfs_ioctl_snap_create_v2+0xc0/0x150 [btrfs]
> [ 1043.996462]  btrfs_ioctl+0x93c/0x970 [btrfs]
> [ 1043.996603]  ? __cond_resched+0x1a/0x50
> [ 1043.996614]  __x64_sys_ioctl+0x91/0xc0
> [ 1043.996623]  do_syscall_64+0x38/0x90
> [ 1043.996630]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1043.996640] RIP: 0033:0x7f5f1db09317
> [ 1043.996647] Code: b3 66 90 48 8b 05 71 4b 2d 00 64 c7 00 26 00 00 00 48
> c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48>
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4b 2d 00 f7 d8 64 89 01 48
> [ 1043.996653] RSP: 002b:00007f5f185532c8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [ 1043.996660] RAX: ffffffffffffffda RBX: 00007f5f185532d0 RCX:
> 00007f5f1db09317
> [ 1043.996664] RDX: 00007f5f185532d0 RSI: 0000000050009417 RDI:
> 0000000000000007
> [ 1043.996668] RBP: 0000000000000006 R08: 000000000000000f R09:
> 00007f5f18554f84
> [ 1043.996671] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000007
> [ 1043.996675] R13: 00007f5f18555450 R14: 0000000000000000 R15:
> 0000000000000001
> [ 1043.996683] ---[ end trace 84d7b5fe58817f91 ]---
> [ 1043.996689] BTRFS: error (device sdf) in
> btrfs_start_dirty_block_groups:2721: errno=-28 No space left
> [ 1044.014701] BTRFS error (device sdf): allocation failed flags 1028,
> wanted 16384 tree-log 0
> [ 1044.014835] BTRFS: error (device sdf) in __btrfs_free_extent:3216:
> errno=-28 No space left
> [ 1044.014918] BTRFS: error (device sdf) in btrfs_run_delayed_refs:2163:
> errno=-28 No space left
> 
> 
> Thanks for the help!
> Asif

> [    0.000000] microcode: microcode updated early to revision 0x28, date = 2019-11-12
> [    0.000000] Linux version 5.12.11-051211-generic (kernel@gloin) (gcc (Ubuntu 10.3.0-4ubuntu1) 10.3.0, GNU ld (GNU Binutils for Ubuntu) 2.36.50.20210603) #202106161201 SMP Wed Jun 16 12:32:38 UTC 2021
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.12.11-051211-generic root=/dev/mapper/ubuntu--server--vg-root ro quiet splash vt.handoff=1
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Hygon HygonGenuine
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   zhaoxin   Shanghai  
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cd39efff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000cd39f000-0x00000000cd3a5fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000cd3a6000-0x00000000dd6d7fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000dd6d8000-0x00000000dd7befff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000dd7bf000-0x00000000dd80afff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000dd80b000-0x00000000dd941fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000dd942000-0x00000000df7fefff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000df7ff000-0x00000000df7fffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000081fffffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.7 present.
> [    0.000000] DMI: Supermicro X10SLM-F/X10SLM-F, BIOS 3.0 04/24/2015
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 3399.822 MHz processor
> [    0.000474] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000477] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000482] last_pfn = 0x820000 max_arch_pfn = 0x400000000
> [    0.000580] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.001186] total RAM covered: 32768M
> [    0.001512] Found optimal setting for mtrr clean up
> [    0.001513]  gran_size: 64K 	chunk_size: 64K 	num_reg: 7  	lose cover RAM: 0G
> [    0.001808] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
> [    0.001813] last_pfn = 0xdf800 max_arch_pfn = 0x400000000
> [    0.008064] found SMP MP-table at [mem 0x000fd710-0x000fd71f]
> [    0.022549] check: Scanning 1 areas for low memory corruption
> [    0.022560] Using GB pages for direct mapping
> [    0.022947] RAMDISK: [mem 0x2f117000-0x33882fff]
> [    0.022951] ACPI: Early table checksum verification disabled
> [    0.022954] ACPI: RSDP 0x00000000000F0490 000024 (v02 SUPERM)
> [    0.022958] ACPI: XSDT 0x00000000DD9130A0 0000C4 (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> [    0.022963] ACPI: FACP 0x00000000DD9229A0 00010C (v05 SUPERM SMCI--MB 01072009 AMI  00010013)
> [    0.022968] ACPI: DSDT 0x00000000DD913200 00F799 (v02 SUPERM SMCI--MB 00000000 INTL 20120711)
> [    0.022971] ACPI: FACS 0x00000000DD941F80 000040
> [    0.022973] ACPI: APIC 0x00000000DD922AB0 000092 (v03 SUPERM SMCI--MB 01072009 AMI  00010013)
> [    0.022975] ACPI: FPDT 0x00000000DD922B48 000044 (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> [    0.022978] ACPI: FIDT 0x00000000DD922B90 00009C (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> [    0.022980] ACPI: SSDT 0x00000000DD922C30 000C7D (v02 Ther_R Ther_Rvp 00001000 INTL 20120711)
> [    0.022983] ACPI: SSDT 0x00000000DD9238B0 000540 (v02 PmRef  Cpu0Ist  00003000 INTL 20051117)
> [    0.022986] ACPI: SSDT 0x00000000DD923DF0 000B74 (v02 CpuRef CpuSsdt  00003000 INTL 20051117)
> [    0.022988] ACPI: SSDT 0x00000000DD924968 0002F2 (v02 PmRef  Cpu0Tst  00003000 INTL 20051117)
> [    0.022991] ACPI: SSDT 0x00000000DD924C60 000348 (v02 PmRef  ApTst    00003000 INTL 20051117)
> [    0.022994] ACPI: MCFG 0x00000000DD924FA8 00003C (v01 SUPERM SMCI--MB 01072009 MSFT 00000097)
> [    0.022997] ACPI: PRAD 0x00000000DD924FE8 0000CE (v02 PRADID PRADTID  00000001 MSFT 03000001)
> [    0.022999] ACPI: HPET 0x00000000DD9250B8 000038 (v01 SUPERM SMCI--MB 01072009 AMI. 00000005)
> [    0.023002] ACPI: SSDT 0x00000000DD9250F0 000397 (v01 SataRe SataTabl 00001000 INTL 20120711)
> [    0.023004] ACPI: SSDT 0x00000000DD925488 0057F6 (v02 SaSsdt SaSsdt   00003000 INTL 20120711)
> [    0.023007] ACPI: SPMI 0x00000000DD92AC80 000040 (v05 A M I  OEMSPMI  00000000 AMI. 00000000)
> [    0.023010] ACPI: DMAR 0x00000000DD92ACC0 000080 (v01 INTEL  BDW      00000001 INTL 00000001)
> [    0.023012] ACPI: EINJ 0x00000000DD92AD40 000130 (v01 AMI    AMI EINJ 00000000      00000000)
> [    0.023015] ACPI: ERST 0x00000000DD92AE70 000230 (v01 AMIER  AMI ERST 00000000      00000000)
> [    0.023018] ACPI: HEST 0x00000000DD92B0A0 0000A8 (v01 AMI    AMI HEST 00000000      00000000)
> [    0.023020] ACPI: BERT 0x00000000DD92B148 000030 (v01 AMI    AMI BERT 00000000      00000000)
> [    0.023022] ACPI: Reserving FACP table memory at [mem 0xdd9229a0-0xdd922aab]
> [    0.023023] ACPI: Reserving DSDT table memory at [mem 0xdd913200-0xdd922998]
> [    0.023024] ACPI: Reserving FACS table memory at [mem 0xdd941f80-0xdd941fbf]
> [    0.023025] ACPI: Reserving APIC table memory at [mem 0xdd922ab0-0xdd922b41]
> [    0.023026] ACPI: Reserving FPDT table memory at [mem 0xdd922b48-0xdd922b8b]
> [    0.023027] ACPI: Reserving FIDT table memory at [mem 0xdd922b90-0xdd922c2b]
> [    0.023027] ACPI: Reserving SSDT table memory at [mem 0xdd922c30-0xdd9238ac]
> [    0.023028] ACPI: Reserving SSDT table memory at [mem 0xdd9238b0-0xdd923def]
> [    0.023029] ACPI: Reserving SSDT table memory at [mem 0xdd923df0-0xdd924963]
> [    0.023030] ACPI: Reserving SSDT table memory at [mem 0xdd924968-0xdd924c59]
> [    0.023031] ACPI: Reserving SSDT table memory at [mem 0xdd924c60-0xdd924fa7]
> [    0.023032] ACPI: Reserving MCFG table memory at [mem 0xdd924fa8-0xdd924fe3]
> [    0.023032] ACPI: Reserving PRAD table memory at [mem 0xdd924fe8-0xdd9250b5]
> [    0.023033] ACPI: Reserving HPET table memory at [mem 0xdd9250b8-0xdd9250ef]
> [    0.023034] ACPI: Reserving SSDT table memory at [mem 0xdd9250f0-0xdd925486]
> [    0.023035] ACPI: Reserving SSDT table memory at [mem 0xdd925488-0xdd92ac7d]
> [    0.023036] ACPI: Reserving SPMI table memory at [mem 0xdd92ac80-0xdd92acbf]
> [    0.023037] ACPI: Reserving DMAR table memory at [mem 0xdd92acc0-0xdd92ad3f]
> [    0.023037] ACPI: Reserving EINJ table memory at [mem 0xdd92ad40-0xdd92ae6f]
> [    0.023038] ACPI: Reserving ERST table memory at [mem 0xdd92ae70-0xdd92b09f]
> [    0.023039] ACPI: Reserving HEST table memory at [mem 0xdd92b0a0-0xdd92b147]
> [    0.023040] ACPI: Reserving BERT table memory at [mem 0xdd92b148-0xdd92b177]
> [    0.023053] ACPI: Local APIC address 0xfee00000
> [    0.023100] No NUMA configuration found
> [    0.023101] Faking a node at [mem 0x0000000000000000-0x000000081fffffff]
> [    0.023110] NODE_DATA(0) allocated [mem 0x81ffd6000-0x81fffffff]
> [    0.023366] Zone ranges:
> [    0.023367]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.023368]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.023370]   Normal   [mem 0x0000000100000000-0x000000081fffffff]
> [    0.023371]   Device   empty
> [    0.023372] Movable zone start for each node
> [    0.023375] Early memory node ranges
> [    0.023375]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
> [    0.023377]   node   0: [mem 0x0000000000100000-0x00000000cd39efff]
> [    0.023378]   node   0: [mem 0x00000000cd3a6000-0x00000000dd6d7fff]
> [    0.023379]   node   0: [mem 0x00000000dd7bf000-0x00000000dd80afff]
> [    0.023379]   node   0: [mem 0x00000000df7ff000-0x00000000df7fffff]
> [    0.023380]   node   0: [mem 0x0000000100000000-0x000000081fffffff]
> [    0.023383] Initmem setup node 0 [mem 0x0000000000001000-0x000000081fffffff]
> [    0.023384] On node 0 totalpages: 8378042
> [    0.023386]   DMA zone: 64 pages used for memmap
> [    0.023386]   DMA zone: 21 pages reserved
> [    0.023387]   DMA zone: 3996 pages, LIFO batch:0
> [    0.023606]   DMA zone: 28772 pages in unavailable ranges
> [    0.023607]   DMA32 zone: 14109 pages used for memmap
> [    0.023608]   DMA32 zone: 902942 pages, LIFO batch:63
> [    0.030556]   DMA32 zone: 10466 pages in unavailable ranges
> [    0.030559]   Normal zone: 116736 pages used for memmap
> [    0.030560]   Normal zone: 7471104 pages, LIFO batch:63
> [    0.088019] ACPI: PM-Timer IO Port: 0x1808
> [    0.088023] ACPI: Local APIC address 0xfee00000
> [    0.088029] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    0.088044] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
> [    0.088046] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.088048] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.088050] ACPI: IRQ0 used by override.
> [    0.088051] ACPI: IRQ9 used by override.
> [    0.088052] Using ACPI (MADT) for SMP configuration information
> [    0.088053] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.088057] TSC deadline timer available
> [    0.088058] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> [    0.088073] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.088074] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
> [    0.088075] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
> [    0.088076] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
> [    0.088077] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
> [    0.088078] PM: hibernation: Registered nosave memory: [mem 0xcd39f000-0xcd3a5fff]
> [    0.088080] PM: hibernation: Registered nosave memory: [mem 0xdd6d8000-0xdd7befff]
> [    0.088081] PM: hibernation: Registered nosave memory: [mem 0xdd80b000-0xdd941fff]
> [    0.088082] PM: hibernation: Registered nosave memory: [mem 0xdd942000-0xdf7fefff]
> [    0.088083] PM: hibernation: Registered nosave memory: [mem 0xdf800000-0xf7ffffff]
> [    0.088084] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
> [    0.088084] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
> [    0.088085] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.088086] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
> [    0.088087] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
> [    0.088087] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
> [    0.088088] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
> [    0.088089] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
> [    0.088089] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.088090] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
> [    0.088090] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
> [    0.088092] [mem 0xdf800000-0xf7ffffff] available for PCI devices
> [    0.088093] Booting paravirtualized kernel on bare hardware
> [    0.088095] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.088101] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
> [    0.088271] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
> [    0.088276] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
> [    0.088279] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
> [    0.088302] Built 1 zonelists, mobility grouping on.  Total pages: 8247112
> [    0.088303] Policy zone: Normal
> [    0.088305] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.12.11-051211-generic root=/dev/mapper/ubuntu--server--vg-root ro quiet splash vt.handoff=1
> [    0.089699] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
> [    0.090368] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.090437] mem auto-init: stack:off, heap alloc:on, heap free:off
> [    0.164912] Memory: 32753968K/33512168K available (16393K kernel code, 3497K rwdata, 10528K rodata, 2684K init, 5956K bss, 757940K reserved, 0K cma-reserved)
> [    0.164918] random: get_random_u64 called from kmem_cache_open+0x23/0x230 with crng_init=0
> [    0.165022] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> [    0.165032] Kernel/User page tables isolation: enabled
> [    0.165049] ftrace: allocating 51424 entries in 201 pages
> [    0.179721] ftrace: allocated 201 pages with 4 groups
> [    0.179813] rcu: Hierarchical RCU implementation.
> [    0.179814] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
> [    0.179815] 	Rude variant of Tasks RCU enabled.
> [    0.179816] 	Tracing variant of Tasks RCU enabled.
> [    0.179816] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.179817] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> [    0.182691] NR_IRQS: 524544, nr_irqs: 488, preallocated irqs: 16
> [    0.182957] random: crng done (trusting CPU's manufacturer)
> [    0.182979] spurious 8259A interrupt: IRQ7.
> [    0.182992] Console: colour dummy device 80x25
> [    0.183005] printk: console [tty0] enabled
> [    0.183019] ACPI: Core revision 20210105
> [    0.183133] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> [    0.183147] APIC: Switch to symmetric I/O mode setup
> [    0.183149] DMAR: Host address width 39
> [    0.183150] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
> [    0.183153] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap d2008c20660462 ecap f010da
> [    0.183155] DMAR: RMRR base: 0x000000df695000 end: 0x000000df6a3fff
> [    0.183157] DMAR-IR: IOAPIC id 8 under DRHD base  0xfed90000 IOMMU 0
> [    0.183158] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
> [    0.183159] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
> [    0.183160] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
> [    0.183389] DMAR-IR: Enabled IRQ remapping in xapic mode
> [    0.183390] x2apic: IRQ remapping doesn't support X2APIC mode
> [    0.183814] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.203153] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3101a67719e, max_idle_ns: 440795335946 ns
> [    0.203158] Calibrating delay loop (skipped), value calculated using timer frequency.. 6799.64 BogoMIPS (lpj=13599288)
> [    0.203160] pid_max: default: 32768 minimum: 301
> [    0.203181] LSM: Security Framework initializing
> [    0.203187] Yama: becoming mindful.
> [    0.203206] AppArmor: AppArmor initialized
> [    0.203278] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.203328] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.203520] CPU0: Thermal monitoring enabled (TM1)
> [    0.203549] process: using mwait in idle threads
> [    0.203551] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
> [    0.203552] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
> [    0.203554] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.203556] Spectre V2 : Mitigation: Full generic retpoline
> [    0.203557] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.203557] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [    0.203558] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.203559] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
> [    0.203560] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    0.203562] SRBDS: Mitigation: Microcode
> [    0.203563] MDS: Mitigation: Clear CPU buffers
> [    0.203731] Freeing SMP alternatives memory: 40K
> [    0.205825] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1084
> [    0.205836] smpboot: CPU0: Intel(R) Xeon(R) CPU E3-1231 v3 @ 3.40GHz (family: 0x6, model: 0x3c, stepping: 0x3)
> [    0.205943] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
> [    0.205963] ... version:                3
> [    0.205964] ... bit width:              48
> [    0.205965] ... generic registers:      4
> [    0.205965] ... value mask:             0000ffffffffffff
> [    0.205966] ... max period:             00007fffffffffff
> [    0.205967] ... fixed-purpose events:   3
> [    0.205967] ... event mask:             000000070000000f
> [    0.206050] rcu: Hierarchical SRCU implementation.
> [    0.206714] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.206772] smp: Bringing up secondary CPUs ...
> [    0.206839] x86: Booting SMP configuration:
> [    0.206840] .... node  #0, CPUs:      #1 #2 #3 #4
> [    0.208771] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> [    0.208771]  #5 #6 #7
> [    0.211605] smp: Brought up 1 node, 8 CPUs
> [    0.211605] smpboot: Max logical packages: 1
> [    0.211605] smpboot: Total of 8 processors activated (54397.15 BogoMIPS)
> [    0.216013] devtmpfs: initialized
> [    0.216013] x86/mm: Memory block size: 128MB
> [    0.216766] PM: Registering ACPI NVS region [mem 0xcd39f000-0xcd3a5fff] (28672 bytes)
> [    0.216766] PM: Registering ACPI NVS region [mem 0xdd80b000-0xdd941fff] (1273856 bytes)
> [    0.216766] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.216766] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
> [    0.216766] pinctrl core: initialized pinctrl subsystem
> [    0.216766] PM: RTC time: 09:42:36, date: 2021-06-18
> [    0.216766] NET: Registered protocol family 16
> [    0.216766] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
> [    0.216766] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.216766] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.216766] audit: initializing netlink subsys (disabled)
> [    0.216766] audit: type=2000 audit(1624009356.032:1): state=initialized audit_enabled=0 res=1
> [    0.216766] thermal_sys: Registered thermal governor 'fair_share'
> [    0.216766] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.216766] thermal_sys: Registered thermal governor 'step_wise'
> [    0.216766] thermal_sys: Registered thermal governor 'user_space'
> [    0.216766] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.216766] EISA bus registered
> [    0.216766] cpuidle: using governor ladder
> [    0.216766] cpuidle: using governor menu
> [    0.216766] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.216766] ACPI: bus type PCI registered
> [    0.216766] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.216766] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
> [    0.216766] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
> [    0.216766] PCI: Using configuration type 1 for base access
> [    0.216766] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
> [    0.219340] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.220089] Kprobes globally optimized
> [    0.220093] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.220093] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.220093] ACPI: Added _OSI(Module Device)
> [    0.220093] ACPI: Added _OSI(Processor Device)
> [    0.220093] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.220093] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.220093] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.220093] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.220093] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.235624] ACPI: 8 ACPI AML tables successfully acquired and loaded
> [    0.240306] ACPI: Dynamic OEM Table Load:
> [    0.241326] ACPI: Dynamic OEM Table Load:
> [    0.241332] ACPI: SSDT 0xFFFF89AE8159A000 0003D3 (v02 PmRef  Cpu0Cst  00003001 INTL 20051117)
> [    0.242177] ACPI: Dynamic OEM Table Load:
> [    0.242182] ACPI: SSDT 0xFFFF89AE80FC4800 0005AA (v02 PmRef  ApIst    00003000 INTL 20051117)
> [    0.243088] ACPI: Dynamic OEM Table Load:
> [    0.243092] ACPI: SSDT 0xFFFF89AE81550800 000119 (v02 PmRef  ApCst    00003000 INTL 20051117)
> [    0.245490] ACPI: Interpreter enabled
> [    0.245517] ACPI: (supports S0 S4 S5)
> [    0.245518] ACPI: Using IOAPIC for interrupt routing
> [    0.245572] HEST: Table parsing has been initialized.
> [    0.245574] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.245860] ACPI: Enabled 9 GPEs in block 00 to 3F
> [    0.247498] ACPI: PM: Power Resource [PG00] (on)
> [    0.247819] ACPI: PM: Power Resource [PG01] (on)
> [    0.248126] ACPI: PM: Power Resource [PG02] (on)
> [    0.256144] ACPI: PM: Power Resource [FN00] (off)
> [    0.256217] ACPI: PM: Power Resource [FN01] (off)
> [    0.256287] ACPI: PM: Power Resource [FN02] (off)
> [    0.256358] ACPI: PM: Power Resource [FN03] (off)
> [    0.256428] ACPI: PM: Power Resource [FN04] (off)
> [    0.257179] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
> [    0.257185] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.257480] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME]
> [    0.257659] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
> [    0.257660] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    0.258359] PCI host bridge to bus 0000:00
> [    0.258360] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.258362] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.258363] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.258364] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
> [    0.258365] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
> [    0.258366] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
> [    0.258367] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
> [    0.258368] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
> [    0.258369] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
> [    0.258370] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> [    0.258371] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> [    0.258372] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfeafffff window]
> [    0.258373] pci_bus 0000:00: root bus resource [bus 00-3e]
> [    0.258384] pci 0000:00:00.0: [8086:0c08] type 00 class 0x060000
> [    0.258463] pci 0000:00:01.0: [8086:0c01] type 01 class 0x060400
> [    0.258494] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> [    0.258614] pci 0000:00:01.1: [8086:0c05] type 01 class 0x060400
> [    0.258646] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
> [    0.258782] pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
> [    0.258797] pci 0000:00:14.0: reg 0x10: [mem 0xf7320000-0xf732ffff 64bit]
> [    0.258859] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.258943] pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
> [    0.258958] pci 0000:00:16.0: reg 0x10: [mem 0xf7338000-0xf733800f 64bit]
> [    0.259175] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> [    0.259280] pci 0000:00:16.1: [8086:8c3b] type 00 class 0x078000
> [    0.259295] pci 0000:00:16.1: reg 0x10: [mem 0xf7337000-0xf733700f 64bit]
> [    0.259351] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
> [    0.259436] pci 0000:00:19.0: [8086:153a] type 00 class 0x020000
> [    0.259448] pci 0000:00:19.0: reg 0x10: [mem 0xf7300000-0xf731ffff]
> [    0.259455] pci 0000:00:19.0: reg 0x14: [mem 0xf7335000-0xf7335fff]
> [    0.259462] pci 0000:00:19.0: reg 0x18: [io  0xf020-0xf03f]
> [    0.259512] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
> [    0.259589] pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
> [    0.259604] pci 0000:00:1a.0: reg 0x10: [mem 0xf7334000-0xf73343ff]
> [    0.259678] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> [    0.259763] pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
> [    0.259834] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.259962] pci 0000:00:1c.1: [8086:8c12] type 01 class 0x060400
> [    0.260035] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> [    0.260175] pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
> [    0.260190] pci 0000:00:1d.0: reg 0x10: [mem 0xf7333000-0xf73333ff]
> [    0.260266] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.260354] pci 0000:00:1f.0: [8086:8c54] type 00 class 0x060100
> [    0.260528] pci 0000:00:1f.2: [8086:8c02] type 00 class 0x010601
> [    0.260538] pci 0000:00:1f.2: reg 0x10: [io  0xf070-0xf077]
> [    0.260545] pci 0000:00:1f.2: reg 0x14: [io  0xf060-0xf063]
> [    0.260551] pci 0000:00:1f.2: reg 0x18: [io  0xf050-0xf057]
> [    0.260558] pci 0000:00:1f.2: reg 0x1c: [io  0xf040-0xf043]
> [    0.260564] pci 0000:00:1f.2: reg 0x20: [io  0xf000-0xf01f]
> [    0.260571] pci 0000:00:1f.2: reg 0x24: [mem 0xf7332000-0xf73327ff]
> [    0.260606] pci 0000:00:1f.2: PME# supported from D3hot
> [    0.260681] pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
> [    0.260696] pci 0000:00:1f.3: reg 0x10: [mem 0xf7331000-0xf73310ff 64bit]
> [    0.260712] pci 0000:00:1f.3: reg 0x20: [io  0x0580-0x059f]
> [    0.260811] pci 0000:00:1f.6: [8086:8c24] type 00 class 0x118000
> [    0.260827] pci 0000:00:1f.6: reg 0x10: [mem 0xf7330000-0xf7330fff 64bit]
> [    0.260966] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.260999] pci 0000:02:00.0: [1000:0072] type 00 class 0x010700
> [    0.261007] pci 0000:02:00.0: reg 0x10: [io  0xe000-0xe0ff]
> [    0.261014] pci 0000:02:00.0: reg 0x14: [mem 0xf72c0000-0xf72c3fff 64bit]
> [    0.261020] pci 0000:02:00.0: reg 0x1c: [mem 0xf7280000-0xf72bffff 64bit]
> [    0.261029] pci 0000:02:00.0: reg 0x30: [mem 0xf7200000-0xf727ffff pref]
> [    0.261065] pci 0000:02:00.0: supports D1 D2
> [    0.261077] pci 0000:02:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
> [    0.261078] pci 0000:02:00.0: VF(n) BAR0 space: [mem 0x00000000-0x0003ffff 64bit] (contains BAR0 for 16 VFs)
> [    0.261084] pci 0000:02:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
> [    0.261085] pci 0000:02:00.0: VF(n) BAR2 space: [mem 0x00000000-0x003fffff 64bit] (contains BAR2 for 16 VFs)
> [    0.261162] pci 0000:00:01.1: PCI bridge to [bus 02]
> [    0.261164] pci 0000:00:01.1:   bridge window [io  0xe000-0xefff]
> [    0.261165] pci 0000:00:01.1:   bridge window [mem 0xf7200000-0xf72fffff]
> [    0.261263] pci 0000:03:00.0: [1a03:1150] type 01 class 0x060400
> [    0.261328] pci 0000:03:00.0: enabling Extended Tags
> [    0.261404] pci 0000:03:00.0: supports D1 D2
> [    0.261405] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.261518] pci 0000:00:1c.0: PCI bridge to [bus 03-04]
> [    0.261521] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
> [    0.261524] pci 0000:00:1c.0:   bridge window [mem 0xf6000000-0xf70fffff]
> [    0.261572] pci_bus 0000:04: extended config space not accessible
> [    0.261598] pci 0000:04:00.0: [1a03:2000] type 00 class 0x030000
> [    0.261621] pci 0000:04:00.0: reg 0x10: [mem 0xf6000000-0xf6ffffff]
> [    0.261634] pci 0000:04:00.0: reg 0x14: [mem 0xf7000000-0xf701ffff]
> [    0.261647] pci 0000:04:00.0: reg 0x18: [io  0xd000-0xd07f]
> [    0.261752] pci 0000:04:00.0: supports D1 D2
> [    0.261752] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.261847] pci 0000:03:00.0: PCI bridge to [bus 04]
> [    0.261855] pci 0000:03:00.0:   bridge window [io  0xd000-0xdfff]
> [    0.261859] pci 0000:03:00.0:   bridge window [mem 0xf6000000-0xf70fffff]
> [    0.261990] pci 0000:05:00.0: [8086:1533] type 00 class 0x020000
> [    0.262020] pci 0000:05:00.0: reg 0x10: [mem 0xf7100000-0xf717ffff]
> [    0.262051] pci 0000:05:00.0: reg 0x18: [io  0xc000-0xc01f]
> [    0.262068] pci 0000:05:00.0: reg 0x1c: [mem 0xf7180000-0xf7183fff]
> [    0.262253] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> [    0.262426] pci 0000:00:1c.1: PCI bridge to [bus 05]
> [    0.262430] pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
> [    0.262433] pci 0000:00:1c.1:   bridge window [mem 0xf7100000-0xf71fffff]
> [    0.263733] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.263810] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
> [    0.263880] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 10 11 12 14 15)
> [    0.263954] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 10 11 12 14 15)
> [    0.264029] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 *4 5 6 10 11 12 14 15)
> [    0.264103] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.264179] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.264253] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.264634] iommu: Default domain type: Translated 
> [    0.264634] pci 0000:04:00.0: vgaarb: setting as boot VGA device
> [    0.264634] pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.264634] pci 0000:04:00.0: vgaarb: bridge control possible
> [    0.264634] vgaarb: loaded
> [    0.264634] SCSI subsystem initialized
> [    0.264634] libata version 3.00 loaded.
> [    0.264634] ACPI: bus type USB registered
> [    0.264634] usbcore: registered new interface driver usbfs
> [    0.264634] usbcore: registered new interface driver hub
> [    0.264634] usbcore: registered new device driver usb
> [    0.264634] pps_core: LinuxPPS API ver. 1 registered
> [    0.264634] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.264634] PTP clock support registered
> [    0.264634] EDAC MC: Ver: 3.0.0
> [    0.264634] NetLabel: Initializing
> [    0.264634] NetLabel:  domain hash size = 128
> [    0.264634] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.264634] NetLabel:  unlabeled traffic allowed by default
> [    0.264634] PCI: Using ACPI for IRQ routing
> [    0.264634] PCI: pci_cache_line_size set to 64 bytes
> [    0.264634] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
> [    0.264634] e820: reserve RAM buffer [mem 0xcd39f000-0xcfffffff]
> [    0.264634] e820: reserve RAM buffer [mem 0xdd6d8000-0xdfffffff]
> [    0.264634] e820: reserve RAM buffer [mem 0xdd80b000-0xdfffffff]
> [    0.264634] e820: reserve RAM buffer [mem 0xdf800000-0xdfffffff]
> [    0.267521] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    0.267527] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> [    0.269556] clocksource: Switched to clocksource tsc-early
> [    0.275606] VFS: Disk quotas dquot_6.6.0
> [    0.275621] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.275704] AppArmor: AppArmor Filesystem Enabled
> [    0.275737] pnp: PnP ACPI init
> [    0.275869] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
> [    0.275875] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.275974] system 00:01: [io  0x0800-0x087f] has been reserved
> [    0.275977] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.275994] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.276028] system 00:03: [io  0x1854-0x1857] has been reserved
> [    0.276031] system 00:03: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
> [    0.276119] system 00:04: [io  0x0a00-0x0a1f] has been reserved
> [    0.276122] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.276409] system 00:05: [io  0x04d0-0x04d1] has been reserved
> [    0.276412] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.277041] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    0.277043] system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
> [    0.277044] system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.277046] system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.277047] system 00:06: [mem 0xf8000000-0xfbffffff] has been reserved
> [    0.277048] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.277049] system 00:06: [mem 0xfed90000-0xfed93fff] could not be reserved
> [    0.277050] system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    0.277052] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
> [    0.277053] system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
> [    0.277054] system 00:06: [mem 0xf7fe0000-0xf7feffff] has been reserved
> [    0.277055] system 00:06: [mem 0xf7ff0000-0xf7ffffff] has been reserved
> [    0.277058] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.277313] pnp: PnP ACPI: found 7 devices
> [    0.282755] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.282798] NET: Registered protocol family 2
> [    0.282916] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.284786] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
> [    0.284910] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.285149] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [    0.285204] TCP: Hash tables configured (established 262144 bind 65536)
> [    0.285288] MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
> [    0.285397] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
> [    0.285460] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
> [    0.285526] NET: Registered protocol family 1
> [    0.285529] NET: Registered protocol family 44
> [    0.285534] pci_bus 0000:00: max bus depth: 2 pci_try_num: 3
> [    0.285539] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.285547] pci 0000:02:00.0: BAR 9: no space for [mem size 0x00400000 64bit]
> [    0.285549] pci 0000:02:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit]
> [    0.285551] pci 0000:02:00.0: BAR 7: no space for [mem size 0x00040000 64bit]
> [    0.285552] pci 0000:02:00.0: BAR 7: failed to assign [mem size 0x00040000 64bit]
> [    0.285553] pci 0000:00:01.1: PCI bridge to [bus 02]
> [    0.285554] pci 0000:00:01.1:   bridge window [io  0xe000-0xefff]
> [    0.285557] pci 0000:00:01.1:   bridge window [mem 0xf7200000-0xf72fffff]
> [    0.285560] pci 0000:03:00.0: PCI bridge to [bus 04]
> [    0.285568] pci 0000:03:00.0:   bridge window [io  0xd000-0xdfff]
> [    0.285574] pci 0000:03:00.0:   bridge window [mem 0xf6000000-0xf70fffff]
> [    0.285585] pci 0000:00:1c.0: PCI bridge to [bus 03-04]
> [    0.285587] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
> [    0.285591] pci 0000:00:1c.0:   bridge window [mem 0xf6000000-0xf70fffff]
> [    0.285597] pci 0000:00:1c.1: PCI bridge to [bus 05]
> [    0.285600] pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
> [    0.285604] pci 0000:00:1c.1:   bridge window [mem 0xf7100000-0xf71fffff]
> [    0.285610] pci_bus 0000:00: No. 2 try to assign unassigned res
> [    0.285611] release child resource [mem 0xf7200000-0xf727ffff pref]
> [    0.285612] release child resource [mem 0xf7280000-0xf72bffff 64bit]
> [    0.285613] release child resource [mem 0xf72c0000-0xf72c3fff 64bit]
> [    0.285614] pci 0000:00:01.1: resource 14 [mem 0xf7200000-0xf72fffff] released
> [    0.285615] pci 0000:00:01.1: PCI bridge to [bus 02]
> [    0.285620] pci 0000:00:01.1: BAR 14: assigned [mem 0xe0000000-0xe05fffff]
> [    0.285622] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.285626] pci 0000:02:00.0: BAR 6: assigned [mem 0xe0000000-0xe007ffff pref]
> [    0.285628] pci 0000:02:00.0: BAR 3: assigned [mem 0xe0080000-0xe00bffff 64bit]
> [    0.285634] pci 0000:02:00.0: BAR 9: assigned [mem 0xe00c0000-0xe04bffff 64bit]
> [    0.285637] pci 0000:02:00.0: BAR 1: assigned [mem 0xe04c0000-0xe04c3fff 64bit]
> [    0.285642] pci 0000:02:00.0: BAR 7: assigned [mem 0xe04c4000-0xe0503fff 64bit]
> [    0.285644] pci 0000:00:01.1: PCI bridge to [bus 02]
> [    0.285645] pci 0000:00:01.1:   bridge window [io  0xe000-0xefff]
> [    0.285647] pci 0000:00:01.1:   bridge window [mem 0xe0000000-0xe05fffff]
> [    0.285651] pci 0000:03:00.0: PCI bridge to [bus 04]
> [    0.285659] pci 0000:03:00.0:   bridge window [io  0xd000-0xdfff]
> [    0.285665] pci 0000:03:00.0:   bridge window [mem 0xf6000000-0xf70fffff]
> [    0.285675] pci 0000:00:1c.0: PCI bridge to [bus 03-04]
> [    0.285677] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
> [    0.285681] pci 0000:00:1c.0:   bridge window [mem 0xf6000000-0xf70fffff]
> [    0.285687] pci 0000:00:1c.1: PCI bridge to [bus 05]
> [    0.285689] pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
> [    0.285693] pci 0000:00:1c.1:   bridge window [mem 0xf7100000-0xf71fffff]
> [    0.285700] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.285701] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.285702] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.285703] pci_bus 0000:00: resource 7 [mem 0x000c8000-0x000cbfff window]
> [    0.285704] pci_bus 0000:00: resource 8 [mem 0x000cc000-0x000cffff window]
> [    0.285705] pci_bus 0000:00: resource 9 [mem 0x000d0000-0x000d3fff window]
> [    0.285706] pci_bus 0000:00: resource 10 [mem 0x000d4000-0x000d7fff window]
> [    0.285707] pci_bus 0000:00: resource 11 [mem 0x000d8000-0x000dbfff window]
> [    0.285708] pci_bus 0000:00: resource 12 [mem 0x000dc000-0x000dffff window]
> [    0.285709] pci_bus 0000:00: resource 13 [mem 0x000e0000-0x000e3fff window]
> [    0.285710] pci_bus 0000:00: resource 14 [mem 0x000e4000-0x000e7fff window]
> [    0.285711] pci_bus 0000:00: resource 15 [mem 0xe0000000-0xfeafffff window]
> [    0.285713] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
> [    0.285714] pci_bus 0000:02: resource 1 [mem 0xe0000000-0xe05fffff]
> [    0.285715] pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
> [    0.285716] pci_bus 0000:03: resource 1 [mem 0xf6000000-0xf70fffff]
> [    0.285717] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
> [    0.285718] pci_bus 0000:04: resource 1 [mem 0xf6000000-0xf70fffff]
> [    0.285719] pci_bus 0000:05: resource 0 [io  0xc000-0xcfff]
> [    0.285720] pci_bus 0000:05: resource 1 [mem 0xf7100000-0xf71fffff]
> [    0.311242] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x120 took 24643 usecs
> [    0.335242] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x120 took 23418 usecs
> [    0.335275] pci 0000:04:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.335291] PCI: CLS 64 bytes, default 64
> [    0.335322] Trying to unpack rootfs image as initramfs...
> [    1.091856] Freeing initrd memory: 73136K
> [    1.091916] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    1.091917] software IO TLB: mapped [mem 0x00000000d96d8000-0x00000000dd6d8000] (64MB)
> [    1.092089] check: Scanning for low memory corruption every 60 seconds
> [    1.092430] Initialise system trusted keyrings
> [    1.092441] Key type blacklist registered
> [    1.092466] workingset: timestamp_bits=36 max_order=23 bucket_order=0
> [    1.093304] zbud: loaded
> [    1.093502] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    1.093593] fuse: init (API version 7.33)
> [    1.093699] integrity: Platform Keyring initialized
> [    1.101725] Key type asymmetric registered
> [    1.101726] Asymmetric key parser 'x509' registered
> [    1.101733] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
> [    1.101754] io scheduler mq-deadline registered
> [    1.102457] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    1.102495] vesafb: mode is 640x480x32, linelength=2560, pages=0
> [    1.102496] vesafb: scrolling: redraw
> [    1.102497] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    1.102508] vesafb: framebuffer at 0xf6000000, mapped to 0x0000000065c62d4e, using 1216k, total 1216k
> [    1.102534] fbcon: Deferring console take-over
> [    1.102536] fb0: VESA VGA frame buffer device
> [    1.102983] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
> [    1.103002] ACPI: button: Sleep Button [SLPB]
> [    1.103022] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> [    1.103033] ACPI: button: Power Button [PWRB]
> [    1.103052] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> [    1.103074] ACPI: button: Power Button [PWRF]
> [    1.105678] thermal LNXTHERM:00: registered as thermal_zone0
> [    1.105680] ACPI: thermal: Thermal Zone [TZ00] (28 C)
> [    1.105923] thermal LNXTHERM:01: registered as thermal_zone1
> [    1.105924] ACPI: thermal: Thermal Zone [TZ01] (30 C)
> [    1.105968] ERST: Error Record Serialization Table (ERST) support is initialized.
> [    1.105969] pstore: Registered erst as persistent store backend
> [    1.106098] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> [    1.106191] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    1.107395] Linux agpgart interface v0.103
> [    1.109099] loop: module loaded
> [    1.109276] libphy: Fixed MDIO Bus: probed
> [    1.109278] tun: Universal TUN/TAP device driver, 1.6
> [    1.109306] PPP generic driver version 2.4.2
> [    1.109358] VFIO - User Level meta-driver version: 0.3
> [    1.109428] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.109431] ehci-pci: EHCI PCI platform driver
> [    1.109533] ehci-pci 0000:00:1a.0: EHCI Host Controller
> [    1.109538] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
> [    1.109548] ehci-pci 0000:00:1a.0: debug port 2
> [    1.113466] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7334000
> [    1.127248] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> [    1.127297] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.12
> [    1.127299] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.127300] usb usb1: Product: EHCI Host Controller
> [    1.127301] usb usb1: Manufacturer: Linux 5.12.11-051211-generic ehci_hcd
> [    1.127302] usb usb1: SerialNumber: 0000:00:1a.0
> [    1.127481] hub 1-0:1.0: USB hub found
> [    1.127486] hub 1-0:1.0: 2 ports detected
> [    1.127773] ehci-pci 0000:00:1d.0: EHCI Host Controller
> [    1.127777] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
> [    1.127793] ehci-pci 0000:00:1d.0: debug port 2
> [    1.131720] ehci-pci 0000:00:1d.0: irq 22, io mem 0xf7333000
> [    1.147246] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> [    1.147291] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.12
> [    1.147293] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.147294] usb usb2: Product: EHCI Host Controller
> [    1.147295] usb usb2: Manufacturer: Linux 5.12.11-051211-generic ehci_hcd
> [    1.147296] usb usb2: SerialNumber: 0000:00:1d.0
> [    1.147475] hub 2-0:1.0: USB hub found
> [    1.147481] hub 2-0:1.0: 2 ports detected
> [    1.147633] ehci-platform: EHCI generic platform driver
> [    1.147649] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.147652] ohci-pci: OHCI PCI platform driver
> [    1.147659] ohci-platform: OHCI generic platform driver
> [    1.147665] uhci_hcd: USB Universal Host Controller Interface driver
> [    1.147695] i8042: PNP: No PS/2 controller found.
> [    1.147885] mousedev: PS/2 mouse device common for all mice
> [    1.148263] rtc_cmos 00:02: RTC can wake from S4
> [    1.148461] rtc_cmos 00:02: registered as rtc0
> [    1.148514] rtc_cmos 00:02: setting system clock to 2021-06-18T09:42:37 UTC (1624009357)
> [    1.148526] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
> [    1.148532] i2c /dev entries driver
> [    1.148694] device-mapper: uevent: version 1.0.3
> [    1.148730] device-mapper: ioctl: 4.44.0-ioctl (2021-02-01) initialised: dm-devel@redhat.com
> [    1.148747] platform eisa.0: Probing EISA bus 0
> [    1.148749] platform eisa.0: EISA: Cannot allocate resource for mainboard
> [    1.148750] platform eisa.0: Cannot allocate resource for EISA slot 1
> [    1.148751] platform eisa.0: Cannot allocate resource for EISA slot 2
> [    1.148752] platform eisa.0: Cannot allocate resource for EISA slot 3
> [    1.148753] platform eisa.0: Cannot allocate resource for EISA slot 4
> [    1.148753] platform eisa.0: Cannot allocate resource for EISA slot 5
> [    1.148754] platform eisa.0: Cannot allocate resource for EISA slot 6
> [    1.148755] platform eisa.0: Cannot allocate resource for EISA slot 7
> [    1.148756] platform eisa.0: Cannot allocate resource for EISA slot 8
> [    1.148757] platform eisa.0: EISA: Detected 0 cards
> [    1.148760] intel_pstate: Intel P-state driver initializing
> [    1.149204] ledtrig-cpu: registered to indicate activity on CPUs
> [    1.149279] drop_monitor: Initializing network drop monitor service
> [    1.149396] NET: Registered protocol family 10
> [    1.154437] Segment Routing with IPv6
> [    1.154450] NET: Registered protocol family 17
> [    1.154471] Key type dns_resolver registered
> [    1.154761] microcode: sig=0x306c3, pf=0x2, revision=0x28
> [    1.154794] microcode: Microcode Update Driver: v2.2.
> [    1.154798] IPI shorthand broadcast: enabled
> [    1.154806] sched_clock: Marking stable (1154518193, 274013)->(1201834446, -47042240)
> [    1.154849] registered taskstats version 1
> [    1.154858] Loading compiled-in X.509 certificates
> [    1.155406] Loaded X.509 cert 'Build time autogenerated kernel key: c82384bfbd53fa24fffb9841b8f625f3a05015d4'
> [    1.155909] Loaded X.509 cert 'Canonical Ltd. Live Patch Signing: 14df34d1a87cf37625abec039ef2bf521249b969'
> [    1.156387] Loaded X.509 cert 'Canonical Ltd. Kernel Module Signing: 88f752e560a1e0737e31163a466ad7b70a850c19'
> [    1.156539] zswap: loaded using pool lzo/zbud
> [    1.156691] Key type ._fscrypt registered
> [    1.156692] Key type .fscrypt registered
> [    1.156693] Key type fscrypt-provisioning registered
> [    1.156739] pstore: Using crash dump compression: deflate
> [    1.158968] Key type encrypted registered
> [    1.158970] AppArmor: AppArmor sha1 policy hashing enabled
> [    1.158974] ima: No TPM chip found, activating TPM-bypass!
> [    1.158976] ima: Allocated hash algorithm: sha1
> [    1.158981] ima: No architecture policies found
> [    1.158988] evm: Initialising EVM extended attributes:
> [    1.158988] evm: security.selinux
> [    1.158989] evm: security.SMACK64
> [    1.158989] evm: security.SMACK64EXEC
> [    1.158990] evm: security.SMACK64TRANSMUTE
> [    1.158990] evm: security.SMACK64MMAP
> [    1.158991] evm: security.apparmor
> [    1.158991] evm: security.ima
> [    1.158992] evm: security.capability
> [    1.158992] evm: HMAC attrs: 0x1
> [    1.159521] PM:   Magic number: 9:988:727
> [    1.159527] block loop7: hash matches
> [    1.159672] RAS: Correctable Errors collector initialized.
> [    1.160622] Freeing unused decrypted memory: 2036K
> [    1.160920] Freeing unused kernel image (initmem) memory: 2684K
> [    1.199244] Write protecting the kernel read-only data: 30720k
> [    1.199617] Freeing unused kernel image (text/rodata gap) memory: 2036K
> [    1.199823] Freeing unused kernel image (rodata/data gap) memory: 1760K
> [    1.236599] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    1.236600] x86/mm: Checking user space page tables
> [    1.271353] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    1.271357] Run /init as init process
> [    1.271358]   with arguments:
> [    1.271359]     /init
> [    1.271360]     splash
> [    1.271360]   with environment:
> [    1.271361]     HOME=/
> [    1.271361]     TERM=linux
> [    1.271362]     BOOT_IMAGE=/boot/vmlinuz-5.12.11-051211-generic
> [    1.348637] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.348646] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
> [    1.348810] e1000e: Intel(R) PRO/1000 Network Driver
> [    1.348812] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    1.348817] dca service started, version 1.12.1
> [    1.348974] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [    1.349718] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
> [    1.349907] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.12
> [    1.349910] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.349912] usb usb3: Product: xHCI Host Controller
> [    1.349914] usb usb3: Manufacturer: Linux 5.12.11-051211-generic xhci-hcd
> [    1.349915] usb usb3: SerialNumber: 0000:00:14.0
> [    1.350062] hub 3-0:1.0: USB hub found
> [    1.350084] hub 3-0:1.0: 12 ports detected
> [    1.354611] mpt3sas version 37.100.00.00 loaded
> [    1.354712] mpt3sas 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
> [    1.355597] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.355602] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
> [    1.355606] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [    1.355670] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.12
> [    1.355674] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.355677] usb usb4: Product: xHCI Host Controller
> [    1.355679] usb usb4: Manufacturer: Linux 5.12.11-051211-generic xhci-hcd
> [    1.355680] usb usb4: SerialNumber: 0000:00:14.0
> [    1.355812] hub 4-0:1.0: USB hub found
> [    1.355834] hub 4-0:1.0: 6 ports detected
> [    1.356486] igb: Intel(R) Gigabit Ethernet Network Driver
> [    1.356488] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    1.360151] mpt2sas_cm0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (32835920 kB)
> [    1.361073] cryptd: max_cpu_qlen set to 1000
> [    1.362153] ahci 0000:00:1f.2: version 3.0
> [    1.363438] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
> [    1.363443] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part ems apst 
> [    1.366793] AVX2 version of gcm_enc/dec engaged.
> [    1.366825] AES CTR mode by8 optimization enabled
> [    1.383175] usb 1-1: new high-speed USB device number 2 using ehci-pci
> [    1.386963] pps pps0: new PPS source ptp0
> [    1.387009] igb 0000:05:00.0: added PHC on eth0
> [    1.387012] igb 0000:05:00.0: Intel(R) Gigabit Ethernet Network Connection
> [    1.387013] igb 0000:05:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 0c:c4:7a:79:68:62
> [    1.387081] igb 0000:05:00.0: eth0: PBA No: 011000-000
> [    1.387082] igb 0000:05:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> [    1.389212] mpt2sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
> [    1.389219] mpt2sas_cm0: MSI-X vectors supported: 1
> [    1.389220] 	 no of cores: 8, max_msix_vectors: -1
> [    1.389221] mpt2sas_cm0:  0 1
> [    1.389275] mpt2sas_cm0: High IOPs queues : disabled
> [    1.389276] mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 37
> [    1.389277] mpt2sas_cm0: iomem(0x00000000e04c0000), mapped(0x0000000073872de8), size(16384)
> [    1.389280] mpt2sas_cm0: ioport(0x000000000000e000), size(256)
> [    1.396090] igb 0000:05:00.0 eno1: renamed from eth0
> [    1.399174] usb 2-1: new high-speed USB device number 2 using ehci-pci
> [    1.401736] checking generic (f6000000 130000) vs hw (f6000000 1000000)
> [    1.401739] fb0: switching to astdrmfb from VESA VGA
> [    1.401939] ast 0000:04:00.0: [drm] Using P2A bridge for configuration
> [    1.401944] ast 0000:04:00.0: [drm] AST 2400 detected
> [    1.401954] ast 0000:04:00.0: [drm] Analog VGA only
> [    1.401961] ast 0000:04:00.0: [drm] dram MCLK=408 Mhz type=1 bus_width=16
> [    1.402018] [TTM] Zone  kernel: Available graphics memory: 16417960 KiB
> [    1.402019] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> [    1.402356] [drm] Initialized ast 0.1.0 20120228 for 0000:04:00.0 on minor 0
> [    1.406777] fbcon: astdrmfb (fb0) is primary device
> [    1.406779] fbcon: Deferring console take-over
> [    1.406781] ast 0000:04:00.0: [drm] fb0: astdrmfb frame buffer device
> [    1.426929] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
> [    1.427957] scsi host1: ahci
> [    1.428123] scsi host2: ahci
> [    1.428217] scsi host3: ahci
> [    1.428328] scsi host4: ahci
> [    1.428435] scsi host5: ahci
> [    1.428568] scsi host6: ahci
> [    1.428605] ata1: SATA max UDMA/133 abar m2048@0xf7332000 port 0xf7332100 irq 36
> [    1.428608] ata2: SATA max UDMA/133 abar m2048@0xf7332000 port 0xf7332180 irq 36
> [    1.428610] ata3: SATA max UDMA/133 abar m2048@0xf7332000 port 0xf7332200 irq 36
> [    1.428613] ata4: SATA max UDMA/133 abar m2048@0xf7332000 port 0xf7332280 irq 36
> [    1.428615] ata5: SATA max UDMA/133 abar m2048@0xf7332000 port 0xf7332300 irq 36
> [    1.428617] ata6: SATA max UDMA/133 abar m2048@0xf7332000 port 0xf7332380 irq 36
> [    1.431162] mpt2sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
> [    1.448387] mpt2sas_cm0: scatter gather: sge_in_main_msg(1), sge_per_chain(9), sge_per_io(128), chains_per_io(15)
> [    1.448447] mpt2sas_cm0: request pool(0x000000009b78bda4) - dma(0x112c00000): depth(3492), frame_size(128), pool_size(436 kB)
> [    1.457077] mpt2sas_cm0: sense pool(0x00000000deed9c99)- dma(0x113280000): depth(3367),element_size(96), pool_size(315 kB)
> [    1.457132] mpt2sas_cm0: config page(0x000000002481a303) - dma(0x113218000): size(512)
> [    1.457133] mpt2sas_cm0: Allocated physical memory: size(1687 kB)
> [    1.457134] mpt2sas_cm0: Current Controller Queue Depth(3364),Max Controller Queue Depth(3432)
> [    1.457134] mpt2sas_cm0: Scatter Gather Elements per IO(128)
> [    1.495515] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 0c:c4:7a:79:68:63
> [    1.495522] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
> [    1.495577] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: 0100FF-0FF
> [    1.496356] e1000e 0000:00:19.0 eno2: renamed from eth0
> [    1.502118] mpt2sas_cm0: LSISAS2008: FWVersion(15.00.00.00), ChipRevision(0x03), BiosVersion(00.00.00.00)
> [    1.502123] mpt2sas_cm0: Protocol=(Initiator,Target), Capabilities=(TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
> [    1.502188] scsi host0: Fusion MPT SAS Host
> [    1.502768] mpt2sas_cm0: sending port enable !!
> [    1.539539] usb 1-1: New USB device found, idVendor=8087, idProduct=8008, bcdDevice= 0.05
> [    1.539546] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    1.539841] hub 1-1:1.0: USB hub found
> [    1.539923] hub 1-1:1.0: 6 ports detected
> [    1.555595] usb 2-1: New USB device found, idVendor=8087, idProduct=8000, bcdDevice= 0.05
> [    1.555611] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    1.556013] hub 2-1:1.0: USB hub found
> [    1.556207] hub 2-1:1.0: 6 ports detected
> [    1.742646] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.742672] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.742686] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.742700] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.742714] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.742726] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.744268] ata5.00: ATA-9: ST8000AS0002-1NA17Z, RT17, max UDMA/133
> [    1.744273] ata5.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    1.744282] ata6.00: ATA-9: ST8000AS0002-1NA17Z, RT17, max UDMA/133
> [    1.744286] ata6.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    1.744484] ata1.00: ATA-9: ST8000AS0002-1NA17Z, RT17, max UDMA/133
> [    1.744491] ata1.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    1.745859] ata6.00: configured for UDMA/133
> [    1.745875] ata5.00: configured for UDMA/133
> [    1.746036] ata1.00: configured for UDMA/133
> [    1.746066] scsi: waiting for bus probes to complete ...
> [    1.746277] ata4.00: ATA-9: WDC WD80EZZX-11CSGA0, 83.H0A03, max UDMA/133
> [    1.746279] ata4.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    1.746326] ata3.00: ATA-9: WDC WD80EZZX-11CSGA0, 83.H0A03, max UDMA/133
> [    1.746339] ata3.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    1.752237] ata4.00: configured for UDMA/133
> [    1.752252] ata3.00: configured for UDMA/133
> [    1.781740] ata2.00: ATA-10: ST8000DM004-2CX188, 0001, max UDMA/133
> [    1.781745] ata2.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    1.833235] ata2.00: configured for UDMA/133
> [    2.103286] tsc: Refined TSC clocksource calibration: 3399.978 MHz
> [    2.103308] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x31023a3a8ac, max_idle_ns: 440795341378 ns
> [    2.103387] clocksource: Switched to clocksource tsc
> [    2.375360] usb 4-1: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> [    2.396459] usb 4-1: New USB device found, idVendor=174c, idProduct=55aa, bcdDevice= 1.00
> [    2.396473] usb 4-1: New USB device strings: Mfr=2, Product=3, SerialNumber=1
> [    2.396478] usb 4-1: Product: ASMT1051
> [    2.396483] usb 4-1: Manufacturer: asmedia
> [    2.396487] usb 4-1: SerialNumber: 12345678C6CA
> [    2.407933] usbcore: registered new interface driver usb-storage
> [    2.415706] scsi host7: uas
> [    2.415788] usbcore: registered new interface driver uas
> [    2.416209] scsi 7:0:0:0: Direct-Access     ASMT     2115             0    PQ: 0 ANSI: 6
> [    2.523239] usb 3-3: new high-speed USB device number 3 using xhci_hcd
> [    2.671548] usb 3-3: New USB device found, idVendor=0557, idProduct=7000, bcdDevice= 0.00
> [    2.671554] usb 3-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    2.672365] hub 3-3:1.0: USB hub found
> [    2.672418] hub 3-3:1.0: 4 ports detected
> [    2.799246] usb 3-10: new high-speed USB device number 4 using xhci_hcd
> [    2.958150] usb 3-10: New USB device found, idVendor=ffff, idProduct=5678, bcdDevice= 2.00
> [    2.958156] usb 3-10: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    2.958158] usb 3-10: Product: Disk 2.0
> [    2.958159] usb 3-10: Manufacturer: USB
> [    2.958161] usb 3-10: SerialNumber: 9207059072891727556
> [    2.959556] usb-storage 3-10:1.0: USB Mass Storage device detected
> [    2.959865] scsi host8: usb-storage 3-10:1.0
> [    3.047241] usb 3-3.1: new low-speed USB device number 5 using xhci_hcd
> [    3.103136] mpt2sas_cm0: hba_port entry: 00000000519b2100, port: 255 is added to hba_port list
> [    3.105068] mpt2sas_cm0: host_add: handle(0x0001), sas_addr(0x5000000080000000), phys(8)
> [    3.172054] usb 3-3.1: New USB device found, idVendor=0557, idProduct=2419, bcdDevice= 1.00
> [    3.172068] usb 3-3.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    3.195974] hid: raw HID events driver (C) Jiri Kosina
> [    3.203307] usbcore: registered new interface driver usbhid
> [    3.203314] usbhid: USB HID core driver
> [    3.209504] input: HID 0557:2419 as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.1/3-3.1:1.0/0003:0557:2419.0001/input/input3
> [    3.267739] hid-generic 0003:0557:2419.0001: input,hidraw0: USB HID v1.00 Keyboard [HID 0557:2419] on usb-0000:00:14.0-3.1/input0
> [    3.268134] input: HID 0557:2419 as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.1/3-3.1:1.1/0003:0557:2419.0002/input/input4
> [    3.268551] hid-generic 0003:0557:2419.0002: input,hidraw1: USB HID v1.00 Mouse [HID 0557:2419] on usb-0000:00:14.0-3.1/input1
> [    3.604600] scsi 0:0:0:0: Direct-Access     ATA      ST8000AS0002-1NA RT17 PQ: 0 ANSI: 6
> [    3.604622] scsi 0:0:0:0: SATA: handle(0x0009), sas_addr(0x4433221100000000), phy(0), device_name(0x0000000000000000)
> [    3.604628] scsi 0:0:0:0: enclosure logical id (0x5000000080000000), slot(3) 
> [    3.604729] scsi 0:0:0:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
> [    3.604736] scsi 0:0:0:0: qdepth(32), tagged(1), scsi_level(7), cmd_que(1)
> [    3.610801]  end_device-0:0: add: handle(0x0009), sas_addr(0x4433221100000000)
> [    3.853803] scsi 0:0:1:0: Direct-Access     ATA      WDC WD60EFRX-68M 0A82 PQ: 0 ANSI: 6
> [    3.853825] scsi 0:0:1:0: SATA: handle(0x000a), sas_addr(0x4433221101000000), phy(1), device_name(0x0000000000000000)
> [    3.853831] scsi 0:0:1:0: enclosure logical id (0x5000000080000000), slot(2) 
> [    3.853973] scsi 0:0:1:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
> [    3.853982] scsi 0:0:1:0: qdepth(32), tagged(1), scsi_level(7), cmd_que(1)
> [    3.857329]  end_device-0:1: add: handle(0x000a), sas_addr(0x4433221101000000)
> [    3.993996] scsi 8:0:0:0: Direct-Access     VendorCo ProductCode      2.00 PQ: 0 ANSI: 4
> [    4.104658] scsi 0:0:2:0: Direct-Access     ATA      ST8000AS0002-1NA RT17 PQ: 0 ANSI: 6
> [    4.104669] scsi 0:0:2:0: SATA: handle(0x000b), sas_addr(0x4433221102000000), phy(2), device_name(0x0000000000000000)
> [    4.104671] scsi 0:0:2:0: enclosure logical id (0x5000000080000000), slot(1) 
> [    4.104756] scsi 0:0:2:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
> [    4.104759] scsi 0:0:2:0: qdepth(32), tagged(1), scsi_level(7), cmd_que(1)
> [    4.110703]  end_device-0:2: add: handle(0x000b), sas_addr(0x4433221102000000)
> [    4.353837] scsi 0:0:3:0: Direct-Access     ATA      WDC WD60EFRX-68M 0A82 PQ: 0 ANSI: 6
> [    4.353859] scsi 0:0:3:0: SATA: handle(0x000c), sas_addr(0x4433221104000000), phy(4), device_name(0x0000000000000000)
> [    4.353865] scsi 0:0:3:0: enclosure logical id (0x5000000080000000), slot(7) 
> [    4.354052] scsi 0:0:3:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
> [    4.354065] scsi 0:0:3:0: qdepth(32), tagged(1), scsi_level(7), cmd_que(1)
> [    4.356652]  end_device-0:3: add: handle(0x000c), sas_addr(0x4433221104000000)
> [    4.607086] scsi 0:0:4:0: Direct-Access     ATA      ST10000DM0004-1Z DN01 PQ: 0 ANSI: 6
> [    4.607103] scsi 0:0:4:0: SATA: handle(0x000d), sas_addr(0x4433221103000000), phy(3), device_name(0x0000000000000000)
> [    4.607107] scsi 0:0:4:0: enclosure logical id (0x5000000080000000), slot(0) 
> [    4.607306] scsi 0:0:4:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
> [    4.607315] scsi 0:0:4:0: qdepth(32), tagged(1), scsi_level(7), cmd_que(1)
> [    4.620137]  end_device-0:4: add: handle(0x000d), sas_addr(0x4433221103000000)
> [    4.853746] scsi 0:0:5:0: Direct-Access     ATA      WDC WD60EZRX-11M 0A80 PQ: 0 ANSI: 6
> [    4.853762] scsi 0:0:5:0: SATA: handle(0x000e), sas_addr(0x4433221105000000), phy(5), device_name(0x0000000000000000)
> [    4.853767] scsi 0:0:5:0: enclosure logical id (0x5000000080000000), slot(6) 
> [    4.853966] scsi 0:0:5:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
> [    4.853974] scsi 0:0:5:0: qdepth(32), tagged(1), scsi_level(7), cmd_que(1)
> [    4.856881]  end_device-0:5: add: handle(0x000e), sas_addr(0x4433221105000000)
> [    5.103243] scsi 0:0:6:0: Direct-Access     ATA      WDC WD140EMFZ-11 0A81 PQ: 0 ANSI: 6
> [    5.103266] scsi 0:0:6:0: SATA: handle(0x000f), sas_addr(0x4433221106000000), phy(6), device_name(0x0000000000000000)
> [    5.103272] scsi 0:0:6:0: enclosure logical id (0x5000000080000000), slot(5) 
> [    5.103447] scsi 0:0:6:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
> [    5.103460] scsi 0:0:6:0: qdepth(32), tagged(1), scsi_level(7), cmd_que(1)
> [    5.104968]  end_device-0:6: add: handle(0x000f), sas_addr(0x4433221106000000)
> [    5.354299] scsi 0:0:7:0: Direct-Access     ATA      WDC WD60EZRX-11M 0A80 PQ: 0 ANSI: 6
> [    5.354316] scsi 0:0:7:0: SATA: handle(0x0010), sas_addr(0x4433221107000000), phy(7), device_name(0x0000000000000000)
> [    5.354320] scsi 0:0:7:0: enclosure logical id (0x5000000080000000), slot(4) 
> [    5.354516] scsi 0:0:7:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
> [    5.354525] scsi 0:0:7:0: qdepth(32), tagged(1), scsi_level(7), cmd_que(1)
> [    5.357387]  end_device-0:7: add: handle(0x0010), sas_addr(0x4433221107000000)
> [    8.247274] mpt2sas_cm0: port enable: SUCCESS
> [    8.247716] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    8.247726] sd 0:0:0:0: Power-on or device reset occurred
> [    8.247916] scsi 0:0:1:0: Attached scsi generic sg1 type 0
> [    8.248050] scsi 0:0:2:0: Attached scsi generic sg2 type 0
> [    8.248062] sd 0:0:1:0: Power-on or device reset occurred
> [    8.248161] sd 0:0:2:0: Power-on or device reset occurred
> [    8.248192] sd 0:0:3:0: Attached scsi generic sg3 type 0
> [    8.248257] sd 0:0:3:0: Power-on or device reset occurred
> [    8.248316] scsi 0:0:4:0: Attached scsi generic sg4 type 0
> [    8.248431] sd 0:0:4:0: Power-on or device reset occurred
> [    8.248456] scsi 0:0:5:0: Attached scsi generic sg5 type 0
> [    8.248608] sd 0:0:5:0: Power-on or device reset occurred
> [    8.248638] sd 0:0:6:0: Attached scsi generic sg6 type 0
> [    8.248683] sd 0:0:6:0: Power-on or device reset occurred
> [    8.248739] scsi 0:0:7:0: Attached scsi generic sg7 type 0
> [    8.248822] sd 0:0:7:0: Power-on or device reset occurred
> [    8.248857] scsi 1:0:0:0: Direct-Access     ATA      ST8000AS0002-1NA RT17 PQ: 0 ANSI: 5
> [    8.248872] sd 7:0:0:0: Attached scsi generic sg8 type 0
> [    8.248998] sd 1:0:0:0: Attached scsi generic sg9 type 0
> [    8.249017] sd 1:0:0:0: [sdj] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
> [    8.249020] sd 1:0:0:0: [sdj] 4096-byte physical blocks
> [    8.249030] sd 1:0:0:0: [sdj] Write Protect is off
> [    8.249032] sd 1:0:0:0: [sdj] Mode Sense: 00 3a 00 00
> [    8.249045] sd 1:0:0:0: [sdj] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [    8.249049] sd 8:0:0:0: Attached scsi generic sg10 type 0
> [    8.249049] scsi: waiting for bus probes to complete ...
> [    8.249164] scsi 2:0:0:0: Direct-Access     ATA      ST8000DM004-2CX1 0001 PQ: 0 ANSI: 5
> [    8.249248] sd 7:0:0:0: [sdi] 937703088 512-byte logical blocks: (480 GB/447 GiB)
> [    8.249293] sd 8:0:0:0: [sdk] 7863568 512-byte logical blocks: (4.03 GB/3.75 GiB)
> [    8.249315] sd 2:0:0:0: Attached scsi generic sg11 type 0
> [    8.249345] sd 2:0:0:0: [sdl] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
> [    8.249348] sd 2:0:0:0: [sdl] 4096-byte physical blocks
> [    8.249371] sd 2:0:0:0: [sdl] Write Protect is off
> [    8.249373] sd 2:0:0:0: [sdl] Mode Sense: 00 3a 00 00
> [    8.249374] sd 7:0:0:0: [sdi] Write Protect is off
> [    8.249376] sd 7:0:0:0: [sdi] Mode Sense: 43 00 00 00
> [    8.249410] sd 2:0:0:0: [sdl] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [    8.249414] scsi 3:0:0:0: Direct-Access     ATA      WDC WD80EZZX-11C 0A03 PQ: 0 ANSI: 5
> [    8.249453] sd 8:0:0:0: [sdk] Write Protect is off
> [    8.249456] sd 8:0:0:0: [sdk] Mode Sense: 33 00 00 00
> [    8.249531] sd 3:0:0:0: Attached scsi generic sg12 type 0
> [    8.249532] sd 0:0:6:0: [sdg] 27344764928 512-byte logical blocks: (14.0 TB/12.7 TiB)
> [    8.249535] sd 0:0:6:0: [sdg] 4096-byte physical blocks
> [    8.249564] sd 3:0:0:0: [sdm] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
> [    8.249566] sd 3:0:0:0: [sdm] 4096-byte physical blocks
> [    8.249574] sd 3:0:0:0: [sdm] Write Protect is off
> [    8.249576] sd 3:0:0:0: [sdm] Mode Sense: 00 3a 00 00
> [    8.249577] sd 7:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    8.249583] sd 3:0:0:0: [sdm] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [    8.249605] sd 8:0:0:0: [sdk] No Caching mode page found
> [    8.249606] scsi 4:0:0:0: Direct-Access     ATA      WDC WD80EZZX-11C 0A03 PQ: 0 ANSI: 5
> [    8.249615] fbcon: Taking over console
> [    8.249617] sd 8:0:0:0: [sdk] Assuming drive cache: write through
> [    8.249714] sd 4:0:0:0: Attached scsi generic sg13 type 0
> [    8.249806] sd 4:0:0:0: [sdn] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
> [    8.249807] sd 4:0:0:0: [sdn] 4096-byte physical blocks
> [    8.249829] sd 4:0:0:0: [sdn] Write Protect is off
> [    8.249844] sd 4:0:0:0: [sdn] Mode Sense: 00 3a 00 00
> [    8.249889] sd 4:0:0:0: [sdn] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [    8.249965] sd 7:0:0:0: [sdi] Optimal transfer size 33553920 bytes
> [    8.250002] sd 0:0:3:0: [sdd] 11721045168 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    8.250006] sd 0:0:3:0: [sdd] 4096-byte physical blocks
> [    8.250446] scsi 5:0:0:0: Direct-Access     ATA      ST8000AS0002-1NA RT17 PQ: 0 ANSI: 5
> [    8.250709] sd 0:0:1:0: [sdb] 11721045168 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    8.250710] sd 0:0:1:0: [sdb] 4096-byte physical blocks
> [    8.250916] sd 0:0:5:0: [sdf] 11720979633 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    8.250916] sd 0:0:5:0: [sdf] 4096-byte physical blocks
> [    8.251078] sd 0:0:7:0: [sdh] 11720979633 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    8.251079] sd 0:0:7:0: [sdh] 4096-byte physical blocks
> [    8.251423] sd 5:0:0:0: [sdo] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
> [    8.251425] sd 5:0:0:0: [sdo] 4096-byte physical blocks
> [    8.251428] sd 5:0:0:0: [sdo] Write Protect is off
> [    8.251429] sd 5:0:0:0: [sdo] Mode Sense: 00 3a 00 00
> [    8.251435] sd 5:0:0:0: Attached scsi generic sg14 type 0
> [    8.251436] sd 5:0:0:0: [sdo] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [    8.251908] scsi 6:0:0:0: Direct-Access     ATA      ST8000AS0002-1NA RT17 PQ: 0 ANSI: 5
> [    8.252312] sd 6:0:0:0: Attached scsi generic sg15 type 0
> [    8.252360] sd 6:0:0:0: [sdp] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
> [    8.252361] sd 6:0:0:0: [sdp] 4096-byte physical blocks
> [    8.252368] sd 6:0:0:0: [sdp] Write Protect is off
> [    8.252385] sd 6:0:0:0: [sdp] Mode Sense: 00 3a 00 00
> [    8.252406] sd 6:0:0:0: [sdp] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [    8.252942] sd 0:0:6:0: [sdg] Write Protect is off
> [    8.252943] sd 0:0:6:0: [sdg] Mode Sense: 7f 00 10 08
> [    8.252947] sd 0:0:0:0: [sda] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
> [    8.252949] sd 0:0:0:0: [sda] 4096-byte physical blocks
> [    8.253423] sd 0:0:6:0: [sdg] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    8.253596] sd 0:0:3:0: [sdd] Write Protect is off
> [    8.253597] sd 0:0:3:0: [sdd] Mode Sense: 7f 00 10 08
> [    8.254541] sd 0:0:1:0: [sdb] Write Protect is off
> [    8.254543] sd 0:0:1:0: [sdb] Mode Sense: 7f 00 10 08
> [    8.254578] sd 0:0:5:0: [sdf] Write Protect is off
> [    8.254580] sd 0:0:5:0: [sdf] Mode Sense: 7f 00 10 08
> [    8.254811] sd 0:0:7:0: [sdh] Write Protect is off
> [    8.254812] sd 0:0:7:0: [sdh] Mode Sense: 7f 00 10 08
> [    8.255831] sd 0:0:7:0: [sdh] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    8.255863] sd 0:0:5:0: [sdf] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    8.255911] sd 0:0:3:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    8.256347] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    8.259001] sd 0:0:2:0: [sdc] 15628053168 512-byte logical blocks: (8.00 TB/7.28 TiB)
> [    8.259003] sd 0:0:2:0: [sdc] 4096-byte physical blocks
> [    8.260108] sd 0:0:4:0: [sde] 19532873728 512-byte logical blocks: (10.0 TB/9.10 TiB)
> [    8.260109] sd 0:0:4:0: [sde] 4096-byte physical blocks
> [    8.270984] Console: switching to colour frame buffer device 128x48
> [    8.296617]  sdi: sdi1 sdi2 < sdi5 >
> [    8.297757] sd 7:0:0:0: [sdi] Attached SCSI disk
> [    8.308524]  sdk: sdk1
> [    8.309383] sd 8:0:0:0: [sdk] Attached SCSI removable disk
> [    8.347243] sd 1:0:0:0: [sdj] Attached SCSI disk
> [    8.347297] sd 4:0:0:0: [sdn] Attached SCSI disk
> [    8.351272] sd 6:0:0:0: [sdp] Attached SCSI disk
> [    8.363233] sd 3:0:0:0: [sdm] Attached SCSI disk
> [    8.363238] sd 2:0:0:0: [sdl] Attached SCSI disk
> [    8.363255] sd 5:0:0:0: [sdo] Attached SCSI disk
> [    8.367539]  sdh: sdh1
> [    8.367546] sd 0:0:6:0: [sdg] Attached SCSI disk
> [    8.367942] sd 0:0:3:0: [sdd] Attached SCSI disk
> [    8.372468] sd 0:0:5:0: [sdf] Attached SCSI disk
> [    8.392994] sd 0:0:7:0: [sdh] Attached SCSI disk
> [    8.394909] sd 0:0:1:0: [sdb] Attached SCSI disk
> [    8.492086] sd 0:0:4:0: [sde] Write Protect is off
> [    8.492090] sd 0:0:4:0: [sde] Mode Sense: 7f 00 10 08
> [    8.496509] sd 0:0:4:0: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    8.609059] sd 0:0:4:0: [sde] Attached SCSI disk
> [    8.610854] sd 0:0:0:0: [sda] Write Protect is off
> [    8.610859] sd 0:0:0:0: [sda] Mode Sense: 7f 00 10 08
> [    8.621619] sd 0:0:2:0: [sdc] Write Protect is off
> [    8.621623] sd 0:0:2:0: [sdc] Mode Sense: 7f 00 10 08
> [    8.900925] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    8.913675] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    9.157502]  sda:
> [    9.337341] sd 0:0:0:0: [sda] Attached SCSI disk
> [    9.348279] sd 0:0:2:0: [sdc] Attached SCSI disk
> [    9.723181] raid6: avx2x4   gen() 36863 MB/s
> [    9.791188] raid6: avx2x4   xor() 12488 MB/s
> [    9.859180] raid6: avx2x2   gen() 36702 MB/s
> [    9.927178] raid6: avx2x2   xor() 21599 MB/s
> [    9.995192] raid6: avx2x1   gen() 32567 MB/s
> [   10.063180] raid6: avx2x1   xor() 18129 MB/s
> [   10.131180] raid6: sse2x4   gen() 20178 MB/s
> [   10.199179] raid6: sse2x4   xor() 10679 MB/s
> [   10.267180] raid6: sse2x2   gen() 19345 MB/s
> [   10.335180] raid6: sse2x2   xor() 12409 MB/s
> [   10.403180] raid6: sse2x1   gen() 16885 MB/s
> [   10.471194] raid6: sse2x1   xor() 10372 MB/s
> [   10.471195] raid6: using algorithm avx2x4 gen() 36863 MB/s
> [   10.471196] raid6: .... xor() 12488 MB/s, rmw enabled
> [   10.471197] raid6: using avx2x2 recovery algorithm
> [   10.472009] xor: automatically using best checksumming function   avx       
> [   10.472632] async_tx: api initialized (async)
> [   11.271397] Btrfs loaded, crc32c=crc32c-intel, zoned=yes
> [   11.472827] BTRFS: device fsid c8557a6e-4b51-44f1-ba8f-75fce8c7dfcd devid 1 transid 445286 /dev/sdh1 scanned by btrfs (503)
> [   11.472906] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 20 transid 4983709 /dev/sdc scanned by btrfs (503)
> [   11.472983] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 14 transid 4983709 /dev/sda scanned by btrfs (503)
> [   11.473100] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 17 transid 4983709 /dev/sde scanned by btrfs (503)
> [   11.473182] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 9 transid 4983709 /dev/sdd scanned by btrfs (503)
> [   11.473355] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 18 transid 4983709 /dev/sdm scanned by btrfs (503)
> [   11.473726] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 4 transid 4983709 /dev/sdf scanned by btrfs (503)
> [   11.473811] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 12 transid 4983709 /dev/sdb scanned by btrfs (503)
> [   11.474066] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 7 transid 4983709 /dev/sdg scanned by btrfs (503)
> [   11.474148] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 5 transid 4983709 /dev/sdj scanned by btrfs (503)
> [   11.474240] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 10 transid 4983709 /dev/sdp scanned by btrfs (503)
> [   11.474332] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 21 transid 4983709 /dev/sdo scanned by btrfs (503)
> [   11.474538] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 11 transid 4983709 /dev/sdl scanned by btrfs (503)
> [   11.474712] BTRFS: device fsid 48ed8a66-731d-499b-829e-dd07dd7260cc devid 15 transid 4983709 /dev/sdn scanned by btrfs (503)
> [   11.478785] process '/bin/fstype' started with executable stack
> [   11.527163] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> [   11.775351] pstore: crypto_comp_decompress failed, ret = -22!
> [   11.778606] systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> [   11.795440] systemd[1]: Detected architecture x86-64.
> [   11.815724] systemd[1]: Set hostname to <butter-server>.
> [   11.990475] systemd[1]: Reached target Libvirt guests shutdown.
> [   11.990933] systemd[1]: Created slice System Slice.
> [   11.991008] systemd[1]: Listening on Journal Socket.
> [   11.991591] systemd[1]: Mounting POSIX Message Queue File System...
> [   11.993730] systemd[1]: Starting Set the console keyboard layout...
> [   11.993755] systemd[1]: Reached target System Time Synchronized.
> [   11.993782] systemd[1]: Reached target User and Group Name Lookups.
> [   12.032866] EXT4-fs (dm-0): re-mounted. Opts: errors=remount-ro. Quota mode: none.
> [   12.033271] Loading iSCSI transport class v2.0-870.
> [   12.042993] iscsi: registered transport (tcp)
> [   12.106540] systemd-journald[594]: Received request to flush runtime journal from PID 1
> [   12.108520] iscsi: registered transport (iser)
> [   12.395891] IPMI message handler: version 39.2
> [   12.397431] ipmi device interface
> [   12.400293] ipmi_si: IPMI System Interface driver
> [   12.400310] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> [   12.400314] ipmi_platform: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
> [   12.400317] ipmi_si: Adding SMBIOS-specified kcs state machine
> [   12.401280] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
> [   12.401464] ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca2] regsize 1 spacing 1 irq 0
> [   12.407030] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
> [   12.407034] ipmi_si: Adding ACPI-specified kcs state machine
> [   12.407087] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x0, irq 0
> [   12.443948] EDAC MC0: Giving out device to module ie31200_edac controller IE31200: DEV 0000:00:00.0 (POLLED)
> [   12.447781] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
> [   12.523628] ACPI Warning: SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000187F (\PMIO) (20210105/utaddress-204)
> [   12.523638] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> [   12.523647] ACPI Warning: SystemIO range 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20210105/utaddress-204)
> [   12.523651] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> [   12.523653] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20210105/utaddress-204)
> [   12.523657] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20210105/utaddress-204)
> [   12.523660] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> [   12.523662] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20210105/utaddress-204)
> [   12.523666] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20210105/utaddress-204)
> [   12.523670] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> [   12.523670] lpc_ich: Resource conflict(s) found affecting gpio_ich
> [   12.674412] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> [   12.674415] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [   12.674416] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   12.674417] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   12.719323] ipmi_si IPI0001:00: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
> [   12.772517] intel_rapl_common: Found RAPL domain package
> [   12.772520] intel_rapl_common: Found RAPL domain core
> [   12.772522] intel_rapl_common: Found RAPL domain dram
> [   12.797828] ipmi_si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x002a7c, prod_id: 0x0811, dev_id: 0x20)
> [   12.817112] ipmi_si IPI0001:00: IPMI kcs interface initialized
> [   12.820234] loop0: detected capacity change from 0 to 173784
> [   12.851985] BTRFS info (device sdh1): force zstd compression, level 9
> [   12.851991] BTRFS info (device sdh1): using free space tree
> [   12.851993] BTRFS info (device sdh1): has skinny extents
> [   12.855491] loop1: detected capacity change from 0 to 126408
> [   12.857780] ipmi_ssif: IPMI SSIF Interface driver
> [   12.883406] loop2: detected capacity change from 0 to 126424
> [   12.915318] loop3: detected capacity change from 0 to 65744
> [   12.955474] loop4: detected capacity change from 0 to 113504
> [   12.967194] Adding 785916k swap on /dev/mapper/cryptswap1.  Priority:-2 extents:1 across:785916k FS
> [   12.987336] loop5: detected capacity change from 0 to 66104
> [   13.023497] loop6: detected capacity change from 0 to 238552
> [   13.055402] loop7: detected capacity change from 0 to 113560
> [   31.657712] audit: type=1400 audit(1624009388.002:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/lxc-start" pid=1620 comm="apparmor_parser"
> [   31.657789] audit: type=1400 audit(1624009388.002:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="docker-default" pid=1616 comm="apparmor_parser"
> [   31.658947] audit: type=1400 audit(1624009388.002:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ippusbxd" pid=1624 comm="apparmor_parser"
> [   31.659928] audit: type=1400 audit(1624009388.006:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=1621 comm="apparmor_parser"
> [   31.659933] audit: type=1400 audit(1624009388.006:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=1621 comm="apparmor_parser"
> [   31.659936] audit: type=1400 audit(1624009388.006:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=1621 comm="apparmor_parser"
> [   31.662475] audit: type=1400 audit(1624009388.006:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ntpd" pid=1626 comm="apparmor_parser"
> [   31.662778] audit: type=1400 audit(1624009388.006:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=1623 comm="apparmor_parser"
> [   31.662782] audit: type=1400 audit(1624009388.006:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=1623 comm="apparmor_parser"
> [   31.662993] audit: type=1400 audit(1624009388.006:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/libvirtd" pid=1625 comm="apparmor_parser"
> [   31.867464] new mount options do not match the existing superblock, will be ignored
> [   32.081874] Bluetooth: Core ver 2.22
> [   32.081898] NET: Registered protocol family 31
> [   32.081899] Bluetooth: HCI device and connection manager initialized
> [   32.081902] Bluetooth: HCI socket layer initialized
> [   32.081903] Bluetooth: L2CAP socket layer initialized
> [   32.081905] Bluetooth: SCO socket layer initialized
> [   32.172393] cgroup: Unknown subsys name '__DEVEL__sane_behavior'
> [   32.288464] cgroup: Unknown subsys name '__DEVEL__sane_behavior'
> [   32.411301] cgroup: Unknown subsys name '__DEVEL__sane_behavior'
> [   32.522503] cgroup: Unknown subsys name '__DEVEL__sane_behavior'
> [   32.798887] cgroup: Unknown subsys name '__DEVEL__sane_behavior'
> [   32.803541] loop8: detected capacity change from 0 to 8
> [   36.936199] e1000e 0000:00:19.0 eno2: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [   36.936261] IPv6: ADDRCONF(NETDEV_CHANGE): eno2: link becomes ready
> [   40.479889] Guest personality initialized and is inactive
> [   40.479931] VMCI host device registered (name=vmci, major=10, minor=122)
> [   40.479932] Initialized host personality
> [   40.499995] NET: Registered protocol family 40
> [   41.128504] ppdev: user-space parallel port driver
> [   41.588683] bpfilter: Loaded bpfilter_umh pid 2411
> [   41.589419] Started bpfilter
> [   42.120291] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> [   42.123153] virbr0: port 1(virbr0-nic) entered blocking state
> [   42.123197] virbr0: port 1(virbr0-nic) entered disabled state
> [   42.123514] device virbr0-nic entered promiscuous mode
> [   42.629997] virbr0: port 1(virbr0-nic) entered blocking state
> [   42.630015] virbr0: port 1(virbr0-nic) entered listening state
> [   42.760536] virbr0: port 1(virbr0-nic) entered disabled state
> [   42.959995] Bridge firewalling registered
> [   43.080457] Initializing XFRM netlink socket
> [   43.456862] docker0: port 1(vethdd08de1) entered blocking state
> [   43.456880] docker0: port 1(vethdd08de1) entered disabled state
> [   43.457400] device vethdd08de1 entered promiscuous mode
> [   43.458207] docker0: port 1(vethdd08de1) entered blocking state
> [   43.458221] docker0: port 1(vethdd08de1) entered forwarding state
> [   43.458414] docker0: port 1(vethdd08de1) entered disabled state
> [   43.535985] docker0: port 2(veth6fb8a4e) entered blocking state
> [   43.536004] docker0: port 2(veth6fb8a4e) entered disabled state
> [   43.537666] device veth6fb8a4e entered promiscuous mode
> [   43.538712] docker0: port 2(veth6fb8a4e) entered blocking state
> [   43.538726] docker0: port 2(veth6fb8a4e) entered forwarding state
> [   43.539953] IPv6: ADDRCONF(NETDEV_CHANGE): docker0: link becomes ready
> [   43.540397] docker0: port 2(veth6fb8a4e) entered disabled state
> [   43.636643] docker0: port 3(veth7379b46) entered blocking state
> [   43.636662] docker0: port 3(veth7379b46) entered disabled state
> [   43.639676] device veth7379b46 entered promiscuous mode
> [   43.642360] docker0: port 3(veth7379b46) entered blocking state
> [   43.642377] docker0: port 3(veth7379b46) entered forwarding state
> [   43.663380] docker0: port 4(veth873b75c) entered blocking state
> [   43.663398] docker0: port 4(veth873b75c) entered disabled state
> [   43.663750] device veth873b75c entered promiscuous mode
> [   43.664265] docker0: port 4(veth873b75c) entered blocking state
> [   43.664279] docker0: port 4(veth873b75c) entered forwarding state
> [   43.813660] docker0: port 5(veth73ccc24) entered blocking state
> [   43.813677] docker0: port 5(veth73ccc24) entered disabled state
> [   43.814036] device veth73ccc24 entered promiscuous mode
> [   43.814461] docker0: port 5(veth73ccc24) entered blocking state
> [   43.814474] docker0: port 5(veth73ccc24) entered forwarding state
> [   43.940104] docker0: port 6(veth9e0ce31) entered blocking state
> [   43.940123] docker0: port 6(veth9e0ce31) entered disabled state
> [   43.940345] device veth9e0ce31 entered promiscuous mode
> [   43.940682] docker0: port 6(veth9e0ce31) entered blocking state
> [   43.940695] docker0: port 6(veth9e0ce31) entered forwarding state
> [   44.133473] cgroup: cgroup: disabling cgroup2 socket matching due to net_prio or net_cls activation
> [   44.151642] docker0: port 3(veth7379b46) entered disabled state
> [   44.151807] docker0: port 4(veth873b75c) entered disabled state
> [   44.152076] docker0: port 5(veth73ccc24) entered disabled state
> [   44.152199] docker0: port 6(veth9e0ce31) entered disabled state
> [   44.243353] docker0: port 4(veth873b75c) entered disabled state
> [   44.272571] device veth873b75c left promiscuous mode
> [   44.272601] docker0: port 4(veth873b75c) entered disabled state
> [   44.892642] eth0: renamed from veth82712ff
> [   44.920700] IPv6: ADDRCONF(NETDEV_CHANGE): vethdd08de1: link becomes ready
> [   44.920847] docker0: port 1(vethdd08de1) entered blocking state
> [   44.920861] docker0: port 1(vethdd08de1) entered forwarding state
> [   44.998308] eth0: renamed from veth52f4820
> [   45.028340] IPv6: ADDRCONF(NETDEV_CHANGE): veth73ccc24: link becomes ready
> [   45.028457] docker0: port 5(veth73ccc24) entered blocking state
> [   45.028468] docker0: port 5(veth73ccc24) entered forwarding state
> [   45.114770] eth0: renamed from veth865bf50
> [   45.189431] eth0: renamed from veth89f9068
> [   45.219694] IPv6: ADDRCONF(NETDEV_CHANGE): veth7379b46: link becomes ready
> [   45.219803] docker0: port 3(veth7379b46) entered blocking state
> [   45.219818] docker0: port 3(veth7379b46) entered forwarding state
> [   45.220768] IPv6: ADDRCONF(NETDEV_CHANGE): veth6fb8a4e: link becomes ready
> [   45.220891] docker0: port 2(veth6fb8a4e) entered blocking state
> [   45.220907] docker0: port 2(veth6fb8a4e) entered forwarding state
> [   45.257748] eth0: renamed from veth4288ee4
> [   45.283933] IPv6: ADDRCONF(NETDEV_CHANGE): veth9e0ce31: link becomes ready
> [   45.284070] docker0: port 6(veth9e0ce31) entered blocking state
> [   45.284083] docker0: port 6(veth9e0ce31) entered forwarding state
> [  326.019174] docker0: port 3(veth7379b46) entered disabled state
> [  326.019449] veth865bf50: renamed from eth0
> [  326.099778] docker0: port 3(veth7379b46) entered disabled state
> [  326.106098] device veth7379b46 left promiscuous mode
> [  326.106114] docker0: port 3(veth7379b46) entered disabled state
> [  329.469884] docker0: port 6(veth9e0ce31) entered disabled state
> [  329.470073] veth4288ee4: renamed from eth0
> [  329.553541] docker0: port 6(veth9e0ce31) entered disabled state
> [  329.559530] device veth9e0ce31 left promiscuous mode
> [  329.559548] docker0: port 6(veth9e0ce31) entered disabled state
> [  331.436622] docker0: port 1(vethdd08de1) entered disabled state
> [  331.436808] veth82712ff: renamed from eth0
> [  331.517034] docker0: port 1(vethdd08de1) entered disabled state
> [  331.523807] device vethdd08de1 left promiscuous mode
> [  331.523825] docker0: port 1(vethdd08de1) entered disabled state
> [  331.666827] docker0: port 2(veth6fb8a4e) entered disabled state
> [  331.667020] veth89f9068: renamed from eth0
> [  331.735130] docker0: port 2(veth6fb8a4e) entered disabled state
> [  331.744454] device veth6fb8a4e left promiscuous mode
> [  331.744474] docker0: port 2(veth6fb8a4e) entered disabled state
> [  334.695979] docker0: port 5(veth73ccc24) entered disabled state
> [  334.696214] veth52f4820: renamed from eth0
> [  334.759361] docker0: port 5(veth73ccc24) entered disabled state
> [  334.766567] device veth73ccc24 left promiscuous mode
> [  334.766585] docker0: port 5(veth73ccc24) entered disabled state
> [  446.332179] BTRFS info (device sdf): has skinny extents
> [  460.053212] BTRFS info (device sdf): bdev /dev/sdf errs: wr 1298641, rd 7847, flush 5, corrupt 13, gen 0
> [  460.053234] BTRFS info (device sdf): bdev /dev/sdj errs: wr 0, rd 0, flush 0, corrupt 231, gen 0
> [  460.053245] BTRFS info (device sdf): bdev /dev/sdg errs: wr 957680, rd 477125, flush 3, corrupt 51358, gen 719
> [  460.053255] BTRFS info (device sdf): bdev /dev/sdd errs: wr 3620417, rd 304456, flush 8, corrupt 164, gen 0
> [  460.053264] BTRFS info (device sdf): bdev /dev/sdp errs: wr 0, rd 0, flush 0, corrupt 271, gen 0
> [  460.053272] BTRFS info (device sdf): bdev /dev/sdl errs: wr 0, rd 0, flush 0, corrupt 404, gen 0
> [  460.053279] BTRFS info (device sdf): bdev /dev/sdb errs: wr 0, rd 0, flush 0, corrupt 111, gen 0
> [  460.053287] BTRFS info (device sdf): bdev /dev/sda errs: wr 0, rd 0, flush 0, corrupt 553, gen 0
> [  460.053295] BTRFS info (device sdf): bdev /dev/sdn errs: wr 0, rd 0, flush 0, corrupt 1613, gen 0
> [  460.053302] BTRFS info (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0, corrupt 369, gen 0
> [  460.053310] BTRFS info (device sdf): bdev /dev/sdm errs: wr 0, rd 0, flush 0, corrupt 175, gen 0
> [  460.053317] BTRFS info (device sdf): bdev /dev/sdc errs: wr 0, rd 0, flush 0, corrupt 1663, gen 0
> [  460.053325] BTRFS info (device sdf): bdev /dev/sdo errs: wr 189088938, rd 10028589, flush 0, corrupt 1037856, gen 698
> [  814.681305] BTRFS info (device sdf): balance: resume skipped
> [  814.681321] BTRFS info (device sdf): checking UUID tree
> [ 1043.993509] BTRFS error (device sdf): allocation failed flags 1028, wanted 16384 tree-log 0
> [ 1043.993620] BTRFS info (device sdf): space_info 4 has 18446744073171730432 free, is full
> [ 1043.993628] BTRFS info (device sdf): space_info total=70866960384, used=70466371584, pinned=49840128, reserved=350748672, may_use=537821184, readonly=0 zone_unusable=0
> [ 1043.993636] BTRFS info (device sdf): global_block_rsv: size 536870912 reserved 535183360
> [ 1043.993641] BTRFS info (device sdf): trans_block_rsv: size 0 reserved 0
> [ 1043.993645] BTRFS info (device sdf): chunk_block_rsv: size 786432 reserved 786432
> [ 1043.993649] BTRFS info (device sdf): delayed_block_rsv: size 524288 reserved 524288
> [ 1043.993653] BTRFS info (device sdf): delayed_refs_rsv: size 25321537536 reserved 0
> [ 1043.994302] BTRFS info (device sdf): block group 365483067637760 has 1073741824 bytes, 1073053696 used 262144 pinned 425984 reserved 0 zone_unusable 
> [ 1043.994310] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994313] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994318] BTRFS info (device sdf): block group 365484141379584 has 1073741824 bytes, 1065582592 used 212992 pinned 7946240 reserved 0 zone_unusable 
> [ 1043.994324] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994327] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994330] BTRFS info (device sdf): block group 365485248675840 has 1073741824 bytes, 1068433408 used 262144 pinned 5046272 reserved 0 zone_unusable 
> [ 1043.994335] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994338] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994341] BTRFS info (device sdf): block group 365486322417664 has 1073741824 bytes, 1071448064 used 16384 pinned 2277376 reserved 0 zone_unusable 
> [ 1043.994347] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994349] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994353] BTRFS info (device sdf): block group 365487396159488 has 1073741824 bytes, 1072267264 used 49152 pinned 1425408 reserved 0 zone_unusable 
> [ 1043.994358] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994361] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994364] BTRFS info (device sdf): block group 365488469901312 has 1073741824 bytes, 1068187648 used 229376 pinned 5324800 reserved 0 zone_unusable 
> [ 1043.994369] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994372] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994375] BTRFS info (device sdf): block group 365489543643136 has 1073741824 bytes, 1072152576 used 32768 pinned 1556480 reserved 0 zone_unusable 
> [ 1043.994380] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994383] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994386] BTRFS info (device sdf): block group 365490617384960 has 1073741824 bytes, 1073315840 used 49152 pinned 376832 reserved 0 zone_unusable 
> [ 1043.994391] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994394] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994397] BTRFS info (device sdf): block group 365491691126784 has 1073741824 bytes, 1071218688 used 49152 pinned 2473984 reserved 0 zone_unusable 
> [ 1043.994403] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994405] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994409] BTRFS info (device sdf): block group 365492764868608 has 1073741824 bytes, 1072939008 used 229376 pinned 573440 reserved 0 zone_unusable 
> [ 1043.994414] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994417] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994420] BTRFS info (device sdf): block group 365493838610432 has 1073741824 bytes, 1072594944 used 245760 pinned 901120 reserved 0 zone_unusable 
> [ 1043.994425] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994428] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994431] BTRFS info (device sdf): block group 365494912352256 has 1073741824 bytes, 1072037888 used 212992 pinned 1490944 reserved 0 zone_unusable 
> [ 1043.994436] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994439] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994442] BTRFS info (device sdf): block group 365495986094080 has 1073741824 bytes, 1072414720 used 393216 pinned 933888 reserved 0 zone_unusable 
> [ 1043.994447] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994450] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994453] BTRFS info (device sdf): block group 365497059835904 has 1073741824 bytes, 1072955392 used 196608 pinned 589824 reserved 0 zone_unusable 
> [ 1043.994459] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994461] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994464] BTRFS info (device sdf): block group 365498133577728 has 1073741824 bytes, 1071857664 used 262144 pinned 1622016 reserved 0 zone_unusable 
> [ 1043.994470] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994473] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994476] BTRFS info (device sdf): block group 365499207319552 has 1073741824 bytes, 1072414720 used 212992 pinned 1114112 reserved 0 zone_unusable 
> [ 1043.994481] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994484] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994487] BTRFS info (device sdf): block group 365500281061376 has 1073741824 bytes, 1072316416 used 98304 pinned 1327104 reserved 0 zone_unusable 
> [ 1043.994492] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994495] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994498] BTRFS info (device sdf): block group 365501354803200 has 1073741824 bytes, 1071136768 used 49152 pinned 2555904 reserved 0 zone_unusable 
> [ 1043.994504] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994506] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994510] BTRFS info (device sdf): block group 365502428545024 has 1073741824 bytes, 1073217536 used 180224 pinned 344064 reserved 0 zone_unusable 
> [ 1043.994515] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994518] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994521] BTRFS info (device sdf): block group 365503502286848 has 1073741824 bytes, 1072513024 used 196608 pinned 1032192 reserved 0 zone_unusable 
> [ 1043.994526] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994529] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994532] BTRFS info (device sdf): block group 365504576028672 has 1073741824 bytes, 1072660480 used 131072 pinned 950272 reserved 0 zone_unusable 
> [ 1043.994537] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994540] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994543] BTRFS info (device sdf): block group 365505649770496 has 1073741824 bytes, 1071611904 used 131072 pinned 1998848 reserved 0 zone_unusable 
> [ 1043.994549] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994551] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994555] BTRFS info (device sdf): block group 365506723512320 has 1073741824 bytes, 1072021504 used 311296 pinned 1409024 reserved 0 zone_unusable 
> [ 1043.994560] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994563] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994566] BTRFS info (device sdf): block group 365507797254144 has 1073741824 bytes, 1071923200 used 98304 pinned 1720320 reserved 0 zone_unusable 
> [ 1043.994571] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994574] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994577] BTRFS info (device sdf): block group 365508870995968 has 1073741824 bytes, 1071104000 used 409600 pinned 2228224 reserved 0 zone_unusable 
> [ 1043.994582] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994585] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994588] BTRFS info (device sdf): block group 365509944737792 has 1073741824 bytes, 1070792704 used 622592 pinned 2326528 reserved 0 zone_unusable 
> [ 1043.994593] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994596] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994599] BTRFS info (device sdf): block group 365511018479616 has 1073741824 bytes, 1070776320 used 507904 pinned 2457600 reserved 0 zone_unusable 
> [ 1043.994604] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994607] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994610] BTRFS info (device sdf): block group 365512092221440 has 1073741824 bytes, 1068171264 used 1294336 pinned 4276224 reserved 0 zone_unusable 
> [ 1043.994616] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994619] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994622] BTRFS info (device sdf): block group 365513165963264 has 1073741824 bytes, 1071546368 used 2129920 pinned 65536 reserved 0 zone_unusable 
> [ 1043.994628] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994630] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994633] BTRFS info (device sdf): block group 365514239705088 has 1073741824 bytes, 1072316416 used 1114112 pinned 311296 reserved 0 zone_unusable 
> [ 1043.994639] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994642] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994645] BTRFS info (device sdf): block group 365515313446912 has 1073741824 bytes, 1072398336 used 835584 pinned 507904 reserved 0 zone_unusable 
> [ 1043.994650] BTRFS info (device sdf): block group has cluster?: no
> [ 1043.994653] BTRFS info (device sdf): 0 blocks of free space at or bigger than bytes is
> [ 1043.994674] ------------[ cut here ]------------
> [ 1043.994676] BTRFS: Transaction aborted (error -28)
> [ 1043.994739] WARNING: CPU: 7 PID: 11673 at fs/btrfs/block-group.c:2721 btrfs_start_dirty_block_groups+0x48c/0x4f0 [btrfs]
> [ 1043.994912] Modules linked in: xt_mark xt_nat veth nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bpfilter ppdev parport_pc parport vmw_vsock_vmci_transport vsock vmw_vmci overlay bluetooth ecdh_generic ecc msr binfmt_misc joydev input_leds ipmi_ssif dm_crypt intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm rapl intel_cstate intel_pch_thermal lpc_ich mei_me mei ie31200_edac acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler mac_hid acpi_pad sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1
> [ 1043.995121]  raid0 multipath linear dm_mirror dm_region_hash dm_log hid_generic usbhid hid uas usb_storage ast drm_vram_helper drm_ttm_helper ttm crct10dif_pclmul drm_kms_helper crc32_pclmul ghash_clmulni_intel aesni_intel syscopyarea sysfillrect sysimgblt fb_sys_fops crypto_simd ahci cec cryptd rc_core libahci mpt3sas igb drm dca xhci_pci raid_class e1000e i2c_algo_bit scsi_transport_sas xhci_pci_renesas video
> [ 1043.995272] CPU: 7 PID: 11673 Comm: snapperd Not tainted 5.12.11-051211-generic #202106161201
> [ 1043.995282] Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 3.0 04/24/2015
> [ 1043.995289] RIP: 0010:btrfs_start_dirty_block_groups+0x48c/0x4f0 [btrfs]
> [ 1043.995459] Code: 8b 53 50 f0 48 0f ba aa 48 0a 00 00 03 72 20 83 f8 fb 74 46 83 f8 e2 74 41 89 c6 48 c7 c7 e0 1a 85 c0 89 45 8c e8 57 99 9c e9 <0f> 0b 8b 45 8c 89 c1 ba a1 0a 00 00 48 89 df 89 45 8c 48 c7 c6 00
> [ 1043.995466] RSP: 0018:ffffb8ba424c3bf8 EFLAGS: 00010282
> [ 1043.995474] RAX: 0000000000000000 RBX: ffff89af68c460d0 RCX: ffff89b57fdd85c8
> [ 1043.995478] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff89b57fdd85c0
> [ 1043.995482] RBP: ffffb8ba424c3c70 R08: 0000000000000000 R09: ffffb8ba424c39d8
> [ 1043.995489] R10: ffffb8ba424c39d0 R11: ffffffffab5542e8 R12: ffff89af9b305000
> [ 1043.995493] R13: ffff89af9b305170 R14: ffff89af06973000 R15: ffff89af9b305160
> [ 1043.995498] FS:  00007f5f18556700(0000) GS:ffff89b57fdc0000(0000) knlGS:0000000000000000
> [ 1043.995503] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1043.995507] CR2: 00007fdb1af228a0 CR3: 000000027477a002 CR4: 00000000001706e0
> [ 1043.995513] Call Trace:
> [ 1043.995521]  btrfs_commit_transaction+0x7ff/0xa20 [btrfs]
> [ 1043.995640]  ? start_transaction+0xd5/0x590 [btrfs]
> [ 1043.995751]  create_snapshot+0x1bb/0x270 [btrfs]
> [ 1043.995894]  btrfs_mksubvol+0x112/0x1f0 [btrfs]
> [ 1043.996037]  btrfs_mksnapshot+0x80/0xb0 [btrfs]
> [ 1043.996178]  __btrfs_ioctl_snap_create+0x176/0x180 [btrfs]
> [ 1043.996320]  btrfs_ioctl_snap_create_v2+0xc0/0x150 [btrfs]
> [ 1043.996462]  btrfs_ioctl+0x93c/0x970 [btrfs]
> [ 1043.996603]  ? __cond_resched+0x1a/0x50
> [ 1043.996614]  __x64_sys_ioctl+0x91/0xc0
> [ 1043.996623]  do_syscall_64+0x38/0x90
> [ 1043.996630]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1043.996640] RIP: 0033:0x7f5f1db09317
> [ 1043.996647] Code: b3 66 90 48 8b 05 71 4b 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4b 2d 00 f7 d8 64 89 01 48
> [ 1043.996653] RSP: 002b:00007f5f185532c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [ 1043.996660] RAX: ffffffffffffffda RBX: 00007f5f185532d0 RCX: 00007f5f1db09317
> [ 1043.996664] RDX: 00007f5f185532d0 RSI: 0000000050009417 RDI: 0000000000000007
> [ 1043.996668] RBP: 0000000000000006 R08: 000000000000000f R09: 00007f5f18554f84
> [ 1043.996671] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
> [ 1043.996675] R13: 00007f5f18555450 R14: 0000000000000000 R15: 0000000000000001
> [ 1043.996683] ---[ end trace 84d7b5fe58817f91 ]---
> [ 1043.996689] BTRFS: error (device sdf) in btrfs_start_dirty_block_groups:2721: errno=-28 No space left
> [ 1044.014701] BTRFS error (device sdf): allocation failed flags 1028, wanted 16384 tree-log 0
> [ 1044.014835] BTRFS: error (device sdf) in __btrfs_free_extent:3216: errno=-28 No space left
> [ 1044.014918] BTRFS: error (device sdf) in btrfs_run_delayed_refs:2163: errno=-28 No space left

