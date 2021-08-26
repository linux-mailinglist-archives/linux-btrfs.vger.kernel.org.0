Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3573F85C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhHZKpA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 26 Aug 2021 06:45:00 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:57409 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233311AbhHZKo7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 06:44:59 -0400
X-Greylist: delayed 8792 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 06:44:58 EDT
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a4a:3500:d32b:79b5:9342:efb9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 11AA02ABCCB
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 12:44:08 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: It's broke, Jim. BTRFS mounted read only after corruption errors on Samsung 980 Pro
Date:   Thu, 26 Aug 2021 12:44:05 +0200
Message-ID: <2925925.e1IPqPlo5U@ananda>
In-Reply-To: <9070016.RUGz74dYir@ananda>
References: <9070016.RUGz74dYir@ananda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

Reposting without word wrapping. 

Could

[GIT PULL] Btrfs fix for 5.14-rc

https://lore.kernel.org/linux-btrfs/cover.1629897022.git.dsterba@suse.com/T/#u

be related to this issue?

One of the backtraces mention a kernel memory allocated failure that could be
related to compression.

Aug 26 09:06:00 ananda kernel: [45802.656848] general protection fault, probably for non-canonical address 0x950937986d3c192d: 0000 [#2] PREEMPT SMP NOPTI
Aug 26 09:06:00 ananda kernel: [45802.656858] CPU: 12 PID: 10155 Comm: kworker/u32:142 Tainted: G      D W   E     5.14.0-rc7-t14 #20
Aug 26 09:06:00 ananda kernel: [45802.656864] Hardware name: LENOVO 20UD0013GE/20UD0013GE, BIOS R1BET65W(1.34 ) 06/17/2021
Aug 26 09:06:00 ananda kernel: [45802.656868] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.656939] RIP: 0010:kmem_cache_alloc+0xf6/0x410
Aug 26 09:06:00 ananda kernel: [45802.656948] Code: 48 8b 70 08 48 39 f2 75 e7 48 83 78 10 00 4c 8b 20 0f 84 b2 02 00 00 4d 85 e4 0f 84 a9 02 00 00 8b 45 28 48 8b 7d 00 4c 01 e0 <48> 8b 18 48 33 9d b8 00 00 00 48 89 c1 48 0f c9 4c 89 e0 48 31 cb
Aug 26 09:06:00 ananda kernel: [45802.656954] RSP: 0018:ffffa9118c127ad8 EFLAGS: 00010286
Aug 26 09:06:00 ananda kernel: [45802.656959] RAX: 950937986d3c192d RBX: 0000000000000000 RCX: 00003d6feea0e960
Aug 26 09:06:00 ananda kernel: [45802.656963] RDX: 000000003323df0c RSI: 000000003323df0c RDI: 00003d6feea0e960
Aug 26 09:06:00 ananda kernel: [45802.656967] RBP: ffff8b9b08233a00 R08: ffffa9118c127d10 R09: ffff8b9fb9a54340
Aug 26 09:06:00 ananda kernel: [45802.656971] R10: 000000000000000f R11: ffff8ba1913327e0 R12: 950937986d3c18e5
Aug 26 09:06:00 ananda kernel: [45802.656975] R13: 0000000000000000 R14: 0000000000000d40 R15: ffffffffc0689076
Aug 26 09:06:00 ananda kernel: [45802.656980] FS:  0000000000000000(0000) GS:ffff8ba191300000(0000) knlGS:0000000000000000
Aug 26 09:06:00 ananda kernel: [45802.656985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 26 09:06:00 ananda kernel: [45802.656989] CR2: 00007f0fdf4e2014 CR3: 000000012e26e000 CR4: 0000000000350ee0
Aug 26 09:06:00 ananda kernel: [45802.656994] Call Trace:
Aug 26 09:06:00 ananda kernel: [45802.657000]  alloc_extent_map+0x16/0x60 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657071]  btrfs_drop_extent_cache+0x2f6/0x3f0 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657137]  btrfs_drop_extents+0x813/0xd20 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657199]  ? cow_file_range_inline.constprop.0+0x135/0x740 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657265]  ? join_transaction+0x12c/0x450 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657333]  cow_file_range_inline.constprop.0+0x4c6/0x740 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657397]  ? update_load_avg+0x531/0x5b0
Aug 26 09:06:00 ananda kernel: [45802.657405]  compress_file_range+0x1f3/0x830 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657467]  ? cpuacct_charge+0x32/0x80
Aug 26 09:06:00 ananda kernel: [45802.657475]  async_cow_start+0x12/0x30 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657538]  ? submit_compressed_extents+0x440/0x440 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657600]  btrfs_work_helper+0xdc/0x360 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657670]  process_one_work+0x1e3/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.657678]  worker_thread+0x50/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.657683]  ? process_one_work+0x3c0/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.657689]  kthread+0x132/0x160
Aug 26 09:06:00 ananda kernel: [45802.657694]  ? set_kthread_struct+0x40/0x40
Aug 26 09:06:00 ananda kernel: [45802.657699]  ret_from_fork+0x22/0x30

see below for all of the backtraces.


Martin Steigerwald - 22.08.21, 13:14:39 CEST:
> This might be a sequel of:
> 
> Corruption errors on Samsung 980 Pro
> 
> https://lore.kernel.org/linux-btrfs/2729231.WZja5ltl65@ananda/
> 
> As the checksum errors I had gone away after clearing the v2 space
> cache, I thought I can continue using this BTRFS filesystem. Maybe I
> was wrong about that.

see: https://lore.kernel.org/linux-btrfs/9070016.RUGz74dYir@ananda/

I was broke again. *sigh*

Hardware and software same as before. Except: kernel 5.14-rc7. Oh and one
thing I did not mention before: I am using kyber as io scheduler for that
2 TB Samsung 980 Pro SSD, not sure whether that matters.

Another kernel goes into unwillingness mode (see below) after resume from
hibernation. This time I scrubbed the home filesystem immediately. The scrub
was okay. Then I checked it and got:

[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
root 256 inode 144953 errors 200, dir isize wrong
root 256 inode 3829720 errors 1, no inode item
	unresolved ref dir 144953 index 3646 namelen 36 name agent_config_akonadi_imap_resource_8 filetype 1 errors 5, no dir item, no inode ref
	unresolved ref dir 144953 index 3650 namelen 36 name agent_config_akonadi_imap_resource_9 filetype 1 errors 5, no dir item, no inode ref
root 256 inode 3829724 errors 1, no inode item
	unresolved ref dir 144953 index 3654 namelen 36 name agent_config_akonadi_imap_resource_7 filetype 1 errors 5, no dir item, no inode ref
root 256 inode 3829725 errors 1, no inode item
	unresolved ref dir 144953 index 3656 namelen 36 name agent_config_akonadi_imap_resource_6 filetype 1 errors 5, no dir item, no inode ref
root 256 inode 3829727 errors 1, no inode item
	unresolved ref dir 144953 index 3657 namelen 41 name agent_config_akonadi_imap_resource_9.lock filetype 1 errors 5, no dir item, no inode ref
root 256 inode 3829731 errors 1, no inode item
	unresolved ref dir 144953 index 3660 namelen 41 name agent_config_akonadi_imap_resource_7.lock filetype 1 errors 5, no dir item, no inode ref
root 256 inode 3829733 errors 1, no inode item
	unresolved ref dir 144953 index 3663 namelen 41 name agent_config_akonadi_imap_resource_6.lock filetype 1 errors 5, no dir item, no inode ref
root 256 inode 3829735 errors 1, no inode item
	unresolved ref dir 144953 index 3666 namelen 41 name agent_config_akonadi_imap_resource_8.lock filetype 1 errors 5, no dir item, no inode ref
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/nvme/home
UUID: bbf23cc8-1a3e-44d1-b7a2-dd2ad1d6bbbf
found 226030166016 bytes used, error(s) found
total csum bytes: 218416176
total tree bytes: 2366423040
total fs tree bytes: 1832189952
total extent tree bytes: 256720896
btree space waste bytes: 372842673
file data blocks allocated: 877801508864
 referenced 236660666368


Then I tried to repair it:

enabling repair mode
WARNING:

	Do not use --repair unless you are advised to do so by a developer
	or an experienced user, and then only after having accepted that no
	fsck can successfully repair all types of filesystem corruption. Eg.
	some software or hardware bugs can fatally damage a volume.
	The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1

Heh, I am experienced after repairing and fixing all these other issues I
had recently, am I?

[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
Deleting bad dir index [144953,96,3646] root 256
Deleting bad dir index [144953,96,3650] root 256
Deleting bad dir index [144953,96,3654] root 256
Deleting bad dir index [144953,96,3656] root 256
Deleting bad dir index [144953,96,3657] root 256
Deleting bad dir index [144953,96,3660] root 256
Deleting bad dir index [144953,96,3663] root 256
Deleting bad dir index [144953,96,3666] root 256
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)

Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/nvme/home
UUID: bbf23cc8-1a3e-44d1-b7a2-dd2ad1d6bbbf
No device size related problem found
found 226030166016 bytes used, no error found
total csum bytes: 218416176
total tree bytes: 2366423040
total fs tree bytes: 1832189952
total extent tree bytes: 256720896
btree space waste bytes: 372842673
file data blocks allocated: 877801508864
 referenced 236660666368

This appears to have worked. Another run of btrfs check reported no errors.

Last time suspected XXHASH as the culprit, just a gut feeling. So I used
the standard crc32c. Cause I did not think of it I initially used space cache
v1. But I switched it to space cache v2 I think yesterday.

Anyway it can't be xxhash cause crc32c also causes trouble.

My current theory is this:

It happens that after resume from hibernation the kernel stops working
correcly. A few seconds till maybe a minute or two after hibernation. I
captured the backtraces in the log this time. See below.

There is some BTRFS backtrace, but it appears to be related to obtaining
kernel memory, and then also a general protection fault. I saw general
protection faults before already on this machine, but never anywhere else.

My idea now is if the kernel crashes while BTRFS likes to write something
BTRFS might not be consistent afterwards. I still think it shall survive
a sudden interruption when writting data even if the cause for that is a
kernel crash, but as Linux is a monolithic kernel, whatever has caused
the kernel mal function may affect BTRFS as well.

So what I will try next is to shutdown the machine after each day or just
keep it in standby and hope the battery will not take damage from it. In
other words I will aim at avoiding hibernation. Its hard for me. I use it
on all of my laptops and now I have the fastest laptop I ever had so far,
but I cannot seem to use it reliably anymore. The faster the laptop, the
faster it crashes if it does, so to say.

Any other ideas, theories, hints?

I hope BTRFS mailing list will dig this. KMail mail composer had issues with
the length of this. So here is the kernel output.

Aug 26 00:15:04 ananda kernel: [45756.216248] PM: hibernation: hibernation entry
Aug 26 09:05:31 ananda kernel: [45756.263028] Filesystems sync: 0.045 seconds
Aug 26 09:05:31 ananda kernel: [45756.263071] Freezing user space processes ... (elapsed 0.005 seconds) done.
Aug 26 09:05:31 ananda kernel: [45756.268450] OOM killer disabled.
Aug 26 09:05:31 ananda kernel: [45756.268861] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
Aug 26 09:05:31 ananda kernel: [45756.268869] PM: hibernation: Marking nosave pages: [mem 0x0009f000-0x000fffff]
Aug 26 09:05:31 ananda kernel: [45756.268873] PM: hibernation: Marking nosave pages: [mem 0x09c00000-0x09d00fff]
Aug 26 09:05:31 ananda kernel: [45756.268881] PM: hibernation: Marking nosave pages: [mem 0x09f00000-0x09f0ffff]
Aug 26 09:05:31 ananda kernel: [45756.268883] PM: hibernation: Marking nosave pages: [mem 0xb9595000-0xb9625fff]
Aug 26 09:05:31 ananda kernel: [45756.268888] PM: hibernation: Marking nosave pages: [mem 0xbd9de000-0xcc3fdfff]
Aug 26 09:05:31 ananda kernel: [45756.269516] PM: hibernation: Marking nosave pages: [mem 0xce000000-0xffffffff]
Aug 26 09:05:31 ananda kernel: [45756.270686] PM: hibernation: Basic memory bitmaps created
Aug 26 09:05:31 ananda kernel: [45756.276873] PM: hibernation: Preallocating image memory
Aug 26 09:05:31 ananda kernel: [45769.004684] PM: hibernation: Allocated 1405790 pages for snapshot
Aug 26 09:05:31 ananda kernel: [45769.004694] PM: hibernation: Allocated 5623160 kbytes in 12.72 seconds (442.07 MB/s)
Aug 26 09:05:31 ananda kernel: [45769.004701] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Aug 26 09:05:31 ananda kernel: [45769.006506] printk: Suspending console(s) (use no_console_suspend to debug)
Aug 26 09:05:31 ananda kernel: [45769.690884] [drm] free PSP TMR buffer
Aug 26 09:05:31 ananda kernel: [45769.719964] amdgpu 0000:07:00.0: amdgpu: MODE2 reset
Aug 26 09:05:31 ananda kernel: [45769.722250] ACPI: EC: interrupt blocked
Aug 26 09:05:31 ananda kernel: [45769.735733] ACPI: PM: Preparing to enter system sleep state S4
Aug 26 09:05:31 ananda kernel: [45769.846292] ACPI: EC: event blocked
Aug 26 09:05:31 ananda kernel: [45769.846294] ACPI: EC: EC stopped
Aug 26 09:05:31 ananda kernel: [45769.846295] ACPI: PM: Saving platform NVS memory
Aug 26 09:05:31 ananda kernel: [45769.884275] Disabling non-boot CPUs ...
Aug 26 09:05:31 ananda kernel: [45769.886498] smpboot: CPU 1 is now offline
Aug 26 09:05:31 ananda kernel: [45769.889467] smpboot: CPU 2 is now offline
Aug 26 09:05:31 ananda kernel: [45769.892473] smpboot: CPU 3 is now offline
Aug 26 09:05:31 ananda kernel: [45769.895505] smpboot: CPU 4 is now offline
Aug 26 09:05:31 ananda kernel: [45769.898459] smpboot: CPU 5 is now offline
Aug 26 09:05:31 ananda kernel: [45769.901328] smpboot: CPU 6 is now offline
Aug 26 09:05:31 ananda kernel: [45769.904257] smpboot: CPU 7 is now offline
Aug 26 09:05:31 ananda kernel: [45769.907357] smpboot: CPU 8 is now offline
Aug 26 09:05:31 ananda kernel: [45769.910590] smpboot: CPU 9 is now offline
Aug 26 09:05:31 ananda kernel: [45769.913315] smpboot: CPU 10 is now offline
Aug 26 09:05:31 ananda kernel: [45769.916179] smpboot: CPU 11 is now offline
Aug 26 09:05:31 ananda kernel: [45769.919104] smpboot: CPU 12 is now offline
Aug 26 09:05:31 ananda kernel: [45769.922253] smpboot: CPU 13 is now offline
Aug 26 09:05:31 ananda kernel: [45769.924673] smpboot: CPU 14 is now offline
Aug 26 09:05:31 ananda kernel: [45769.927077] smpboot: CPU 15 is now offline
Aug 26 09:05:31 ananda kernel: [45769.927990] PM: hibernation: Creating image:
Aug 26 09:05:31 ananda kernel: [45769.928567] PM: hibernation: Need to copy 1612339 pages
Aug 26 09:05:31 ananda kernel: [45769.928567] PM: hibernation: Normal pages needed: 1612339 + 1024, available pages: 6179572
Aug 26 09:05:31 ananda kernel: [45769.928567] ACPI: PM: Restoring platform NVS memory
Aug 26 09:05:31 ananda kernel: [45769.928567] ACPI: EC: EC started
Aug 26 09:05:31 ananda kernel: [45769.928567] LVT offset 0 assigned for vector 0x400
Aug 26 09:05:31 ananda kernel: [45769.928567] Enabling non-boot CPUs ...
Aug 26 09:05:31 ananda kernel: [45769.928567] x86: Booting SMP configuration:
Aug 26 09:05:31 ananda kernel: [45769.928567] smpboot: Booting Node 0 Processor 1 APIC 0x1
Aug 26 09:05:31 ananda kernel: [45769.886313] microcode: CPU1: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.928567] ACPI: \_SB_.PLTF.C001: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.928567] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.928567] CPU1 is up
Aug 26 09:05:31 ananda kernel: [45769.928567] smpboot: Booting Node 0 Processor 2 APIC 0x2
Aug 26 09:05:31 ananda kernel: [45769.928567] microcode: CPU2: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.928887] ACPI: \_SB_.PLTF.C002: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.928896] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.929104] CPU2 is up
Aug 26 09:05:31 ananda kernel: [45769.929123] smpboot: Booting Node 0 Processor 3 APIC 0x3
Aug 26 09:05:31 ananda kernel: [45769.928751] microcode: CPU3: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.929489] ACPI: \_SB_.PLTF.C003: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.929497] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.929721] CPU3 is up
Aug 26 09:05:31 ananda kernel: [45769.929737] smpboot: Booting Node 0 Processor 4 APIC 0x4
Aug 26 09:05:31 ananda kernel: [45769.929347] microcode: CPU4: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.932781] ACPI: \_SB_.PLTF.C004: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.932790] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.933033] CPU4 is up
Aug 26 09:05:31 ananda kernel: [45769.933065] smpboot: Booting Node 0 Processor 5 APIC 0x5
Aug 26 09:05:31 ananda kernel: [45769.932643] microcode: CPU5: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.933426] ACPI: \_SB_.PLTF.C005: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.933434] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.933723] CPU5 is up
Aug 26 09:05:31 ananda kernel: [45769.933764] smpboot: Booting Node 0 Processor 6 APIC 0x6
Aug 26 09:05:31 ananda kernel: [45769.933285] microcode: CPU6: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.934108] ACPI: \_SB_.PLTF.C006: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.934117] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.934378] CPU6 is up
Aug 26 09:05:31 ananda kernel: [45769.934394] smpboot: Booting Node 0 Processor 7 APIC 0x7
Aug 26 09:05:31 ananda kernel: [45769.933964] microcode: CPU7: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.934853] ACPI: \_SB_.PLTF.C007: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.934862] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.935148] CPU7 is up
Aug 26 09:05:31 ananda kernel: [45769.935184] smpboot: Booting Node 0 Processor 8 APIC 0x8
Aug 26 09:05:31 ananda kernel: [45769.934788] microcode: CPU8: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.935456] ACPI: \_SB_.PLTF.C008: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.935462] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.935656] CPU8 is up
Aug 26 09:05:31 ananda kernel: [45769.935695] smpboot: Booting Node 0 Processor 9 APIC 0x9
Aug 26 09:05:31 ananda kernel: [45769.935356] microcode: CPU9: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.936008] ACPI: \_SB_.PLTF.C009: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.936015] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.936199] CPU9 is up
Aug 26 09:05:31 ananda kernel: [45769.936215] smpboot: Booting Node 0 Processor 10 APIC 0xa
Aug 26 09:05:31 ananda kernel: [45769.935882] microcode: CPU10: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.936491] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.936498] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.936704] CPU10 is up
Aug 26 09:05:31 ananda kernel: [45769.936720] smpboot: Booting Node 0 Processor 11 APIC 0xb
Aug 26 09:05:31 ananda kernel: [45769.936382] microcode: CPU11: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.937038] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.937045] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.937246] CPU11 is up
Aug 26 09:05:31 ananda kernel: [45769.937261] smpboot: Booting Node 0 Processor 12 APIC 0xc
Aug 26 09:05:31 ananda kernel: [45769.936898] microcode: CPU12: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.937658] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.937666] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.938001] CPU12 is up
Aug 26 09:05:31 ananda kernel: [45769.938017] smpboot: Booting Node 0 Processor 13 APIC 0xd
Aug 26 09:05:31 ananda kernel: [45769.937476] microcode: CPU13: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.938445] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.938453] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.938835] CPU13 is up
Aug 26 09:05:31 ananda kernel: [45769.938861] smpboot: Booting Node 0 Processor 14 APIC 0xe
Aug 26 09:05:31 ananda kernel: [45769.938260] microcode: CPU14: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.939240] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.939249] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.939625] CPU14 is up
Aug 26 09:05:31 ananda kernel: [45769.939652] smpboot: Booting Node 0 Processor 15 APIC 0xf
Aug 26 09:05:31 ananda kernel: [45769.939085] microcode: CPU15: patch_level=0x08600106
Aug 26 09:05:31 ananda kernel: [45769.940092] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
Aug 26 09:05:31 ananda kernel: [45769.940101] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:05:31 ananda kernel: [45769.940489] CPU15 is up
Aug 26 09:05:31 ananda kernel: [45769.946706] ACPI: PM: Waking up from system sleep state S4
Aug 26 09:05:31 ananda kernel: [45769.971307] ACPI: EC: interrupt unblocked
Aug 26 09:05:31 ananda kernel: [45770.132518] ACPI: EC: event unblocked
Aug 26 09:05:31 ananda kernel: [45770.133069] usb usb1: root hub lost power or was reset
Aug 26 09:05:31 ananda kernel: [45770.133107] pci 0000:00:00.2: can't derive routing for PCI INT A
Aug 26 09:05:31 ananda kernel: [45770.133111] pci 0000:00:00.2: PCI INT A: no GSI
Aug 26 09:05:31 ananda kernel: [45770.133449] usb usb2: root hub lost power or was reset
Aug 26 09:05:31 ananda kernel: [45770.133455] usb usb3: root hub lost power or was reset
Aug 26 09:05:31 ananda kernel: [45770.133488] usb usb4: root hub lost power or was reset
Aug 26 09:05:31 ananda kernel: [45770.133494] usb usb5: root hub lost power or was reset
Aug 26 09:05:31 ananda kernel: [45770.133527] usb usb6: root hub lost power or was reset
Aug 26 09:05:31 ananda kernel: [45770.133527] usb usb7: root hub lost power or was reset
Aug 26 09:05:31 ananda kernel: [45770.134176] [drm] PCIE GART of 1024M enabled.
Aug 26 09:05:31 ananda kernel: [45770.134178] [drm] PTB located at 0x000000F400900000
Aug 26 09:05:31 ananda kernel: [45770.134190] [drm] PSP is resuming...
Aug 26 09:05:31 ananda kernel: [45770.134138] xhci_hcd 0000:06:00.0: Zeroing 64bit base registers, expecting fault
Aug 26 09:05:31 ananda kernel: [45770.154225] [drm] reserve 0x400000 from 0xf47f800000 for PSP TMR
Aug 26 09:05:31 ananda kernel: [45770.185923] nvme nvme0: Shutdown timeout set to 10 seconds
Aug 26 09:05:31 ananda kernel: [45770.189787] nvme nvme0: 16/0/0 default/read/poll queues
Aug 26 09:05:31 ananda kernel: [45770.239119] amdgpu 0000:07:00.0: amdgpu: RAS: optional ras ta ucode is not available
Aug 26 09:05:31 ananda kernel: [45770.248109] amdgpu 0000:07:00.0: amdgpu: RAP: optional rap ta ucode is not available
Aug 26 09:05:31 ananda kernel: [45770.248113] amdgpu 0000:07:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
Aug 26 09:05:31 ananda kernel: [45770.248117] amdgpu 0000:07:00.0: amdgpu: SMU is resuming...
Aug 26 09:05:31 ananda kernel: [45770.248161] amdgpu 0000:07:00.0: amdgpu: dpm has been disabled
Aug 26 09:05:31 ananda kernel: [45770.249206] amdgpu 0000:07:00.0: amdgpu: SMU is resumed successfully!
Aug 26 09:05:31 ananda kernel: [45770.250544] [drm] kiq ring mec 2 pipe 1 q 0
Aug 26 09:05:31 ananda kernel: [45770.251827] [drm] DMUB hardware initialized: version=0x01010019
Aug 26 09:05:31 ananda kernel: [45770.371392] usb 7-2: reset SuperSpeed USB device number 2 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45770.395702] usb 4-3: reset full-speed USB device number 2 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45770.504921] usb 6-2: reset high-speed USB device number 3 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45770.508527] [drm] VCN decode and encode initialized successfully(under DPG Mode).
Aug 26 09:05:31 ananda kernel: [45770.508870] [drm] JPEG decode initialized successfully.
Aug 26 09:05:31 ananda kernel: [45770.509088] amdgpu 0000:07:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
Aug 26 09:05:31 ananda kernel: [45770.509090] amdgpu 0000:07:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
Aug 26 09:05:31 ananda kernel: [45770.509091] amdgpu 0000:07:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
Aug 26 09:05:31 ananda kernel: [45770.509092] amdgpu 0000:07:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
Aug 26 09:05:31 ananda kernel: [45770.509093] amdgpu 0000:07:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
Aug 26 09:05:31 ananda kernel: [45770.509093] amdgpu 0000:07:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
Aug 26 09:05:31 ananda kernel: [45770.509094] amdgpu 0000:07:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
Aug 26 09:05:31 ananda kernel: [45770.509095] amdgpu 0000:07:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
Aug 26 09:05:31 ananda kernel: [45770.509095] amdgpu 0000:07:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
Aug 26 09:05:31 ananda kernel: [45770.509096] amdgpu 0000:07:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
Aug 26 09:05:31 ananda kernel: [45770.509097] amdgpu 0000:07:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
Aug 26 09:05:31 ananda kernel: [45770.509098] amdgpu 0000:07:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
Aug 26 09:05:31 ananda kernel: [45770.509098] amdgpu 0000:07:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
Aug 26 09:05:31 ananda kernel: [45770.509099] amdgpu 0000:07:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
Aug 26 09:05:31 ananda kernel: [45770.509100] amdgpu 0000:07:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
Aug 26 09:05:31 ananda kernel: [45770.556260] usb 2-2: reset high-speed USB device number 2 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45770.757000] usb 6-4: reset full-speed USB device number 2 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45770.965816] usb 7-2.1: reset SuperSpeed USB device number 3 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45771.054113] usb 7-2.2: reset SuperSpeed USB device number 4 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45771.121762] psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
Aug 26 09:05:31 ananda kernel: [45771.174421] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
Aug 26 09:05:31 ananda kernel: [45771.379768] usb 6-2.1: reset high-speed USB device number 4 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45771.554779] usb 6-2.2: reset high-speed USB device number 5 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45771.722172] usb 6-2.3: reset full-speed USB device number 7 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45772.073876] usb 6-2.1.3: reset low-speed USB device number 8 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45772.603068] usb 6-2.1.2: reset low-speed USB device number 6 using xhci_hcd
Aug 26 09:05:31 ananda kernel: [45772.908604] PM: hibernation: Basic memory bitmaps freed
Aug 26 09:05:31 ananda kernel: [45772.908610] OOM killer enabled.
Aug 26 09:05:31 ananda kernel: [45772.908611] Restarting tasks ... 
Aug 26 09:05:31 ananda kernel: [45772.909793] pci_bus 0000:01: Allocating resources
Aug 26 09:05:31 ananda kernel: [45772.909817] pci_bus 0000:02: Allocating resources
Aug 26 09:05:31 ananda kernel: [45772.909843] pci_bus 0000:03: Allocating resources
Aug 26 09:05:31 ananda kernel: [45772.910082] pci_bus 0000:04: Allocating resources
Aug 26 09:05:31 ananda kernel: [45772.910330] pci_bus 0000:05: Allocating resources
Aug 26 09:05:31 ananda kernel: [45772.910348] pci_bus 0000:06: Allocating resources
Aug 26 09:05:31 ananda kernel: [45772.910759] pci_bus 0000:07: Allocating resources
Aug 26 09:05:31 ananda kernel: [45772.911007] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
Aug 26 09:05:31 ananda kernel: [45772.911299] done.
Aug 26 09:05:31 ananda kernel: [45772.913081] Bluetooth: hci0: Device revision is 1
Aug 26 09:05:31 ananda kernel: [45772.913098] Bluetooth: hci0: Secure boot is enabled
Aug 26 09:05:31 ananda kernel: [45772.913102] Bluetooth: hci0: OTP lock is enabled
Aug 26 09:05:31 ananda kernel: [45772.913104] Bluetooth: hci0: API lock is enabled
Aug 26 09:05:31 ananda kernel: [45772.913107] Bluetooth: hci0: Debug lock is disabled
Aug 26 09:05:31 ananda kernel: [45772.913110] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Aug 26 09:05:31 ananda kernel: [45772.913595] PM: hibernation: hibernation exit
Aug 26 09:05:31 ananda kernel: [45772.942401] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
Aug 26 09:05:30 ananda rtkit-daemon[5455]: The canary thread is apparently starving. Taking action.
Aug 26 09:05:30 ananda rtkit-daemon[5455]: Demoting known real-time threads.
Aug 26 09:05:30 ananda rtkit-daemon[5455]: Successfully demoted thread 3660 of process 15500.
Aug 26 09:05:30 ananda rtkit-daemon[5455]: Successfully demoted thread 3659 of process 15500.
Aug 26 09:05:30 ananda rtkit-daemon[5455]: Successfully demoted thread 3658 of process 15500.
Aug 26 09:05:30 ananda rtkit-daemon[5455]: Successfully demoted thread 15598 of process 15500.
Aug 26 09:05:30 ananda rtkit-daemon[5455]: Successfully demoted thread 15597 of process 15500.
Aug 26 09:05:30 ananda rtkit-daemon[5455]: Successfully demoted thread 15596 of process 15500.
Aug 26 09:05:30 ananda rtkit-daemon[5455]: Successfully demoted thread 15592 of process 15500.
Aug 26 09:05:30 ananda rtkit-daemon[5455]: Successfully demoted thread 15500 of process 15500.
Aug 26 09:05:30 ananda rtkit-daemon[5455]: Demoted 8 threads.
Aug 26 09:05:31 ananda ModemManager[5033]: <info>  [sleep-monitor] system is resuming
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.1427] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.1430] device (en0): state change: unmanaged -> unavailable (reason 'managed', sys-iface-state: 'external')
Aug 26 09:05:31 ananda kernel: [45773.097621] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
Aug 26 09:05:31 ananda kernel: [45773.206056] r8169 0000:02:00.0 en0: Link is Down
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.2899] device (en1): state change: unmanaged -> unavailable (reason 'managed', sys-iface-state: 'external')
Aug 26 09:05:31 ananda kernel: [45773.247612] Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY driver (mii_bus:phy_addr=r8169-0-500:00, irq=MAC)
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.4897] device (wlan0): state change: unmanaged -> unavailable (reason 'managed', sys-iface-state: 'external')
Aug 26 09:05:31 ananda kernel: [45773.417860] r8169 0000:05:00.0 en1: Link is Down
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.5119] device (wlan0): set-hw-addr: set MAC address to C6:6B:79:DB:87:B1 (scanning)
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.7659] device (p2p-dev-wlan0): state change: unmanaged -> unavailable (reason 'managed', sys-iface-state: 'external')
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.7669] manager: NetworkManager state is now DISCONNECTED
Aug 26 09:05:31 ananda PackageKit: get-updates transaction /2435_bacdabdc from uid 1000 finished with success after 17911ms
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.8358] device (wlan0): supplicant interface state: internal-starting -> disconnected
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.8358] device (p2p-dev-wlan0): state change: unavailable -> unmanaged (reason 'removed', sys-iface-state: 'removed')
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.8369] Wi-Fi P2P device controlled by interface wlan0 created
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.8374] manager: (p2p-dev-wlan0): new 802.11 Wi-Fi P2P device (/org/freedesktop/NetworkManager/Devices/8)
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.8379] device (p2p-dev-wlan0): state change: unmanaged -> unavailable (reason 'managed', sys-iface-state: 'external')
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.8389] device (wlan0): state change: unavailable -> disconnected (reason 'supplicant-available', sys-iface-state: 'managed')
Aug 26 09:05:31 ananda NetworkManager[4069]: <info>  [1629961531.8401] device (p2p-dev-wlan0): state change: unavailable -> disconnected (reason 'none', sys-iface-state: 'managed')
Aug 26 09:05:31 ananda NetworkManager[4069]: <warn>  [1629961531.8636] sup-iface[814e98af1efcc384,3,wlan0]: call-p2p-cancel: failed with P2P cancel failed
Aug 26 09:05:32 ananda kernel: [45774.515643] Bluetooth: hci0: Waiting for firmware download to complete
Aug 26 09:05:32 ananda kernel: [45774.515949] Bluetooth: hci0: Firmware loaded in 1536654 usecs
Aug 26 09:05:32 ananda kernel: [45774.516031] Bluetooth: hci0: Waiting for device to boot
Aug 26 09:05:32 ananda kernel: [45774.530970] Bluetooth: hci0: Device booted in 14624 usecs
Aug 26 09:05:32 ananda kernel: [45774.531135] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-20-1-3.ddc
Aug 26 09:05:32 ananda kernel: [45774.537010] Bluetooth: hci0: Applying Intel DDC parameters completed
Aug 26 09:05:32 ananda kernel: [45774.546056] Bluetooth: hci0: Firmware revision 0.0 build 191 week 21 2021
Aug 26 09:05:32 ananda bluetoothd[3594]: profiles/sap/server.c:sap_server_register() Sap driver initialization failed.
Aug 26 09:05:32 ananda bluetoothd[3594]: sap-server: Operation not permitted (1)
Aug 26 09:05:33 ananda ModemManager[5033]: <info>  [base-manager] couldn't check support for device '/sys/devices/pci0000:00/0000:00:02.2/0000:02:00.0': not supported by any plugin
Aug 26 09:05:33 ananda ModemManager[5033]: <info>  [base-manager] couldn't check support for device '/sys/devices/pci0000:00/0000:00:02.3/0000:03:00.0': not supported by any plugin
Aug 26 09:05:33 ananda ModemManager[5033]: <info>  [base-manager] couldn't check support for device '/sys/devices/pci0000:00/0000:00:02.6/0000:05:00.0': not supported by any plugin
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0273] device (en1): carrier: link connected
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0277] device (en1): state change: unavailable -> disconnected (reason 'carrier-changed', sys-iface-state: 'managed')
Aug 26 09:05:35 ananda kernel: [45776.954664] r8169 0000:05:00.0 en1: Link is Up - 1Gbps/Full - flow control rx/tx
Aug 26 09:05:35 ananda kernel: [45776.954686] IPv6: ADDRCONF(NETDEV_CHANGE): en1: link becomes ready
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0289] policy: auto-activating connection 'Ethernet' (33925618-11f3-4dd7-b828-ac554192a6aa)
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0297] device (en1): Activation: starting connection 'Ethernet' (33925618-11f3-4dd7-b828-ac554192a6aa)
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0299] device (en1): state change: disconnected -> prepare (reason 'none', sys-iface-state: 'managed')
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0304] manager: NetworkManager state is now CONNECTING
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0307] device (en1): state change: prepare -> config (reason 'none', sys-iface-state: 'managed')
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0315] device (en1): state change: config -> ip-config (reason 'none', sys-iface-state: 'managed')
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0321] dhcp4 (en1): activation: beginning transaction (timeout in 45 seconds)
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0432] dhcp4 (en1): state changed unknown -> bound, address=10.0.0.72
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0453] device (en1): state change: ip-config -> ip-check (reason 'none', sys-iface-state: 'managed')
Aug 26 09:05:35 ananda dbus-daemon[1989]: [system] Activating service name='org.freedesktop.nm_dispatcher' requested by ':1.2' (uid=0 pid=4069 comm="/usr/sbin/NetworkManager ") (using servicehelper)
Aug 26 09:05:35 ananda dbus-daemon[1989]: [system] Successfully activated service 'org.freedesktop.nm_dispatcher'
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0823] device (en1): state change: ip-check -> secondaries (reason 'none', sys-iface-state: 'managed')
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0829] device (en1): state change: secondaries -> activated (reason 'none', sys-iface-state: 'managed')
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0836] manager: NetworkManager state is now CONNECTED_LOCAL
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0852] manager: NetworkManager state is now CONNECTED_SITE
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0855] policy: set 'Ethernet' (en1) as default for IPv4 routing and DNS
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0875] device (en1): Activation: successful, device activated.
Aug 26 09:05:35 ananda NetworkManager[4069]: <info>  [1629961535.0885] manager: NetworkManager state is now CONNECTED_GLOBAL
Aug 26 09:05:35 ananda chronyd[1920]: Forward time jump detected!
Aug 26 09:05:35 ananda chronyd[1920]: Source 78.46.60.40 online
Aug 26 09:05:35 ananda chronyd[1920]: Source 3.64.117.201 online
Aug 26 09:05:35 ananda wpa_supplicant[5031]: wlan0: CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=COUNTRY alpha2=DE
Aug 26 09:05:36 ananda PackageKit: get-updates transaction /2436_abbadade from uid 1000 finished with success after 760ms
Aug 26 09:05:36 ananda NetworkManager[4069]: <info>  [1629961536.8230] dhcp6 (en1): activation: beginning transaction (timeout in 45 seconds)
Aug 26 09:05:36 ananda NetworkManager[4069]: <info>  [1629961536.8249] policy: set 'Ethernet' (en1) as default for IPv6 routing and DNS
Aug 26 09:05:36 ananda NetworkManager[4069]: <info>  [1629961536.8287] dhcp6 (en1): state changed unknown -> bound, address=fdc0:9e25:cc69::9ea 2001:a62:1a4a:3500::9ea
Aug 26 09:05:39 ananda chronyd[1920]: Selected source 3.64.117.201 (2.debian.pool.ntp.org)
Aug 26 09:06:00 ananda kernel: [45802.650494] general protection fault, probably for non-canonical address 0x950937986d3c192d: 0000 [#1] PREEMPT SMP NOPTI
Aug 26 09:06:00 ananda kernel: [45802.650508] CPU: 12 PID: 10157 Comm: kworker/u32:144 Tainted: G            E     5.14.0-rc7-t14 #20
Aug 26 09:06:00 ananda kernel: [45802.650515] Hardware name: LENOVO 20UD0013GE/20UD0013GE, BIOS R1BET65W(1.34 ) 06/17/2021
Aug 26 09:06:00 ananda kernel: [45802.650519] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.650590] RIP: 0010:kmem_cache_alloc+0xf6/0x410
Aug 26 09:06:00 ananda kernel: [45802.650600] Code: 48 8b 70 08 48 39 f2 75 e7 48 83 78 10 00 4c 8b 20 0f 84 b2 02 00 00 4d 85 e4 0f 84 a9 02 00 00 8b 45 28 48 8b 7d 00 4c 01 e0 <48> 8b 18 48 33 9d b8 00 00 00 48 89 c1 48 0f c9 4c 89 e0 48 31 cb
Aug 26 09:06:00 ananda kernel: [45802.650605] RSP: 0018:ffffa9118c137b68 EFLAGS: 00010286
Aug 26 09:06:00 ananda kernel: [45802.650610] RAX: 950937986d3c192d RBX: 0000000000000100 RCX: 00003d6feea0e960
Aug 26 09:06:00 ananda kernel: [45802.650614] RDX: 000000003323df0c RSI: 000000003323df0c RDI: 00003d6feea0e960
Aug 26 09:06:00 ananda kernel: [45802.650617] RBP: ffff8b9b08233a00 R08: 0000000000000000 R09: ffff8b9b4b0d0380
Aug 26 09:06:00 ananda kernel: [45802.650621] R10: ffff8b9fb9a54d68 R11: ffff8ba1913327e0 R12: 950937986d3c18e5
Aug 26 09:06:00 ananda kernel: [45802.650624] R13: 0000000000000000 R14: 0000000000000c40 R15: ffffffffc06cab85
Aug 26 09:06:00 ananda kernel: [45802.650628] FS:  0000000000000000(0000) GS:ffff8ba191300000(0000) knlGS:0000000000000000
Aug 26 09:06:00 ananda kernel: [45802.650633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 26 09:06:00 ananda kernel: [45802.650637] CR2: 00007f0fdf4e2014 CR3: 00000002c0e0a000 CR4: 0000000000350ee0
Aug 26 09:06:00 ananda kernel: [45802.650641] Call Trace:
Aug 26 09:06:00 ananda kernel: [45802.650647]  btrfs_add_delayed_data_ref+0x145/0x4a0 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.650720]  btrfs_alloc_reserved_file_extent+0x83/0xb0 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.650767]  insert_reserved_file_extent+0x325/0x410 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.650814]  btrfs_finish_ordered_io.isra.0+0x702/0x9a0 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.650863]  btrfs_work_helper+0xdc/0x360 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.650910]  process_one_work+0x1e3/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.650917]  worker_thread+0x50/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.650921]  ? process_one_work+0x3c0/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.650926]  kthread+0x132/0x160
Aug 26 09:06:00 ananda kernel: [45802.650929]  ? set_kthread_struct+0x40/0x40
Aug 26 09:06:00 ananda kernel: [45802.650933]  ret_from_fork+0x22/0x30
Aug 26 09:06:00 ananda kernel: [45802.650940] Modules linked in: hid_lenovo(E) hid_generic(E) snd_usb_audio(E) snd_usbmidi_lib(E) usbhid(E) snd_rawmidi(E) hid(E) snd_seq_device(E) fuse(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) efivarfs(E) sch_fq_pie(E) sch_pie(E) xxhash_generic(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) xfs(E) kyber_iosched(E) btusb(E) btrtl(E) btbcm(E) snd_ctl_led(E) iwlmvm(E) btintel(E) amdgpu(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) bluetooth(E) snd_hda_codec_hdmi(E) drm_ttm_helper(E) mac80211(E) libarc4(E) ttm(E) snd_hda_intel(E) snd_intel_dspcfg(E) gpu_sched(E) snd_acp3x_rn(E) snd_intel_sdw_acpi(E) snd_soc_dmic(E) snd_acp3x_pdm_dma(E) jitterentropy_rng(E) uvcvideo(E) drm_kms_helper(E) videobuf2_vmalloc(E) iwlwifi(E) videobuf2_memops(E) snd_hda_codec(E) snd_soc_core(E) videobuf2_v4l2(E) sha512_ssse3(E) cec(E) edac_mce_amd(E) snd_hwdep(E) videobuf2_common(E) sha512_generic(E) snd_hda_core(E) snd_compress(E) drm(E) thinkpad_acpi(E) drbg(E) nvram(E) kvm_amd(E)
Aug 26 09:06:00 ananda kernel: [45802.651012]  videodev(E) snd_pcm(E) ledtrig_audio(E) think_lmi(E) syscopyarea(E) sysfillrect(E) platform_profile(E) snd_timer(E) ansi_cprng(E) wmi_bmof(E) firmware_attributes_class(E) sysimgblt(E) joydev(E) evdev(E) ecdh_generic(E) kvm(E) ecc(E) mc(E) fb_sys_fops(E) ipmi_devintf(E) tpm_crb(E) snd(E) pcspkr(E) serio_raw(E) ucsi_acpi(E) crc16(E) cfg80211(E) snd_rn_pci_acp3x(E) k10temp(E) irqbypass(E) efi_pstore(E) i2c_algo_bit(E) soundcore(E) tpm_tis(E) typec_ucsi(E) ccp(E) ac(E) rfkill(E) ipmi_msghandler(E) battery(E) roles(E) video(E) tpm_tis_core(E) tpm(E) typec(E) rng_core(E) wmi(E) acpi_cpufreq(E) button(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_generic(E) dm_crypt(E) dm_mod(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) rtsx_pci_sdmmc(E) nvme(E) mmc_core(E) xhci_pci(E) aesni_intel(E) ehci_pci(E) nvme_core(E) libaes(E) crypto_simd(E) xhci_hcd(E) ehci_hcd(E) t10_pi(E) cryptd(E) psmouse(E) crc_t10dif(E) i2c_piix4(E) crct10dif_generic(E)
Aug 26 09:06:00 ananda kernel: [45802.651113]  rtsx_pci(E) r8169(E) usbcore(E) crct10dif_pclmul(E) realtek(E) crct10dif_common(E) i2c_scmi(E)
Aug 26 09:06:00 ananda kernel: [45802.651156] ---[ end trace 01a690ead79878d4 ]---
Aug 26 09:06:00 ananda kernel: [45802.654642] ------------[ cut here ]------------
Aug 26 09:06:00 ananda kernel: [45802.654647] WARNING: CPU: 12 PID: 10157 at kernel/rcu/tree_plugin.h:349 rcu_note_context_switch+0x5f/0x510
Aug 26 09:06:00 ananda kernel: [45802.654805] Modules linked in: hid_lenovo(E) hid_generic(E) snd_usb_audio(E) snd_usbmidi_lib(E) usbhid(E) snd_rawmidi(E) hid(E) snd_seq_device(E) fuse(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) efivarfs(E) sch_fq_pie(E) sch_pie(E) xxhash_generic(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) xfs(E) kyber_iosched(E) btusb(E) btrtl(E) btbcm(E) snd_ctl_led(E) iwlmvm(E) btintel(E) amdgpu(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) bluetooth(E) snd_hda_codec_hdmi(E) drm_ttm_helper(E) mac80211(E) libarc4(E) ttm(E) snd_hda_intel(E) snd_intel_dspcfg(E) gpu_sched(E) snd_acp3x_rn(E) snd_intel_sdw_acpi(E) snd_soc_dmic(E) snd_acp3x_pdm_dma(E) jitterentropy_rng(E) uvcvideo(E) drm_kms_helper(E) videobuf2_vmalloc(E) iwlwifi(E) videobuf2_memops(E) snd_hda_codec(E) snd_soc_core(E) videobuf2_v4l2(E) sha512_ssse3(E) cec(E) edac_mce_amd(E) snd_hwdep(E) videobuf2_common(E) sha512_generic(E) snd_hda_core(E) snd_compress(E) drm(E) thinkpad_acpi(E) drbg(E) nvram(E) kvm_amd(E)
Aug 26 09:06:00 ananda kernel: [45802.654881]  videodev(E) snd_pcm(E) ledtrig_audio(E) think_lmi(E) syscopyarea(E) sysfillrect(E) platform_profile(E) snd_timer(E) ansi_cprng(E) wmi_bmof(E) firmware_attributes_class(E) sysimgblt(E) joydev(E) evdev(E) ecdh_generic(E) kvm(E) ecc(E) mc(E) fb_sys_fops(E) ipmi_devintf(E) tpm_crb(E) snd(E) pcspkr(E) serio_raw(E) ucsi_acpi(E) crc16(E) cfg80211(E) snd_rn_pci_acp3x(E) k10temp(E) irqbypass(E) efi_pstore(E) i2c_algo_bit(E) soundcore(E) tpm_tis(E) typec_ucsi(E) ccp(E) ac(E) rfkill(E) ipmi_msghandler(E) battery(E) roles(E) video(E) tpm_tis_core(E) tpm(E) typec(E) rng_core(E) wmi(E) acpi_cpufreq(E) button(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_generic(E) dm_crypt(E) dm_mod(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) rtsx_pci_sdmmc(E) nvme(E) mmc_core(E) xhci_pci(E) aesni_intel(E) ehci_pci(E) nvme_core(E) libaes(E) crypto_simd(E) xhci_hcd(E) ehci_hcd(E) t10_pi(E) cryptd(E) psmouse(E) crc_t10dif(E) i2c_piix4(E) crct10dif_generic(E)
Aug 26 09:06:00 ananda kernel: [45802.654960]  rtsx_pci(E) r8169(E) usbcore(E) crct10dif_pclmul(E) realtek(E) crct10dif_common(E) i2c_scmi(E)
Aug 26 09:06:00 ananda kernel: [45802.654971] CPU: 12 PID: 10157 Comm: kworker/u32:144 Tainted: G      D     E     5.14.0-rc7-t14 #20
Aug 26 09:06:00 ananda kernel: [45802.654976] Hardware name: LENOVO 20UD0013GE/20UD0013GE, BIOS R1BET65W(1.34 ) 06/17/2021
Aug 26 09:06:00 ananda kernel: [45802.654980] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.655034] RIP: 0010:rcu_note_context_switch+0x5f/0x510
Aug 26 09:06:00 ananda kernel: [45802.655041] Code: 25 80 7b 01 00 65 48 03 1d 2e 4c f1 6c 0f 1f 44 00 00 45 84 e4 75 15 65 48 8b 04 25 80 7b 01 00 8b 90 0c 03 00 00 85 d2 7e 02 <0f> 0b 65 48 8b 04 25 80 7b 01 00 8b 80 0c 03 00 00 85 c0 7e 0e 41
Aug 26 09:06:00 ananda kernel: [45802.655045] RSP: 0018:ffffa9118c1375a8 EFLAGS: 00010002
Aug 26 09:06:00 ananda kernel: [45802.655048] RAX: ffff8b9b079e0000 RBX: ffff8ba19132cd40 RCX: 0000000000000000
Aug 26 09:06:00 ananda kernel: [45802.655052] RDX: 0000000000000001 RSI: ffffffff9388fa39 RDI: 0000000000000000
Aug 26 09:06:00 ananda kernel: [45802.655054] RBP: ffffa9118c137638 R08: ffffffff94866388 R09: ffffffff94866388
Aug 26 09:06:00 ananda kernel: [45802.655057] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
Aug 26 09:06:00 ananda kernel: [45802.655059] R13: ffff8b9b079e0000 R14: ffff8ba19132c040 R15: ffff8b9b044bf000
Aug 26 09:06:00 ananda kernel: [45802.655062] FS:  0000000000000000(0000) GS:ffff8ba191300000(0000) knlGS:0000000000000000
Aug 26 09:06:00 ananda kernel: [45802.655066] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 26 09:06:00 ananda kernel: [45802.655069] CR2: 00007f0fdf4e2014 CR3: 00000002c0e0a000 CR4: 0000000000350ee0
Aug 26 09:06:00 ananda kernel: [45802.655073] Call Trace:
Aug 26 09:06:00 ananda kernel: [45802.655078]  __schedule+0x7c/0x770
Aug 26 09:06:00 ananda kernel: [45802.655085]  schedule+0x59/0xc0
Aug 26 09:06:00 ananda kernel: [45802.655089]  schedule_timeout+0x115/0x150
Aug 26 09:06:00 ananda kernel: [45802.655094]  ? __prepare_to_swait+0x73/0x90
Aug 26 09:06:00 ananda kernel: [45802.655099]  wait_for_completion+0x89/0xe0
Aug 26 09:06:00 ananda kernel: [45802.655104]  virt_efi_query_variable_info+0x163/0x170
Aug 26 09:06:00 ananda kernel: [45802.655111]  efi_query_variable_store+0x5d/0x1b0
Aug 26 09:06:00 ananda kernel: [45802.655116]  efivar_entry_set_safe+0xd0/0x230
Aug 26 09:06:00 ananda kernel: [45802.655121]  efi_pstore_write+0x11b/0x1a0 [efi_pstore]
Aug 26 09:06:00 ananda kernel: [45802.655129]  pstore_dump+0x114/0x340
Aug 26 09:06:00 ananda kernel: [45802.655137]  kmsg_dump+0x46/0x60
Aug 26 09:06:00 ananda kernel: [45802.655141]  oops_end+0x45/0xa0
Aug 26 09:06:00 ananda kernel: [45802.655146]  exc_general_protection+0x1aa/0x390
Aug 26 09:06:00 ananda kernel: [45802.655152]  ? btrfs_get_32+0x6c/0x120 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.655199]  asm_exc_general_protection+0x1e/0x30
Aug 26 09:06:00 ananda kernel: [45802.655205] RIP: 0010:kmem_cache_alloc+0xf6/0x410
Aug 26 09:06:00 ananda kernel: [45802.655211] Code: 48 8b 70 08 48 39 f2 75 e7 48 83 78 10 00 4c 8b 20 0f 84 b2 02 00 00 4d 85 e4 0f 84 a9 02 00 00 8b 45 28 48 8b 7d 00 4c 01 e0 <48> 8b 18 48 33 9d b8 00 00 00 48 89 c1 48 0f c9 4c 89 e0 48 31 cb
Aug 26 09:06:00 ananda kernel: [45802.655215] RSP: 0018:ffffa9118c137b68 EFLAGS: 00010286
Aug 26 09:06:00 ananda kernel: [45802.655218] RAX: 950937986d3c192d RBX: 0000000000000100 RCX: 00003d6feea0e960
Aug 26 09:06:00 ananda kernel: [45802.655221] RDX: 000000003323df0c RSI: 000000003323df0c RDI: 00003d6feea0e960
Aug 26 09:06:00 ananda kernel: [45802.655224] RBP: ffff8b9b08233a00 R08: 0000000000000000 R09: ffff8b9b4b0d0380
Aug 26 09:06:00 ananda kernel: [45802.655226] R10: ffff8b9fb9a54d68 R11: ffff8ba1913327e0 R12: 950937986d3c18e5
Aug 26 09:06:00 ananda kernel: [45802.655228] R13: 0000000000000000 R14: 0000000000000c40 R15: ffffffffc06cab85
Aug 26 09:06:00 ananda kernel: [45802.655231]  ? btrfs_add_delayed_data_ref+0x145/0x4a0 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.655282]  ? kmem_cache_alloc+0x3c/0x410
Aug 26 09:06:00 ananda kernel: [45802.655287]  btrfs_add_delayed_data_ref+0x145/0x4a0 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.655328]  btrfs_alloc_reserved_file_extent+0x83/0xb0 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.655373]  insert_reserved_file_extent+0x325/0x410 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.655420]  btrfs_finish_ordered_io.isra.0+0x702/0x9a0 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.655462]  btrfs_work_helper+0xdc/0x360 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.655509]  process_one_work+0x1e3/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.655515]  worker_thread+0x50/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.655519]  ? process_one_work+0x3c0/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.655523]  kthread+0x132/0x160
Aug 26 09:06:00 ananda kernel: [45802.655527]  ? set_kthread_struct+0x40/0x40
Aug 26 09:06:00 ananda kernel: [45802.655531]  ret_from_fork+0x22/0x30
Aug 26 09:06:00 ananda kernel: [45802.655538] ---[ end trace 01a690ead79878d5 ]---
Aug 26 09:06:00 ananda kernel: [45802.656848] general protection fault, probably for non-canonical address 0x950937986d3c192d: 0000 [#2] PREEMPT SMP NOPTI
Aug 26 09:06:00 ananda kernel: [45802.656858] CPU: 12 PID: 10155 Comm: kworker/u32:142 Tainted: G      D W   E     5.14.0-rc7-t14 #20
Aug 26 09:06:00 ananda kernel: [45802.656864] Hardware name: LENOVO 20UD0013GE/20UD0013GE, BIOS R1BET65W(1.34 ) 06/17/2021
Aug 26 09:06:00 ananda kernel: [45802.656868] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.656939] RIP: 0010:kmem_cache_alloc+0xf6/0x410
Aug 26 09:06:00 ananda kernel: [45802.656948] Code: 48 8b 70 08 48 39 f2 75 e7 48 83 78 10 00 4c 8b 20 0f 84 b2 02 00 00 4d 85 e4 0f 84 a9 02 00 00 8b 45 28 48 8b 7d 00 4c 01 e0 <48> 8b 18 48 33 9d b8 00 00 00 48 89 c1 48 0f c9 4c 89 e0 48 31 cb
Aug 26 09:06:00 ananda kernel: [45802.656954] RSP: 0018:ffffa9118c127ad8 EFLAGS: 00010286
Aug 26 09:06:00 ananda kernel: [45802.656959] RAX: 950937986d3c192d RBX: 0000000000000000 RCX: 00003d6feea0e960
Aug 26 09:06:00 ananda kernel: [45802.656963] RDX: 000000003323df0c RSI: 000000003323df0c RDI: 00003d6feea0e960
Aug 26 09:06:00 ananda kernel: [45802.656967] RBP: ffff8b9b08233a00 R08: ffffa9118c127d10 R09: ffff8b9fb9a54340
Aug 26 09:06:00 ananda kernel: [45802.656971] R10: 000000000000000f R11: ffff8ba1913327e0 R12: 950937986d3c18e5
Aug 26 09:06:00 ananda kernel: [45802.656975] R13: 0000000000000000 R14: 0000000000000d40 R15: ffffffffc0689076
Aug 26 09:06:00 ananda kernel: [45802.656980] FS:  0000000000000000(0000) GS:ffff8ba191300000(0000) knlGS:0000000000000000
Aug 26 09:06:00 ananda kernel: [45802.656985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 26 09:06:00 ananda kernel: [45802.656989] CR2: 00007f0fdf4e2014 CR3: 000000012e26e000 CR4: 0000000000350ee0
Aug 26 09:06:00 ananda kernel: [45802.656994] Call Trace:
Aug 26 09:06:00 ananda kernel: [45802.657000]  alloc_extent_map+0x16/0x60 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657071]  btrfs_drop_extent_cache+0x2f6/0x3f0 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657137]  btrfs_drop_extents+0x813/0xd20 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657199]  ? cow_file_range_inline.constprop.0+0x135/0x740 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657265]  ? join_transaction+0x12c/0x450 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657333]  cow_file_range_inline.constprop.0+0x4c6/0x740 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657397]  ? update_load_avg+0x531/0x5b0
Aug 26 09:06:00 ananda kernel: [45802.657405]  compress_file_range+0x1f3/0x830 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657467]  ? cpuacct_charge+0x32/0x80
Aug 26 09:06:00 ananda kernel: [45802.657475]  async_cow_start+0x12/0x30 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657538]  ? submit_compressed_extents+0x440/0x440 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657600]  btrfs_work_helper+0xdc/0x360 [btrfs]
Aug 26 09:06:00 ananda kernel: [45802.657670]  process_one_work+0x1e3/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.657678]  worker_thread+0x50/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.657683]  ? process_one_work+0x3c0/0x3c0
Aug 26 09:06:00 ananda kernel: [45802.657689]  kthread+0x132/0x160
Aug 26 09:06:00 ananda kernel: [45802.657694]  ? set_kthread_struct+0x40/0x40
Aug 26 09:06:00 ananda kernel: [45802.657699]  ret_from_fork+0x22/0x30
Aug 26 09:06:00 ananda kernel: [45802.657707] Modules linked in: hid_lenovo(E) hid_generic(E) snd_usb_audio(E) snd_usbmidi_lib(E) usbhid(E) snd_rawmidi(E) hid(E) snd_seq_device(E) fuse(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) efivarfs(E) sch_fq_pie(E) sch_pie(E) xxhash_generic(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) xfs(E) kyber_iosched(E) btusb(E) btrtl(E) btbcm(E) snd_ctl_led(E) iwlmvm(E) btintel(E) amdgpu(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) bluetooth(E) snd_hda_codec_hdmi(E) drm_ttm_helper(E) mac80211(E) libarc4(E) ttm(E) snd_hda_intel(E) snd_intel_dspcfg(E) gpu_sched(E) snd_acp3x_rn(E) snd_intel_sdw_acpi(E) snd_soc_dmic(E) snd_acp3x_pdm_dma(E) jitterentropy_rng(E) uvcvideo(E) drm_kms_helper(E) videobuf2_vmalloc(E) iwlwifi(E) videobuf2_memops(E) snd_hda_codec(E) snd_soc_core(E) videobuf2_v4l2(E) sha512_ssse3(E) cec(E) edac_mce_amd(E) snd_hwdep(E) videobuf2_common(E) sha512_generic(E) snd_hda_core(E) snd_compress(E) drm(E) thinkpad_acpi(E) drbg(E) nvram(E) kvm_amd(E)
Aug 26 09:06:00 ananda kernel: [45802.657814]  videodev(E) snd_pcm(E) ledtrig_audio(E) think_lmi(E) syscopyarea(E) sysfillrect(E) platform_profile(E) snd_timer(E) ansi_cprng(E) wmi_bmof(E) firmware_attributes_class(E) sysimgblt(E) joydev(E) evdev(E) ecdh_generic(E) kvm(E) ecc(E) mc(E) fb_sys_fops(E) ipmi_devintf(E) tpm_crb(E) snd(E) pcspkr(E) serio_raw(E) ucsi_acpi(E) crc16(E) cfg80211(E) snd_rn_pci_acp3x(E) k10temp(E) irqbypass(E) efi_pstore(E) i2c_algo_bit(E) soundcore(E) tpm_tis(E) typec_ucsi(E) ccp(E) ac(E) rfkill(E) ipmi_msghandler(E) battery(E) roles(E) video(E) tpm_tis_core(E) tpm(E) typec(E) rng_core(E) wmi(E) acpi_cpufreq(E) button(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_generic(E) dm_crypt(E) dm_mod(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) rtsx_pci_sdmmc(E) nvme(E) mmc_core(E) xhci_pci(E) aesni_intel(E) ehci_pci(E) nvme_core(E) libaes(E) crypto_simd(E) xhci_hcd(E) ehci_hcd(E) t10_pi(E) cryptd(E) psmouse(E) crc_t10dif(E) i2c_piix4(E) crct10dif_generic(E)
Aug 26 09:06:00 ananda kernel: [45802.657822]  rtsx_pci(E) r8169(E) usbcore(E) crct10dif_pclmul(E) realtek(E) crct10dif_common(E) i2c_scmi(E)
Aug 26 09:06:00 ananda kernel: [45802.658228] ---[ end trace 01a690ead79878d6 ]---
Aug 26 09:06:01 ananda kernel: [45803.626251] general protection fault, probably for non-canonical address 0x950937986d3c192d: 0000 [#3] PREEMPT SMP NOPTI
Aug 26 09:06:01 ananda kernel: [45803.626263] CPU: 12 PID: 10150 Comm: kworker/u32:137 Tainted: G      D W   E     5.14.0-rc7-t14 #20
Aug 26 09:06:01 ananda kernel: [45803.626271] Hardware name: LENOVO 20UD0013GE/20UD0013GE, BIOS R1BET65W(1.34 ) 06/17/2021
Aug 26 09:06:01 ananda kernel: [45803.626276] Workqueue: btrfs-delayed-meta btrfs_work_helper [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626488] RIP: 0010:kmem_cache_alloc+0xf6/0x410
Aug 26 09:06:01 ananda kernel: [45803.626644] Code: 48 8b 70 08 48 39 f2 75 e7 48 83 78 10 00 4c 8b 20 0f 84 b2 02 00 00 4d 85 e4 0f 84 a9 02 00 00 8b 45 28 48 8b 7d 00 4c 01 e0 <48> 8b 18 48 33 9d b8 00 00 00 48 89 c1 48 0f c9 4c 89 e0 48 31 cb
Aug 26 09:06:01 ananda kernel: [45803.626644] RSP: 0018:ffffa9118c0ffa10 EFLAGS: 00010286
Aug 26 09:06:01 ananda kernel: [45803.626644] RAX: 950937986d3c192d RBX: ffffa9118c0ffb28 RCX: 00003d6feea0e960
Aug 26 09:06:01 ananda kernel: [45803.626644] RDX: 000000003323df0c RSI: 000000003323df0c RDI: 00003d6feea0e960
Aug 26 09:06:01 ananda kernel: [45803.626644] RBP: ffff8b9b08233a00 R08: 0000000000000068 R09: ffff8b9f5228f7b8
Aug 26 09:06:01 ananda kernel: [45803.626644] R10: 0000000000000005 R11: 0000000000000000 R12: 950937986d3c18e5
Aug 26 09:06:01 ananda kernel: [45803.626644] R13: 0000000000000000 R14: 0000000000000c40 R15: ffffffffc06ca646
Aug 26 09:06:01 ananda kernel: [45803.626644] FS:  0000000000000000(0000) GS:ffff8ba191300000(0000) knlGS:0000000000000000
Aug 26 09:06:01 ananda kernel: [45803.626644] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 26 09:06:01 ananda kernel: [45803.626644] CR2: 00007f3bfae8d000 CR3: 000000010e6b2000 CR4: 0000000000350ee0
Aug 26 09:06:01 ananda kernel: [45803.626644] Call Trace:
Aug 26 09:06:01 ananda kernel: [45803.626644]  btrfs_add_delayed_tree_ref+0x96/0x490 [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626644]  btrfs_alloc_tree_block+0x4a6/0x560 [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626644]  __btrfs_cow_block+0x13b/0x5f0 [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626644]  btrfs_cow_block+0x119/0x1d0 [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626644]  btrfs_search_slot+0x58f/0x870 [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626644]  btrfs_lookup_inode+0x3a/0xc0 [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626644]  ? btrfs_insert_delayed_items+0xcf/0x490 [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626644]  __btrfs_update_delayed_inode+0xa2/0x330 [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626644]  btrfs_async_run_delayed_root+0x179/0x240 [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626644]  btrfs_work_helper+0xdc/0x360 [btrfs]
Aug 26 09:06:01 ananda kernel: [45803.626644]  ? clone_endio+0xda/0x230 [dm_mod]
Aug 26 09:06:01 ananda kernel: [45803.626644]  process_one_work+0x1e3/0x3c0
Aug 26 09:06:01 ananda kernel: [45803.626644]  worker_thread+0x50/0x3c0
Aug 26 09:06:01 ananda kernel: [45803.626644]  ? process_one_work+0x3c0/0x3c0
Aug 26 09:06:01 ananda kernel: [45803.626644]  kthread+0x132/0x160
Aug 26 09:06:01 ananda kernel: [45803.626644]  ? set_kthread_struct+0x40/0x40
Aug 26 09:06:01 ananda kernel: [45803.626644]  ret_from_fork+0x22/0x30
Aug 26 09:06:01 ananda kernel: [45803.626644] Modules linked in: hid_lenovo(E) hid_generic(E) snd_usb_audio(E) snd_usbmidi_lib(E) usbhid(E) snd_rawmidi(E) hid(E) snd_seq_device(E) fuse(E) rfcomm(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) efivarfs(E) sch_fq_pie(E) sch_pie(E) xxhash_generic(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) xfs(E) kyber_iosched(E) btusb(E) btrtl(E) btbcm(E) snd_ctl_led(E) iwlmvm(E) btintel(E) amdgpu(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) bluetooth(E) snd_hda_codec_hdmi(E) drm_ttm_helper(E) mac80211(E) libarc4(E) ttm(E) snd_hda_intel(E) snd_intel_dspcfg(E) gpu_sched(E) snd_acp3x_rn(E) snd_intel_sdw_acpi(E) snd_soc_dmic(E) snd_acp3x_pdm_dma(E) jitterentropy_rng(E) uvcvideo(E) drm_kms_helper(E) videobuf2_vmalloc(E) iwlwifi(E) videobuf2_memops(E) snd_hda_codec(E) snd_soc_core(E) videobuf2_v4l2(E) sha512_ssse3(E) cec(E) edac_mce_amd(E) snd_hwdep(E) videobuf2_common(E) sha512_generic(E) snd_hda_core(E) snd_compress(E) drm(E) thinkpad_acpi(E) drbg(E) nvram(E) kvm_amd(E)
Aug 26 09:06:01 ananda kernel: [45803.626644]  videodev(E) snd_pcm(E) ledtrig_audio(E) think_lmi(E) syscopyarea(E) sysfillrect(E) platform_profile(E) snd_timer(E) ansi_cprng(E) wmi_bmof(E) firmware_attributes_class(E) sysimgblt(E) joydev(E) evdev(E) ecdh_generic(E) kvm(E) ecc(E) mc(E) fb_sys_fops(E) ipmi_devintf(E) tpm_crb(E) snd(E) Aug 26 09:07:59 ananda kernel: [    0.000000] Linux version 5.14.0-rc7-t14 (martin@ananda) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.37) #20 SMP PREEMPT Mon Aug 23 10:11:33 CEST 2021

This is the next boot, maybe helpful so you see what hardware is involved:

Aug 26 09:07:59 ananda kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.14.0-rc7-t14 root=/dev/mapper/nvme-system ro rootflags=subvol=system
Aug 26 09:07:59 ananda kernel: [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
Aug 26 09:07:59 ananda kernel: [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
Aug 26 09:07:59 ananda kernel: [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
Aug 26 09:07:59 ananda kernel: [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
Aug 26 09:07:59 ananda kernel: [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
Aug 26 09:07:59 ananda kernel: [    0.000000] signal: max sigframe size: 1776
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-provided physical RAM map:
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfffff] usable
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x0000000009c00000-0x0000000009d00fff] reserved
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x0000000009d01000-0x0000000009efffff] usable
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0ffff] ACPI NVS
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x0000000009f10000-0x00000000bd9ddfff] usable
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000000bd9de000-0x00000000bdbddfff] type 20
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000000bdbde000-0x00000000ca37dfff] reserved
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000000ca37e000-0x00000000cc37dfff] ACPI NVS
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000000cc37e000-0x00000000cc3fdfff] ACPI data
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000000cc3fe000-0x00000000cdffffff] usable
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000000ce000000-0x00000000cfffffff] reserved
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000000fde00000-0x00000000fdefffff] reserved
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000007af33ffff] usable
Aug 26 09:07:59 ananda kernel: [    0.000000] BIOS-e820: [mem 0x00000007af340000-0x000000082fffffff] reserved
Aug 26 09:07:59 ananda kernel: [    0.000000] NX (Execute Disable) protection: active
Aug 26 09:07:59 ananda kernel: [    0.000000] efi: EFI v2.70 by Lenovo
Aug 26 09:07:59 ananda kernel: [    0.000000] efi: ACPI=0xcc3fd000 ACPI 2.0=0xcc3fd014 TPMFinalLog=0xcc22d000 SMBIOS=0xbf71d000 SMBIOS 3.0=0xbf710000 MEMATTR=0xb9e73018 ESRT=0xbe46b000 
Aug 26 09:07:59 ananda kernel: [    0.000000] SMBIOS 3.2.0 present.
Aug 26 09:07:59 ananda kernel: [    0.000000] DMI: LENOVO 20UD0013GE/20UD0013GE, BIOS R1BET65W(1.34 ) 06/17/2021
Aug 26 09:07:59 ananda kernel: [    0.000000] tsc: Fast TSC calibration using PIT
Aug 26 09:07:59 ananda kernel: [    0.000000] tsc: Detected 1696.898 MHz processor
Aug 26 09:07:59 ananda kernel: [    0.000010] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Aug 26 09:07:59 ananda kernel: [    0.000012] e820: remove [mem 0x000a0000-0x000fffff] usable
Aug 26 09:07:59 ananda kernel: [    0.000015] last_pfn = 0x7af340 max_arch_pfn = 0x400000000
Aug 26 09:07:59 ananda kernel: [    0.000172] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Aug 26 09:07:59 ananda kernel: [    0.000472] last_pfn = 0xce000 max_arch_pfn = 0x400000000
Aug 26 09:07:59 ananda kernel: [    0.000484] esrt: Reserving ESRT space from 0x00000000be46b000 to 0x00000000be46b100.
Aug 26 09:07:59 ananda kernel: [    0.000494] Using GB pages for direct mapping
Aug 26 09:07:59 ananda kernel: [    0.000869] Secure boot could not be determined
Aug 26 09:07:59 ananda kernel: [    0.000870] RAMDISK: [mem 0x361b9000-0x370d3fff]
Aug 26 09:07:59 ananda kernel: [    0.000874] ACPI: Early table checksum verification disabled
Aug 26 09:07:59 ananda kernel: [    0.000877] ACPI: RSDP 0x00000000CC3FD014 000024 (v02 LENOVO)
Aug 26 09:07:59 ananda kernel: [    0.000881] ACPI: XSDT 0x00000000CC3FB188 000104 (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000885] ACPI: FACP 0x00000000BE498000 000114 (v06 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000889] ACPI: DSDT 0x00000000BE484000 00E991 (v01 LENOVO TP-R1B   000012E0 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000891] ACPI: FACS 0x00000000CC218000 000040
Aug 26 09:07:59 ananda kernel: [    0.000893] ACPI: SSDT 0x00000000BF751000 0000A2 (v01 LENOVO PID0Ssdt 00000001 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000895] ACPI: SSDT 0x00000000BF74F000 00118F (v01 LENOVO UsbCTabl 00000001 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000898] ACPI: SSDT 0x00000000BF742000 007216 (v02 LENOVO TP-R1B   00000002 MSFT 04000000)
Aug 26 09:07:59 ananda kernel: [    0.000900] ACPI: IVRS 0x00000000BF741000 0001A4 (v02 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000902] ACPI: SSDT 0x00000000BF703000 000266 (v01 LENOVO STD3     00000001 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000904] ACPI: SSDT 0x00000000BF6EF000 000632 (v02 LENOVO Tpm2Tabl 00001000 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000906] ACPI: TPM2 0x00000000BF6EE000 000034 (v03 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000908] ACPI: SSDT 0x00000000BF6ED000 000924 (v01 LENOVO WmiTable 00000001 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000910] ACPI: MSDM 0x00000000BF6B4000 000055 (v03 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000912] ACPI: BATB 0x00000000BF69F000 00004A (v02 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000914] ACPI: HPET 0x00000000BE497000 000038 (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000917] ACPI: APIC 0x00000000BE496000 000138 (v02 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000919] ACPI: MCFG 0x00000000BE495000 00003C (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000921] ACPI: SBST 0x00000000BE494000 000030 (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000923] ACPI: WSMT 0x00000000BE493000 000028 (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000925] ACPI: VFCT 0x00000000BE476000 00D484 (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000927] ACPI: SSDT 0x00000000BE472000 0039F4 (v01 LENOVO TP-R1B   00000001 AMD  00000001)
Aug 26 09:07:59 ananda kernel: [    0.000929] ACPI: CRAT 0x00000000BE471000 000F00 (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000931] ACPI: CDIT 0x00000000BE470000 000029 (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000933] ACPI: FPDT 0x00000000BF6C6000 000034 (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000935] ACPI: SSDT 0x00000000BE46E000 0013CF (v01 LENOVO TP-R1B   00000001 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000937] ACPI: SSDT 0x00000000BE46C000 001576 (v01 LENOVO TP-R1B   00000001 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000939] ACPI: SSDT 0x00000000BE467000 00353C (v01 LENOVO TP-R1B   00000001 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000941] ACPI: BGRT 0x00000000BE466000 000038 (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000943] ACPI: UEFI 0x00000000CC217000 00013E (v01 LENOVO TP-R1B   000012E0 PTEC 00000002)
Aug 26 09:07:59 ananda kernel: [    0.000945] ACPI: SSDT 0x00000000BF74E000 000090 (v01 LENOVO TP-R1B   00000001 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000947] ACPI: SSDT 0x00000000BF74D000 0009AD (v01 LENOVO TP-R1B   00000001 INTL 20180313)
Aug 26 09:07:59 ananda kernel: [    0.000949] ACPI: Reserving FACP table memory at [mem 0xbe498000-0xbe498113]
Aug 26 09:07:59 ananda kernel: [    0.000950] ACPI: Reserving DSDT table memory at [mem 0xbe484000-0xbe492990]
Aug 26 09:07:59 ananda kernel: [    0.000951] ACPI: Reserving FACS table memory at [mem 0xcc218000-0xcc21803f]
Aug 26 09:07:59 ananda kernel: [    0.000952] ACPI: Reserving SSDT table memory at [mem 0xbf751000-0xbf7510a1]
Aug 26 09:07:59 ananda kernel: [    0.000953] ACPI: Reserving SSDT table memory at [mem 0xbf74f000-0xbf75018e]
Aug 26 09:07:59 ananda kernel: [    0.000954] ACPI: Reserving SSDT table memory at [mem 0xbf742000-0xbf749215]
Aug 26 09:07:59 ananda kernel: [    0.000955] ACPI: Reserving IVRS table memory at [mem 0xbf741000-0xbf7411a3]
Aug 26 09:07:59 ananda kernel: [    0.000956] ACPI: Reserving SSDT table memory at [mem 0xbf703000-0xbf703265]
Aug 26 09:07:59 ananda kernel: [    0.000956] ACPI: Reserving SSDT table memory at [mem 0xbf6ef000-0xbf6ef631]
Aug 26 09:07:59 ananda kernel: [    0.000957] ACPI: Reserving TPM2 table memory at [mem 0xbf6ee000-0xbf6ee033]
Aug 26 09:07:59 ananda kernel: [    0.000958] ACPI: Reserving SSDT table memory at [mem 0xbf6ed000-0xbf6ed923]
Aug 26 09:07:59 ananda kernel: [    0.000959] ACPI: Reserving MSDM table memory at [mem 0xbf6b4000-0xbf6b4054]
Aug 26 09:07:59 ananda kernel: [    0.000960] ACPI: Reserving BATB table memory at [mem 0xbf69f000-0xbf69f049]
Aug 26 09:07:59 ananda kernel: [    0.000961] ACPI: Reserving HPET table memory at [mem 0xbe497000-0xbe497037]
Aug 26 09:07:59 ananda kernel: [    0.000961] ACPI: Reserving APIC table memory at [mem 0xbe496000-0xbe496137]
Aug 26 09:07:59 ananda kernel: [    0.000962] ACPI: Reserving MCFG table memory at [mem 0xbe495000-0xbe49503b]
Aug 26 09:07:59 ananda kernel: [    0.000963] ACPI: Reserving SBST table memory at [mem 0xbe494000-0xbe49402f]
Aug 26 09:07:59 ananda kernel: [    0.000964] ACPI: Reserving WSMT table memory at [mem 0xbe493000-0xbe493027]
Aug 26 09:07:59 ananda kernel: [    0.000965] ACPI: Reserving VFCT table memory at [mem 0xbe476000-0xbe483483]
Aug 26 09:07:59 ananda kernel: [    0.000966] ACPI: Reserving SSDT table memory at [mem 0xbe472000-0xbe4759f3]
Aug 26 09:07:59 ananda kernel: [    0.000967] ACPI: Reserving CRAT table memory at [mem 0xbe471000-0xbe471eff]
Aug 26 09:07:59 ananda kernel: [    0.000967] ACPI: Reserving CDIT table memory at [mem 0xbe470000-0xbe470028]
Aug 26 09:07:59 ananda kernel: [    0.000968] ACPI: Reserving FPDT table memory at [mem 0xbf6c6000-0xbf6c6033]
Aug 26 09:07:59 ananda kernel: [    0.000969] ACPI: Reserving SSDT table memory at [mem 0xbe46e000-0xbe46f3ce]
Aug 26 09:07:59 ananda kernel: [    0.000970] ACPI: Reserving SSDT table memory at [mem 0xbe46c000-0xbe46d575]
Aug 26 09:07:59 ananda kernel: [    0.000971] ACPI: Reserving SSDT table memory at [mem 0xbe467000-0xbe46a53b]
Aug 26 09:07:59 ananda kernel: [    0.000972] ACPI: Reserving BGRT table memory at [mem 0xbe466000-0xbe466037]
Aug 26 09:07:59 ananda kernel: [    0.000973] ACPI: Reserving UEFI table memory at [mem 0xcc217000-0xcc21713d]
Aug 26 09:07:59 ananda kernel: [    0.000974] ACPI: Reserving SSDT table memory at [mem 0xbf74e000-0xbf74e08f]
Aug 26 09:07:59 ananda kernel: [    0.000975] ACPI: Reserving SSDT table memory at [mem 0xbf74d000-0xbf74d9ac]
Aug 26 09:07:59 ananda kernel: [    0.001014] Zone ranges:
Aug 26 09:07:59 ananda kernel: [    0.001015]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Aug 26 09:07:59 ananda kernel: [    0.001016]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Aug 26 09:07:59 ananda kernel: [    0.001018]   Normal   [mem 0x0000000100000000-0x00000007af33ffff]
Aug 26 09:07:59 ananda kernel: [    0.001019]   Device   empty
Aug 26 09:07:59 ananda kernel: [    0.001020] Movable zone start for each node
Aug 26 09:07:59 ananda kernel: [    0.001020] Early memory node ranges
Aug 26 09:07:59 ananda kernel: [    0.001021]   node   0: [mem 0x0000000000001000-0x000000000009efff]
Aug 26 09:07:59 ananda kernel: [    0.001022]   node   0: [mem 0x0000000000100000-0x0000000009bfffff]
Aug 26 09:07:59 ananda kernel: [    0.001023]   node   0: [mem 0x0000000009d01000-0x0000000009efffff]
Aug 26 09:07:59 ananda kernel: [    0.001024]   node   0: [mem 0x0000000009f10000-0x00000000bd9ddfff]
Aug 26 09:07:59 ananda kernel: [    0.001025]   node   0: [mem 0x00000000cc3fe000-0x00000000cdffffff]
Aug 26 09:07:59 ananda kernel: [    0.001025]   node   0: [mem 0x0000000100000000-0x00000007af33ffff]
Aug 26 09:07:59 ananda kernel: [    0.001028] Initmem setup node 0 [mem 0x0000000000001000-0x00000007af33ffff]
Aug 26 09:07:59 ananda kernel: [    0.001033] On node 0, zone DMA: 1 pages in unavailable ranges
Aug 26 09:07:59 ananda kernel: [    0.001048] On node 0, zone DMA: 97 pages in unavailable ranges
Aug 26 09:07:59 ananda kernel: [    0.001181] On node 0, zone DMA32: 257 pages in unavailable ranges
Aug 26 09:07:59 ananda kernel: [    0.006397] On node 0, zone DMA32: 16 pages in unavailable ranges
Aug 26 09:07:59 ananda kernel: [    0.006676] On node 0, zone DMA32: 27168 pages in unavailable ranges
Aug 26 09:07:59 ananda kernel: [    0.056422] On node 0, zone Normal: 8192 pages in unavailable ranges
Aug 26 09:07:59 ananda kernel: [    0.056453] On node 0, zone Normal: 3264 pages in unavailable ranges
Aug 26 09:07:59 ananda kernel: [    0.057159] ACPI: PM-Timer IO Port: 0x408
Aug 26 09:07:59 ananda kernel: [    0.057165] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057167] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057167] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057168] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057169] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057170] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057170] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057171] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057172] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057173] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057173] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057174] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057175] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057175] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057176] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057177] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
Aug 26 09:07:59 ananda kernel: [    0.057189] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0-23
Aug 26 09:07:59 ananda kernel: [    0.057194] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 24-55
Aug 26 09:07:59 ananda kernel: [    0.057196] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Aug 26 09:07:59 ananda kernel: [    0.057197] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Aug 26 09:07:59 ananda kernel: [    0.057200] ACPI: Using ACPI (MADT) for SMP configuration information
Aug 26 09:07:59 ananda kernel: [    0.057201] ACPI: HPET id: 0x43538210 base: 0xfed00000
Aug 26 09:07:59 ananda kernel: [    0.057210] e820: update [mem 0xb9595000-0xb9625fff] usable ==> reserved
Aug 26 09:07:59 ananda kernel: [    0.057218] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
Aug 26 09:07:59 ananda kernel: [    0.057235] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
Aug 26 09:07:59 ananda kernel: [    0.057237] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
Aug 26 09:07:59 ananda kernel: [    0.057238] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
Aug 26 09:07:59 ananda kernel: [    0.057238] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
Aug 26 09:07:59 ananda kernel: [    0.057240] PM: hibernation: Registered nosave memory: [mem 0x09c00000-0x09d00fff]
Aug 26 09:07:59 ananda kernel: [    0.057241] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0x09f0ffff]
Aug 26 09:07:59 ananda kernel: [    0.057243] PM: hibernation: Registered nosave memory: [mem 0xb9595000-0xb9625fff]
Aug 26 09:07:59 ananda kernel: [    0.057244] PM: hibernation: Registered nosave memory: [mem 0xbd9de000-0xbdbddfff]
Aug 26 09:07:59 ananda kernel: [    0.057245] PM: hibernation: Registered nosave memory: [mem 0xbdbde000-0xca37dfff]
Aug 26 09:07:59 ananda kernel: [    0.057245] PM: hibernation: Registered nosave memory: [mem 0xca37e000-0xcc37dfff]
Aug 26 09:07:59 ananda kernel: [    0.057246] PM: hibernation: Registered nosave memory: [mem 0xcc37e000-0xcc3fdfff]
Aug 26 09:07:59 ananda kernel: [    0.057248] PM: hibernation: Registered nosave memory: [mem 0xce000000-0xcfffffff]
Aug 26 09:07:59 ananda kernel: [    0.057248] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xf7ffffff]
Aug 26 09:07:59 ananda kernel: [    0.057249] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
Aug 26 09:07:59 ananda kernel: [    0.057250] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfddfffff]
Aug 26 09:07:59 ananda kernel: [    0.057250] PM: hibernation: Registered nosave memory: [mem 0xfde00000-0xfdefffff]
Aug 26 09:07:59 ananda kernel: [    0.057251] PM: hibernation: Registered nosave memory: [mem 0xfdf00000-0xfed7ffff]
Aug 26 09:07:59 ananda kernel: [    0.057252] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed80fff]
Aug 26 09:07:59 ananda kernel: [    0.057252] PM: hibernation: Registered nosave memory: [mem 0xfed81000-0xffffffff]
Aug 26 09:07:59 ananda kernel: [    0.057254] [mem 0xd0000000-0xf7ffffff] available for PCI devices
Aug 26 09:07:59 ananda kernel: [    0.057255] Booting paravirtualized kernel on bare hardware
Aug 26 09:07:59 ananda kernel: [    0.057258] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
Aug 26 09:07:59 ananda kernel: [    0.059958] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:16 nr_node_ids:1
Aug 26 09:07:59 ananda kernel: [    0.060509] percpu: Embedded 55 pages/cpu s185048 r8192 d32040 u262144
Aug 26 09:07:59 ananda kernel: [    0.060518] pcpu-alloc: s185048 r8192 d32040 u262144 alloc=1*2097152
Aug 26 09:07:59 ananda kernel: [    0.060520] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
Aug 26 09:07:59 ananda kernel: [    0.060546] Built 1 zonelists, mobility grouping on.  Total pages: 7670638
Aug 26 09:07:59 ananda kernel: [    0.060548] Kernel command line: BOOT_IMAGE=/vmlinuz-5.14.0-rc7-t14 root=/dev/mapper/nvme-system ro rootflags=subvol=system
Aug 26 09:07:59 ananda kernel: [    0.060571] Unknown command line parameters: BOOT_IMAGE=/vmlinuz-5.14.0-rc7-t14
Aug 26 09:07:59 ananda kernel: [    0.064040] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.065789] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.065826] mem auto-init: stack:off, heap alloc:on, heap free:off
Aug 26 09:07:59 ananda kernel: [    0.123275] Memory: 30468624K/31170228K available (12295K kernel code, 1634K rwdata, 2736K rodata, 1572K init, 2176K bss, 701344K reserved, 0K cma-reserved)
Aug 26 09:07:59 ananda kernel: [    0.123283] random: get_random_u64 called from __kmem_cache_create+0x26/0x4b0 with crng_init=0
Aug 26 09:07:59 ananda kernel: [    0.123420] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
Aug 26 09:07:59 ananda kernel: [    0.123434] ftrace: allocating 33964 entries in 133 pages
Aug 26 09:07:59 ananda kernel: [    0.131515] ftrace: allocated 133 pages with 3 groups
Aug 26 09:07:59 ananda kernel: [    0.131619] rcu: Preemptible hierarchical RCU implementation.
Aug 26 09:07:59 ananda kernel: [    0.131620] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=16.
Aug 26 09:07:59 ananda kernel: [    0.131621] 	Trampoline variant of Tasks RCU enabled.
Aug 26 09:07:59 ananda kernel: [    0.131622] 	Rude variant of Tasks RCU enabled.
Aug 26 09:07:59 ananda kernel: [    0.131623] 	Tracing variant of Tasks RCU enabled.
Aug 26 09:07:59 ananda kernel: [    0.131623] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
Aug 26 09:07:59 ananda kernel: [    0.131624] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
Aug 26 09:07:59 ananda kernel: [    0.134028] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
Aug 26 09:07:59 ananda kernel: [    0.134347] Console: colour dummy device 80x25
Aug 26 09:07:59 ananda kernel: [    0.134549] printk: console [tty0] enabled
Aug 26 09:07:59 ananda kernel: [    0.134558] ACPI: Core revision 20210604
Aug 26 09:07:59 ananda kernel: [    0.134734] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
Aug 26 09:07:59 ananda kernel: [    0.134753] APIC: Switch to symmetric I/O mode setup
Aug 26 09:07:59 ananda kernel: [    0.134755] Switched APIC routing to physical flat.
Aug 26 09:07:59 ananda kernel: [    0.135470] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Aug 26 09:07:59 ananda kernel: [    0.139758] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1875b4ef64c, max_idle_ns: 440795203028 ns
Aug 26 09:07:59 ananda kernel: [    0.139767] Calibrating delay loop (skipped), value calculated using timer frequency.. 3393.79 BogoMIPS (lpj=1696898)
Aug 26 09:07:59 ananda kernel: [    0.139771] pid_max: default: 32768 minimum: 301
Aug 26 09:07:59 ananda kernel: [    0.141029] LSM: Security Framework initializing
Aug 26 09:07:59 ananda kernel: [    0.141063] AppArmor: AppArmor initialized
Aug 26 09:07:59 ananda kernel: [    0.141154] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.141229] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.141453] x86/cpu: User Mode Instruction Prevention (UMIP) activated
Aug 26 09:07:59 ananda kernel: [    0.141507] LVT offset 1 assigned for vector 0xf9
Aug 26 09:07:59 ananda kernel: [    0.141612] LVT offset 2 assigned for vector 0xf4
Aug 26 09:07:59 ananda kernel: [    0.141637] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
Aug 26 09:07:59 ananda kernel: [    0.141639] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
Aug 26 09:07:59 ananda kernel: [    0.141645] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Aug 26 09:07:59 ananda kernel: [    0.141648] Spectre V2 : Mitigation: Full AMD retpoline
Aug 26 09:07:59 ananda kernel: [    0.141649] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Aug 26 09:07:59 ananda kernel: [    0.141651] Spectre V2 : Enabling Restricted Speculation for firmware calls
Aug 26 09:07:59 ananda kernel: [    0.141654] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Aug 26 09:07:59 ananda kernel: [    0.141656] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
Aug 26 09:07:59 ananda kernel: [    0.141658] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
Aug 26 09:07:59 ananda kernel: [    0.144192] Freeing SMP alternatives memory: 32K
Aug 26 09:07:59 ananda kernel: [    0.247803] smpboot: CPU0: AMD Ryzen 7 PRO 4750U with Radeon Graphics (family: 0x17, model: 0x60, stepping: 0x1)
Aug 26 09:07:59 ananda kernel: [    0.247900] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
Aug 26 09:07:59 ananda kernel: [    0.247907] ... version:                0
Aug 26 09:07:59 ananda kernel: [    0.247908] ... bit width:              48
Aug 26 09:07:59 ananda kernel: [    0.247910] ... generic registers:      6
Aug 26 09:07:59 ananda kernel: [    0.247911] ... value mask:             0000ffffffffffff
Aug 26 09:07:59 ananda kernel: [    0.247913] ... max period:             00007fffffffffff
Aug 26 09:07:59 ananda kernel: [    0.247915] ... fixed-purpose events:   0
Aug 26 09:07:59 ananda kernel: [    0.247916] ... event mask:             000000000000003f
Aug 26 09:07:59 ananda kernel: [    0.247968] rcu: Hierarchical SRCU implementation.
Aug 26 09:07:59 ananda kernel: [    0.248176] smp: Bringing up secondary CPUs ...
Aug 26 09:07:59 ananda kernel: [    0.248250] x86: Booting SMP configuration:
Aug 26 09:07:59 ananda kernel: [    0.248253] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
Aug 26 09:07:59 ananda kernel: [    0.266807] smp: Brought up 1 node, 16 CPUs
Aug 26 09:07:59 ananda kernel: [    0.266814] smpboot: Max logical packages: 1
Aug 26 09:07:59 ananda kernel: [    0.266816] smpboot: Total of 16 processors activated (54300.73 BogoMIPS)
Aug 26 09:07:59 ananda kernel: [    0.269044] devtmpfs: initialized
Aug 26 09:07:59 ananda kernel: [    0.269044] x86/mm: Memory block size: 128MB
Aug 26 09:07:59 ananda kernel: [    0.270103] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0ffff] (65536 bytes)
Aug 26 09:07:59 ananda kernel: [    0.270103] ACPI: PM: Registering ACPI NVS region [mem 0xca37e000-0xcc37dfff] (33554432 bytes)
Aug 26 09:07:59 ananda kernel: [    0.270103] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
Aug 26 09:07:59 ananda kernel: [    0.270106] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.270155] pinctrl core: initialized pinctrl subsystem
Aug 26 09:07:59 ananda kernel: [    0.270769] NET: Registered PF_NETLINK/PF_ROUTE protocol family
Aug 26 09:07:59 ananda kernel: [    0.270810] audit: initializing netlink subsys (disabled)
Aug 26 09:07:59 ananda kernel: [    0.270815] audit: type=2000 audit(1629961655.136:1): state=initialized audit_enabled=0 res=1
Aug 26 09:07:59 ananda kernel: [    0.270820] thermal_sys: Registered thermal governor 'fair_share'
Aug 26 09:07:59 ananda kernel: [    0.270821] thermal_sys: Registered thermal governor 'bang_bang'
Aug 26 09:07:59 ananda kernel: [    0.270824] thermal_sys: Registered thermal governor 'step_wise'
Aug 26 09:07:59 ananda kernel: [    0.270825] thermal_sys: Registered thermal governor 'user_space'
Aug 26 09:07:59 ananda kernel: [    0.270837] cpuidle: using governor ladder
Aug 26 09:07:59 ananda kernel: [    0.270837] cpuidle: using governor menu
Aug 26 09:07:59 ananda kernel: [    0.270837] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
Aug 26 09:07:59 ananda kernel: [    0.270837] ACPI: bus type PCI registered
Aug 26 09:07:59 ananda kernel: [    0.270837] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Aug 26 09:07:59 ananda kernel: [    0.270837] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
Aug 26 09:07:59 ananda kernel: [    0.270837] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
Aug 26 09:07:59 ananda kernel: [    0.270846] PCI: Using configuration type 1 for base access
Aug 26 09:07:59 ananda kernel: [    0.272249] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
Aug 26 09:07:59 ananda kernel: [    0.272249] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
Aug 26 09:07:59 ananda kernel: [    0.351785] ACPI: Added _OSI(Module Device)
Aug 26 09:07:59 ananda kernel: [    0.351788] ACPI: Added _OSI(Processor Device)
Aug 26 09:07:59 ananda kernel: [    0.351790] ACPI: Added _OSI(3.0 _SCP Extensions)
Aug 26 09:07:59 ananda kernel: [    0.351791] ACPI: Added _OSI(Processor Aggregator Device)
Aug 26 09:07:59 ananda kernel: [    0.351793] ACPI: Added _OSI(Linux-Dell-Video)
Aug 26 09:07:59 ananda kernel: [    0.351794] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
Aug 26 09:07:59 ananda kernel: [    0.351796] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
Aug 26 09:07:59 ananda kernel: [    0.359717] ACPI: 13 ACPI AML tables successfully acquired and loaded
Aug 26 09:07:59 ananda kernel: [    0.360502] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
Aug 26 09:07:59 ananda kernel: [    0.372217] ACPI: EC: EC started
Aug 26 09:07:59 ananda kernel: [    0.372219] ACPI: EC: interrupt blocked
Aug 26 09:07:59 ananda kernel: [    0.372405] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
Aug 26 09:07:59 ananda kernel: [    0.372408] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle transactions
Aug 26 09:07:59 ananda kernel: [    0.372410] ACPI: Interpreter enabled
Aug 26 09:07:59 ananda kernel: [    0.372422] ACPI: PM: (supports S0 S3 S4 S5)
Aug 26 09:07:59 ananda kernel: [    0.372424] ACPI: Using IOAPIC for interrupt routing
Aug 26 09:07:59 ananda kernel: [    0.372501] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Aug 26 09:07:59 ananda kernel: [    0.372662] ACPI: Enabled 3 GPEs in block 00 to 1F
Aug 26 09:07:59 ananda kernel: [    0.373277] ACPI: PM: Power Resource [P0U1]
Aug 26 09:07:59 ananda kernel: [    0.373289] ACPI: PM: Power Resource [P3U1]
Aug 26 09:07:59 ananda kernel: [    0.373464] ACPI: PM: Power Resource [WRST]
Aug 26 09:07:59 ananda kernel: [    0.373514] ACPI: PM: Power Resource [P0NV]
Aug 26 09:07:59 ananda kernel: [    0.373952] ACPI: PM: Power Resource [P0S0]
Aug 26 09:07:59 ananda kernel: [    0.373965] ACPI: PM: Power Resource [P3S0]
Aug 26 09:07:59 ananda kernel: [    0.374007] ACPI: PM: Power Resource [P0S1]
Aug 26 09:07:59 ananda kernel: [    0.374016] ACPI: PM: Power Resource [P3S1]
Aug 26 09:07:59 ananda kernel: [    0.375627] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Aug 26 09:07:59 ananda kernel: [    0.375633] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
Aug 26 09:07:59 ananda kernel: [    0.375705] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR]
Aug 26 09:07:59 ananda kernel: [    0.375770] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
Aug 26 09:07:59 ananda kernel: [    0.375773] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
Aug 26 09:07:59 ananda kernel: [    0.375776] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
Aug 26 09:07:59 ananda kernel: [    0.375877] PCI host bridge to bus 0000:00
Aug 26 09:07:59 ananda kernel: [    0.375879] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Aug 26 09:07:59 ananda kernel: [    0.375881] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c1fff window]
Aug 26 09:07:59 ananda kernel: [    0.375883] pci_bus 0000:00: root bus resource [mem 0x000c2000-0x000c3fff window]
Aug 26 09:07:59 ananda kernel: [    0.375885] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c5fff window]
Aug 26 09:07:59 ananda kernel: [    0.375887] pci_bus 0000:00: root bus resource [mem 0x000c6000-0x000c7fff window]
Aug 26 09:07:59 ananda kernel: [    0.375889] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000c9fff window]
Aug 26 09:07:59 ananda kernel: [    0.375891] pci_bus 0000:00: root bus resource [mem 0x000ca000-0x000cbfff window]
Aug 26 09:07:59 ananda kernel: [    0.375893] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cdfff window]
Aug 26 09:07:59 ananda kernel: [    0.375895] pci_bus 0000:00: root bus resource [mem 0x000ce000-0x000cffff window]
Aug 26 09:07:59 ananda kernel: [    0.375897] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d1fff window]
Aug 26 09:07:59 ananda kernel: [    0.375899] pci_bus 0000:00: root bus resource [mem 0x000d2000-0x000d3fff window]
Aug 26 09:07:59 ananda kernel: [    0.375901] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d5fff window]
Aug 26 09:07:59 ananda kernel: [    0.375903] pci_bus 0000:00: root bus resource [mem 0x000d6000-0x000d7fff window]
Aug 26 09:07:59 ananda kernel: [    0.375905] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000d9fff window]
Aug 26 09:07:59 ananda kernel: [    0.375907] pci_bus 0000:00: root bus resource [mem 0x000da000-0x000dbfff window]
Aug 26 09:07:59 ananda kernel: [    0.375909] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000ddfff window]
Aug 26 09:07:59 ananda kernel: [    0.375911] pci_bus 0000:00: root bus resource [mem 0x000de000-0x000dffff window]
Aug 26 09:07:59 ananda kernel: [    0.375913] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e1fff window]
Aug 26 09:07:59 ananda kernel: [    0.375914] pci_bus 0000:00: root bus resource [mem 0x000e2000-0x000e3fff window]
Aug 26 09:07:59 ananda kernel: [    0.375916] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e5fff window]
Aug 26 09:07:59 ananda kernel: [    0.375918] pci_bus 0000:00: root bus resource [mem 0x000e6000-0x000e7fff window]
Aug 26 09:07:59 ananda kernel: [    0.375920] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000e9fff window]
Aug 26 09:07:59 ananda kernel: [    0.375922] pci_bus 0000:00: root bus resource [mem 0x000ea000-0x000ebfff window]
Aug 26 09:07:59 ananda kernel: [    0.375924] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000edfff window]
Aug 26 09:07:59 ananda kernel: [    0.375926] pci_bus 0000:00: root bus resource [mem 0x000ee000-0x000effff window]
Aug 26 09:07:59 ananda kernel: [    0.375928] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xf7ffffff window]
Aug 26 09:07:59 ananda kernel: [    0.375930] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfdffffff window]
Aug 26 09:07:59 ananda kernel: [    0.375932] pci_bus 0000:00: root bus resource [mem 0x830000000-0xffffffffff window]
Aug 26 09:07:59 ananda kernel: [    0.375934] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Aug 26 09:07:59 ananda kernel: [    0.375937] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Aug 26 09:07:59 ananda kernel: [    0.375939] pci_bus 0000:00: root bus resource [bus 00-ff]
Aug 26 09:07:59 ananda kernel: [    0.375949] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.376017] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600
Aug 26 09:07:59 ananda kernel: [    0.376084] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.376134] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.376181] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400
Aug 26 09:07:59 ananda kernel: [    0.376237] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.376309] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400
Aug 26 09:07:59 ananda kernel: [    0.376364] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.376434] pci 0000:00:02.3: [1022:1634] type 01 class 0x060400
Aug 26 09:07:59 ananda kernel: [    0.376495] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.376558] pci 0000:00:02.4: [1022:1634] type 01 class 0x060400
Aug 26 09:07:59 ananda kernel: [    0.376613] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.376688] pci 0000:00:02.6: [1022:1634] type 01 class 0x060400
Aug 26 09:07:59 ananda kernel: [    0.376743] pci 0000:00:02.6: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.376816] pci 0000:00:02.7: [1022:1634] type 01 class 0x060400
Aug 26 09:07:59 ananda kernel: [    0.376870] pci 0000:00:02.7: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.376946] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.376992] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400
Aug 26 09:07:59 ananda kernel: [    0.377012] pci 0000:00:08.1: enabling Extended Tags
Aug 26 09:07:59 ananda kernel: [    0.377040] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.377122] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
Aug 26 09:07:59 ananda kernel: [    0.377210] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
Aug 26 09:07:59 ananda kernel: [    0.377318] pci 0000:00:18.0: [1022:1448] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.377346] pci 0000:00:18.1: [1022:1449] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.377375] pci 0000:00:18.2: [1022:144a] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.377400] pci 0000:00:18.3: [1022:144b] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.377428] pci 0000:00:18.4: [1022:144c] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.377454] pci 0000:00:18.5: [1022:144d] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.377480] pci 0000:00:18.6: [1022:144e] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.377506] pci 0000:00:18.7: [1022:144f] type 00 class 0x060000
Aug 26 09:07:59 ananda kernel: [    0.377783] pci 0000:01:00.0: [144d:a80a] type 00 class 0x010802
Aug 26 09:07:59 ananda kernel: [    0.377801] pci 0000:01:00.0: reg 0x10: [mem 0xfd900000-0xfd903fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.377963] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:02.1 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
Aug 26 09:07:59 ananda kernel: [    0.378015] pci 0000:00:02.1: PCI bridge to [bus 01]
Aug 26 09:07:59 ananda kernel: [    0.378019] pci 0000:00:02.1:   bridge window [mem 0xfd900000-0xfd9fffff]
Aug 26 09:07:59 ananda kernel: [    0.378068] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
Aug 26 09:07:59 ananda kernel: [    0.378085] pci 0000:02:00.0: reg 0x10: [io  0x3400-0x34ff]
Aug 26 09:07:59 ananda kernel: [    0.378107] pci 0000:02:00.0: reg 0x18: [mem 0xfd814000-0xfd814fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.378121] pci 0000:02:00.0: reg 0x20: [mem 0xfd800000-0xfd803fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.378208] pci 0000:02:00.0: supports D1 D2
Aug 26 09:07:59 ananda kernel: [    0.378210] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.378320] pci 0000:02:00.1: [10ec:816a] type 00 class 0x070002
Aug 26 09:07:59 ananda kernel: [    0.378335] pci 0000:02:00.1: reg 0x10: [io  0x3200-0x32ff]
Aug 26 09:07:59 ananda kernel: [    0.378352] pci 0000:02:00.1: reg 0x18: [mem 0xfd815000-0xfd815fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.378364] pci 0000:02:00.1: reg 0x20: [mem 0xfd804000-0xfd807fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.378442] pci 0000:02:00.1: supports D1 D2
Aug 26 09:07:59 ananda kernel: [    0.378443] pci 0000:02:00.1: PME# supported from D0 D1 D2 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.378532] pci 0000:02:00.2: [10ec:816b] type 00 class 0x070002
Aug 26 09:07:59 ananda kernel: [    0.378546] pci 0000:02:00.2: reg 0x10: [io  0x3100-0x31ff]
Aug 26 09:07:59 ananda kernel: [    0.378563] pci 0000:02:00.2: reg 0x18: [mem 0xfd816000-0xfd816fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.378575] pci 0000:02:00.2: reg 0x20: [mem 0xfd808000-0xfd80bfff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.378653] pci 0000:02:00.2: supports D1 D2
Aug 26 09:07:59 ananda kernel: [    0.378655] pci 0000:02:00.2: PME# supported from D0 D1 D2 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.378776] pci 0000:02:00.3: [10ec:816c] type 00 class 0x0c0701
Aug 26 09:07:59 ananda kernel: [    0.378790] pci 0000:02:00.3: reg 0x10: [io  0x3000-0x30ff]
Aug 26 09:07:59 ananda kernel: [    0.378807] pci 0000:02:00.3: reg 0x18: [mem 0xfd817000-0xfd817fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.378819] pci 0000:02:00.3: reg 0x20: [mem 0xfd80c000-0xfd80ffff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.378897] pci 0000:02:00.3: supports D1 D2
Aug 26 09:07:59 ananda kernel: [    0.378899] pci 0000:02:00.3: PME# supported from D0 D1 D2 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.378984] pci 0000:02:00.4: [10ec:816d] type 00 class 0x0c0320
Aug 26 09:07:59 ananda kernel: [    0.379001] pci 0000:02:00.4: reg 0x10: [mem 0xfd818000-0xfd818fff]
Aug 26 09:07:59 ananda kernel: [    0.379022] pci 0000:02:00.4: reg 0x18: [mem 0xfd810000-0xfd813fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.379118] pci 0000:02:00.4: supports D1 D2
Aug 26 09:07:59 ananda kernel: [    0.379119] pci 0000:02:00.4: PME# supported from D0 D1 D2 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.379246] pci 0000:00:02.2: PCI bridge to [bus 02]
Aug 26 09:07:59 ananda kernel: [    0.379249] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
Aug 26 09:07:59 ananda kernel: [    0.379252] pci 0000:00:02.2:   bridge window [mem 0xfd800000-0xfd8fffff]
Aug 26 09:07:59 ananda kernel: [    0.379566] pci 0000:03:00.0: [8086:2723] type 00 class 0x028000
Aug 26 09:07:59 ananda kernel: [    0.379618] pci 0000:03:00.0: reg 0x10: [mem 0xfd700000-0xfd703fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.379786] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.380188] pci 0000:00:02.3: PCI bridge to [bus 03]
Aug 26 09:07:59 ananda kernel: [    0.380192] pci 0000:00:02.3:   bridge window [mem 0xfd700000-0xfd7fffff]
Aug 26 09:07:59 ananda kernel: [    0.380239] pci 0000:04:00.0: [10ec:522a] type 00 class 0xff0000
Aug 26 09:07:59 ananda kernel: [    0.380253] pci 0000:04:00.0: reg 0x10: [mem 0xfd600000-0xfd600fff]
Aug 26 09:07:59 ananda kernel: [    0.380352] pci 0000:04:00.0: supports D1 D2
Aug 26 09:07:59 ananda kernel: [    0.380354] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.380462] pci 0000:00:02.4: PCI bridge to [bus 04]
Aug 26 09:07:59 ananda kernel: [    0.380466] pci 0000:00:02.4:   bridge window [mem 0xfd600000-0xfd6fffff]
Aug 26 09:07:59 ananda kernel: [    0.380511] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000
Aug 26 09:07:59 ananda kernel: [    0.380525] pci 0000:05:00.0: reg 0x10: [io  0x2000-0x20ff]
Aug 26 09:07:59 ananda kernel: [    0.380542] pci 0000:05:00.0: reg 0x18: [mem 0xfd504000-0xfd504fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.380554] pci 0000:05:00.0: reg 0x20: [mem 0xfd500000-0xfd503fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.380635] pci 0000:05:00.0: supports D1 D2
Aug 26 09:07:59 ananda kernel: [    0.380636] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.380754] pci 0000:00:02.6: PCI bridge to [bus 05]
Aug 26 09:07:59 ananda kernel: [    0.380757] pci 0000:00:02.6:   bridge window [io  0x2000-0x2fff]
Aug 26 09:07:59 ananda kernel: [    0.380760] pci 0000:00:02.6:   bridge window [mem 0xfd500000-0xfd5fffff]
Aug 26 09:07:59 ananda kernel: [    0.380804] pci 0000:06:00.0: [1912:0015] type 00 class 0x0c0330
Aug 26 09:07:59 ananda kernel: [    0.380825] pci 0000:06:00.0: reg 0x10: [mem 0xfd400000-0xfd401fff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.380921] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.380993] pci 0000:00:02.7: PCI bridge to [bus 06]
Aug 26 09:07:59 ananda kernel: [    0.380997] pci 0000:00:02.7:   bridge window [mem 0xfd400000-0xfd4fffff]
Aug 26 09:07:59 ananda kernel: [    0.381045] pci 0000:07:00.0: [1002:1636] type 00 class 0x030000
Aug 26 09:07:59 ananda kernel: [    0.381056] pci 0000:07:00.0: reg 0x10: [mem 0x860000000-0x86fffffff 64bit pref]
Aug 26 09:07:59 ananda kernel: [    0.381064] pci 0000:07:00.0: reg 0x18: [mem 0x870000000-0x8701fffff 64bit pref]
Aug 26 09:07:59 ananda kernel: [    0.381070] pci 0000:07:00.0: reg 0x20: [io  0x1000-0x10ff]
Aug 26 09:07:59 ananda kernel: [    0.381075] pci 0000:07:00.0: reg 0x24: [mem 0xfd300000-0xfd37ffff]
Aug 26 09:07:59 ananda kernel: [    0.381084] pci 0000:07:00.0: enabling Extended Tags
Aug 26 09:07:59 ananda kernel: [    0.381094] pci 0000:07:00.0: BAR 0: assigned to efifb
Aug 26 09:07:59 ananda kernel: [    0.381130] pci 0000:07:00.0: PME# supported from D1 D2 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.381197] pci 0000:07:00.1: [1002:1637] type 00 class 0x040300
Aug 26 09:07:59 ananda kernel: [    0.381205] pci 0000:07:00.1: reg 0x10: [mem 0xfd3c8000-0xfd3cbfff]
Aug 26 09:07:59 ananda kernel: [    0.381225] pci 0000:07:00.1: enabling Extended Tags
Aug 26 09:07:59 ananda kernel: [    0.381250] pci 0000:07:00.1: PME# supported from D1 D2 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.381296] pci 0000:07:00.2: [1022:15df] type 00 class 0x108000
Aug 26 09:07:59 ananda kernel: [    0.381308] pci 0000:07:00.2: reg 0x18: [mem 0xfd200000-0xfd2fffff]
Aug 26 09:07:59 ananda kernel: [    0.381318] pci 0000:07:00.2: reg 0x24: [mem 0xfd3cc000-0xfd3cdfff]
Aug 26 09:07:59 ananda kernel: [    0.381325] pci 0000:07:00.2: enabling Extended Tags
Aug 26 09:07:59 ananda kernel: [    0.381394] pci 0000:07:00.3: [1022:1639] type 00 class 0x0c0330
Aug 26 09:07:59 ananda kernel: [    0.381405] pci 0000:07:00.3: reg 0x10: [mem 0xfd000000-0xfd0fffff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.381427] pci 0000:07:00.3: enabling Extended Tags
Aug 26 09:07:59 ananda kernel: [    0.381454] pci 0000:07:00.3: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.381499] pci 0000:07:00.4: [1022:1639] type 00 class 0x0c0330
Aug 26 09:07:59 ananda kernel: [    0.381509] pci 0000:07:00.4: reg 0x10: [mem 0xfd100000-0xfd1fffff 64bit]
Aug 26 09:07:59 ananda kernel: [    0.381532] pci 0000:07:00.4: enabling Extended Tags
Aug 26 09:07:59 ananda kernel: [    0.381559] pci 0000:07:00.4: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.381605] pci 0000:07:00.5: [1022:15e2] type 00 class 0x048000
Aug 26 09:07:59 ananda kernel: [    0.381613] pci 0000:07:00.5: reg 0x10: [mem 0xfd380000-0xfd3bffff]
Aug 26 09:07:59 ananda kernel: [    0.381633] pci 0000:07:00.5: enabling Extended Tags
Aug 26 09:07:59 ananda kernel: [    0.381659] pci 0000:07:00.5: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.381703] pci 0000:07:00.6: [1022:15e3] type 00 class 0x040300
Aug 26 09:07:59 ananda kernel: [    0.381710] pci 0000:07:00.6: reg 0x10: [mem 0xfd3c0000-0xfd3c7fff]
Aug 26 09:07:59 ananda kernel: [    0.381730] pci 0000:07:00.6: enabling Extended Tags
Aug 26 09:07:59 ananda kernel: [    0.381756] pci 0000:07:00.6: PME# supported from D0 D3hot D3cold
Aug 26 09:07:59 ananda kernel: [    0.381813] pci 0000:00:08.1: PCI bridge to [bus 07]
Aug 26 09:07:59 ananda kernel: [    0.381816] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
Aug 26 09:07:59 ananda kernel: [    0.381819] pci 0000:00:08.1:   bridge window [mem 0xfd000000-0xfd3fffff]
Aug 26 09:07:59 ananda kernel: [    0.381822] pci 0000:00:08.1:   bridge window [mem 0x860000000-0x8701fffff 64bit pref]
Aug 26 09:07:59 ananda kernel: [    0.381847] pci_bus 0000:00: on NUMA node 0
Aug 26 09:07:59 ananda kernel: [    0.381953] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
Aug 26 09:07:59 ananda kernel: [    0.381990] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
Aug 26 09:07:59 ananda kernel: [    0.382015] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
Aug 26 09:07:59 ananda kernel: [    0.382051] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
Aug 26 09:07:59 ananda kernel: [    0.382083] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
Aug 26 09:07:59 ananda kernel: [    0.382106] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
Aug 26 09:07:59 ananda kernel: [    0.382128] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
Aug 26 09:07:59 ananda kernel: [    0.382151] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
Aug 26 09:07:59 ananda kernel: [    0.382564] ACPI: EC: interrupt unblocked
Aug 26 09:07:59 ananda kernel: [    0.382566] ACPI: EC: event unblocked
Aug 26 09:07:59 ananda kernel: [    0.382572] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
Aug 26 09:07:59 ananda kernel: [    0.382573] ACPI: EC: GPE=0x3
Aug 26 09:07:59 ananda kernel: [    0.382575] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization complete
Aug 26 09:07:59 ananda kernel: [    0.382577] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions and events
Aug 26 09:07:59 ananda kernel: [    0.382613] iommu: Default domain type: Translated 
Aug 26 09:07:59 ananda kernel: [    0.382622] pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
Aug 26 09:07:59 ananda kernel: [    0.382622] pci 0000:07:00.0: vgaarb: bridge control possible
Aug 26 09:07:59 ananda kernel: [    0.382622] pci 0000:07:00.0: vgaarb: setting as boot device
Aug 26 09:07:59 ananda kernel: [    0.382622] vgaarb: loaded
Aug 26 09:07:59 ananda kernel: [    0.383277] EDAC MC: Ver: 3.0.0
Aug 26 09:07:59 ananda kernel: [    0.383788] Registered efivars operations
Aug 26 09:07:59 ananda kernel: [    0.383839] NetLabel: Initializing
Aug 26 09:07:59 ananda kernel: [    0.383842] NetLabel:  domain hash size = 128
Aug 26 09:07:59 ananda kernel: [    0.383844] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
Aug 26 09:07:59 ananda kernel: [    0.383853] NetLabel:  unlabeled traffic allowed by default
Aug 26 09:07:59 ananda kernel: [    0.383855] PCI: Using ACPI for IRQ routing
Aug 26 09:07:59 ananda kernel: [    0.385907] PCI: pci_cache_line_size set to 64 bytes
Aug 26 09:07:59 ananda kernel: [    0.386778] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
Aug 26 09:07:59 ananda kernel: [    0.386780] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
Aug 26 09:07:59 ananda kernel: [    0.386780] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
Aug 26 09:07:59 ananda kernel: [    0.386781] e820: reserve RAM buffer [mem 0xb9595000-0xbbffffff]
Aug 26 09:07:59 ananda kernel: [    0.386782] e820: reserve RAM buffer [mem 0xbd9de000-0xbfffffff]
Aug 26 09:07:59 ananda kernel: [    0.386783] e820: reserve RAM buffer [mem 0xce000000-0xcfffffff]
Aug 26 09:07:59 ananda kernel: [    0.386783] e820: reserve RAM buffer [mem 0x7af340000-0x7afffffff]
Aug 26 09:07:59 ananda kernel: [    0.386802] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Aug 26 09:07:59 ananda kernel: [    0.386806] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
Aug 26 09:07:59 ananda kernel: [    0.388828] clocksource: Switched to clocksource tsc-early
Aug 26 09:07:59 ananda kernel: [    0.392760] AppArmor: AppArmor Filesystem Enabled
Aug 26 09:07:59 ananda kernel: [    0.392803] pnp: PnP ACPI init
Aug 26 09:07:59 ananda kernel: [    0.392949] system 00:00: [io  0x0f50-0x0f51] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.392953] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reserved
Aug 26 09:07:59 ananda kernel: [    0.392956] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.392959] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393116] system 00:02: [io  0x04d0-0x04d1] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393118] system 00:02: [io  0x0530-0x0537] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393120] system 00:02: [io  0x0400-0x0427] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393121] system 00:02: [io  0x0430] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393123] system 00:02: [io  0x0440-0x0447] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393125] system 00:02: [io  0x0b00-0x0b1f] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393126] system 00:02: [io  0x0b20-0x0b3f] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393128] system 00:02: [io  0x0c00-0x0c01] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393130] system 00:02: [io  0x0c14] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393131] system 00:02: [io  0x0c50-0x0c52] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393133] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393135] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393136] system 00:02: [io  0x0cd4-0x0cd5] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393138] system 00:02: [io  0x0cd6-0x0cd7] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393141] system 00:02: [io  0x0cd8-0x0cdf] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393142] system 00:02: [io  0x0cf9] could not be reserved
Aug 26 09:07:59 ananda kernel: [    0.393144] system 00:02: [io  0x8100-0x81ff window] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393146] system 00:02: [io  0x8200-0x82ff window] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393187] system 00:03: [mem 0x000e0000-0x000fffff] could not be reserved
Aug 26 09:07:59 ananda kernel: [    0.393189] system 00:03: [mem 0xff000000-0xffffffff] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393192] system 00:03: [mem 0xfec10000-0xfec1001f] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393194] system 00:03: [mem 0xfed00000-0xfed003ff] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393196] system 00:03: [mem 0xfed61000-0xfed613ff] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393198] system 00:03: [mem 0xfed80000-0xfed80fff] has been reserved
Aug 26 09:07:59 ananda kernel: [    0.393324] pnp: PnP ACPI: found 6 devices
Aug 26 09:07:59 ananda kernel: [    0.400060] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Aug 26 09:07:59 ananda kernel: [    0.400132] NET: Registered PF_INET protocol family
Aug 26 09:07:59 ananda kernel: [    0.400371] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.402324] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.402507] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.402750] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.402815] TCP: Hash tables configured (established 262144 bind 65536)
Aug 26 09:07:59 ananda kernel: [    0.402897] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.402972] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
Aug 26 09:07:59 ananda kernel: [    0.403053] NET: Registered PF_UNIX/PF_LOCAL protocol family
Aug 26 09:07:59 ananda kernel: [    0.403059] NET: Registered PF_XDP protocol family
Aug 26 09:07:59 ananda kernel: [    0.403076] pci 0000:00:02.3: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
Aug 26 09:07:59 ananda kernel: [    0.403080] pci 0000:00:02.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
Aug 26 09:07:59 ananda kernel: [    0.403098] pci 0000:00:02.3: BAR 15: assigned [mem 0x830000000-0x8301fffff 64bit pref]
Aug 26 09:07:59 ananda kernel: [    0.403104] pci 0000:00:02.3: BAR 13: assigned [io  0x4000-0x4fff]
Aug 26 09:07:59 ananda kernel: [    0.403107] pci 0000:00:02.1: PCI bridge to [bus 01]
Aug 26 09:07:59 ananda kernel: [    0.403111] pci 0000:00:02.1:   bridge window [mem 0xfd900000-0xfd9fffff]
Aug 26 09:07:59 ananda kernel: [    0.403116] pci 0000:00:02.2: PCI bridge to [bus 02]
Aug 26 09:07:59 ananda kernel: [    0.403119] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
Aug 26 09:07:59 ananda kernel: [    0.403122] pci 0000:00:02.2:   bridge window [mem 0xfd800000-0xfd8fffff]
Aug 26 09:07:59 ananda kernel: [    0.403126] pci 0000:00:02.3: PCI bridge to [bus 03]
Aug 26 09:07:59 ananda kernel: [    0.403128] pci 0000:00:02.3:   bridge window [io  0x4000-0x4fff]
Aug 26 09:07:59 ananda kernel: [    0.403131] pci 0000:00:02.3:   bridge window [mem 0xfd700000-0xfd7fffff]
Aug 26 09:07:59 ananda kernel: [    0.403134] pci 0000:00:02.3:   bridge window [mem 0x830000000-0x8301fffff 64bit pref]
Aug 26 09:07:59 ananda kernel: [    0.403138] pci 0000:00:02.4: PCI bridge to [bus 04]
Aug 26 09:07:59 ananda kernel: [    0.403141] pci 0000:00:02.4:   bridge window [mem 0xfd600000-0xfd6fffff]
Aug 26 09:07:59 ananda kernel: [    0.403146] pci 0000:00:02.6: PCI bridge to [bus 05]
Aug 26 09:07:59 ananda kernel: [    0.403148] pci 0000:00:02.6:   bridge window [io  0x2000-0x2fff]
Aug 26 09:07:59 ananda kernel: [    0.403150] pci 0000:00:02.6:   bridge window [mem 0xfd500000-0xfd5fffff]
Aug 26 09:07:59 ananda kernel: [    0.403155] pci 0000:00:02.7: PCI bridge to [bus 06]
Aug 26 09:07:59 ananda kernel: [    0.403158] pci 0000:00:02.7:   bridge window [mem 0xfd400000-0xfd4fffff]
Aug 26 09:07:59 ananda kernel: [    0.403164] pci 0000:00:08.1: PCI bridge to [bus 07]
Aug 26 09:07:59 ananda kernel: [    0.403166] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
Aug 26 09:07:59 ananda kernel: [    0.403168] pci 0000:00:08.1:   bridge window [mem 0xfd000000-0xfd3fffff]
Aug 26 09:07:59 ananda kernel: [    0.403171] pci 0000:00:08.1:   bridge window [mem 0x860000000-0x8701fffff 64bit pref]
Aug 26 09:07:59 ananda kernel: [    0.403176] pci_bus 0000:00: resource 4 [mem 0x000a0000-0x000bffff window]
Aug 26 09:07:59 ananda kernel: [    0.403179] pci_bus 0000:00: resource 5 [mem 0x000c0000-0x000c1fff window]
Aug 26 09:07:59 ananda kernel: [    0.403180] pci_bus 0000:00: resource 6 [mem 0x000c2000-0x000c3fff window]
Aug 26 09:07:59 ananda kernel: [    0.403182] pci_bus 0000:00: resource 7 [mem 0x000c4000-0x000c5fff window]
Aug 26 09:07:59 ananda kernel: [    0.403184] pci_bus 0000:00: resource 8 [mem 0x000c6000-0x000c7fff window]
Aug 26 09:07:59 ananda kernel: [    0.403185] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000c9fff window]
Aug 26 09:07:59 ananda kernel: [    0.403187] pci_bus 0000:00: resource 10 [mem 0x000ca000-0x000cbfff window]
Aug 26 09:07:59 ananda kernel: [    0.403189] pci_bus 0000:00: resource 11 [mem 0x000cc000-0x000cdfff window]
Aug 26 09:07:59 ananda kernel: [    0.403191] pci_bus 0000:00: resource 12 [mem 0x000ce000-0x000cffff window]
Aug 26 09:07:59 ananda kernel: [    0.403192] pci_bus 0000:00: resource 13 [mem 0x000d0000-0x000d1fff window]
Aug 26 09:07:59 ananda kernel: [    0.403194] pci_bus 0000:00: resource 14 [mem 0x000d2000-0x000d3fff window]
Aug 26 09:07:59 ananda kernel: [    0.403196] pci_bus 0000:00: resource 15 [mem 0x000d4000-0x000d5fff window]
Aug 26 09:07:59 ananda kernel: [    0.403197] pci_bus 0000:00: resource 16 [mem 0x000d6000-0x000d7fff window]
Aug 26 09:07:59 ananda kernel: [    0.403199] pci_bus 0000:00: resource 17 [mem 0x000d8000-0x000d9fff window]
Aug 26 09:07:59 ananda kernel: [    0.403201] pci_bus 0000:00: resource 18 [mem 0x000da000-0x000dbfff window]
Aug 26 09:07:59 ananda kernel: [    0.403203] pci_bus 0000:00: resource 19 [mem 0x000dc000-0x000ddfff window]
Aug 26 09:07:59 ananda kernel: [    0.403204] pci_bus 0000:00: resource 20 [mem 0x000de000-0x000dffff window]
Aug 26 09:07:59 ananda kernel: [    0.403206] pci_bus 0000:00: resource 21 [mem 0x000e0000-0x000e1fff window]
Aug 26 09:07:59 ananda kernel: [    0.403208] pci_bus 0000:00: resource 22 [mem 0x000e2000-0x000e3fff window]
Aug 26 09:07:59 ananda kernel: [    0.403210] pci_bus 0000:00: resource 23 [mem 0x000e4000-0x000e5fff window]
Aug 26 09:07:59 ananda kernel: [    0.403211] pci_bus 0000:00: resource 24 [mem 0x000e6000-0x000e7fff window]
Aug 26 09:07:59 ananda kernel: [    0.403213] pci_bus 0000:00: resource 25 [mem 0x000e8000-0x000e9fff window]
Aug 26 09:07:59 ananda kernel: [    0.403215] pci_bus 0000:00: resource 26 [mem 0x000ea000-0x000ebfff window]
Aug 26 09:07:59 ananda kernel: [    0.403217] pci_bus 0000:00: resource 27 [mem 0x000ec000-0x000edfff window]
Aug 26 09:07:59 ananda kernel: [    0.403218] pci_bus 0000:00: resource 28 [mem 0x000ee000-0x000effff window]
Aug 26 09:07:59 ananda kernel: [    0.403220] pci_bus 0000:00: resource 29 [mem 0xd0000000-0xf7ffffff window]
Aug 26 09:07:59 ananda kernel: [    0.403222] pci_bus 0000:00: resource 30 [mem 0xfc000000-0xfdffffff window]
Aug 26 09:07:59 ananda kernel: [    0.403223] pci_bus 0000:00: resource 31 [mem 0x830000000-0xffffffffff window]
Aug 26 09:07:59 ananda kernel: [    0.403225] pci_bus 0000:00: resource 32 [io  0x0000-0x0cf7 window]
Aug 26 09:07:59 ananda kernel: [    0.403227] pci_bus 0000:00: resource 33 [io  0x0d00-0xffff window]
Aug 26 09:07:59 ananda kernel: [    0.403229] pci_bus 0000:01: resource 1 [mem 0xfd900000-0xfd9fffff]
Aug 26 09:07:59 ananda kernel: [    0.403231] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
Aug 26 09:07:59 ananda kernel: [    0.403233] pci_bus 0000:02: resource 1 [mem 0xfd800000-0xfd8fffff]
Aug 26 09:07:59 ananda kernel: [    0.403235] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
Aug 26 09:07:59 ananda kernel: [    0.403236] pci_bus 0000:03: resource 1 [mem 0xfd700000-0xfd7fffff]
Aug 26 09:07:59 ananda kernel: [    0.403238] pci_bus 0000:03: resource 2 [mem 0x830000000-0x8301fffff 64bit pref]
Aug 26 09:07:59 ananda kernel: [    0.403240] pci_bus 0000:04: resource 1 [mem 0xfd600000-0xfd6fffff]
Aug 26 09:07:59 ananda kernel: [    0.403242] pci_bus 0000:05: resource 0 [io  0x2000-0x2fff]
Aug 26 09:07:59 ananda kernel: [    0.403244] pci_bus 0000:05: resource 1 [mem 0xfd500000-0xfd5fffff]
Aug 26 09:07:59 ananda kernel: [    0.403246] pci_bus 0000:06: resource 1 [mem 0xfd400000-0xfd4fffff]
Aug 26 09:07:59 ananda kernel: [    0.403248] pci_bus 0000:07: resource 0 [io  0x1000-0x1fff]
Aug 26 09:07:59 ananda kernel: [    0.403249] pci_bus 0000:07: resource 1 [mem 0xfd000000-0xfd3fffff]
Aug 26 09:07:59 ananda kernel: [    0.403251] pci_bus 0000:07: resource 2 [mem 0x860000000-0x8701fffff 64bit pref]
Aug 26 09:07:59 ananda kernel: [    0.403980] pci 0000:07:00.1: D0 power state depends on 0000:07:00.0
Aug 26 09:07:59 ananda kernel: [    0.404013] pci 0000:07:00.3: extending delay after power-on from D3hot to 20 msec
Aug 26 09:07:59 ananda kernel: [    0.404102] pci 0000:07:00.4: extending delay after power-on from D3hot to 20 msec
Aug 26 09:07:59 ananda kernel: [    0.404149] PCI: CLS 32 bytes, default 64
Aug 26 09:07:59 ananda kernel: [    0.404272] Trying to unpack rootfs image as initramfs...
Aug 26 09:07:59 ananda kernel: [    0.404828] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:160
Aug 26 09:07:59 ananda kernel: [    0.404830] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:160
Aug 26 09:07:59 ananda kernel: [    0.404832] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:160
Aug 26 09:07:59 ananda kernel: [    0.404834] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:160
Aug 26 09:07:59 ananda kernel: [    0.404878] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
Aug 26 09:07:59 ananda kernel: [    0.404940] pci 0000:00:00.2: can't derive routing for PCI INT A
Aug 26 09:07:59 ananda kernel: [    0.404942] pci 0000:00:00.2: PCI INT A: not connected
Aug 26 09:07:59 ananda kernel: [    0.404945] AMD-Vi: Lazy IO/TLB flushing enabled
Aug 26 09:07:59 ananda kernel: [    0.404961] pci 0000:00:01.0: Adding to iommu group 0
Aug 26 09:07:59 ananda kernel: [    0.404977] pci 0000:00:02.0: Adding to iommu group 1
Aug 26 09:07:59 ananda kernel: [    0.404985] pci 0000:00:02.1: Adding to iommu group 2
Aug 26 09:07:59 ananda kernel: [    0.404993] pci 0000:00:02.2: Adding to iommu group 3
Aug 26 09:07:59 ananda kernel: [    0.405001] pci 0000:00:02.3: Adding to iommu group 4
Aug 26 09:07:59 ananda kernel: [    0.405009] pci 0000:00:02.4: Adding to iommu group 5
Aug 26 09:07:59 ananda kernel: [    0.405017] pci 0000:00:02.6: Adding to iommu group 6
Aug 26 09:07:59 ananda kernel: [    0.405024] pci 0000:00:02.7: Adding to iommu group 7
Aug 26 09:07:59 ananda kernel: [    0.405035] pci 0000:00:08.0: Adding to iommu group 8
Aug 26 09:07:59 ananda kernel: [    0.405043] pci 0000:00:08.1: Adding to iommu group 8
Aug 26 09:07:59 ananda kernel: [    0.405053] pci 0000:00:14.0: Adding to iommu group 9
Aug 26 09:07:59 ananda kernel: [    0.405060] pci 0000:00:14.3: Adding to iommu group 9
Aug 26 09:07:59 ananda kernel: [    0.405083] pci 0000:00:18.0: Adding to iommu group 10
Aug 26 09:07:59 ananda kernel: [    0.405089] pci 0000:00:18.1: Adding to iommu group 10
Aug 26 09:07:59 ananda kernel: [    0.405096] pci 0000:00:18.2: Adding to iommu group 10
Aug 26 09:07:59 ananda kernel: [    0.405103] pci 0000:00:18.3: Adding to iommu group 10
Aug 26 09:07:59 ananda kernel: [    0.405110] pci 0000:00:18.4: Adding to iommu group 10
Aug 26 09:07:59 ananda kernel: [    0.405117] pci 0000:00:18.5: Adding to iommu group 10
Aug 26 09:07:59 ananda kernel: [    0.405124] pci 0000:00:18.6: Adding to iommu group 10
Aug 26 09:07:59 ananda kernel: [    0.405131] pci 0000:00:18.7: Adding to iommu group 10
Aug 26 09:07:59 ananda kernel: [    0.405138] pci 0000:01:00.0: Adding to iommu group 11
Aug 26 09:07:59 ananda kernel: [    0.405159] pci 0000:02:00.0: Adding to iommu group 12
Aug 26 09:07:59 ananda kernel: [    0.405168] pci 0000:02:00.1: Adding to iommu group 12
Aug 26 09:07:59 ananda kernel: [    0.405175] pci 0000:02:00.2: Adding to iommu group 12
Aug 26 09:07:59 ananda kernel: [    0.405183] pci 0000:02:00.3: Adding to iommu group 12
Aug 26 09:07:59 ananda kernel: [    0.405191] pci 0000:02:00.4: Adding to iommu group 12
Aug 26 09:07:59 ananda kernel: [    0.405198] pci 0000:03:00.0: Adding to iommu group 13
Aug 26 09:07:59 ananda kernel: [    0.405207] pci 0000:04:00.0: Adding to iommu group 14
Aug 26 09:07:59 ananda kernel: [    0.405214] pci 0000:05:00.0: Adding to iommu group 15
Aug 26 09:07:59 ananda kernel: [    0.405222] pci 0000:06:00.0: Adding to iommu group 16
Aug 26 09:07:59 ananda kernel: [    0.405234] pci 0000:07:00.0: Adding to iommu group 8
Aug 26 09:07:59 ananda kernel: [    0.405238] pci 0000:07:00.1: Adding to iommu group 8
Aug 26 09:07:59 ananda kernel: [    0.405241] pci 0000:07:00.2: Adding to iommu group 8
Aug 26 09:07:59 ananda kernel: [    0.405246] pci 0000:07:00.3: Adding to iommu group 8
Aug 26 09:07:59 ananda kernel: [    0.405249] pci 0000:07:00.4: Adding to iommu group 8
Aug 26 09:07:59 ananda kernel: [    0.405253] pci 0000:07:00.5: Adding to iommu group 8
Aug 26 09:07:59 ananda kernel: [    0.405257] pci 0000:07:00.6: Adding to iommu group 8
Aug 26 09:07:59 ananda kernel: [    0.407069] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
Aug 26 09:07:59 ananda kernel: [    0.407076] AMD-Vi: Extended features (0x206d73ef22254ade): PPR X2APIC NX GT IA GA PC GA_vAPIC
Aug 26 09:07:59 ananda kernel: [    0.407200] amd_uncore: 4  amd_df counters detected
Aug 26 09:07:59 ananda kernel: [    0.407204] amd_uncore: 6  amd_l3 counters detected
Aug 26 09:07:59 ananda kernel: [    0.407673] LVT offset 0 assigned for vector 0x400
Aug 26 09:07:59 ananda kernel: [    0.407895] perf: AMD IBS detected (0x000003ff)
Aug 26 09:07:59 ananda kernel: [    0.407899] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
Aug 26 09:07:59 ananda kernel: [    0.408150] Initialise system trusted keyrings
Aug 26 09:07:59 ananda kernel: [    0.408166] Key type blacklist registered
Aug 26 09:07:59 ananda kernel: [    0.408224] workingset: timestamp_bits=46 max_order=23 bucket_order=0
Aug 26 09:07:59 ananda kernel: [    0.408759] zbud: loaded
Aug 26 09:07:59 ananda kernel: [    0.408905] Key type asymmetric registered
Aug 26 09:07:59 ananda kernel: [    0.408907] Asymmetric key parser 'x509' registered
Aug 26 09:07:59 ananda kernel: [    0.408914] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
Aug 26 09:07:59 ananda kernel: [    0.408954] io scheduler mq-deadline registered
Aug 26 09:07:59 ananda kernel: [    0.409612] pcieport 0000:00:02.1: PME: Signaling with IRQ 26
Aug 26 09:07:59 ananda kernel: [    0.409692] pcieport 0000:00:02.2: PME: Signaling with IRQ 27
Aug 26 09:07:59 ananda kernel: [    0.409760] pcieport 0000:00:02.3: PME: Signaling with IRQ 28
Aug 26 09:07:59 ananda kernel: [    0.409772] pcieport 0000:00:02.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
Aug 26 09:07:59 ananda kernel: [    0.409875] pcieport 0000:00:02.4: PME: Signaling with IRQ 29
Aug 26 09:07:59 ananda kernel: [    0.409941] pcieport 0000:00:02.6: PME: Signaling with IRQ 30
Aug 26 09:07:59 ananda kernel: [    0.410007] pcieport 0000:00:02.7: PME: Signaling with IRQ 31
Aug 26 09:07:59 ananda kernel: [    0.410072] pcieport 0000:00:08.1: PME: Signaling with IRQ 32
Aug 26 09:07:59 ananda kernel: [    0.410136] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Aug 26 09:07:59 ananda kernel: [    0.410148] efifb: probing for efifb
Aug 26 09:07:59 ananda kernel: [    0.410157] efifb: framebuffer at 0x860000000, using 8128k, total 8128k
Aug 26 09:07:59 ananda kernel: [    0.410159] efifb: mode is 1920x1080x32, linelength=7680, pages=1
Aug 26 09:07:59 ananda kernel: [    0.410161] efifb: scrolling: redraw
Aug 26 09:07:59 ananda kernel: [    0.410162] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Aug 26 09:07:59 ananda kernel: [    0.412897] Console: switching to colour frame buffer device 240x67
Aug 26 09:07:59 ananda kernel: [    0.415535] fb0: EFI VGA frame buffer device
Aug 26 09:07:59 ananda kernel: [    0.415584] Monitor-Mwait will be used to enter C-1 state
Aug 26 09:07:59 ananda kernel: [    0.415587] ACPI: \_SB_.PLTF.C000: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.415605] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.415698] ACPI: \_SB_.PLTF.C001: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.415714] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.415774] ACPI: \_SB_.PLTF.C002: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.415789] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.418925] ACPI: \_SB_.PLTF.C003: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.418950] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.419101] ACPI: \_SB_.PLTF.C004: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.419127] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.419379] ACPI: \_SB_.PLTF.C005: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.419404] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.419635] ACPI: \_SB_.PLTF.C006: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.419657] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.419849] ACPI: \_SB_.PLTF.C007: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.419883] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.420096] ACPI: \_SB_.PLTF.C008: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.420131] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.420351] ACPI: \_SB_.PLTF.C009: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.420387] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.420668] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.420703] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.421021] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.421044] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.421169] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.421184] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.421341] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.421362] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.421467] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.421484] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.421684] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
Aug 26 09:07:59 ananda kernel: [    0.421708] ACPI: FW issue: working around C-state latencies out of order
Aug 26 09:07:59 ananda kernel: [    0.421946] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Aug 26 09:07:59 ananda kernel: [    0.422262] serial 0000:02:00.1: enabling device (0000 -> 0003)
Aug 26 09:07:59 ananda kernel: [    0.422580] 0000:02:00.1: ttyS0 at I/O 0x3200 (irq = 33, base_baud = 115200) is a 16550A
Aug 26 09:07:59 ananda kernel: [    0.422691] serial 0000:02:00.2: enabling device (0000 -> 0003)
Aug 26 09:07:59 ananda kernel: [    0.423576] 0000:02:00.2: ttyS1 at I/O 0x3100 (irq = 34, base_baud = 115200) is a 16550A
Aug 26 09:07:59 ananda kernel: [    0.424362] Linux agpgart interface v0.103
Aug 26 09:07:59 ananda kernel: [    0.425951] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
Aug 26 09:07:59 ananda kernel: [    0.428006] libphy: Fixed MDIO Bus: probed
Aug 26 09:07:59 ananda kernel: [    0.428675] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Aug 26 09:07:59 ananda kernel: [    0.433825] serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 26 09:07:59 ananda kernel: [    0.434487] serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 26 09:07:59 ananda kernel: [    0.435255] mousedev: PS/2 mouse device common for all mice
Aug 26 09:07:59 ananda kernel: [    0.435928] rtc_cmos 00:01: RTC can wake from S4
Aug 26 09:07:59 ananda kernel: [    0.436818] rtc_cmos 00:01: registered as rtc0
Aug 26 09:07:59 ananda kernel: [    0.438062] rtc_cmos 00:01: setting system clock to 2021-08-26T07:07:35 UTC (1629961655)
Aug 26 09:07:59 ananda kernel: [    0.438741] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
Aug 26 09:07:59 ananda kernel: [    0.439884] ledtrig-cpu: registered to indicate activity on CPUs
Aug 26 09:07:59 ananda kernel: [    0.440873] NET: Registered PF_INET6 protocol family
Aug 26 09:07:59 ananda kernel: [    0.443808] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
Aug 26 09:07:59 ananda kernel: [    0.564250] Freeing initrd memory: 15468K
Aug 26 09:07:59 ananda kernel: [    0.572177] Segment Routing with IPv6
Aug 26 09:07:59 ananda kernel: [    0.572868] mip6: Mobile IPv6
Aug 26 09:07:59 ananda kernel: [    0.573513] NET: Registered PF_PACKET protocol family
Aug 26 09:07:59 ananda kernel: [    0.574186] can: controller area network core
Aug 26 09:07:59 ananda kernel: [    0.574861] NET: Registered PF_CAN protocol family
Aug 26 09:07:59 ananda kernel: [    0.575610] mpls_gso: MPLS GSO support
Aug 26 09:07:59 ananda kernel: [    0.577857] microcode: CPU0: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.578660] microcode: CPU1: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.579581] microcode: CPU2: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.580997] microcode: CPU3: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.581677] microcode: CPU4: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.582297] microcode: CPU5: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.582966] microcode: CPU6: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.583641] microcode: CPU7: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.584251] microcode: CPU8: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.585980] microcode: CPU9: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.586689] microcode: CPU10: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.587939] microcode: CPU11: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.588609] microcode: CPU12: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.589837] microcode: CPU13: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.590561] microcode: CPU14: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.591411] microcode: CPU15: patch_level=0x08600106
Aug 26 09:07:59 ananda kernel: [    0.591953] microcode: Microcode Update Driver: v2.2.
Aug 26 09:07:59 ananda kernel: [    0.592279] resctrl: L3 allocation detected
Aug 26 09:07:59 ananda kernel: [    0.593326] resctrl: L3DATA allocation detected
Aug 26 09:07:59 ananda kernel: [    0.593850] resctrl: L3CODE allocation detected
Aug 26 09:07:59 ananda kernel: [    0.594359] resctrl: MB allocation detected
Aug 26 09:07:59 ananda kernel: [    0.594863] resctrl: L3 monitoring detected
Aug 26 09:07:59 ananda kernel: [    0.595365] IPI shorthand broadcast: enabled
Aug 26 09:07:59 ananda kernel: [    0.595874] sched_clock: Marking stable (594821459, 538636)->(612549994, -17189899)
Aug 26 09:07:59 ananda kernel: [    0.596569] registered taskstats version 1
Aug 26 09:07:59 ananda kernel: [    0.597062] Loading compiled-in X.509 certificates
Aug 26 09:07:59 ananda kernel: [    0.598044] zswap: loaded using pool lzo/zbud
Aug 26 09:07:59 ananda kernel: [    0.598849] Key type ._fscrypt registered
Aug 26 09:07:59 ananda kernel: [    0.599341] Key type .fscrypt registered
Aug 26 09:07:59 ananda kernel: [    0.599831] Key type fscrypt-provisioning registered
Aug 26 09:07:59 ananda kernel: [    0.600368] AppArmor: AppArmor sha1 policy hashing enabled
Aug 26 09:07:59 ananda kernel: [    0.601650] Freeing unused kernel image (initmem) memory: 1572K
Aug 26 09:07:59 ananda kernel: [    0.610356] Write protecting the kernel read-only data: 18432k
Aug 26 09:07:59 ananda kernel: [    0.611762] Freeing unused kernel image (text/rodata gap) memory: 2040K
Aug 26 09:07:59 ananda kernel: [    0.612483] Freeing unused kernel image (rodata/data gap) memory: 1360K
Aug 26 09:07:59 ananda kernel: [    0.638646] x86/mm: Checked W+X mappings: passed, no W+X pages found.
Aug 26 09:07:59 ananda kernel: [    0.639124] Run /init as init process
Aug 26 09:07:59 ananda kernel: [    0.639591]   with arguments:
Aug 26 09:07:59 ananda kernel: [    0.639591]     /init
Aug 26 09:07:59 ananda kernel: [    0.639592]   with environment:
Aug 26 09:07:59 ananda kernel: [    0.639592]     HOME=/
Aug 26 09:07:59 ananda kernel: [    0.639593]     TERM=linux
Aug 26 09:07:59 ananda kernel: [    0.639593]     BOOT_IMAGE=/vmlinuz-5.14.0-rc7-t14
Aug 26 09:07:59 ananda kernel: [    0.685757] random: udevd: uninitialized urandom read (16 bytes read)
Aug 26 09:07:59 ananda kernel: [    0.686287] random: udevd: uninitialized urandom read (16 bytes read)
Aug 26 09:07:59 ananda kernel: [    0.686741] random: udevd: uninitialized urandom read (16 bytes read)
Aug 26 09:07:59 ananda kernel: [    0.698578] i2c_scmi: module verification failed: signature and/or required key missing - tainting kernel
Aug 26 09:07:59 ananda kernel: [    0.703792] rtsx_pci 0000:04:00.0: enabling device (0000 -> 0002)
Aug 26 09:07:59 ananda kernel: [    0.704683] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
Aug 26 09:07:59 ananda kernel: [    0.705391] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
Aug 26 09:07:59 ananda kernel: [    0.706177] ACPI: bus type USB registered
Aug 26 09:07:59 ananda kernel: [    0.706219] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
Aug 26 09:07:59 ananda kernel: [    0.706829] usbcore: registered new interface driver usbfs
Aug 26 09:07:59 ananda kernel: [    0.707452] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
Aug 26 09:07:59 ananda kernel: [    0.707992] usbcore: registered new interface driver hub
Aug 26 09:07:59 ananda kernel: [    0.709128] usbcore: registered new device driver usb
Aug 26 09:07:59 ananda kernel: [    0.709913] cryptd: max_cpu_qlen set to 1000
Aug 26 09:07:59 ananda kernel: [    0.712334] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Aug 26 09:07:59 ananda kernel: [    0.714929] ehci-pci: EHCI PCI platform driver
Aug 26 09:07:59 ananda kernel: [    0.714943] AVX2 version of gcm_enc/dec engaged.
Aug 26 09:07:59 ananda kernel: [    0.715721] ehci-pci 0000:02:00.4: EHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.716721] AES CTR mode by8 optimization enabled
Aug 26 09:07:59 ananda kernel: [    0.717344] ehci-pci 0000:02:00.4: new USB bus registered, assigned bus number 1
Aug 26 09:07:59 ananda kernel: [    0.717428] libphy: r8169: probed
Aug 26 09:07:59 ananda kernel: [    0.718114] ehci-pci 0000:02:00.4: irq 40, io mem 0xfd818000
Aug 26 09:07:59 ananda kernel: [    0.718812] r8169 0000:02:00.0 eth0: RTL8168ep/8111ep, 00:2b:67:b6:30:ae, XID 502, IRQ 38
Aug 26 09:07:59 ananda kernel: [    0.720003] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
Aug 26 09:07:59 ananda kernel: [    0.720662] r8169 0000:05:00.0: can't disable ASPM; OS doesn't have ASPM control
Aug 26 09:07:59 ananda kernel: [    0.721279] r8169 0000:05:00.0: enabling device (0000 -> 0003)
Aug 26 09:07:59 ananda kernel: [    0.723244] nvme 0000:01:00.0: platform quirk: setting simple suspend
Aug 26 09:07:59 ananda kernel: [    0.723970] nvme nvme0: pci function 0000:01:00.0
Aug 26 09:07:59 ananda kernel: [    0.726007] ehci-pci 0000:02:00.4: USB 0.0 started, EHCI 1.00
Aug 26 09:07:59 ananda kernel: [    0.726830] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.14
Aug 26 09:07:59 ananda kernel: [    0.727420] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 26 09:07:59 ananda kernel: [    0.728016] usb usb1: Product: EHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.728600] usb usb1: Manufacturer: Linux 5.14.0-rc7-t14 ehci_hcd
Aug 26 09:07:59 ananda kernel: [    0.729207] usb usb1: SerialNumber: 0000:02:00.4
Aug 26 09:07:59 ananda kernel: [    0.729658] libphy: r8169: probed
Aug 26 09:07:59 ananda kernel: [    0.729939] hub 1-0:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    0.730573] r8169 0000:05:00.0 eth1: RTL8168h/8111h, 00:2b:67:b6:30:ad, XID 541, IRQ 44
Aug 26 09:07:59 ananda kernel: [    0.731116] hub 1-0:1.0: 1 port detected
Aug 26 09:07:59 ananda kernel: [    0.731735] r8169 0000:05:00.0 eth1: jumbo features [frames: 9194 bytes, tx checksumming: ko]
Aug 26 09:07:59 ananda kernel: [    0.732500] xhci_hcd 0000:06:00.0: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.733751] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 2
Aug 26 09:07:59 ananda kernel: [    0.734457] xhci_hcd 0000:06:00.0: Zeroing 64bit base registers, expecting fault
Aug 26 09:07:59 ananda kernel: [    0.737353] nvme nvme0: Shutdown timeout set to 10 seconds
Aug 26 09:07:59 ananda kernel: [    0.742745] nvme nvme0: 16/0/0 default/read/poll queues
Aug 26 09:07:59 ananda kernel: [    0.745735]  nvme0n1: p1 p2 p3
Aug 26 09:07:59 ananda kernel: [    0.772404] xhci_hcd 0000:06:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x0000001100000090
Aug 26 09:07:59 ananda kernel: [    0.773350] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.14
Aug 26 09:07:59 ananda kernel: [    0.774051] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 26 09:07:59 ananda kernel: [    0.774736] usb usb2: Product: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.775404] usb usb2: Manufacturer: Linux 5.14.0-rc7-t14 xhci-hcd
Aug 26 09:07:59 ananda kernel: [    0.776091] usb usb2: SerialNumber: 0000:06:00.0
Aug 26 09:07:59 ananda kernel: [    0.776927] hub 2-0:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    0.777601] hub 2-0:1.0: 2 ports detected
Aug 26 09:07:59 ananda kernel: [    0.778388] xhci_hcd 0000:06:00.0: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.779077] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 3
Aug 26 09:07:59 ananda kernel: [    0.779761] xhci_hcd 0000:06:00.0: Host supports USB 3.0 SuperSpeed
Aug 26 09:07:59 ananda kernel: [    0.780472] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
Aug 26 09:07:59 ananda kernel: [    0.781179] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.14
Aug 26 09:07:59 ananda kernel: [    0.781870] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 26 09:07:59 ananda kernel: [    0.782557] usb usb3: Product: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.783230] usb usb3: Manufacturer: Linux 5.14.0-rc7-t14 xhci-hcd
Aug 26 09:07:59 ananda kernel: [    0.783926] usb usb3: SerialNumber: 0000:06:00.0
Aug 26 09:07:59 ananda kernel: [    0.784795] hub 3-0:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    0.785473] hub 3-0:1.0: 2 ports detected
Aug 26 09:07:59 ananda kernel: [    0.786351] xhci_hcd 0000:07:00.3: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.787005] xhci_hcd 0000:07:00.3: new USB bus registered, assigned bus number 4
Aug 26 09:07:59 ananda kernel: [    0.787728] xhci_hcd 0000:07:00.3: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000020000000410
Aug 26 09:07:59 ananda kernel: [    0.788561] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.14
Aug 26 09:07:59 ananda kernel: [    0.789214] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 26 09:07:59 ananda kernel: [    0.789885] usb usb4: Product: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.790536] usb usb4: Manufacturer: Linux 5.14.0-rc7-t14 xhci-hcd
Aug 26 09:07:59 ananda kernel: [    0.791179] usb usb4: SerialNumber: 0000:07:00.3
Aug 26 09:07:59 ananda kernel: [    0.792006] hub 4-0:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    0.792679] hub 4-0:1.0: 4 ports detected
Aug 26 09:07:59 ananda kernel: [    0.793481] xhci_hcd 0000:07:00.3: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.794137] xhci_hcd 0000:07:00.3: new USB bus registered, assigned bus number 5
Aug 26 09:07:59 ananda kernel: [    0.794788] xhci_hcd 0000:07:00.3: Host supports USB 3.1 Enhanced SuperSpeed
Aug 26 09:07:59 ananda kernel: [    0.795430] usb usb5: We don't know the algorithms for LPM for this host, disabling LPM.
Aug 26 09:07:59 ananda kernel: [    0.796102] usb usb5: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.14
Aug 26 09:07:59 ananda kernel: [    0.796742] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 26 09:07:59 ananda kernel: [    0.797381] usb usb5: Product: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.798020] usb usb5: Manufacturer: Linux 5.14.0-rc7-t14 xhci-hcd
Aug 26 09:07:59 ananda kernel: [    0.798674] usb usb5: SerialNumber: 0000:07:00.3
Aug 26 09:07:59 ananda kernel: [    0.799426] hub 5-0:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    0.800086] hub 5-0:1.0: 2 ports detected
Aug 26 09:07:59 ananda kernel: [    0.800944] xhci_hcd 0000:07:00.4: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.801586] xhci_hcd 0000:07:00.4: new USB bus registered, assigned bus number 6
Aug 26 09:07:59 ananda kernel: [    0.802291] xhci_hcd 0000:07:00.4: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000020000000410
Aug 26 09:07:59 ananda kernel: [    0.803107] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.14
Aug 26 09:07:59 ananda kernel: [    0.803762] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 26 09:07:59 ananda kernel: [    0.804386] usb usb6: Product: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.805016] usb usb6: Manufacturer: Linux 5.14.0-rc7-t14 xhci-hcd
Aug 26 09:07:59 ananda kernel: [    0.805649] usb usb6: SerialNumber: 0000:07:00.4
Aug 26 09:07:59 ananda kernel: [    0.806370] hub 6-0:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    0.807060] hub 6-0:1.0: 4 ports detected
Aug 26 09:07:59 ananda kernel: [    0.807892] xhci_hcd 0000:07:00.4: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.808528] xhci_hcd 0000:07:00.4: new USB bus registered, assigned bus number 7
Aug 26 09:07:59 ananda kernel: [    0.809155] xhci_hcd 0000:07:00.4: Host supports USB 3.1 Enhanced SuperSpeed
Aug 26 09:07:59 ananda kernel: [    0.809801] usb usb7: We don't know the algorithms for LPM for this host, disabling LPM.
Aug 26 09:07:59 ananda kernel: [    0.810428] usb usb7: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.14
Aug 26 09:07:59 ananda kernel: [    0.811061] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 26 09:07:59 ananda kernel: [    0.811687] usb usb7: Product: xHCI Host Controller
Aug 26 09:07:59 ananda kernel: [    0.812289] usb usb7: Manufacturer: Linux 5.14.0-rc7-t14 xhci-hcd
Aug 26 09:07:59 ananda kernel: [    0.812908] usb usb7: SerialNumber: 0000:07:00.4
Aug 26 09:07:59 ananda kernel: [    0.813639] hub 7-0:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    0.814243] hub 7-0:1.0: 2 ports detected
Aug 26 09:07:59 ananda kernel: [    0.887504] device-mapper: uevent: version 1.0.3
Aug 26 09:07:59 ananda kernel: [    0.888266] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
Aug 26 09:07:59 ananda kernel: [    1.017664] usb 2-2: new high-speed USB device number 2 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    1.033665] usb 4-3: new full-speed USB device number 2 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    1.049658] usb 6-2: new high-speed USB device number 2 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    1.150633] usb 2-2: New USB device found, idVendor=04f2, idProduct=b6d0, bcdDevice=58.18
Aug 26 09:07:59 ananda kernel: [    1.150643] usb 2-2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
Aug 26 09:07:59 ananda kernel: [    1.150646] usb 2-2: Product: Integrated Camera
Aug 26 09:07:59 ananda kernel: [    1.150649] usb 2-2: Manufacturer: Chicony Electronics Co.,Ltd.
Aug 26 09:07:59 ananda kernel: [    1.150651] usb 2-2: SerialNumber: 0001
Aug 26 09:07:59 ananda kernel: [    1.504838] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1875b4ef64c, max_idle_ns: 440795203028 ns
Aug 26 09:07:59 ananda kernel: [    1.504898] clocksource: Switched to clocksource tsc
Aug 26 09:07:59 ananda kernel: [    1.559612] usb 4-3: New USB device found, idVendor=058f, idProduct=9540, bcdDevice= 1.20
Aug 26 09:07:59 ananda kernel: [    1.559621] usb 4-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 26 09:07:59 ananda kernel: [    1.559625] usb 4-3: Product: EMV Smartcard Reader
Aug 26 09:07:59 ananda kernel: [    1.559627] usb 4-3: Manufacturer: Generic
Aug 26 09:07:59 ananda kernel: [    1.563750] usb 6-2: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.17
Aug 26 09:07:59 ananda kernel: [    1.563760] usb 6-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 26 09:07:59 ananda kernel: [    1.563763] usb 6-2: Product: 4-Port USB 2.0 Hub
Aug 26 09:07:59 ananda kernel: [    1.563774] usb 6-2: Manufacturer: Generic
Aug 26 09:07:59 ananda kernel: [    1.622669] hub 6-2:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    1.623901] hub 6-2:1.0: 4 ports detected
Aug 26 09:07:59 ananda kernel: [    1.688155] usb 7-2: new SuperSpeed USB device number 2 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    1.738152] usb 7-2: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.17
Aug 26 09:07:59 ananda kernel: [    1.738164] usb 7-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 26 09:07:59 ananda kernel: [    1.738168] usb 7-2: Product: 4-Port USB 3.0 Hub
Aug 26 09:07:59 ananda kernel: [    1.738172] usb 7-2: Manufacturer: Generic
Aug 26 09:07:59 ananda kernel: [    1.775196] hub 7-2:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    1.776431] hub 7-2:1.0: 4 ports detected
Aug 26 09:07:59 ananda kernel: [    1.822790] usb 6-4: new full-speed USB device number 3 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    2.054664] usb 6-4: New USB device found, idVendor=8087, idProduct=0029, bcdDevice= 0.01
Aug 26 09:07:59 ananda kernel: [    2.054675] usb 6-4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Aug 26 09:07:59 ananda kernel: [    2.087904] usb 6-2.1: new high-speed USB device number 4 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    2.249009] usb 6-2.1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.17
Aug 26 09:07:59 ananda kernel: [    2.249017] usb 6-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 26 09:07:59 ananda kernel: [    2.249019] usb 6-2.1: Product: 4-Port USB 2.0 Hub
Aug 26 09:07:59 ananda kernel: [    2.249021] usb 6-2.1: Manufacturer: Generic
Aug 26 09:07:59 ananda kernel: [    2.254161] random: fast init done
Aug 26 09:07:59 ananda kernel: [    2.288883] hub 6-2.1:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    2.290137] hub 6-2.1:1.0: 4 ports detected
Aug 26 09:07:59 ananda kernel: [    2.321220] usb 7-2.1: new SuperSpeed USB device number 3 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    2.369659] usb 7-2.1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.17
Aug 26 09:07:59 ananda kernel: [    2.369670] usb 7-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 26 09:07:59 ananda kernel: [    2.369674] usb 7-2.1: Product: 4-Port USB 3.0 Hub
Aug 26 09:07:59 ananda kernel: [    2.369677] usb 7-2.1: Manufacturer: Generic
Aug 26 09:07:59 ananda kernel: [    2.409228] hub 7-2.1:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    2.410602] hub 7-2.1:1.0: 4 ports detected
Aug 26 09:07:59 ananda kernel: [    2.456803] usb 6-2.2: new high-speed USB device number 5 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    2.574303] usb 6-2.2: New USB device found, idVendor=2109, idProduct=2811, bcdDevice=90.90
Aug 26 09:07:59 ananda kernel: [    2.574313] usb 6-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 26 09:07:59 ananda kernel: [    2.574316] usb 6-2.2: Product: USB2.0 Hub             
Aug 26 09:07:59 ananda kernel: [    2.574319] usb 6-2.2: Manufacturer: VIA Labs, Inc.         
Aug 26 09:07:59 ananda kernel: [    2.637559] psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
Aug 26 09:07:59 ananda kernel: [    2.637930] hub 6-2.2:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    2.638454] hub 6-2.2:1.0: 4 ports detected
Aug 26 09:07:59 ananda kernel: [    2.655988] usb 7-2.2: new SuperSpeed USB device number 4 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    2.758295] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
Aug 26 09:07:59 ananda kernel: [    2.758312] psmouse serio1: synaptics: Your touchpad (PNP: LEN2064 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
Aug 26 09:07:59 ananda kernel: [    2.938177] usb 7-2.2: New USB device found, idVendor=2109, idProduct=8110, bcdDevice=90.91
Aug 26 09:07:59 ananda kernel: [    2.938182] usb 7-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 26 09:07:59 ananda kernel: [    2.938184] usb 7-2.2: Product: USB3.0 Hub             
Aug 26 09:07:59 ananda kernel: [    2.938185] usb 7-2.2: Manufacturer: VIA Labs, Inc.         
Aug 26 09:07:59 ananda kernel: [    2.971034] hub 7-2.2:1.0: USB hub found
Aug 26 09:07:59 ananda kernel: [    2.971246] hub 7-2.2:1.0: 4 ports detected
Aug 26 09:07:59 ananda kernel: [    2.988815] psmouse serio1: synaptics: Touchpad model: 1, fw: 10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board id: 3471, fw id: 2909640
Aug 26 09:07:59 ananda kernel: [    2.988826] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
Aug 26 09:07:59 ananda kernel: [    2.989844] usb 6-2.1.2: new low-speed USB device number 6 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    3.170656] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input2
Aug 26 09:07:59 ananda kernel: [    3.171759] urandom_read: 6 callbacks suppressed
Aug 26 09:07:59 ananda kernel: [    3.171772] random: udevd: uninitialized urandom read (16 bytes read)
Aug 26 09:07:59 ananda kernel: [    3.173728] usb 6-2.1.2: New USB device found, idVendor=17ef, idProduct=6009, bcdDevice= 1.27
Aug 26 09:07:59 ananda kernel: [    3.173733] usb 6-2.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 26 09:07:59 ananda kernel: [    3.173734] usb 6-2.1.2: Product: ThinkPad USB Keyboard with TrackPoint
Aug 26 09:07:59 ananda kernel: [    3.173735] usb 6-2.1.2: Manufacturer: Lite-On Technology Corp.
Aug 26 09:07:59 ananda kernel: [    3.188788] usb 6-2.3: new full-speed USB device number 7 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    3.257752] hid: raw HID events driver (C) Jiri Kosina
Aug 26 09:07:59 ananda kernel: [    3.276138] usbcore: registered new interface driver usbhid
Aug 26 09:07:59 ananda kernel: [    3.276144] usbhid: USB HID core driver
Aug 26 09:07:59 ananda kernel: [    3.277728] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint as /devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb6/6-2/6-2.1/6-2.1.2/6-2.1.2:1.0/0003:17EF:6009.0001/input/input4
Aug 26 09:07:59 ananda kernel: [    3.337473] lenovo 0003:17EF:6009.0001: input,hidraw0: USB HID v1.10 Keyboard [Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint] on usb-0000:07:00.4-2.1.2/input0
Aug 26 09:07:59 ananda kernel: [    3.337816] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint as /devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb6/6-2/6-2.1/6-2.1.2/6-2.1.2:1.1/0003:17EF:6009.0002/input/input5
Aug 26 09:07:59 ananda kernel: [    3.361878] usb 6-2.3: New USB device found, idVendor=05fc, idProduct=0231, bcdDevice= 1.00
Aug 26 09:07:59 ananda kernel: [    3.361888] usb 6-2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Aug 26 09:07:59 ananda kernel: [    3.361891] usb 6-2.3: Product: JBL Pebbles
Aug 26 09:07:59 ananda kernel: [    3.361894] usb 6-2.3: Manufacturer: Harman Multimedia
Aug 26 09:07:59 ananda kernel: [    3.361896] usb 6-2.3: SerialNumber: 1.0.0
Aug 26 09:07:59 ananda kernel: [    3.404251] lenovo 0003:17EF:6009.0002: input,hiddev0,hidraw1: USB HID v1.10 Mouse [Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint] on usb-0000:07:00.4-2.1.2/input1
Aug 26 09:07:59 ananda kernel: [    3.409991] input: Harman Multimedia JBL Pebbles as /devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb6/6-2/6-2.3/6-2.3:1.2/0003:05FC:0231.0003/input/input6
Aug 26 09:07:59 ananda kernel: [    3.417837] usb 6-2.1.3: new low-speed USB device number 8 using xhci_hcd
Aug 26 09:07:59 ananda kernel: [    3.470644] hid-generic 0003:05FC:0231.0003: input,hidraw2: USB HID v1.00 Device [Harman Multimedia JBL Pebbles] on usb-0000:07:00.4-2.3/input2
Aug 26 09:07:59 ananda kernel: [    3.572955] usb 6-2.1.3: New USB device found, idVendor=046d, idProduct=c050, bcdDevice=27.20
Aug 26 09:07:59 ananda kernel: [    3.572965] usb 6-2.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 26 09:07:59 ananda kernel: [    3.572968] usb 6-2.1.3: Product: USB-PS/2 Optical Mouse
Aug 26 09:07:59 ananda kernel: [    3.572971] usb 6-2.1.3: Manufacturer: Logitech
Aug 26 09:07:59 ananda kernel: [    3.654063] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb6/6-2/6-2.1/6-2.1.3/6-2.1.3:1.0/0003:046D:C050.0004/input/input7
Aug 26 09:07:59 ananda kernel: [    3.654286] hid-generic 0003:046D:C050.0004: input,hidraw3: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:07:00.4-2.1.3/input0
Aug 26 09:07:59 ananda kernel: [    5.339442] psmouse serio2: trackpoint: Elan TrackPoint firmware: 0x11, buttons: 3/3
Aug 26 09:07:59 ananda kernel: [    6.485441] input: TPPS/2 Elan TrackPoint as /devices/platform/i8042/serio1/serio2/input/input3
Aug 26 09:07:59 ananda kernel: [    6.802163] random: crng init done
Aug 26 09:07:59 ananda kernel: [   19.902788] raid6: avx2x4   gen() 38197 MB/s
Aug 26 09:07:59 ananda kernel: [   19.919790] raid6: avx2x4   xor() 10105 MB/s
Aug 26 09:07:59 ananda kernel: [   19.936781] raid6: avx2x2   gen() 39862 MB/s
Aug 26 09:07:59 ananda kernel: [   19.953785] raid6: avx2x2   xor() 23871 MB/s
Aug 26 09:07:59 ananda kernel: [   19.970781] raid6: avx2x1   gen() 33243 MB/s
Aug 26 09:07:59 ananda kernel: [   19.987783] raid6: avx2x1   xor() 17759 MB/s
Aug 26 09:07:59 ananda kernel: [   20.004773] raid6: sse2x4   gen() 18596 MB/s
Aug 26 09:07:59 ananda kernel: [   20.021768] raid6: sse2x4   xor()  8683 MB/s
Aug 26 09:07:59 ananda kernel: [   20.038767] raid6: sse2x2   gen() 20381 MB/s
Aug 26 09:07:59 ananda kernel: [   20.055781] raid6: sse2x2   xor() 12117 MB/s
Aug 26 09:07:59 ananda kernel: [   20.072781] raid6: sse2x1   gen() 15897 MB/s
Aug 26 09:07:59 ananda kernel: [   20.089781] raid6: sse2x1   xor()  8983 MB/s
Aug 26 09:07:59 ananda kernel: [   20.090326] raid6: using algorithm avx2x2 gen() 39862 MB/s
Aug 26 09:07:59 ananda kernel: [   20.090869] raid6: .... xor() 23871 MB/s, rmw enabled
Aug 26 09:07:59 ananda kernel: [   20.091409] raid6: using avx2x2 recovery algorithm
Aug 26 09:07:59 ananda kernel: [   20.092380] xor: automatically using best checksumming function   avx       
Aug 26 09:07:59 ananda kernel: [   20.135548] Btrfs loaded, crc32c=crc32c-intel, zoned=yes
Aug 26 09:07:59 ananda kernel: [   20.179910] BTRFS: device label home2 devid 1 transid 105555 /dev/mapper/nvme-home scanned by btrfs (517)
Aug 26 09:07:59 ananda kernel: [   20.180655] BTRFS: device label daten devid 1 transid 5288 /dev/mapper/nvme-daten scanned by btrfs (517)
Aug 26 09:07:59 ananda kernel: [   20.181373] BTRFS: device label home devid 1 transid 1741410 /dev/mapper/nvme-homedefect scanned by btrfs (517)
Aug 26 09:07:59 ananda kernel: [   20.182081] BTRFS: device label system devid 1 transid 64631 /dev/mapper/nvme-system scanned by btrfs (517)
Aug 26 09:07:59 ananda kernel: [   20.191696] PM: Image not found (code -22)
Aug 26 09:07:59 ananda kernel: [   20.201735] BTRFS info (device dm-1): using free space tree
Aug 26 09:07:59 ananda kernel: [   20.202344] BTRFS info (device dm-1): has skinny extents
Aug 26 09:07:59 ananda kernel: [   20.208808] BTRFS info (device dm-1): enabling ssd optimizations
Aug 26 09:07:59 ananda kernel: [   20.386271] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input8
Aug 26 09:07:59 ananda kernel: [   20.387675] ACPI: button: Power Button [PWRB]
Aug 26 09:07:59 ananda kernel: [   20.387824] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input9
Aug 26 09:07:59 ananda kernel: [   20.389581] IPMI message handler: version 39.2
Aug 26 09:07:59 ananda kernel: [   20.389884] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
Aug 26 09:07:59 ananda kernel: [   20.391530] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
Aug 26 09:07:59 ananda kernel: [   20.392757] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
Aug 26 09:07:59 ananda kernel: [   20.392820] ACPI: button: Lid Switch [LID]
Aug 26 09:07:59 ananda kernel: [   20.393274] r8169 0000:02:00.0 en0: renamed from eth0
Aug 26 09:07:59 ananda kernel: [   20.393933] acpi PNP0C14:04: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
Aug 26 09:07:59 ananda kernel: [   20.394723] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input10
Aug 26 09:07:59 ananda kernel: [   20.395756] acpi PNP0C14:05: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
Aug 26 09:07:59 ananda kernel: [   20.398068] ACPI: button: Sleep Button [SLPB]
Aug 26 09:07:59 ananda kernel: [   20.399449] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input11
Aug 26 09:07:59 ananda kernel: [   20.399464] ipmi device interface
Aug 26 09:07:59 ananda kernel: [   20.400549] ACPI: button: Power Button [PWRF]
Aug 26 09:07:59 ananda kernel: [   20.402467] acpi_cpufreq: overriding BIOS provided _PSD data
Aug 26 09:07:59 ananda kernel: [   20.405633] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Aug 26 09:07:59 ananda kernel: [   20.405703] ACPI: battery: Slot [BAT0] (battery present)
Aug 26 09:07:59 ananda kernel: [   20.407034] ACPI: AC: AC Adapter [AC] (on-line)
Aug 26 09:07:59 ananda kernel: [   20.408990] acpi device:1a: registered as cooling_device16
Aug 26 09:07:59 ananda kernel: [   20.410532] r8169 0000:05:00.0 en1: renamed from eth1
Aug 26 09:07:59 ananda kernel: [   20.419230] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:19/LNXVIDEO:00/input/input12
Aug 26 09:07:59 ananda kernel: [   20.419878] ipmi_si: IPMI System Interface driver
Aug 26 09:07:59 ananda kernel: [   20.424266] ipmi_si: Unable to find any System Interface(s)
Aug 26 09:07:59 ananda kernel: [   20.426351] snd_rn_pci_acp3x 0000:07:00.5: enabling device (0000 -> 0002)
Aug 26 09:07:59 ananda kernel: [   20.444649] input: PC Speaker as /devices/platform/pcspkr/input/input13
Aug 26 09:07:59 ananda kernel: [   20.444698] cfg80211: Loading compiled-in X.509 certificates for regulatory database
Aug 26 09:07:59 ananda kernel: [   20.450373] ccp 0000:07:00.2: enabling device (0000 -> 0002)
Aug 26 09:07:59 ananda kernel: [   20.452912] ccp 0000:07:00.2: ccp: unable to access the device: you might be running a broken BIOS.
Aug 26 09:07:59 ananda kernel: [   20.455257] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
Aug 26 09:07:59 ananda kernel: [   20.459431] mc: Linux media interface: v0.10
Aug 26 09:07:59 ananda kernel: [   20.469423] ccp 0000:07:00.2: tee enabled
Aug 26 09:07:59 ananda kernel: [   20.481073] ccp 0000:07:00.2: psp enabled
Aug 26 09:07:59 ananda kernel: [   20.508009] Non-volatile memory driver v1.3
Aug 26 09:07:59 ananda kernel: [   20.529164] pstore: Using crash dump compression: deflate
Aug 26 09:07:59 ananda kernel: [   20.546093] thinkpad_acpi: ThinkPad ACPI Extras v0.26
Aug 26 09:07:59 ananda kernel: [   20.554678] thinkpad_acpi: http://ibm-acpi.sf.net/
Aug 26 09:07:59 ananda kernel: [   20.554724] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
Aug 26 09:07:59 ananda kernel: [   20.566792] thinkpad_acpi: ThinkPad BIOS R1BET65W(1.34 ), EC R1BHT65W
Aug 26 09:07:59 ananda kernel: [   20.572805] pstore: Registered efi as persistent store backend
Aug 26 09:07:59 ananda kernel: [   20.580399] thinkpad_acpi: Lenovo ThinkPad T14 Gen 1, model 20UD0013GE
Aug 26 09:07:59 ananda kernel: [   20.582889] videodev: Linux video capture interface: v2.00
Aug 26 09:07:59 ananda kernel: [   20.590681] thinkpad_acpi: radio switch found; radios are enabled
Aug 26 09:07:59 ananda kernel: [   20.594148] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
Aug 26 09:07:59 ananda kernel: [   20.594153] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
Aug 26 09:07:59 ananda kernel: [   20.596953] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
Aug 26 09:07:59 ananda kernel: [   20.609518] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Aug 26 09:07:59 ananda kernel: [   20.612185] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
Aug 26 09:07:59 ananda kernel: [   20.612346] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
Aug 26 09:07:59 ananda kernel: [   20.640910] thinkpad_acpi: battery 1 registered (start 70, stop 95)
Aug 26 09:07:59 ananda kernel: [   20.640925] ACPI: battery: new extension: ThinkPad Battery Extension
Aug 26 09:07:59 ananda kernel: [   20.640952] kvm: Nested Virtualization enabled
Aug 26 09:07:59 ananda kernel: [   20.640955] SVM: kvm: Nested Paging enabled
Aug 26 09:07:59 ananda kernel: [   20.640972] SVM: Virtual VMLOAD VMSAVE supported
Aug 26 09:07:59 ananda kernel: [   20.640973] SVM: Virtual GIF supported
Aug 26 09:07:59 ananda kernel: [   20.650201] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input14
Aug 26 09:07:59 ananda kernel: [   20.664553] Intel(R) Wireless WiFi driver for Linux
Aug 26 09:07:59 ananda kernel: [   20.665808] usb 2-2: Found UVC 1.10 device Integrated Camera (04f2:b6d0)
Aug 26 09:07:59 ananda kernel: [   20.667738] iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
Aug 26 09:07:59 ananda kernel: [   20.676972] input: Integrated Camera: Integrated C as /devices/pci0000:00/0000:00:02.7/0000:06:00.0/usb2/2-2/2-2:1.0/input/input15
Aug 26 09:07:59 ananda kernel: [   20.678935] usb 2-2: Found UVC 1.50 device Integrated Camera (04f2:b6d0)
Aug 26 09:07:59 ananda kernel: [   20.680887] input: Integrated Camera: Integrated I as /devices/pci0000:00/0000:00:02.7/0000:06:00.0/usb2/2-2/2-2:1.2/input/input16
Aug 26 09:07:59 ananda kernel: [   20.681045] usbcore: registered new interface driver uvcvideo
Aug 26 09:07:59 ananda kernel: [   20.682030] iwlwifi 0000:03:00.0: Direct firmware load for iwlwifi-cc-a0-64.ucode failed with error -2
Aug 26 09:07:59 ananda kernel: [   20.684118] MCE: In-kernel MCE decoding enabled.
Aug 26 09:07:59 ananda kernel: [   20.685699] iwlwifi 0000:03:00.0: api flags index 2 larger than supported by driver
Aug 26 09:07:59 ananda kernel: [   20.685729] iwlwifi 0000:03:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
Aug 26 09:07:59 ananda kernel: [   20.686200] iwlwifi 0000:03:00.0: loaded firmware version 63.c04f3485.0 cc-a0-63.ucode op_mode iwlmvm
Aug 26 09:07:59 ananda kernel: [   20.712347] snd_hda_intel 0000:07:00.1: enabling device (0000 -> 0002)
Aug 26 09:07:59 ananda kernel: [   20.713334] snd_hda_intel 0000:07:00.6: enabling device (0000 -> 0002)
Aug 26 09:07:59 ananda kernel: [   20.731065] acp_pdm_mach acp_pdm_mach.0: snd_soc_register_card(acp) failed: -517
Aug 26 09:07:59 ananda kernel: [   20.755679] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:07:00.1/sound/card0/input17
Aug 26 09:07:59 ananda kernel: [   20.760299] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:07:00.1/sound/card0/input18
Aug 26 09:07:59 ananda kernel: [   20.761432] snd_hda_codec_realtek hdaudioC2D0: autoconfig for ALC257: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
Aug 26 09:07:59 ananda kernel: [   20.764822] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:07:00.1/sound/card0/input19
Aug 26 09:07:59 ananda kernel: [   20.767520] snd_hda_codec_realtek hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
Aug 26 09:07:59 ananda kernel: [   20.774445] snd_hda_codec_realtek hdaudioC2D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
Aug 26 09:07:59 ananda kernel: [   20.776889] snd_hda_codec_realtek hdaudioC2D0:    mono: mono_out=0x0
Aug 26 09:07:59 ananda kernel: [   20.779270] snd_hda_codec_realtek hdaudioC2D0:    inputs:
Aug 26 09:07:59 ananda kernel: [   20.781891] snd_hda_codec_realtek hdaudioC2D0:      Mic=0x19
Aug 26 09:07:59 ananda kernel: [   20.785384] iwlwifi 0000:03:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
Aug 26 09:07:59 ananda kernel: [   20.798006] thermal thermal_zone0: failed to read out thermal zone (-61)
Aug 26 09:07:59 ananda kernel: [   20.799966] usbcore: registered new interface driver snd-usb-audio
Aug 26 09:07:59 ananda kernel: [   20.855598] Bluetooth: Core ver 2.22
Aug 26 09:07:59 ananda kernel: [   20.856355] [drm] amdgpu kernel modesetting enabled.
Aug 26 09:07:59 ananda kernel: [   20.859974] NET: Registered PF_BLUETOOTH protocol family
Aug 26 09:07:59 ananda kernel: [   20.866251] Bluetooth: HCI device and connection manager initialized
Aug 26 09:07:59 ananda kernel: [   20.870102] Bluetooth: HCI socket layer initialized
Aug 26 09:07:59 ananda kernel: [   20.874153] Bluetooth: L2CAP socket layer initialized
Aug 26 09:07:59 ananda kernel: [   20.878069] Bluetooth: SCO socket layer initialized
Aug 26 09:07:59 ananda kernel: [   20.889215] usbcore: registered new interface driver btusb
Aug 26 09:07:59 ananda kernel: [   20.890776] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
Aug 26 09:07:59 ananda kernel: [   20.895835] Bluetooth: hci0: Device revision is 1
Aug 26 09:07:59 ananda kernel: [   20.898090] Bluetooth: hci0: Secure boot is enabled
Aug 26 09:07:59 ananda kernel: [   20.900341] Bluetooth: hci0: OTP lock is enabled
Aug 26 09:07:59 ananda kernel: [   20.902564] Bluetooth: hci0: API lock is enabled
Aug 26 09:07:59 ananda kernel: [   20.904751] Bluetooth: hci0: Debug lock is disabled
Aug 26 09:07:59 ananda kernel: [   20.906924] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Aug 26 09:07:59 ananda kernel: [   20.911929] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
Aug 26 09:07:59 ananda kernel: [   20.917583] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:08.1/0000:07:00.6/sound/card2/input20
Aug 26 09:07:59 ananda kernel: [   20.920429] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:07:00.6/sound/card2/input21
Aug 26 09:07:59 ananda kernel: [   20.923040] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:08.1/0000:07:00.6/sound/card2/input22
Aug 26 09:07:59 ananda kernel: [   20.956946] iwlwifi 0000:03:00.0: Detected RF HR B3, rfid=0x10a100
Aug 26 09:07:59 ananda kernel: [   21.029542] iwlwifi 0000:03:00.0: base HW address: a8:7e:ea:0a:c6:cf
Aug 26 09:07:59 ananda kernel: [   21.093786] amdgpu: Virtual CRAT table created for CPU
Aug 26 09:07:59 ananda kernel: [   21.096091] amdgpu: Topology: Add CPU node
Aug 26 09:07:59 ananda kernel: [   21.098697] checking generic (860000000 7f0000) vs hw (860000000 10000000)
Aug 26 09:07:59 ananda kernel: [   21.098702] fb0: switching to amdgpudrmfb from EFI VGA
Aug 26 09:07:59 ananda kernel: [   21.101096] Console: switching to colour dummy device 80x25
Aug 26 09:07:59 ananda kernel: [   21.101153] amdgpu 0000:07:00.0: vgaarb: deactivate vga console
Aug 26 09:07:59 ananda kernel: [   21.101220] amdgpu 0000:07:00.0: enabling device (0006 -> 0007)
Aug 26 09:07:59 ananda kernel: [   21.101825] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1636 0x17AA:0x5081 0xD1).
Aug 26 09:07:59 ananda kernel: [   21.101838] amdgpu 0000:07:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
Aug 26 09:07:59 ananda kernel: [   21.104932] [drm] register mmio base: 0xFD300000
Aug 26 09:07:59 ananda kernel: [   21.104946] [drm] register mmio size: 524288
Aug 26 09:07:59 ananda kernel: [   21.104953] [drm] PCIE atomic ops is not supported
Aug 26 09:07:59 ananda kernel: [   21.106029] [drm] add ip block number 0 <soc15_common>
Aug 26 09:07:59 ananda kernel: [   21.106038] [drm] add ip block number 1 <gmc_v9_0>
Aug 26 09:07:59 ananda kernel: [   21.106043] [drm] add ip block number 2 <vega10_ih>
Aug 26 09:07:59 ananda kernel: [   21.106050] [drm] add ip block number 3 <psp>
Aug 26 09:07:59 ananda kernel: [   21.106054] [drm] add ip block number 4 <smu>
Aug 26 09:07:59 ananda kernel: [   21.106078] [drm] add ip block number 5 <gfx_v9_0>
Aug 26 09:07:59 ananda kernel: [   21.106082] [drm] add ip block number 6 <sdma_v4_0>
Aug 26 09:07:59 ananda kernel: [   21.106087] [drm] add ip block number 7 <dm>
Aug 26 09:07:59 ananda kernel: [   21.106091] [drm] add ip block number 8 <vcn_v2_0>
Aug 26 09:07:59 ananda kernel: [   21.106095] [drm] add ip block number 9 <jpeg_v2_0>
Aug 26 09:07:59 ananda kernel: [   21.106120] amdgpu 0000:07:00.0: amdgpu: Fetched VBIOS from VFCT
Aug 26 09:07:59 ananda kernel: [   21.106128] amdgpu: ATOM BIOS: 113-RENOIR-026
Aug 26 09:07:59 ananda kernel: [   21.115637] [drm] VCN decode is enabled in VM mode
Aug 26 09:07:59 ananda kernel: [   21.115648] [drm] VCN encode is enabled in VM mode
Aug 26 09:07:59 ananda kernel: [   21.115652] [drm] JPEG decode is enabled in VM mode
Aug 26 09:07:59 ananda kernel: [   21.115713] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
Aug 26 09:07:59 ananda kernel: [   21.115727] amdgpu 0000:07:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
Aug 26 09:07:59 ananda kernel: [   21.115737] amdgpu 0000:07:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
Aug 26 09:07:59 ananda kernel: [   21.115745] amdgpu 0000:07:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
Aug 26 09:07:59 ananda kernel: [   21.115759] [drm] Detected VRAM RAM=2048M, BAR=2048M
Aug 26 09:07:59 ananda kernel: [   21.115763] [drm] RAM width 128bits DDR4
Aug 26 09:07:59 ananda kernel: [   21.115914] [drm] amdgpu: 2048M of VRAM memory ready
Aug 26 09:07:59 ananda kernel: [   21.115919] [drm] amdgpu: 3072M of GTT memory ready.
Aug 26 09:07:59 ananda kernel: [   21.115929] [drm] GART: num cpu pages 262144, num gpu pages 262144
Aug 26 09:07:59 ananda kernel: [   21.116044] [drm] PCIE GART of 1024M enabled.
Aug 26 09:07:59 ananda kernel: [   21.116049] [drm] PTB located at 0x000000F400900000
Aug 26 09:07:59 ananda kernel: [   21.118189] amdgpu 0000:07:00.0: amdgpu: PSP runtime database doesn't exist
Aug 26 09:07:59 ananda kernel: [   21.124539] [drm] Loading DMUB firmware via PSP: version=0x01010019
Aug 26 09:07:59 ananda kernel: [   21.125963] [drm] Found VCN firmware Version ENC: 1.14 DEC: 5 VEP: 0 Revision: 20
Aug 26 09:07:59 ananda kernel: [   21.126005] [drm] PSP loading VCN firmware
Aug 26 09:07:59 ananda kernel: [   21.954754] [drm] reserve 0x400000 from 0xf47f800000 for PSP TMR
Aug 26 09:07:59 ananda kernel: [   22.039088] amdgpu 0000:07:00.0: amdgpu: RAS: optional ras ta ucode is not available
Aug 26 09:07:59 ananda kernel: [   22.048191] amdgpu 0000:07:00.0: amdgpu: RAP: optional rap ta ucode is not available
Aug 26 09:07:59 ananda kernel: [   22.048202] amdgpu 0000:07:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
Aug 26 09:07:59 ananda kernel: [   22.048796] amdgpu 0000:07:00.0: amdgpu: SMU is initialized successfully!
Aug 26 09:07:59 ananda kernel: [   22.050169] [drm] kiq ring mec 2 pipe 1 q 0
Aug 26 09:07:59 ananda kernel: [   22.050915] [drm] Display Core initialized with v3.2.141!
Aug 26 09:07:59 ananda kernel: [   22.051576] [drm] DMUB hardware initialized: version=0x01010019
Aug 26 09:07:59 ananda kernel: [   22.077681] snd_hda_intel 0000:07:00.1: bound 0000:07:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
Aug 26 09:07:59 ananda kernel: [   22.237198] [drm] VCN decode and encode initialized successfully(under DPG Mode).
Aug 26 09:07:59 ananda kernel: [   22.237230] [drm] JPEG decode initialized successfully.
Aug 26 09:07:59 ananda kernel: [   22.239556] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
Aug 26 09:07:59 ananda kernel: [   22.239813] amdgpu: Virtual CRAT table created for GPU
Aug 26 09:07:59 ananda kernel: [   22.239999] amdgpu: Topology: Add dGPU node [0x1636:0x1002]
Aug 26 09:07:59 ananda kernel: [   22.240012] kfd kfd: amdgpu: added device 1002:1636
Aug 26 09:07:59 ananda kernel: [   22.240019] amdgpu 0000:07:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 18, active_cu_number 27
Aug 26 09:07:59 ananda kernel: [   22.243784] [drm] fb mappable at 0x7B0CD1000
Aug 26 09:07:59 ananda kernel: [   22.243793] [drm] vram apper at 0x7B0000000
Aug 26 09:07:59 ananda kernel: [   22.243796] [drm] size 8294400
Aug 26 09:07:59 ananda kernel: [   22.243800] [drm] fb depth is 24
Aug 26 09:07:59 ananda kernel: [   22.243803] [drm]    pitch is 7680
Aug 26 09:07:59 ananda kernel: [   22.243969] fbcon: amdgpu (fb0) is primary device
Aug 26 09:07:59 ananda kernel: [   22.314006] Console: switching to colour frame buffer device 240x67
Aug 26 09:07:59 ananda kernel: [   22.336210] amdgpu 0000:07:00.0: [drm] fb0: amdgpu frame buffer device
Aug 26 09:07:59 ananda kernel: [   22.341933] amdgpu 0000:07:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
Aug 26 09:07:59 ananda kernel: [   22.341940] amdgpu 0000:07:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
Aug 26 09:07:59 ananda kernel: [   22.341943] amdgpu 0000:07:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
Aug 26 09:07:59 ananda kernel: [   22.341945] amdgpu 0000:07:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
Aug 26 09:07:59 ananda kernel: [   22.341947] amdgpu 0000:07:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
Aug 26 09:07:59 ananda kernel: [   22.341949] amdgpu 0000:07:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
Aug 26 09:07:59 ananda kernel: [   22.341951] amdgpu 0000:07:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
Aug 26 09:07:59 ananda kernel: [   22.341953] amdgpu 0000:07:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
Aug 26 09:07:59 ananda kernel: [   22.341954] amdgpu 0000:07:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
Aug 26 09:07:59 ananda kernel: [   22.341957] amdgpu 0000:07:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
Aug 26 09:07:59 ananda kernel: [   22.341959] amdgpu 0000:07:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
Aug 26 09:07:59 ananda kernel: [   22.341962] amdgpu 0000:07:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
Aug 26 09:07:59 ananda kernel: [   22.341964] amdgpu 0000:07:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
Aug 26 09:07:59 ananda kernel: [   22.341966] amdgpu 0000:07:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
Aug 26 09:07:59 ananda kernel: [   22.341968] amdgpu 0000:07:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
Aug 26 09:07:59 ananda kernel: [   22.343891] [drm] Initialized amdgpu 3.42.0 20150101 for 0000:07:00.0 on minor 0
Aug 26 09:07:59 ananda kernel: [   22.496679] Bluetooth: hci0: Waiting for firmware download to complete
Aug 26 09:07:59 ananda kernel: [   22.497669] Bluetooth: hci0: Firmware loaded in 1546258 usecs
Aug 26 09:07:59 ananda kernel: [   22.497752] Bluetooth: hci0: Waiting for device to boot
Aug 26 09:07:59 ananda kernel: [   22.506099] Adding 41943036k swap on /dev/mapper/nvme-swap.  Priority:-2 extents:1 across:41943036k SSFS
Aug 26 09:07:59 ananda kernel: [   22.512709] Bluetooth: hci0: Device booted in 14624 usecs
Aug 26 09:07:59 ananda kernel: [   22.512879] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-20-1-3.ddc
Aug 26 09:07:59 ananda kernel: [   22.515200] BTRFS info (device dm-1): use zstd compression, level 3
Aug 26 09:07:59 ananda kernel: [   22.515261] BTRFS info (device dm-1): using free space tree
Aug 26 09:07:59 ananda kernel: [   22.518721] Bluetooth: hci0: Applying Intel DDC parameters completed
Aug 26 09:07:59 ananda kernel: [   22.527692] Bluetooth: hci0: Firmware revision 0.0 build 191 week 21 2021
Aug 26 09:07:59 ananda kernel: [   22.703733] io scheduler kyber registered
Aug 26 09:07:59 ananda kernel: [   23.023861] SGI XFS with ACLs, security attributes, realtime, no debug enabled
Aug 26 09:07:59 ananda kernel: [   23.036421] XFS (nvme0n1p2): Mounting V5 Filesystem
Aug 26 09:07:59 ananda kernel: [   23.091702] XFS (nvme0n1p2): Starting recovery (logdev: internal)
Aug 26 09:07:59 ananda kernel: [   23.096224] XFS (nvme0n1p2): Ending recovery (logdev: internal)
Aug 26 09:07:59 ananda kernel: [   23.099736] xfs filesystem being mounted at /boot supports timestamps until 2038 (0x7fffffff)
Aug 26 09:07:59 ananda kernel: [   23.119868] BTRFS info (device dm-5): use zstd compression, level 3
Aug 26 09:07:59 ananda kernel: [   23.121690] BTRFS info (device dm-5): using free space tree
Aug 26 09:07:59 ananda kernel: [   23.123483] BTRFS info (device dm-5): has skinny extents
Aug 26 09:07:59 ananda kernel: [   23.176711] BTRFS info (device dm-5): enabling ssd optimizations
Aug 26 09:07:59 ananda kernel: [   23.178489] BTRFS info (device dm-5): start tree-log replay
Aug 26 09:07:59 ananda kernel: [   23.424607] BTRFS info (device dm-5): checking UUID tree
Aug 26 09:07:59 ananda kernel: [   23.433947] BTRFS info (device dm-4): use zstd compression, level 3
Aug 26 09:07:59 ananda kernel: [   23.435708] BTRFS info (device dm-4): using free space tree
Aug 26 09:07:59 ananda kernel: [   23.437438] BTRFS info (device dm-4): has skinny extents
Aug 26 09:07:59 ananda kernel: [   23.566279] BTRFS info (device dm-4): enabling ssd optimizations

Thanks,
-- 
Martin



