Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7E64FB21E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 05:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244475AbiDKDE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Apr 2022 23:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244474AbiDKDEZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Apr 2022 23:04:25 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E99796171
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Apr 2022 20:02:09 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 78DEB2C2574; Sun, 10 Apr 2022 23:02:08 -0400 (EDT)
Date:   Sun, 10 Apr 2022 23:02:08 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "petr.develak" <petr.develak@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: High corrupt count and  checksum errors
Message-ID: <YlOaMP74k6I7XgAW@hungrycats.org>
References: <pKrpMmCVfuH5tLE9FiKhRoMPvU9Sw8uj43OQ2ULNCxK7vNeFX3wPj8Fgw-ZasY2qLNTZyi1qBUtiqFZAHxJDOBJAlPXhYkiFZudJkgYpDAc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pKrpMmCVfuH5tLE9FiKhRoMPvU9Sw8uj43OQ2ULNCxK7vNeFX3wPj8Fgw-ZasY2qLNTZyi1qBUtiqFZAHxJDOBJAlPXhYkiFZudJkgYpDAc=@protonmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 08, 2022 at 08:56:51PM +0000, petr.develak wrote:
> Hi,
> so I started having issues with my btrfs. And I would say, I had this
> issue before. Last time however, I evaluated as failing SSD and at
> the end replaced it, reinstalled and did not have the issue. Until now.
> 
> Last time it was mostly manifesting as massive re-downloads on Steam and
> that's how I started digging into it again today. Suddenly Steam wants
> to re-download like 30Gb and during the download filesystem goes to
> read-only. After reboot it works until I try to re-download stuff again.
> 
> Obviously there is a lot of "solutions" and ideas what to do and
> most of those are: scrub, check, rebalance ,delete files if you can,
> repair. Balancing and repair are the only things I have not tried.

Balance won't help, it will stop at the first unrecoverable error.
Repair is a last resort to be done after extracting any data you want
to save with 'btrfs restore'.  Deleting files works if the corrupted
blocks are file data, but it doesn't work for metadata corruption.
Scrub works if you have a redundant raid profile like 'dup' or 'raid1',
but if you have corrupted data or metadata in the 'single' profile then
it's gone forever.

> I have two questions:
> 
> 1. What is causing it? This one is me, since it looks like a repeated
> issue on a system where only SSD and GPU was changed. Some mem-tests
> are in order.

Three things cause csum failures:

	1.  Drive is failing and corrupting data silently

	2.  RAM is failing (in the drive, the host, or the HBA)
	and corrupting data

	3.  A kernel bug (in btrfs or some other driver) is corrupting
	data in memory

The most likely cause of csum errors is silent corruption on the SSD,
since that's the exact event btrfs csums are designed to detect.
Some low-end SSDs will corrupt data during early stages of device
failure without reporting IO errors or giving any indication of issues
in SMART data.

I've seen a number of reports from users of 970 EVOs corrupting sectors
as they start to die, but I've tested a few 970 EVOs and so far mine
have all died before any corruption was detected.  So the data I have
is inconclusive for how likely silent corruption is for this drive model.

Less likely causes are RAM misconfiguration (overclocking, undervoltage,
insufficient cooling) or failure (making csums incorrect in RAM) and
power supply issues (breaking RAM in every part of the PC).  It may be a
good idea to replace or upgrade the power supply, especially if it's old.
RAM failures are more likely to resemble kernel bugs than disk failures,
but disk failures can also be caused by power and cooling issues.

Kernel bugs typically do not manifest as csum failure, but produce
other error messages (especially tree checker failures) from parts of
the kernel code that run after the csum check.

> 2. How/if can it be fixed? Data are backed up. If I have to format
> the SSD, so be it, but it would be really nice if there is a more
> convenient solution to this.

Use dup metadata, so btrfs can repair metadata corruptions automatically
as soon as they are detected.  Single metadata cannot tolerate any
corruption or sector-level losses--one bit lost in the wrong place breaks
the filesystem.

Run scrubs at regular intervals (for a drive this small, daily
scrub should be fine) to catch corruption early.  Monitor the scrub
results--have it send you an email when the device stats are above zero.

If you have two failures on the same drive model, either try a different
drive model, or look for failures in other parts of the system (power
and cooling, or mainboard compatibility).

'btrfs check --init-extent-tree' might be able to rebuild the filesystem
from subvol trees if the subvol trees are intact; however, if the subvol
tree is damaged (or almost any tree except extent, csum, free space and
log trees is damaged) then check --repair won't work, and may damage
the filesystem further when trying.

> Here is my system info:
> 
> $ uname -a
> Linux <hostname> 5.16.18-200.fc35.x86_64 #1 SMP PREEMPT Mon Mar 28 14:10:07 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> 
> $ btrfs --version
> btrfs-progs v5.16.2
> 
> $btrfs fi show
> Label: 'fedora_localhost-live'  uuid: eb56bce8-9d27-4ecd-b5bd-6fc2dc895943
>         Total devices 1 FS bytes used 802.83GiB
>         devid    1 size 929.91GiB used 892.02GiB path /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b
> 
> $btrfs fi df /
> Data, single: total=886.01GiB, used=799.64GiB
> System, single: total=4.00MiB, used=128.00KiB
> Metadata, single: total=6.01GiB, used=3.19GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> And some tldr of the system/issue
> * It's Fedora 35 (KDE) with latest kernel.
> * Btrfs in question is on Samsung EVO 970 1Tb. Btrfs is inside LUKS2
> * Running on Ryzen 3600, X570 Aorus Elite, 32Gb DD4 3200 Kingston RAM
> * When trying to read and write(remove) a problematic files (out from
> btrfs check) I get Input/output error or no issue what so ever
> 
> >From dmesg:
> warning (device dm-0): checksum error at logical 831624151040 on dev /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b, physical 724249968640: metadata leaf (level 0) in tree 256
> bdev /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b errs: wr 0, rd 0, flush 0, corrupt 818188740, gen 0

It looks like it's been banging against this one corrupt metadata block
for some time now.  That indicates the failure occurred some time ago.

> Whole dmesg in the attachment (did a scrub before)
> 
> >From btrfs-check:
> 
> UUID: eb56bce8-9d27-4ecd-b5bd-6fc2dc895943
> [1/7] checking root items
> [2/7] checking extents
> checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8
> checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8
> Csum didn't match
> ref mismatch on [1086820352 4096] extent item 1, found 0
> incorrect local backref count on 1086820352 root 256 owner 1178 offset 0 found 0 wanted 1 back 0x560c3fbf6e00
> backref disk bytenr does not match extent record, bytenr=1086820352, ref bytenr=0
> backpointer mismatch on [1086820352 4096]
> owner ref check failed [1086820352 4096]
> ref mismatch on [1086828544 4096] extent item 1, found 0
> incorrect local backref count on 1086828544 root 256 owner 1171 offset 0 found 0 wanted 1 back 0x560c3fbf7060
> backref disk bytenr does not match extent record, bytenr=1086828544, ref bytenr=0
> backpointer mismatch on [1086828544 4096]
> owner ref check failed [1086828544 4096]
> ref mismatch on [6162178048 16384] extent item 1, found 0
> incorrect local backref count on 6162178048 root 256 owner 1168 offset 114688 found 0 wanted 1 back 0x560c4b8a6070
> backref disk bytenr does not match extent record, bytenr=6162178048, ref bytenr=0
> backpointer mismatch on [6162178048 16384]
> owner ref check failed [6162178048 16384]
> ref mismatch on [6162194432 16384] extent item 1, found 0
> incorrect local backref count on 6162194432 root 256 owner 1168 offset 131072 found 0 wanted 1 back 0x560c4b8a61a0
> backref disk bytenr does not match extent record, bytenr=6162194432, ref bytenr=0
> backpointer mismatch on [6162194432 16384]
> owner ref check failed [6162194432 16384]
> ref mismatch on [6162276352 4096] extent item 1, found 0
> incorrect local backref count on 6162276352 root 256 owner 1175 offset 0 found 0 wanted 1 back 0x560c4b8a6400
> backref disk bytenr does not match extent record, bytenr=6162276352, ref bytenr=0
> backpointer mismatch on [6162276352 4096]
> owner ref check failed [6162276352 4096]
> ref mismatch on [6163308544 65536] extent item 1, found 0
> incorrect local backref count on 6163308544 root 256 owner 1168 offset 0 found 0 wanted 1 back 0x560c4b8a94c0
> backref disk bytenr does not match extent record, bytenr=6163308544, ref bytenr=0
> backpointer mismatch on [6163308544 65536]
> owner ref check failed [6163308544 65536]
> ref mismatch on [6163374080 32768] extent item 1, found 0
> incorrect local backref count on 6163374080 root 256 owner 1168 offset 65536 found 0 wanted 1 back 0x560c4b8a95f0
> backref disk bytenr does not match extent record, bytenr=6163374080, ref bytenr=0
> backpointer mismatch on [6163374080 32768]
> owner ref check failed [6163374080 32768]
> ref mismatch on [6163406848 16384] extent item 1, found 0
> incorrect local backref count on 6163406848 root 256 owner 1168 offset 98304 found 0 wanted 1 back 0x560c4b8a9720
> backref disk bytenr does not match extent record, bytenr=6163406848, ref bytenr=0
> backpointer mismatch on [6163406848 16384]
> owner ref check failed [6163406848 16384]
> owner ref check failed [831624151040 16384]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8
> checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8
> Csum didn't match
> The following tree block(s) is corrupted in tree 256:
>         tree block bytenr: 1299300352, level: 1, node key: (1168, 1, 0)
> root 256 inode 1168 errors 2001, no inode item, link count wrong
>         unresolved ref dir 1102 index 84 namelen 36 name tagremoteidresourcerelationtable.ibd filetype 1 errors 4, no inode ref
> root 256 inode 1171 errors 2001, no inode item, link count wrong
> ...
> (lots of this type of messages)
> ...
> ERROR: errors found in fs roots
> found 870385442816 bytes used, error(s) found
> total csum bytes: 828614492
> total tree bytes: 3437035520
> total fs tree bytes: 2302328832
> total extent tree bytes: 143572992
> btree space waste bytes: 588538593
> file data blocks allocated: 1276334678016
>  referenced 887802191872
> 
> ================================================

Ideally you don't want to run btrfs check when there are csum failures on
the drives, as btrfs check might ignore the csum failures and import bad
metadata into the filesystem, causing even more severe losses downstream.

It's best to use btrfs check to repair kernel bugs and use btrfs scrub
(with dup or raid1 metadata profile) to repair disk failures.

> Thanks for any help

> [    0.000000] Linux version 5.16.18-200.fc35.x86_64 (mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9), GNU ld version 2.37-10.fc35) #1 SMP PREEMPT Mon Mar 28 14:10:07 UTC 2022
> [    0.000000] Command line: BOOT_IMAGE=(hd5,gpt2)/vmlinuz-5.16.18-200.fc35.x86_64 root=UUID=eb56bce8-9d27-4ecd-b5bd-6fc2dc895943 ro rootflags=subvol=root rd.luks.uuid=luks-58094e4a-97cc-412f-9875-3c414c1e898b rhgb quiet ???systemd.unified_cgroup_hierarchy=0???
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
> [    0.000000] signal: max sigframe size: 1776
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009c1efff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000009c1f000-0x0000000009ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20ffff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000000a210000-0x00000000bc2dcfff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bc2dd000-0x00000000bc613fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000bc614000-0x00000000bc65ffff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000bc660000-0x00000000bcce0fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000bcce1000-0x00000000bd9fefff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000bd9ff000-0x00000000beffffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bf000000-0x00000000bfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fd400000-0x00000000fd5fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083f37ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000083f380000-0x000000083fffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] e820: update [mem 0xb8595018-0xb85a6057] usable ==> usable
> [    0.000000] e820: update [mem 0xb8595018-0xb85a6057] usable ==> usable
> [    0.000000] e820: update [mem 0xb82fa018-0xb8317c57] usable ==> usable
> [    0.000000] e820: update [mem 0xb82fa018-0xb8317c57] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009c1efff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000009c1f000-0x0000000009ffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000000a1fffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a20ffff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x000000000a210000-0x00000000b82fa017] usable
> [    0.000000] reserve setup_data: [mem 0x00000000b82fa018-0x00000000b8317c57] usable
> [    0.000000] reserve setup_data: [mem 0x00000000b8317c58-0x00000000b8595017] usable
> [    0.000000] reserve setup_data: [mem 0x00000000b8595018-0x00000000b85a6057] usable
> [    0.000000] reserve setup_data: [mem 0x00000000b85a6058-0x00000000bc2dcfff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000bc2dd000-0x00000000bc613fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000bc614000-0x00000000bc65ffff] ACPI data
> [    0.000000] reserve setup_data: [mem 0x00000000bc660000-0x00000000bcce0fff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x00000000bcce1000-0x00000000bd9fefff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000bd9ff000-0x00000000beffffff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000bf000000-0x00000000bfffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fd400000-0x00000000fd5fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000083f37ffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000083f380000-0x000000083fffffff] reserved
> [    0.000000] efi: EFI v2.70 by American Megatrends
> [    0.000000] efi: ACPI=0xbccc8000 ACPI 2.0=0xbccc8014 SMBIOS=0xbd824000 SMBIOS 3.0=0xbd823000 MEMATTR=0xb85d3698 ESRT=0xbb313198 MOKvar=0xb85d4000 RNG=0xbd869e98 
> [    0.000000] efi: seeding entropy pool
> [    0.000000] secureboot: Secure boot disabled
> [    0.000000] SMBIOS 3.3.0 present.
> [    0.000000] DMI: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F34 06/10/2021
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 3593.153 MHz processor
> [    0.000010] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000012] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000017] last_pfn = 0x83f380 max_arch_pfn = 0x400000000
> [    0.000537] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.000722] e820: update [mem 0xbd120000-0xbd12ffff] usable ==> reserved
> [    0.000725] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
> [    0.000729] last_pfn = 0xbf000 max_arch_pfn = 0x400000000
> [    0.003886] esrt: Reserving ESRT space from 0x00000000bb313198 to 0x00000000bb313220.
> [    0.003896] e820: update [mem 0xbb313000-0xbb313fff] usable ==> reserved
> [    0.003911] e820: update [mem 0xb85d4000-0xb85d4fff] usable ==> reserved
> [    0.003959] Using GB pages for direct mapping
> [    0.004307] secureboot: Secure boot disabled
> [    0.004307] RAMDISK: [mem 0x59922000-0x5c77dfff]
> [    0.004310] ACPI: Early table checksum verification disabled
> [    0.004313] ACPI: RSDP 0x00000000BCCC8014 000024 (v02 ALASKA)
> [    0.004315] ACPI: XSDT 0x00000000BCCC7728 0000E4 (v01 ALASKA A M I    01072009 AMI  01000013)
> [    0.004319] ACPI: FACP 0x00000000BC64E000 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
> [    0.004323] ACPI: DSDT 0x00000000BC647000 00627E (v02 ALASKA A M I    01072009 INTL 20190509)
> [    0.004325] ACPI: FACS 0x00000000BCCC2000 000040
> [    0.004327] ACPI: SSDT 0x00000000BC655000 00AB2F (v02 GBT    GSWApp   00000001 INTL 20190509)
> [    0.004329] ACPI: SSDT 0x00000000BC654000 00092A (v02 AMD    AmdTable 00000002 MSFT 04000000)
> [    0.004331] ACPI: SSDT 0x00000000BC650000 003C9A (v01 AMD    AMD AOD  00000001 INTL 20190509)
> [    0.004333] ACPI: SSDT 0x00000000BC64F000 0000C8 (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
> [    0.004335] ACPI: FIDT 0x00000000BC646000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.004337] ACPI: MCFG 0x00000000BC645000 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
> [    0.004338] ACPI: HPET 0x00000000BC644000 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
> [    0.004340] ACPI: SSDT 0x00000000BC643000 000024 (v01 AMD    BIXBY    00001000 INTL 20190509)
> [    0.004342] ACPI: IVRS 0x00000000BC642000 0000D0 (v02 AMD    AmdTable 00000001 AMD  00000001)
> [    0.004344] ACPI: VFCT 0x00000000BC637000 00AA84 (v01 ALASKA A M I    00000001 AMD  31504F47)
> [    0.004346] ACPI: BGRT 0x00000000BC636000 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.004348] ACPI: PCCT 0x00000000BC635000 00006E (v02 AMD    AmdTable 00000001 AMD  00000001)
> [    0.004350] ACPI: SSDT 0x00000000BC632000 002FA1 (v02 AMD    AmdTable 00000001 AMD  00000001)
> [    0.004352] ACPI: CRAT 0x00000000BC631000 000B58 (v01 AMD    AmdTable 00000001 AMD  00000001)
> [    0.004354] ACPI: CDIT 0x00000000BC630000 000029 (v01 AMD    AmdTable 00000001 AMD  00000001)
> [    0.004356] ACPI: SSDT 0x00000000BC62F000 00065F (v01 AMD    QOGIRDGP 00000001 INTL 20190509)
> [    0.004358] ACPI: SSDT 0x00000000BC62D000 00150D (v01 AMD    QOGIRTPX 00000001 INTL 20190509)
> [    0.004360] ACPI: SSDT 0x00000000BC62C000 000788 (v01 AMD    QOGIRNOI 00000001 INTL 20190509)
> [    0.004362] ACPI: SSDT 0x00000000BC628000 003A59 (v01 AMD    QOGIRN   00000001 INTL 20190509)
> [    0.004363] ACPI: WSMT 0x00000000BC627000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.004365] ACPI: APIC 0x00000000BC626000 00015E (v03 ALASKA A M I    01072009 AMI  00010013)
> [    0.004367] ACPI: SSDT 0x00000000BC624000 00147F (v01 AMD    QOGIRC   00000001 INTL 20190509)
> [    0.004369] ACPI: FPDT 0x00000000BC623000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
> [    0.004371] ACPI: Reserving FACP table memory at [mem 0xbc64e000-0xbc64e113]
> [    0.004372] ACPI: Reserving DSDT table memory at [mem 0xbc647000-0xbc64d27d]
> [    0.004373] ACPI: Reserving FACS table memory at [mem 0xbccc2000-0xbccc203f]
> [    0.004374] ACPI: Reserving SSDT table memory at [mem 0xbc655000-0xbc65fb2e]
> [    0.004374] ACPI: Reserving SSDT table memory at [mem 0xbc654000-0xbc654929]
> [    0.004375] ACPI: Reserving SSDT table memory at [mem 0xbc650000-0xbc653c99]
> [    0.004376] ACPI: Reserving SSDT table memory at [mem 0xbc64f000-0xbc64f0c7]
> [    0.004376] ACPI: Reserving FIDT table memory at [mem 0xbc646000-0xbc64609b]
> [    0.004377] ACPI: Reserving MCFG table memory at [mem 0xbc645000-0xbc64503b]
> [    0.004378] ACPI: Reserving HPET table memory at [mem 0xbc644000-0xbc644037]
> [    0.004379] ACPI: Reserving SSDT table memory at [mem 0xbc643000-0xbc643023]
> [    0.004379] ACPI: Reserving IVRS table memory at [mem 0xbc642000-0xbc6420cf]
> [    0.004380] ACPI: Reserving VFCT table memory at [mem 0xbc637000-0xbc641a83]
> [    0.004381] ACPI: Reserving BGRT table memory at [mem 0xbc636000-0xbc636037]
> [    0.004381] ACPI: Reserving PCCT table memory at [mem 0xbc635000-0xbc63506d]
> [    0.004382] ACPI: Reserving SSDT table memory at [mem 0xbc632000-0xbc634fa0]
> [    0.004383] ACPI: Reserving CRAT table memory at [mem 0xbc631000-0xbc631b57]
> [    0.004384] ACPI: Reserving CDIT table memory at [mem 0xbc630000-0xbc630028]
> [    0.004384] ACPI: Reserving SSDT table memory at [mem 0xbc62f000-0xbc62f65e]
> [    0.004385] ACPI: Reserving SSDT table memory at [mem 0xbc62d000-0xbc62e50c]
> [    0.004386] ACPI: Reserving SSDT table memory at [mem 0xbc62c000-0xbc62c787]
> [    0.004386] ACPI: Reserving SSDT table memory at [mem 0xbc628000-0xbc62ba58]
> [    0.004387] ACPI: Reserving WSMT table memory at [mem 0xbc627000-0xbc627027]
> [    0.004388] ACPI: Reserving APIC table memory at [mem 0xbc626000-0xbc62615d]
> [    0.004389] ACPI: Reserving SSDT table memory at [mem 0xbc624000-0xbc62547e]
> [    0.004389] ACPI: Reserving FPDT table memory at [mem 0xbc623000-0xbc623043]
> [    0.004431] No NUMA configuration found
> [    0.004432] Faking a node at [mem 0x0000000000000000-0x000000083f37ffff]
> [    0.004439] NODE_DATA(0) allocated [mem 0x83f355000-0x83f37ffff]
> [    0.040291] Zone ranges:
> [    0.040293]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.040295]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.040296]   Normal   [mem 0x0000000100000000-0x000000083f37ffff]
> [    0.040297]   Device   empty
> [    0.040298] Movable zone start for each node
> [    0.040300] Early memory node ranges
> [    0.040300]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> [    0.040301]   node   0: [mem 0x0000000000100000-0x0000000009c1efff]
> [    0.040302]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
> [    0.040303]   node   0: [mem 0x000000000a210000-0x00000000bc2dcfff]
> [    0.040304]   node   0: [mem 0x00000000bd9ff000-0x00000000beffffff]
> [    0.040304]   node   0: [mem 0x0000000100000000-0x000000083f37ffff]
> [    0.040308] Initmem setup node 0 [mem 0x0000000000001000-0x000000083f37ffff]
> [    0.040312] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.040332] On node 0, zone DMA: 96 pages in unavailable ranges
> [    0.040512] On node 0, zone DMA32: 993 pages in unavailable ranges
> [    0.043761] On node 0, zone DMA32: 16 pages in unavailable ranges
> [    0.043824] On node 0, zone DMA32: 5922 pages in unavailable ranges
> [    0.078210] On node 0, zone Normal: 4096 pages in unavailable ranges
> [    0.078234] On node 0, zone Normal: 3200 pages in unavailable ranges
> [    0.078833] ACPI: PM-Timer IO Port: 0x808
> [    0.078839] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    0.078849] IOAPIC[0]: apic_id 13, version 33, address 0xfec00000, GSI 0-23
> [    0.078853] IOAPIC[1]: apic_id 14, version 33, address 0xfec01000, GSI 24-55
> [    0.078854] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.078856] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.078858] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.078859] ACPI: HPET id: 0x10228201 base: 0xfed00000
> [    0.078871] e820: update [mem 0xb8b7d000-0xb8bd3fff] usable ==> reserved
> [    0.078880] smpboot: Allowing 32 CPUs, 20 hotplug CPUs
> [    0.078906] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.078907] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.078909] PM: hibernation: Registered nosave memory: [mem 0x09c1f000-0x09ffffff]
> [    0.078911] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a20ffff]
> [    0.078912] PM: hibernation: Registered nosave memory: [mem 0xb82fa000-0xb82fafff]
> [    0.078913] PM: hibernation: Registered nosave memory: [mem 0xb8317000-0xb8317fff]
> [    0.078915] PM: hibernation: Registered nosave memory: [mem 0xb8595000-0xb8595fff]
> [    0.078916] PM: hibernation: Registered nosave memory: [mem 0xb85a6000-0xb85a6fff]
> [    0.078918] PM: hibernation: Registered nosave memory: [mem 0xb85d4000-0xb85d4fff]
> [    0.078919] PM: hibernation: Registered nosave memory: [mem 0xb8b7d000-0xb8bd3fff]
> [    0.078921] PM: hibernation: Registered nosave memory: [mem 0xbb313000-0xbb313fff]
> [    0.078922] PM: hibernation: Registered nosave memory: [mem 0xbc2dd000-0xbc613fff]
> [    0.078923] PM: hibernation: Registered nosave memory: [mem 0xbc614000-0xbc65ffff]
> [    0.078923] PM: hibernation: Registered nosave memory: [mem 0xbc660000-0xbcce0fff]
> [    0.078924] PM: hibernation: Registered nosave memory: [mem 0xbcce1000-0xbd9fefff]
> [    0.078925] PM: hibernation: Registered nosave memory: [mem 0xbf000000-0xbfffffff]
> [    0.078926] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xefffffff]
> [    0.078927] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
> [    0.078927] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfd1fffff]
> [    0.078928] PM: hibernation: Registered nosave memory: [mem 0xfd200000-0xfd2fffff]
> [    0.078928] PM: hibernation: Registered nosave memory: [mem 0xfd300000-0xfd3fffff]
> [    0.078929] PM: hibernation: Registered nosave memory: [mem 0xfd400000-0xfd5fffff]
> [    0.078929] PM: hibernation: Registered nosave memory: [mem 0xfd600000-0xfe9fffff]
> [    0.078930] PM: hibernation: Registered nosave memory: [mem 0xfea00000-0xfea0ffff]
> [    0.078930] PM: hibernation: Registered nosave memory: [mem 0xfea10000-0xfeb7ffff]
> [    0.078931] PM: hibernation: Registered nosave memory: [mem 0xfeb80000-0xfec01fff]
> [    0.078931] PM: hibernation: Registered nosave memory: [mem 0xfec02000-0xfec0ffff]
> [    0.078932] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
> [    0.078932] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0xfecfffff]
> [    0.078933] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
> [    0.078933] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed3ffff]
> [    0.078934] PM: hibernation: Registered nosave memory: [mem 0xfed40000-0xfed44fff]
> [    0.078934] PM: hibernation: Registered nosave memory: [mem 0xfed45000-0xfed7ffff]
> [    0.078935] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
> [    0.078935] PM: hibernation: Registered nosave memory: [mem 0xfed90000-0xfedc1fff]
> [    0.078936] PM: hibernation: Registered nosave memory: [mem 0xfedc2000-0xfedcffff]
> [    0.078936] PM: hibernation: Registered nosave memory: [mem 0xfedd0000-0xfedd3fff]
> [    0.078937] PM: hibernation: Registered nosave memory: [mem 0xfedd4000-0xfedd5fff]
> [    0.078937] PM: hibernation: Registered nosave memory: [mem 0xfedd6000-0xfeffffff]
> [    0.078938] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
> [    0.078939] [mem 0xc0000000-0xefffffff] available for PCI devices
> [    0.078941] Booting paravirtualized kernel on bare hardware
> [    0.078942] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.082945] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
> [    0.083746] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
> [    0.083756] pcpu-alloc: s212992 r8192 d28672 u262144 alloc=1*2097152
> [    0.083758] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
> [    0.083765] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 29 30 31 
> [    0.083797] Fallback order for Node 0: 0 
> [    0.083800] Built 1 zonelists, mobility grouping on.  Total pages: 8243275
> [    0.083801] Policy zone: Normal
> [    0.083802] Kernel command line: BOOT_IMAGE=(hd5,gpt2)/vmlinuz-5.16.18-200.fc35.x86_64 root=UUID=eb56bce8-9d27-4ecd-b5bd-6fc2dc895943 ro rootflags=subvol=root rd.luks.uuid=luks-58094e4a-97cc-412f-9875-3c414c1e898b rhgb quiet ???systemd.unified_cgroup_hierarchy=0???
> [    0.083870] Unknown kernel command line parameters "rhgb BOOT_IMAGE=(hd5,gpt2)/vmlinuz-5.16.18-200.fc35.x86_64", will be passed to user space.
> [    0.085980] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
> [    0.087016] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.087108] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.140370] Memory: 32659220K/33497136K available (16394K kernel code, 3571K rwdata, 10680K rodata, 2684K init, 4892K bss, 837656K reserved, 0K cma-reserved)
> [    0.140376] random: get_random_u64 called from __kmem_cache_create+0x2a/0x530 with crng_init=0
> [    0.140498] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
> [    0.140509] ftrace: allocating 48124 entries in 188 pages
> [    0.151648] ftrace: allocated 188 pages with 5 groups
> [    0.152134] Dynamic Preempt: voluntary
> [    0.152173] rcu: Preemptible hierarchical RCU implementation.
> [    0.152174] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
> [    0.152175] 	Trampoline variant of Tasks RCU enabled.
> [    0.152175] 	Rude variant of Tasks RCU enabled.
> [    0.152176] 	Tracing variant of Tasks RCU enabled.
> [    0.152176] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.152177] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
> [    0.154922] NR_IRQS: 524544, nr_irqs: 1224, preallocated irqs: 16
> [    0.155182] random: crng done (trusting CPU's manufacturer)
> [    0.155205] Console: colour dummy device 80x25
> [    0.155216] printk: console [tty0] enabled
> [    0.155235] ACPI: Core revision 20210930
> [    0.155387] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    0.155400] APIC: Switch to symmetric I/O mode setup
> [    0.322827] Switched APIC routing to physical flat.
> [    0.323316] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.327404] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33cb0fd4c16, max_idle_ns: 440795389425 ns
> [    0.327408] Calibrating delay loop (skipped), value calculated using timer frequency.. 7186.30 BogoMIPS (lpj=3593153)
> [    0.327409] pid_max: default: 32768 minimum: 301
> [    0.329759] LSM: Security Framework initializing
> [    0.329767] Yama: becoming mindful.
> [    0.329771] SELinux:  Initializing.
> [    0.329793] LSM support for eBPF active
> [    0.329794] landlock: Up and running.
> [    0.329836] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.329870] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.330040] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [    0.330088] LVT offset 1 assigned for vector 0xf9
> [    0.330200] LVT offset 2 assigned for vector 0xf4
> [    0.330235] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
> [    0.330235] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
> [    0.330237] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.330239] Spectre V2 : Mitigation: Retpolines
> [    0.330239] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.330240] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.330241] Spectre V2 : User space: Mitigation: STIBP via prctl
> [    0.330242] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [    0.331919] Freeing SMP alternatives memory: 44K
> [    0.434082] smpboot: CPU0: AMD Ryzen 5 3600 6-Core Processor (family: 0x17, model: 0x71, stepping: 0x0)
> [    0.434186] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
> [    0.434189] ... version:                0
> [    0.434189] ... bit width:              48
> [    0.434190] ... generic registers:      6
> [    0.434190] ... value mask:             0000ffffffffffff
> [    0.434191] ... max period:             00007fffffffffff
> [    0.434191] ... fixed-purpose events:   0
> [    0.434192] ... event mask:             000000000000003f
> [    0.434239] rcu: Hierarchical SRCU implementation.
> [    0.434406] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.434406] smp: Bringing up secondary CPUs ...
> [    0.434406] x86: Booting SMP configuration:
> [    0.434406] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11
> [    0.447431] smp: Brought up 1 node, 12 CPUs
> [    0.447431] smpboot: Max logical packages: 3
> [    0.447431] smpboot: Total of 12 processors activated (86235.67 BogoMIPS)
> [    0.449455] devtmpfs: initialized
> [    0.449455] x86/mm: Memory block size: 128MB
> [    0.450906] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20ffff] (65536 bytes)
> [    0.450906] ACPI: PM: Registering ACPI NVS region [mem 0xbc660000-0xbcce0fff] (6819840 bytes)
> [    0.450906] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.450906] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
> [    0.450906] pinctrl core: initialized pinctrl subsystem
> [    0.450906] PM: RTC time: 19:18:49, date: 2022-04-08
> [    0.450906] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.451408] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
> [    0.451414] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.451418] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.451426] audit: initializing netlink subsys (disabled)
> [    0.451430] audit: type=2000 audit(1649445529.130:1): state=initialized audit_enabled=0 res=1
> [    0.451472] thermal_sys: Registered thermal governor 'fair_share'
> [    0.451473] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.451473] thermal_sys: Registered thermal governor 'step_wise'
> [    0.451474] thermal_sys: Registered thermal governor 'user_space'
> [    0.451487] cpuidle: using governor menu
> [    0.451487] Detected 1 PCC Subspaces
> [    0.451487] Registering PCC driver as Mailbox controller
> [    0.451487] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.451520] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> [    0.451523] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
> [    0.451530] PCI: Using configuration type 1 for base access
> [    0.452892] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.452892] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.452892] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.452892] cryptd: max_cpu_qlen set to 1000
> [    0.452892] raid6: skip pq benchmark and using algorithm avx2x4
> [    0.452892] raid6: using avx2x2 recovery algorithm
> [    0.453414] ACPI: Added _OSI(Module Device)
> [    0.453415] ACPI: Added _OSI(Processor Device)
> [    0.453416] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.453416] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.453417] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.453418] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.453418] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.458937] ACPI: 12 ACPI AML tables successfully acquired and loaded
> [    0.459825] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.465362] ACPI: Interpreter enabled
> [    0.465373] ACPI: PM: (supports S0 S3 S4 S5)
> [    0.465374] ACPI: Using IOAPIC for interrupt routing
> [    0.465582] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.465795] ACPI: Enabled 2 GPEs in block 00 to 1F
> [    0.471197] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.471202] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    0.471247] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR DPC]
> [    0.471325] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> [    0.471331] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-7f] only partially covers this bridge
> [    0.471525] PCI host bridge to bus 0000:00
> [    0.471526] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
> [    0.471527] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
> [    0.471528] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
> [    0.471529] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.471530] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
> [    0.471531] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfcffffff window]
> [    0.471532] pci_bus 0000:00: root bus resource [mem 0x840000000-0xffffffffff window]
> [    0.471533] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.471541] pci 0000:00:00.0: [1022:1480] type 00 class 0x060000
> [    0.471605] pci 0000:00:00.2: [1022:1481] type 00 class 0x080600
> [    0.471672] pci 0000:00:01.0: [1022:1482] type 00 class 0x060000
> [    0.471717] pci 0000:00:01.1: [1022:1483] type 01 class 0x060400
> [    0.471739] pci 0000:00:01.1: enabling Extended Tags
> [    0.471779] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
> [    0.471862] pci 0000:00:01.2: [1022:1483] type 01 class 0x060400
> [    0.471883] pci 0000:00:01.2: enabling Extended Tags
> [    0.471922] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
> [    0.472002] pci 0000:00:02.0: [1022:1482] type 00 class 0x060000
> [    0.472045] pci 0000:00:03.0: [1022:1482] type 00 class 0x060000
> [    0.472088] pci 0000:00:03.1: [1022:1483] type 01 class 0x060400
> [    0.472146] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
> [    0.472223] pci 0000:00:04.0: [1022:1482] type 00 class 0x060000
> [    0.472266] pci 0000:00:05.0: [1022:1482] type 00 class 0x060000
> [    0.472309] pci 0000:00:07.0: [1022:1482] type 00 class 0x060000
> [    0.472349] pci 0000:00:07.1: [1022:1484] type 01 class 0x060400
> [    0.472366] pci 0000:00:07.1: enabling Extended Tags
> [    0.472394] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
> [    0.472462] pci 0000:00:08.0: [1022:1482] type 00 class 0x060000
> [    0.472503] pci 0000:00:08.1: [1022:1484] type 01 class 0x060400
> [    0.472523] pci 0000:00:08.1: enabling Extended Tags
> [    0.472554] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
> [    0.472636] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
> [    0.472722] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
> [    0.472814] pci 0000:00:18.0: [1022:1440] type 00 class 0x060000
> [    0.472838] pci 0000:00:18.1: [1022:1441] type 00 class 0x060000
> [    0.472862] pci 0000:00:18.2: [1022:1442] type 00 class 0x060000
> [    0.472886] pci 0000:00:18.3: [1022:1443] type 00 class 0x060000
> [    0.472910] pci 0000:00:18.4: [1022:1444] type 00 class 0x060000
> [    0.472934] pci 0000:00:18.5: [1022:1445] type 00 class 0x060000
> [    0.472958] pci 0000:00:18.6: [1022:1446] type 00 class 0x060000
> [    0.472984] pci 0000:00:18.7: [1022:1447] type 00 class 0x060000
> [    0.473054] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
> [    0.473070] pci 0000:01:00.0: reg 0x10: [mem 0xfcf00000-0xfcf03fff 64bit]
> [    0.473235] pci 0000:00:01.1: PCI bridge to [bus 01]
> [    0.473239] pci 0000:00:01.1:   bridge window [mem 0xfcf00000-0xfcffffff]
> [    0.473290] pci 0000:02:00.0: [1022:57ad] type 01 class 0x060400
> [    0.473339] pci 0000:02:00.0: enabling Extended Tags
> [    0.473414] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [    0.473502] pci 0000:02:00.0: 63.012 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x4 link at 0000:00:01.2 (capable of 126.024 Gb/s with 16.0 GT/s PCIe x8 link)
> [    0.473560] pci 0000:00:01.2: PCI bridge to [bus 02-08]
> [    0.473563] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
> [    0.473565] pci 0000:00:01.2:   bridge window [mem 0xfc300000-0xfc8fffff]
> [    0.473822] pci 0000:03:04.0: [1022:57a3] type 01 class 0x060400
> [    0.473885] pci 0000:03:04.0: enabling Extended Tags
> [    0.474107] pci 0000:03:04.0: PME# supported from D0 D3hot D3cold
> [    0.474428] pci 0000:03:05.0: [1022:57a3] type 01 class 0x060400
> [    0.474509] pci 0000:03:05.0: enabling Extended Tags
> [    0.474731] pci 0000:03:05.0: PME# supported from D0 D3hot D3cold
> [    0.475154] pci 0000:03:08.0: [1022:57a4] type 01 class 0x060400
> [    0.475217] pci 0000:03:08.0: enabling Extended Tags
> [    0.475364] pci 0000:03:08.0: PME# supported from D0 D3hot D3cold
> [    0.475558] pci 0000:03:09.0: [1022:57a4] type 01 class 0x060400
> [    0.475621] pci 0000:03:09.0: enabling Extended Tags
> [    0.475769] pci 0000:03:09.0: PME# supported from D0 D3hot D3cold
> [    0.475939] pci 0000:03:0a.0: [1022:57a4] type 01 class 0x060400
> [    0.476002] pci 0000:03:0a.0: enabling Extended Tags
> [    0.476149] pci 0000:03:0a.0: PME# supported from D0 D3hot D3cold
> [    0.476323] pci 0000:02:00.0: PCI bridge to [bus 03-08]
> [    0.476329] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
> [    0.476332] pci 0000:02:00.0:   bridge window [mem 0xfc300000-0xfc8fffff]
> [    0.476450] pci 0000:04:00.0: [8086:1539] type 00 class 0x020000
> [    0.476479] pci 0000:04:00.0: reg 0x10: [mem 0xfc800000-0xfc81ffff]
> [    0.476510] pci 0000:04:00.0: reg 0x18: [io  0xf000-0xf01f]
> [    0.476526] pci 0000:04:00.0: reg 0x1c: [mem 0xfc820000-0xfc823fff]
> [    0.476692] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
> [    0.476855] pci 0000:03:04.0: PCI bridge to [bus 04]
> [    0.476860] pci 0000:03:04.0:   bridge window [io  0xf000-0xffff]
> [    0.476863] pci 0000:03:04.0:   bridge window [mem 0xfc800000-0xfc8fffff]
> [    0.476972] pci 0000:05:00.0: [8086:2526] type 00 class 0x028000
> [    0.477001] pci 0000:05:00.0: reg 0x10: [mem 0xfc700000-0xfc703fff 64bit]
> [    0.477158] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> [    0.477310] pci 0000:03:05.0: PCI bridge to [bus 05]
> [    0.477318] pci 0000:03:05.0:   bridge window [mem 0xfc700000-0xfc7fffff]
> [    0.477440] pci 0000:06:00.0: [1022:1485] type 00 class 0x130000
> [    0.477501] pci 0000:06:00.0: enabling Extended Tags
> [    0.477645] pci 0000:06:00.0: 63.012 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x4 link at 0000:00:01.2 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
> [    0.477931] pci 0000:06:00.1: [1022:149c] type 00 class 0x0c0330
> [    0.478236] pci 0000:06:00.1: reg 0x10: [mem 0xfc400000-0xfc4fffff 64bit]
> [    0.479254] pci 0000:06:00.1: enabling Extended Tags
> [    0.479840] pci 0000:06:00.1: PME# supported from D0 D3hot D3cold
> [    0.480244] pci 0000:06:00.3: [1022:149c] type 00 class 0x0c0330
> [    0.480267] pci 0000:06:00.3: reg 0x10: [mem 0xfc300000-0xfc3fffff 64bit]
> [    0.480321] pci 0000:06:00.3: enabling Extended Tags
> [    0.480386] pci 0000:06:00.3: PME# supported from D0 D3hot D3cold
> [    0.480541] pci 0000:03:08.0: PCI bridge to [bus 06]
> [    0.480549] pci 0000:03:08.0:   bridge window [mem 0xfc300000-0xfc4fffff]
> [    0.480647] pci 0000:07:00.0: [1022:7901] type 00 class 0x010601
> [    0.480709] pci 0000:07:00.0: reg 0x24: [mem 0xfc600000-0xfc6007ff]
> [    0.480727] pci 0000:07:00.0: enabling Extended Tags
> [    0.480814] pci 0000:07:00.0: PME# supported from D3hot D3cold
> [    0.480886] pci 0000:07:00.0: 63.012 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x4 link at 0000:00:01.2 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
> [    0.480933] pci 0000:03:09.0: PCI bridge to [bus 07]
> [    0.480940] pci 0000:03:09.0:   bridge window [mem 0xfc600000-0xfc6fffff]
> [    0.481038] pci 0000:08:00.0: [1022:7901] type 00 class 0x010601
> [    0.481101] pci 0000:08:00.0: reg 0x24: [mem 0xfc500000-0xfc5007ff]
> [    0.481118] pci 0000:08:00.0: enabling Extended Tags
> [    0.481205] pci 0000:08:00.0: PME# supported from D3hot D3cold
> [    0.481277] pci 0000:08:00.0: 63.012 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x4 link at 0000:00:01.2 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
> [    0.481322] pci 0000:03:0a.0: PCI bridge to [bus 08]
> [    0.481330] pci 0000:03:0a.0:   bridge window [mem 0xfc500000-0xfc5fffff]
> [    0.481415] pci 0000:09:00.0: [1002:1478] type 01 class 0x060400
> [    0.481426] pci 0000:09:00.0: reg 0x10: [mem 0xfce00000-0xfce03fff]
> [    0.481512] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
> [    0.481616] pci 0000:00:03.1: PCI bridge to [bus 09-0b]
> [    0.481619] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
> [    0.481620] pci 0000:00:03.1:   bridge window [mem 0xfcc00000-0xfcefffff]
> [    0.481623] pci 0000:00:03.1:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
> [    0.481673] pci 0000:0a:00.0: [1002:1479] type 01 class 0x060400
> [    0.481769] pci 0000:0a:00.0: PME# supported from D0 D3hot D3cold
> [    0.482074] pci 0000:09:00.0: PCI bridge to [bus 0a-0b]
> [    0.482079] pci 0000:09:00.0:   bridge window [io  0xe000-0xefff]
> [    0.482081] pci 0000:09:00.0:   bridge window [mem 0xfcc00000-0xfcdfffff]
> [    0.482085] pci 0000:09:00.0:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
> [    0.482141] pci 0000:0b:00.0: [1002:73df] type 00 class 0x030000
> [    0.482156] pci 0000:0b:00.0: reg 0x10: [mem 0xf800000000-0xfbffffffff 64bit pref]
> [    0.482166] pci 0000:0b:00.0: reg 0x18: [mem 0xfc00000000-0xfc0fffffff 64bit pref]
> [    0.482173] pci 0000:0b:00.0: reg 0x20: [io  0xe000-0xe0ff]
> [    0.482179] pci 0000:0b:00.0: reg 0x24: [mem 0xfcc00000-0xfccfffff]
> [    0.482186] pci 0000:0b:00.0: reg 0x30: [mem 0xfcd00000-0xfcd1ffff pref]
> [    0.482206] pci 0000:0b:00.0: BAR 0: assigned to efifb
> [    0.482262] pci 0000:0b:00.0: PME# supported from D1 D2 D3hot D3cold
> [    0.482376] pci 0000:0b:00.1: [1002:ab28] type 00 class 0x040300
> [    0.482386] pci 0000:0b:00.1: reg 0x10: [mem 0xfcd20000-0xfcd23fff]
> [    0.482465] pci 0000:0b:00.1: PME# supported from D1 D2 D3hot D3cold
> [    0.482549] pci 0000:0a:00.0: PCI bridge to [bus 0b]
> [    0.482553] pci 0000:0a:00.0:   bridge window [io  0xe000-0xefff]
> [    0.482556] pci 0000:0a:00.0:   bridge window [mem 0xfcc00000-0xfcdfffff]
> [    0.482560] pci 0000:0a:00.0:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
> [    0.482599] pci 0000:0c:00.0: [1022:148a] type 00 class 0x130000
> [    0.482620] pci 0000:0c:00.0: enabling Extended Tags
> [    0.482704] pci 0000:00:07.1: PCI bridge to [bus 0c]
> [    0.482747] pci 0000:0d:00.0: [1022:1485] type 00 class 0x130000
> [    0.482771] pci 0000:0d:00.0: enabling Extended Tags
> [    0.482855] pci 0000:0d:00.1: [1022:1486] type 00 class 0x108000
> [    0.482867] pci 0000:0d:00.1: reg 0x18: [mem 0xfca00000-0xfcafffff]
> [    0.482875] pci 0000:0d:00.1: reg 0x24: [mem 0xfcb08000-0xfcb09fff]
> [    0.482881] pci 0000:0d:00.1: enabling Extended Tags
> [    0.482957] pci 0000:0d:00.3: [1022:149c] type 00 class 0x0c0330
> [    0.482966] pci 0000:0d:00.3: reg 0x10: [mem 0xfc900000-0xfc9fffff 64bit]
> [    0.482987] pci 0000:0d:00.3: enabling Extended Tags
> [    0.483019] pci 0000:0d:00.3: PME# supported from D0 D3hot D3cold
> [    0.483078] pci 0000:0d:00.4: [1022:1487] type 00 class 0x040300
> [    0.483084] pci 0000:0d:00.4: reg 0x10: [mem 0xfcb00000-0xfcb07fff]
> [    0.483103] pci 0000:0d:00.4: enabling Extended Tags
> [    0.483132] pci 0000:0d:00.4: PME# supported from D0 D3hot D3cold
> [    0.483195] pci 0000:00:08.1: PCI bridge to [bus 0d]
> [    0.483198] pci 0000:00:08.1:   bridge window [mem 0xfc900000-0xfcbfffff]
> [    0.483385] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
> [    0.483416] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
> [    0.483440] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
> [    0.483469] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
> [    0.483495] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
> [    0.483517] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
> [    0.483539] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
> [    0.483561] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
> [    0.484003] iommu: Default domain type: Translated 
> [    0.484003] iommu: DMA domain TLB invalidation policy: lazy mode 
> [    0.484003] pci 0000:0b:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> [    0.484003] pci 0000:0b:00.0: vgaarb: bridge control possible
> [    0.484003] pci 0000:0b:00.0: vgaarb: setting as boot device
> [    0.484003] vgaarb: loaded
> [    0.484003] SCSI subsystem initialized
> [    0.484003] libata version 3.00 loaded.
> [    0.484003] ACPI: bus type USB registered
> [    0.484003] usbcore: registered new interface driver usbfs
> [    0.484003] usbcore: registered new interface driver hub
> [    0.484003] usbcore: registered new device driver usb
> [    0.484003] pps_core: LinuxPPS API ver. 1 registered
> [    0.484003] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.484003] PTP clock support registered
> [    0.484003] EDAC MC: Ver: 3.0.0
> [    0.484003] Registered efivars operations
> [    0.484480] NetLabel: Initializing
> [    0.484480] NetLabel:  domain hash size = 128
> [    0.484481] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.484490] NetLabel:  unlabeled traffic allowed by default
> [    0.484492] mctp: management component transport protocol core
> [    0.484493] NET: Registered PF_MCTP protocol family
> [    0.484495] PCI: Using ACPI for IRQ routing
> [    0.487653] PCI: pci_cache_line_size set to 64 bytes
> [    0.487746] e820: reserve RAM buffer [mem 0x09c1f000-0x0bffffff]
> [    0.487747] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
> [    0.487748] e820: reserve RAM buffer [mem 0xb82fa018-0xbbffffff]
> [    0.487749] e820: reserve RAM buffer [mem 0xb8595018-0xbbffffff]
> [    0.487750] e820: reserve RAM buffer [mem 0xb85d4000-0xbbffffff]
> [    0.487751] e820: reserve RAM buffer [mem 0xb8b7d000-0xbbffffff]
> [    0.487751] e820: reserve RAM buffer [mem 0xbb313000-0xbbffffff]
> [    0.487752] e820: reserve RAM buffer [mem 0xbc2dd000-0xbfffffff]
> [    0.487753] e820: reserve RAM buffer [mem 0xbf000000-0xbfffffff]
> [    0.487753] e820: reserve RAM buffer [mem 0x83f380000-0x83fffffff]
> [    0.487759] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.487759] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [    0.489439] clocksource: Switched to clocksource tsc-early
> [    0.498250] VFS: Disk quotas dquot_6.6.0
> [    0.498262] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.498309] pnp: PnP ACPI init
> [    0.498369] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
> [    0.498433] system 00:01: [mem 0xfd200000-0xfd2fffff] has been reserved
> [    0.498540] system 00:03: [io  0x0a00-0x0a2f] has been reserved
> [    0.498541] system 00:03: [io  0x0a30-0x0a3f] has been reserved
> [    0.498542] system 00:03: [io  0x0a40-0x0a4f] has been reserved
> [    0.498673] system 00:04: [io  0x04d0-0x04d1] has been reserved
> [    0.498674] system 00:04: [io  0x040b] has been reserved
> [    0.498675] system 00:04: [io  0x04d6] has been reserved
> [    0.498676] system 00:04: [io  0x0c00-0x0c01] has been reserved
> [    0.498677] system 00:04: [io  0x0c14] has been reserved
> [    0.498678] system 00:04: [io  0x0c50-0x0c51] has been reserved
> [    0.498679] system 00:04: [io  0x0c52] has been reserved
> [    0.498680] system 00:04: [io  0x0c6c] has been reserved
> [    0.498680] system 00:04: [io  0x0c6f] has been reserved
> [    0.498681] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
> [    0.498682] system 00:04: [io  0x0800-0x089f] has been reserved
> [    0.498683] system 00:04: [io  0x0b00-0x0b0f] has been reserved
> [    0.498684] system 00:04: [io  0x0b20-0x0b3f] has been reserved
> [    0.498685] system 00:04: [io  0x0900-0x090f] has been reserved
> [    0.498686] system 00:04: [io  0x0910-0x091f] has been reserved
> [    0.498687] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
> [    0.498689] system 00:04: [mem 0xfec01000-0xfec01fff] could not be reserved
> [    0.498690] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
> [    0.498692] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
> [    0.498693] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be reserved
> [    0.498694] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
> [    0.498696] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
> [    0.498971] pnp: PnP ACPI: found 5 devices
> [    0.504482] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.504527] NET: Registered PF_INET protocol family
> [    0.504657] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.505624] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
> [    0.505648] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.505859] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [    0.505934] TCP: Hash tables configured (established 262144 bind 65536)
> [    0.506070] MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
> [    0.506109] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
> [    0.506150] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
> [    0.506234] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.506238] NET: Registered PF_XDP protocol family
> [    0.506247] pci 0000:00:01.1: PCI bridge to [bus 01]
> [    0.506251] pci 0000:00:01.1:   bridge window [mem 0xfcf00000-0xfcffffff]
> [    0.506256] pci 0000:03:04.0: PCI bridge to [bus 04]
> [    0.506258] pci 0000:03:04.0:   bridge window [io  0xf000-0xffff]
> [    0.506262] pci 0000:03:04.0:   bridge window [mem 0xfc800000-0xfc8fffff]
> [    0.506270] pci 0000:03:05.0: PCI bridge to [bus 05]
> [    0.506275] pci 0000:03:05.0:   bridge window [mem 0xfc700000-0xfc7fffff]
> [    0.506283] pci 0000:03:08.0: PCI bridge to [bus 06]
> [    0.506287] pci 0000:03:08.0:   bridge window [mem 0xfc300000-0xfc4fffff]
> [    0.506295] pci 0000:03:09.0: PCI bridge to [bus 07]
> [    0.506299] pci 0000:03:09.0:   bridge window [mem 0xfc600000-0xfc6fffff]
> [    0.506307] pci 0000:03:0a.0: PCI bridge to [bus 08]
> [    0.506311] pci 0000:03:0a.0:   bridge window [mem 0xfc500000-0xfc5fffff]
> [    0.506319] pci 0000:02:00.0: PCI bridge to [bus 03-08]
> [    0.506322] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
> [    0.506326] pci 0000:02:00.0:   bridge window [mem 0xfc300000-0xfc8fffff]
> [    0.506334] pci 0000:00:01.2: PCI bridge to [bus 02-08]
> [    0.506336] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
> [    0.506338] pci 0000:00:01.2:   bridge window [mem 0xfc300000-0xfc8fffff]
> [    0.506342] pci 0000:0a:00.0: PCI bridge to [bus 0b]
> [    0.506343] pci 0000:0a:00.0:   bridge window [io  0xe000-0xefff]
> [    0.506346] pci 0000:0a:00.0:   bridge window [mem 0xfcc00000-0xfcdfffff]
> [    0.506349] pci 0000:0a:00.0:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
> [    0.506353] pci 0000:09:00.0: PCI bridge to [bus 0a-0b]
> [    0.506355] pci 0000:09:00.0:   bridge window [io  0xe000-0xefff]
> [    0.506358] pci 0000:09:00.0:   bridge window [mem 0xfcc00000-0xfcdfffff]
> [    0.506360] pci 0000:09:00.0:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
> [    0.506364] pci 0000:00:03.1: PCI bridge to [bus 09-0b]
> [    0.506366] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
> [    0.506368] pci 0000:00:03.1:   bridge window [mem 0xfcc00000-0xfcefffff]
> [    0.506369] pci 0000:00:03.1:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
> [    0.506372] pci 0000:00:07.1: PCI bridge to [bus 0c]
> [    0.506377] pci 0000:00:08.1: PCI bridge to [bus 0d]
> [    0.506379] pci 0000:00:08.1:   bridge window [mem 0xfc900000-0xfcbfffff]
> [    0.506383] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
> [    0.506384] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
> [    0.506385] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
> [    0.506386] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
> [    0.506387] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
> [    0.506388] pci_bus 0000:00: resource 9 [mem 0xc0000000-0xfcffffff window]
> [    0.506389] pci_bus 0000:00: resource 10 [mem 0x840000000-0xffffffffff window]
> [    0.506390] pci_bus 0000:01: resource 1 [mem 0xfcf00000-0xfcffffff]
> [    0.506391] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
> [    0.506391] pci_bus 0000:02: resource 1 [mem 0xfc300000-0xfc8fffff]
> [    0.506392] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
> [    0.506393] pci_bus 0000:03: resource 1 [mem 0xfc300000-0xfc8fffff]
> [    0.506394] pci_bus 0000:04: resource 0 [io  0xf000-0xffff]
> [    0.506395] pci_bus 0000:04: resource 1 [mem 0xfc800000-0xfc8fffff]
> [    0.506395] pci_bus 0000:05: resource 1 [mem 0xfc700000-0xfc7fffff]
> [    0.506396] pci_bus 0000:06: resource 1 [mem 0xfc300000-0xfc4fffff]
> [    0.506397] pci_bus 0000:07: resource 1 [mem 0xfc600000-0xfc6fffff]
> [    0.506398] pci_bus 0000:08: resource 1 [mem 0xfc500000-0xfc5fffff]
> [    0.506399] pci_bus 0000:09: resource 0 [io  0xe000-0xefff]
> [    0.506400] pci_bus 0000:09: resource 1 [mem 0xfcc00000-0xfcefffff]
> [    0.506400] pci_bus 0000:09: resource 2 [mem 0xf800000000-0xfc0fffffff 64bit pref]
> [    0.506401] pci_bus 0000:0a: resource 0 [io  0xe000-0xefff]
> [    0.506402] pci_bus 0000:0a: resource 1 [mem 0xfcc00000-0xfcdfffff]
> [    0.506403] pci_bus 0000:0a: resource 2 [mem 0xf800000000-0xfc0fffffff 64bit pref]
> [    0.506404] pci_bus 0000:0b: resource 0 [io  0xe000-0xefff]
> [    0.506404] pci_bus 0000:0b: resource 1 [mem 0xfcc00000-0xfcdfffff]
> [    0.506405] pci_bus 0000:0b: resource 2 [mem 0xf800000000-0xfc0fffffff 64bit pref]
> [    0.506406] pci_bus 0000:0d: resource 1 [mem 0xfc900000-0xfcbfffff]
> [    0.506773] pci 0000:0b:00.1: D0 power state depends on 0000:0b:00.0
> [    0.506888] PCI: CLS 64 bytes, default 64
> [    0.506894] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
> [    0.506919] pci 0000:00:01.0: Adding to iommu group 0
> [    0.506921] Trying to unpack rootfs image as initramfs...
> [    0.506927] pci 0000:00:01.1: Adding to iommu group 1
> [    0.506934] pci 0000:00:01.2: Adding to iommu group 2
> [    0.506943] pci 0000:00:02.0: Adding to iommu group 3
> [    0.506953] pci 0000:00:03.0: Adding to iommu group 4
> [    0.506964] pci 0000:00:03.1: Adding to iommu group 5
> [    0.506972] pci 0000:00:04.0: Adding to iommu group 6
> [    0.506981] pci 0000:00:05.0: Adding to iommu group 7
> [    0.506990] pci 0000:00:07.0: Adding to iommu group 8
> [    0.507000] pci 0000:00:07.1: Adding to iommu group 9
> [    0.507010] pci 0000:00:08.0: Adding to iommu group 10
> [    0.507017] pci 0000:00:08.1: Adding to iommu group 11
> [    0.507028] pci 0000:00:14.0: Adding to iommu group 12
> [    0.507034] pci 0000:00:14.3: Adding to iommu group 12
> [    0.507062] pci 0000:00:18.0: Adding to iommu group 13
> [    0.507068] pci 0000:00:18.1: Adding to iommu group 13
> [    0.507074] pci 0000:00:18.2: Adding to iommu group 13
> [    0.507080] pci 0000:00:18.3: Adding to iommu group 13
> [    0.507086] pci 0000:00:18.4: Adding to iommu group 13
> [    0.507092] pci 0000:00:18.5: Adding to iommu group 13
> [    0.507098] pci 0000:00:18.6: Adding to iommu group 13
> [    0.507105] pci 0000:00:18.7: Adding to iommu group 13
> [    0.507112] pci 0000:01:00.0: Adding to iommu group 14
> [    0.507119] pci 0000:02:00.0: Adding to iommu group 15
> [    0.507148] pci 0000:03:04.0: Adding to iommu group 16
> [    0.507178] pci 0000:03:05.0: Adding to iommu group 17
> [    0.507187] pci 0000:03:08.0: Adding to iommu group 18
> [    0.507197] pci 0000:03:09.0: Adding to iommu group 19
> [    0.507206] pci 0000:03:0a.0: Adding to iommu group 20
> [    0.507237] pci 0000:04:00.0: Adding to iommu group 21
> [    0.507266] pci 0000:05:00.0: Adding to iommu group 22
> [    0.507269] pci 0000:06:00.0: Adding to iommu group 18
> [    0.507272] pci 0000:06:00.1: Adding to iommu group 18
> [    0.507275] pci 0000:06:00.3: Adding to iommu group 18
> [    0.507277] pci 0000:07:00.0: Adding to iommu group 19
> [    0.507280] pci 0000:08:00.0: Adding to iommu group 20
> [    0.507288] pci 0000:09:00.0: Adding to iommu group 23
> [    0.507295] pci 0000:0a:00.0: Adding to iommu group 24
> [    0.507306] pci 0000:0b:00.0: Adding to iommu group 25
> [    0.507316] pci 0000:0b:00.1: Adding to iommu group 26
> [    0.507325] pci 0000:0c:00.0: Adding to iommu group 27
> [    0.507333] pci 0000:0d:00.0: Adding to iommu group 28
> [    0.507340] pci 0000:0d:00.1: Adding to iommu group 29
> [    0.507348] pci 0000:0d:00.3: Adding to iommu group 30
> [    0.507357] pci 0000:0d:00.4: Adding to iommu group 31
> [    0.511175] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> [    0.511177] AMD-Vi: Extended features (0x58f77ef22294a5a): PPR NX GT IA PC GA_vAPIC
> [    0.511181] AMD-Vi: Interrupt remapping enabled
> [    0.511255] software IO TLB: tearing down default memory pool
> [    0.512193] LVT offset 0 assigned for vector 0x400
> [    0.512317] perf: AMD IBS detected (0x000003ff)
> [    0.512325] amd_uncore: 4  amd_df counters detected
> [    0.512340] amd_uncore: 6  amd_l3 counters detected
> [    0.512704] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
> [    0.513983] Initialise system trusted keyrings
> [    0.513997] Key type blacklist registered
> [    0.514025] workingset: timestamp_bits=36 max_order=23 bucket_order=0
> [    0.515162] zbud: loaded
> [    0.515605] integrity: Platform Keyring initialized
> [    0.518092] NET: Registered PF_ALG protocol family
> [    0.518093] xor: automatically using best checksumming function   avx       
> [    0.518094] Key type asymmetric registered
> [    0.518095] Asymmetric key parser 'x509' registered
> [    0.518112] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
> [    0.518143] io scheduler mq-deadline registered
> [    0.518144] io scheduler kyber registered
> [    0.518162] io scheduler bfq registered
> [    0.518799] atomic64_test: passed for x86-64 platform with CX8 and with SSE
> [    0.519705] pcieport 0000:00:01.1: PME: Signaling with IRQ 27
> [    0.519746] pcieport 0000:00:01.1: AER: enabled with IRQ 27
> [    0.519848] pcieport 0000:00:01.2: PME: Signaling with IRQ 28
> [    0.519896] pcieport 0000:00:01.2: AER: enabled with IRQ 28
> [    0.519988] pcieport 0000:00:03.1: PME: Signaling with IRQ 29
> [    0.520024] pcieport 0000:00:03.1: AER: enabled with IRQ 29
> [    0.520160] pcieport 0000:00:07.1: PME: Signaling with IRQ 31
> [    0.520194] pcieport 0000:00:07.1: AER: enabled with IRQ 31
> [    0.520267] pcieport 0000:00:08.1: PME: Signaling with IRQ 32
> [    0.520304] pcieport 0000:00:08.1: AER: enabled with IRQ 32
> [    0.521723] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    0.521802] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    0.521814] ACPI: button: Power Button [PWRB]
> [    0.521835] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> [    0.521875] ACPI: button: Power Button [PWRF]
> [    0.522475] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1110
> [    0.522485] Monitor-Mwait will be used to enter C-1 state
> [    0.522491] ACPI: \_PR_.C000: Found 2 idle states
> [    0.522642] ACPI: \_PR_.C002: Found 2 idle states
> [    0.522881] ACPI: \_PR_.C004: Found 2 idle states
> [    0.522957] ACPI: \_PR_.C006: Found 2 idle states
> [    0.523029] ACPI: \_PR_.C008: Found 2 idle states
> [    0.523104] ACPI: \_PR_.C00A: Found 2 idle states
> [    0.523186] ACPI: \_PR_.C001: Found 2 idle states
> [    0.523277] ACPI: \_PR_.C003: Found 2 idle states
> [    0.523362] ACPI: \_PR_.C005: Found 2 idle states
> [    0.523427] ACPI: \_PR_.C007: Found 2 idle states
> [    0.523483] ACPI: \_PR_.C009: Found 2 idle states
> [    0.523551] ACPI: \_PR_.C00B: Found 2 idle states
> [    0.818932] Freeing initrd memory: 47472K
> [    1.568819] tsc: Refined TSC clocksource calibration: 3593.248 MHz
> [    1.568831] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33cb68e6ea4, max_idle_ns: 440795288133 ns
> [    1.568863] clocksource: Switched to clocksource tsc
> [    2.529653] ACPI: \_TZ_.TZ10: Invalid passive threshold
> [    2.529814] thermal LNXTHERM:00: registered as thermal_zone0
> [    2.529815] ACPI: thermal: Thermal Zone [TZ10] (17 C)
> [    2.529858] ACPI: \_TZ_.PCT0: Invalid passive threshold
> [    2.529890] thermal LNXTHERM:01: registered as thermal_zone1
> [    2.529891] ACPI: thermal: Thermal Zone [PCT0] (17 C)
> [    2.530047] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    2.530898] Non-volatile memory driver v1.3
> [    2.530912] Linux agpgart interface v0.103
> [    2.532073] ahci 0000:07:00.0: version 3.0
> [    2.532334] ahci 0000:07:00.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0xc impl SATA mode
> [    2.532336] ahci 0000:07:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part sxs 
> [    2.532605] scsi host0: ahci
> [    2.532691] scsi host1: ahci
> [    2.532752] scsi host2: ahci
> [    2.532812] scsi host3: ahci
> [    2.532835] ata1: DUMMY
> [    2.532836] ata2: DUMMY
> [    2.532838] ata3: SATA max UDMA/133 abar m2048@0xfc600000 port 0xfc600200 irq 45
> [    2.532841] ata4: SATA max UDMA/133 abar m2048@0xfc600000 port 0xfc600280 irq 46
> [    2.533116] ahci 0000:08:00.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0x33 impl SATA mode
> [    2.533119] ahci 0000:08:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part sxs 
> [    2.533414] scsi host4: ahci
> [    2.533476] scsi host5: ahci
> [    2.533530] scsi host6: ahci
> [    2.533584] scsi host7: ahci
> [    2.533634] scsi host8: ahci
> [    2.533683] scsi host9: ahci
> [    2.533705] ata5: SATA max UDMA/133 abar m2048@0xfc500000 port 0xfc500100 irq 59
> [    2.533707] ata6: SATA max UDMA/133 abar m2048@0xfc500000 port 0xfc500180 irq 60
> [    2.533708] ata7: DUMMY
> [    2.533709] ata8: DUMMY
> [    2.533711] ata9: SATA max UDMA/133 abar m2048@0xfc500000 port 0xfc500300 irq 63
> [    2.533713] ata10: SATA max UDMA/133 abar m2048@0xfc500000 port 0xfc500380 irq 64
> [    2.533858] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    2.533861] ehci-pci: EHCI PCI platform driver
> [    2.533869] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    2.533870] ohci-pci: OHCI PCI platform driver
> [    2.533876] uhci_hcd: USB Universal Host Controller Interface driver
> [    2.534127] xhci_hcd 0000:06:00.1: xHCI Host Controller
> [    2.534163] xhci_hcd 0000:06:00.1: new USB bus registered, assigned bus number 1
> [    2.534307] xhci_hcd 0000:06:00.1: hcc params 0x0278ffe5 hci version 0x110 quirks 0x0000000000000410
> [    2.534842] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
> [    2.534843] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.534844] usb usb1: Product: xHCI Host Controller
> [    2.534845] usb usb1: Manufacturer: Linux 5.16.18-200.fc35.x86_64 xhci-hcd
> [    2.534846] usb usb1: SerialNumber: 0000:06:00.1
> [    2.534906] hub 1-0:1.0: USB hub found
> [    2.534915] hub 1-0:1.0: 6 ports detected
> [    2.535067] xhci_hcd 0000:06:00.1: xHCI Host Controller
> [    2.535099] xhci_hcd 0000:06:00.1: new USB bus registered, assigned bus number 2
> [    2.535101] xhci_hcd 0000:06:00.1: Host supports USB 3.1 Enhanced SuperSpeed
> [    2.535117] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [    2.535129] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
> [    2.535130] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.535131] usb usb2: Product: xHCI Host Controller
> [    2.535132] usb usb2: Manufacturer: Linux 5.16.18-200.fc35.x86_64 xhci-hcd
> [    2.535132] usb usb2: SerialNumber: 0000:06:00.1
> [    2.535180] hub 2-0:1.0: USB hub found
> [    2.535187] hub 2-0:1.0: 4 ports detected
> [    2.535342] xhci_hcd 0000:06:00.3: xHCI Host Controller
> [    2.535375] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 3
> [    2.535512] xhci_hcd 0000:06:00.3: hcc params 0x0278ffe5 hci version 0x110 quirks 0x0000000000000410
> [    2.535821] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
> [    2.535823] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.535824] usb usb3: Product: xHCI Host Controller
> [    2.535824] usb usb3: Manufacturer: Linux 5.16.18-200.fc35.x86_64 xhci-hcd
> [    2.535825] usb usb3: SerialNumber: 0000:06:00.3
> [    2.535885] hub 3-0:1.0: USB hub found
> [    2.535894] hub 3-0:1.0: 6 ports detected
> [    2.536049] xhci_hcd 0000:06:00.3: xHCI Host Controller
> [    2.536079] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 4
> [    2.536081] xhci_hcd 0000:06:00.3: Host supports USB 3.1 Enhanced SuperSpeed
> [    2.536095] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
> [    2.536108] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
> [    2.536109] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.536110] usb usb4: Product: xHCI Host Controller
> [    2.536111] usb usb4: Manufacturer: Linux 5.16.18-200.fc35.x86_64 xhci-hcd
> [    2.536111] usb usb4: SerialNumber: 0000:06:00.3
> [    2.536158] hub 4-0:1.0: USB hub found
> [    2.536165] hub 4-0:1.0: 4 ports detected
> [    2.536196] usb: port power management may be unreliable
> [    2.536298] xhci_hcd 0000:0d:00.3: xHCI Host Controller
> [    2.536330] xhci_hcd 0000:0d:00.3: new USB bus registered, assigned bus number 5
> [    2.536425] xhci_hcd 0000:0d:00.3: hcc params 0x0278ffe5 hci version 0x110 quirks 0x0000000000000410
> [    2.536659] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.16
> [    2.536660] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.536661] usb usb5: Product: xHCI Host Controller
> [    2.536662] usb usb5: Manufacturer: Linux 5.16.18-200.fc35.x86_64 xhci-hcd
> [    2.536662] usb usb5: SerialNumber: 0000:0d:00.3
> [    2.536721] hub 5-0:1.0: USB hub found
> [    2.536726] hub 5-0:1.0: 4 ports detected
> [    2.536856] xhci_hcd 0000:0d:00.3: xHCI Host Controller
> [    2.536888] xhci_hcd 0000:0d:00.3: new USB bus registered, assigned bus number 6
> [    2.536890] xhci_hcd 0000:0d:00.3: Host supports USB 3.1 Enhanced SuperSpeed
> [    2.536898] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
> [    2.536909] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.16
> [    2.536910] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.536911] usb usb6: Product: xHCI Host Controller
> [    2.536912] usb usb6: Manufacturer: Linux 5.16.18-200.fc35.x86_64 xhci-hcd
> [    2.536912] usb usb6: SerialNumber: 0000:0d:00.3
> [    2.536959] hub 6-0:1.0: USB hub found
> [    2.536964] hub 6-0:1.0: 4 ports detected
> [    2.537058] usbcore: registered new interface driver usbserial_generic
> [    2.537061] usbserial: USB Serial support registered for generic
> [    2.537070] i8042: PNP: No PS/2 controller found.
> [    2.537101] mousedev: PS/2 mouse device common for all mice
> [    2.537153] rtc_cmos 00:02: RTC can wake from S4
> [    2.537313] rtc_cmos 00:02: registered as rtc0
> [    2.537338] rtc_cmos 00:02: setting system clock to 2022-04-08T19:18:51 UTC (1649445531)
> [    2.537347] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [    2.537360] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> [    2.537371] device-mapper: uevent: version 1.0.3
> [    2.537421] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
> [    2.537656] efifb: probing for efifb
> [    2.537668] efifb: showing boot graphics
> [    2.538044] efifb: framebuffer at 0xf800000000, using 3072k, total 3072k
> [    2.538045] efifb: mode is 1024x768x32, linelength=4096, pages=1
> [    2.538046] efifb: scrolling: redraw
> [    2.538047] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    2.538089] fbcon: Deferring console take-over
> [    2.538089] fb0: EFI VGA frame buffer device
> [    2.538120] hid: raw HID events driver (C) Jiri Kosina
> [    2.538142] usbcore: registered new interface driver usbhid
> [    2.538143] usbhid: USB HID core driver
> [    2.538207] drop_monitor: Initializing network drop monitor service
> [    2.538256] Initializing XFRM netlink socket
> [    2.538333] NET: Registered PF_INET6 protocol family
> [    2.542620] Segment Routing with IPv6
> [    2.542622] RPL Segment Routing with IPv6
> [    2.542627] In-situ OAM (IOAM) with IPv6
> [    2.542642] mip6: Mobile IPv6
> [    2.542643] NET: Registered PF_PACKET protocol family
> [    2.543489] microcode: CPU0: patch_level=0x08701021
> [    2.543506] microcode: CPU1: patch_level=0x08701021
> [    2.543522] microcode: CPU2: patch_level=0x08701021
> [    2.543537] microcode: CPU3: patch_level=0x08701021
> [    2.543553] microcode: CPU4: patch_level=0x08701021
> [    2.543560] microcode: CPU5: patch_level=0x08701021
> [    2.543567] microcode: CPU6: patch_level=0x08701021
> [    2.543574] microcode: CPU7: patch_level=0x08701021
> [    2.543580] microcode: CPU8: patch_level=0x08701021
> [    2.543585] microcode: CPU9: patch_level=0x08701021
> [    2.543590] microcode: CPU10: patch_level=0x08701021
> [    2.543592] microcode: CPU11: patch_level=0x08701021
> [    2.543595] microcode: Microcode Update Driver: v2.2.
> [    2.543717] resctrl: L3 allocation detected
> [    2.543718] resctrl: MB allocation detected
> [    2.543718] resctrl: L3 monitoring detected
> [    2.543720] IPI shorthand broadcast: enabled
> [    2.543724] AVX2 version of gcm_enc/dec engaged.
> [    2.543872] AES CTR mode by8 optimization enabled
> [    2.544023] sched_clock: Marking stable (2377716995, 166300476)->(2556143987, -12126516)
> [    2.544354] registered taskstats version 1
> [    2.544490] Loading compiled-in X.509 certificates
> [    2.562336] Loaded X.509 cert 'Fedora kernel signing key: 7c8aa450c55ec76ac3adde1b1b789564f5fb7d57'
> [    2.562844] zswap: loaded using pool lzo/zbud
> [    2.563321] page_owner is disabled
> [    2.563352] Key type ._fscrypt registered
> [    2.563353] Key type .fscrypt registered
> [    2.563354] Key type fscrypt-provisioning registered
> [    2.563576] Btrfs loaded, crc32c=crc32c-generic, zoned=yes, fsverity=yes
> [    2.563587] Key type big_key registered
> [    2.565290] Key type encrypted registered
> [    2.565396] integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
> [    2.582770] integrity: Loaded X.509 cert 'Fedora Secure Boot CA: fde32599c2d61db1bf5807335d7b20e4cd963b42'
> [    2.582774] ima: No TPM chip found, activating TPM-bypass!
> [    2.582777] Loading compiled-in module X.509 certificates
> [    2.583167] Loaded X.509 cert 'Fedora kernel signing key: 7c8aa450c55ec76ac3adde1b1b789564f5fb7d57'
> [    2.583169] ima: Allocated hash algorithm: sha256
> [    2.583176] ima: No architecture policies found
> [    2.583184] evm: Initialising EVM extended attributes:
> [    2.583185] evm: security.selinux
> [    2.583186] evm: security.SMACK64 (disabled)
> [    2.583186] evm: security.SMACK64EXEC (disabled)
> [    2.583187] evm: security.SMACK64TRANSMUTE (disabled)
> [    2.583187] evm: security.SMACK64MMAP (disabled)
> [    2.583188] evm: security.apparmor (disabled)
> [    2.583188] evm: security.ima
> [    2.583189] evm: security.capability
> [    2.583189] evm: HMAC attrs: 0x1
> [    2.597022] alg: No test for 842 (842-scomp)
> [    2.597042] alg: No test for 842 (842-generic)
> [    2.672289] PM:   Magic number: 2:874:343
> [    2.672324] tty tty60: hash matches
> [    2.672334] xhci_hcd 0000:0d:00.3: hash matches
> [    2.672449] RAS: Correctable Errors collector initialized.
> [    2.778410] usb 1-3: new high-speed USB device number 2 using xhci_hcd
> [    2.778416] usb 3-3: new high-speed USB device number 2 using xhci_hcd
> [    2.837562] ata10: SATA link down (SStatus 0 SControl 300)
> [    2.837602] ata9: SATA link down (SStatus 0 SControl 300)
> [    2.907394] usb 1-3: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=85.36
> [    2.907397] usb 1-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [    2.907398] usb 1-3: Product: USB2.0 Hub
> [    2.910492] usb 3-3: New USB device found, idVendor=05e3, idProduct=0736, bcdDevice= 2.72
> [    2.910496] usb 3-3: New USB device strings: Mfr=3, Product=4, SerialNumber=2
> [    2.910497] usb 3-3: Product: USB Storage
> [    2.910498] usb 3-3: Manufacturer: Generic
> [    2.910499] usb 3-3: SerialNumber: 000000000272
> [    2.951647] hub 1-3:1.0: USB hub found
> [    2.952134] hub 1-3:1.0: 4 ports detected
> [    2.992835] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    2.992836] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    2.992866] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    2.992870] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    2.993791] ata3.00: ATA-10: WDC WD40EZRZ-22GXCB0, 80.00A80, max UDMA/133
> [    2.993791] ata6.00: ATA-10: WDC WD40EZRZ-00GXCB0, 80.00A80, max UDMA/133
> [    2.993800] ata4.00: ATA-9: WDC WD40EZRZ-00WN9B0, 80.00A80, max UDMA/133
> [    2.993803] ata5.00: ATA-10: WDC WD40EZRZ-22GXCB0, 80.00A80, max UDMA/133
> [    2.994179] ata4.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    2.994507] ata3.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    2.994509] ata6.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    2.994522] ata5.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    2.994705] ata4.00: configured for UDMA/133
> [    2.996032] ata3.00: configured for UDMA/133
> [    2.996032] ata6.00: configured for UDMA/133
> [    2.996043] ata5.00: configured for UDMA/133
> [    2.996452] scsi 2:0:0:0: Direct-Access     ATA      WDC WD40EZRZ-22G 0A80 PQ: 0 ANSI: 5
> [    2.996598] sd 2:0:0:0: Attached scsi generic sg0 type 0
> [    2.996624] sd 2:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
> [    2.996626] sd 2:0:0:0: [sda] 4096-byte physical blocks
> [    2.996632] sd 2:0:0:0: [sda] Write Protect is off
> [    2.996634] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    2.996651] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    2.996886] scsi 3:0:0:0: Direct-Access     ATA      WDC WD40EZRZ-00W 0A80 PQ: 0 ANSI: 5
> [    2.997003] sd 3:0:0:0: Attached scsi generic sg1 type 0
> [    2.997063] sd 3:0:0:0: [sdb] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
> [    2.997065] sd 3:0:0:0: [sdb] 4096-byte physical blocks
> [    2.997070] sd 3:0:0:0: [sdb] Write Protect is off
> [    2.997071] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    2.997079] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    2.997115] scsi 4:0:0:0: Direct-Access     ATA      WDC WD40EZRZ-22G 0A80 PQ: 0 ANSI: 5
> [    2.997215] sd 4:0:0:0: Attached scsi generic sg2 type 0
> [    2.997249] sd 4:0:0:0: [sdc] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
> [    2.997251] sd 4:0:0:0: [sdc] 4096-byte physical blocks
> [    2.997258] sd 4:0:0:0: [sdc] Write Protect is off
> [    2.997260] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    2.997268] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    2.997290] scsi 5:0:0:0: Direct-Access     ATA      WDC WD40EZRZ-00G 0A80 PQ: 0 ANSI: 5
> [    2.997397] sd 5:0:0:0: Attached scsi generic sg3 type 0
> [    2.997428] sd 5:0:0:0: [sdd] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
> [    2.997429] sd 5:0:0:0: [sdd] 4096-byte physical blocks
> [    2.997434] sd 5:0:0:0: [sdd] Write Protect is off
> [    2.997435] sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [    2.997443] sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    3.024824] usb 3-6: new high-speed USB device number 3 using xhci_hcd
> [    3.069857] usb 1-4: new full-speed USB device number 3 using xhci_hcd
> [    3.156104] usb 3-6: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=85.36
> [    3.156108] usb 3-6: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [    3.156110] usb 3-6: Product: USB2.0 Hub
> [    3.208757] hub 3-6:1.0: USB hub found
> [    3.209224] hub 3-6:1.0: 4 ports detected
> [    3.221257] usb 1-4: New USB device found, idVendor=048d, idProduct=8297, bcdDevice= 0.03
> [    3.221260] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    3.221261] usb 1-4: Product: ITE Device(8595)
> [    3.221262] usb 1-4: Manufacturer: ITE Tech. Inc.
> [    3.231721] hid-generic 0003:048D:8297.0001: hiddev96,hidraw0: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(8595)] on usb-0000:06:00.1-4/input0
> [    3.266824] usb 1-3.1: new full-speed USB device number 4 using xhci_hcd
> [    3.368252] usb 1-3.1: New USB device found, idVendor=046d, idProduct=c24e, bcdDevice=84.01
> [    3.368257] usb 1-3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    3.368259] usb 1-3.1: Product: G500s Laser Gaming Mouse
> [    3.368260] usb 1-3.1: Manufacturer: Logitech
> [    3.368261] usb 1-3.1: SerialNumber: 00FBC188560009
> [    3.404638]  sda: sda1
> [    3.411650] sd 5:0:0:0: [sdd] Attached SCSI removable disk
> [    3.419636] sd 2:0:0:0: [sda] Attached SCSI removable disk
> [    3.426232]  sdc: sdc1
> [    3.435606] sd 4:0:0:0: [sdc] Attached SCSI removable disk
> [    3.474361] input: Logitech G500s Laser Gaming Mouse as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.1/usb1/1-3/1-3.1/1-3.1:1.0/0003:046D:C24E.0002/input/input2
> [    3.474446] hid-generic 0003:046D:C24E.0002: input,hidraw1: USB HID v1.11 Mouse [Logitech G500s Laser Gaming Mouse] on usb-0000:06:00.1-3.1/input0
> [    3.482421] input: Logitech G500s Laser Gaming Mouse Keyboard as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.1/usb1/1-3/1-3.1/1-3.1:1.1/0003:046D:C24E.0003/input/input3
> [    3.498823] usb 3-6.2: new full-speed USB device number 4 using xhci_hcd
> [    3.534937] hid-generic 0003:046D:C24E.0003: input,hiddev97,hidraw2: USB HID v1.11 Keyboard [Logitech G500s Laser Gaming Mouse] on usb-0000:06:00.1-3.1/input1
> [    3.584638] sd 3:0:0:0: [sdb] Attached SCSI removable disk
> [    3.586128] Freeing unused decrypted memory: 2036K
> [    3.586383] Freeing unused kernel image (initmem) memory: 2684K
> [    3.586385] Write protecting the kernel read-only data: 30720k
> [    3.586733] Freeing unused kernel image (text/rodata gap) memory: 2036K
> [    3.586933] Freeing unused kernel image (rodata/data gap) memory: 1608K
> [    3.596120] usb 3-6.2: New USB device found, idVendor=8087, idProduct=0025, bcdDevice= 0.02
> [    3.596125] usb 3-6.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    3.601427] usb 1-3.2: new full-speed USB device number 5 using xhci_hcd
> [    3.616853] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    3.616856] rodata_test: all tests were successful
> [    3.616860] Run /init as init process
> [    3.616861]   with arguments:
> [    3.616861]     /init
> [    3.616862]     rhgb
> [    3.616863]   with environment:
> [    3.616863]     HOME=/
> [    3.616864]     TERM=linux
> [    3.616864]     BOOT_IMAGE=(hd5,gpt2)/vmlinuz-5.16.18-200.fc35.x86_64
> [    3.625165] systemd[1]: systemd v249.9-1.fc35 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
> [    3.636444] systemd[1]: Detected architecture x86-64.
> [    3.636446] systemd[1]: Running in initial RAM disk.
> [    3.636472] systemd[1]: Hostname set to <hostname>.
> [    3.666432] usb 1-3.2: device descriptor read/64, error -32
> [    3.681042] systemd[1]: Queued start job for default target Initrd Default Target.
> [    3.681610] systemd[1]: Created slice Slice /system/systemd-cryptsetup.
> [    3.681659] systemd[1]: Reached target Initrd /usr File System.
> [    3.681667] systemd[1]: Reached target Local File Systems.
> [    3.681680] systemd[1]: Reached target Slice Units.
> [    3.681689] systemd[1]: Reached target Swaps.
> [    3.681697] systemd[1]: Reached target Timer Units.
> [    3.681743] systemd[1]: Listening on D-Bus System Message Bus Socket.
> [    3.681813] systemd[1]: Listening on Journal Audit Socket.
> [    3.681862] systemd[1]: Listening on Journal Socket (/dev/log).
> [    3.681913] systemd[1]: Listening on Journal Socket.
> [    3.681965] systemd[1]: Listening on udev Control Socket.
> [    3.682005] systemd[1]: Listening on udev Kernel Socket.
> [    3.682016] systemd[1]: Reached target Socket Units.
> [    3.682451] systemd[1]: Starting Create List of Static Device Nodes...
> [    3.682488] systemd[1]: Condition check resulted in Memstrack Anylazing Service being skipped.
> [    3.682898] systemd[1]: Started Hardware RNG Entropy Gatherer Daemon.
> [    3.683841] systemd[1]: Starting Journal Service...
> [    3.684339] systemd[1]: Starting Load Kernel Modules...
> [    3.684372] systemd[1]: Condition check resulted in Create System Users being skipped.
> [    3.684826] systemd[1]: Starting Setup Virtual Console...
> [    3.685192] systemd[1]: Finished Create List of Static Device Nodes.
> [    3.685629] systemd[1]: Starting Create Static Device Nodes in /dev...
> [    3.688503] systemd[1]: Finished Create Static Device Nodes in /dev.
> [    3.694871] fuse: init (API version 7.35)
> [    3.698182] IPMI message handler: version 39.2
> [    3.699302] ipmi device interface
> [    3.699930] systemd[1]: Finished Load Kernel Modules.
> [    3.699956] audit: type=1130 audit(1649445532.662:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    3.700606] systemd[1]: Starting Apply Kernel Variables...
> [    3.703611] systemd[1]: Finished Apply Kernel Variables.
> [    3.703642] audit: type=1130 audit(1649445532.666:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    3.724147] systemd[1]: Finished Setup Virtual Console.
> [    3.724169] audit: type=1130 audit(1649445532.686:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    3.724771] systemd[1]: Starting dracut ask for additional cmdline parameters...
> [    3.725415] usb 3-6.4: new full-speed USB device number 5 using xhci_hcd
> [    3.726483] systemd[1]: Started Journal Service.
> [    3.726534] audit: type=1130 audit(1649445532.689:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    3.731074] audit: type=1130 audit(1649445532.693:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    3.734552] audit: type=1130 audit(1649445532.697:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline-ask comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    3.776658] audit: type=1130 audit(1649445532.739:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    3.788218] audit: type=1130 audit(1649445532.750:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    3.788879] audit: type=1334 audit(1649445532.751:10): prog-id=6 op=LOAD
> [    3.824081] usb 3-6.4: New USB device found, idVendor=045e, idProduct=07a5, bcdDevice= 7.97
> [    3.824085] usb 3-6.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    3.824086] usb 3-6.4: Product: Microsoft?? 2.4GHz Transceiver v9.0
> [    3.824087] usb 3-6.4: Manufacturer: Microsoft
> [    3.832475] usb 1-3.2: device descriptor read/64, error -32
> [    3.878875] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
> [    3.892731] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
> [    3.892781] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
> [    3.892833] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
> [    3.894496] ccp 0000:0d:00.1: enabling device (0000 -> 0002)
> [    3.894646] ccp 0000:0d:00.1: ccp: unable to access the device: you might be running a broken BIOS.
> [    3.898200] nvme nvme0: pci function 0000:01:00.0
> [    3.905980] nvme nvme0: missing or invalid SUBNQN field.
> [    3.906007] nvme nvme0: Shutdown timeout set to 8 seconds
> [    3.918998] ACPI: bus type drm_connector registered
> [    3.935061] nvme nvme0: 32/0/0 default/read/poll queues
> [    3.939103]  nvme0n1: p1 p2 p3
> [    3.952227] input: Microsoft Microsoft?? 2.4GHz Transceiver v9.0 as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.3/usb3/3-6/3-6.4/3-6.4:1.0/0003:045E:07A5.0004/input/input6
> [    3.988808] AMD-Vi: AMD IOMMUv2 loaded and initialized
> [    4.000418] usb 1-3.2: new full-speed USB device number 6 using xhci_hcd
> [    4.003537] hid-generic 0003:045E:07A5.0004: input,hidraw3: USB HID v1.11 Keyboard [Microsoft Microsoft?? 2.4GHz Transceiver v9.0] on usb-0000:06:00.3-6.4/input0
> [    4.016103] input: Microsoft Microsoft?? 2.4GHz Transceiver v9.0 Mouse as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.3/usb3/3-6/3-6.4/3-6.4:1.1/0003:045E:07A5.0005/input/input7
> [    4.016170] input: Microsoft Microsoft?? 2.4GHz Transceiver v9.0 Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.3/usb3/3-6/3-6.4/3-6.4:1.1/0003:045E:07A5.0005/input/input8
> [    4.016203] hid-generic 0003:045E:07A5.0005: input,hidraw4: USB HID v1.11 Mouse [Microsoft Microsoft?? 2.4GHz Transceiver v9.0] on usb-0000:06:00.3-6.4/input1
> [    4.024368] input: Microsoft Microsoft?? 2.4GHz Transceiver v9.0 Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.3/usb3/3-6/3-6.4/3-6.4:1.2/0003:045E:07A5.0006/input/input9
> [    4.064436] usb 1-3.2: device descriptor read/64, error -32
> [    4.075469] input: Microsoft Microsoft?? 2.4GHz Transceiver v9.0 System Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.3/usb3/3-6/3-6.4/3-6.4:1.2/0003:045E:07A5.0006/input/input10
> [    4.075512] hid-generic 0003:045E:07A5.0006: input,hidraw5: USB HID v1.11 Device [Microsoft Microsoft?? 2.4GHz Transceiver v9.0] on usb-0000:06:00.3-6.4/input2
> [    4.080030] dca service started, version 1.12.1
> [    4.090066] usb-storage 3-3:1.0: USB Mass Storage device detected
> [    4.090430] scsi host10: usb-storage 3-3:1.0
> [    4.090514] usbcore: registered new interface driver usb-storage
> [    4.095018] usbcore: registered new interface driver uas
> [    4.095997] igb: Intel(R) Gigabit Ethernet Network Driver
> [    4.095999] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    4.124811] pps pps0: new PPS source ptp0
> [    4.124836] igb 0000:04:00.0: added PHC on eth0
> [    4.124837] igb 0000:04:00.0: Intel(R) Gigabit Ethernet Network Connection
> [    4.124838] igb 0000:04:00.0: eth0: (PCIe:2.5Gb/s:Width x1) b4:2e:99:0f:9d:28
> [    4.124840] igb 0000:04:00.0: eth0: PBA No: FFFFFF-0FF
> [    4.124841] igb 0000:04:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)
> [    4.125963] igb 0000:04:00.0 enp4s0: renamed from eth0
> [    4.232434] usb 1-3.2: device descriptor read/64, error -32
> [    4.336753] usb 1-3-port2: attempt power cycle
> [    4.372772] [drm] amdgpu kernel modesetting enabled.
> [    4.377727] amdgpu: Ignoring ACPI CRAT on non-APU system
> [    4.377730] amdgpu: Virtual CRAT table created for CPU
> [    4.377739] amdgpu: Topology: Add CPU node
> [    4.377826] checking generic (f800000000 300000) vs hw (f800000000 400000000)
> [    4.377828] checking generic (f800000000 300000) vs hw (f800000000 400000000)
> [    4.377830] fb0: switching to amdgpu from EFI VGA
> [    4.377874] amdgpu 0000:0b:00.0: vgaarb: deactivate vga console
> [    4.377919] amdgpu 0000:0b:00.0: enabling device (0006 -> 0007)
> [    4.377948] [drm] initializing kernel modesetting (NAVY_FLOUNDER 0x1002:0x73DF 0x1002:0x0E36 0xC1).
> [    4.377950] amdgpu 0000:0b:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
> [    4.377957] [drm] register mmio base: 0xFCC00000
> [    4.377958] [drm] register mmio size: 1048576
> [    4.379334] [drm] add ip block number 0 <nv_common>
> [    4.379335] [drm] add ip block number 1 <gmc_v10_0>
> [    4.379336] [drm] add ip block number 2 <navi10_ih>
> [    4.379337] [drm] add ip block number 3 <psp>
> [    4.379338] [drm] add ip block number 4 <smu>
> [    4.379339] [drm] add ip block number 5 <dm>
> [    4.379339] [drm] add ip block number 6 <gfx_v10_0>
> [    4.379340] [drm] add ip block number 7 <sdma_v5_2>
> [    4.379341] [drm] add ip block number 8 <vcn_v3_0>
> [    4.379342] [drm] add ip block number 9 <jpeg_v3_0>
> [    4.379353] amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
> [    4.379355] amdgpu: ATOM BIOS: 113-D5121100-101
> [    4.379361] [drm] VCN(0) decode is enabled in VM mode
> [    4.379362] [drm] VCN(0) encode is enabled in VM mode
> [    4.379363] [drm] JPEG decode is enabled in VM mode
> [    4.379389] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
> [    4.379393] amdgpu 0000:0b:00.0: amdgpu: VRAM: 12272M 0x0000008000000000 - 0x00000082FEFFFFFF (12272M used)
> [    4.379395] amdgpu 0000:0b:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
> [    4.379397] amdgpu 0000:0b:00.0: amdgpu: AGP: 267894784M 0x0000008400000000 - 0x0000FFFFFFFFFFFF
> [    4.379404] [drm] Detected VRAM RAM=12272M, BAR=16384M
> [    4.379405] [drm] RAM width 192bits GDDR6
> [    4.379455] [drm] amdgpu: 12272M of VRAM memory ready
> [    4.379456] [drm] amdgpu: 12272M of GTT memory ready.
> [    4.379467] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [    4.379584] [drm] PCIE GART of 512M enabled (table at 0x0000008000300000).
> [    4.386888] amdgpu 0000:0b:00.0: amdgpu: PSP runtime database doesn't exist
> [    4.916410] usb 1-3.2: new full-speed USB device number 7 using xhci_hcd
> [    4.916483] usb 1-3.2: Device not responding to setup address.
> [    5.120488] usb 1-3.2: Device not responding to setup address.
> [    5.153517] scsi 10:0:0:0: Direct-Access     Generic  STORAGE DEVICE   0272 PQ: 0 ANSI: 0
> [    5.153660] sd 10:0:0:0: Attached scsi generic sg4 type 0
> [    5.328414] usb 1-3.2: device not accepting address 7, error -71
> [    5.369872] sd 10:0:0:0: [sde] 60456960 512-byte logical blocks: (31.0 GB/28.8 GiB)
> [    5.370707] sd 10:0:0:0: [sde] Write Protect is off
> [    5.370708] sd 10:0:0:0: [sde] Mode Sense: 0b 00 00 08
> [    5.371581] sd 10:0:0:0: [sde] No Caching mode page found
> [    5.371583] sd 10:0:0:0: [sde] Assuming drive cache: write through
> [    5.376224]  sde: sde1
> [    5.378598] sd 10:0:0:0: [sde] Attached SCSI removable disk
> [    5.392415] usb 1-3.2: new full-speed USB device number 8 using xhci_hcd
> [    5.392487] usb 1-3.2: Device not responding to setup address.
> [    5.600485] usb 1-3.2: Device not responding to setup address.
> [    5.808415] usb 1-3.2: device not accepting address 8, error -71
> [    5.808842] usb 1-3-port2: unable to enumerate USB device
> [    5.922967] [drm] Loading DMUB firmware via PSP: version=0x0202000C
> [    5.939753] [drm] use_doorbell being set to: [true]
> [    5.939785] [drm] use_doorbell being set to: [true]
> [    5.966848] [drm] Found VCN firmware Version ENC: 1.18 DEC: 2 VEP: 0 Revision: 14
> [    5.966855] amdgpu 0000:0b:00.0: amdgpu: Will use PSP to load VCN firmware
> [    6.048058] [drm] reserve 0xa00000 from 0x82fe000000 for PSP TMR
> [    6.140636] amdgpu 0000:0b:00.0: amdgpu: RAS: optional ras ta ucode is not available
> [    6.154637] amdgpu 0000:0b:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
> [    6.154659] amdgpu 0000:0b:00.0: amdgpu: smu driver if version = 0x0000000e, smu fw if version = 0x00000012, smu fw version = 0x00413500 (65.53.0)
> [    6.154662] amdgpu 0000:0b:00.0: amdgpu: SMU driver if version not matched
> [    6.154667] amdgpu 0000:0b:00.0: amdgpu: use vbios provided pptable
> [    6.211881] amdgpu 0000:0b:00.0: amdgpu: SMU is initialized successfully!
> [    6.212080] [drm] Display Core initialized with v3.2.160!
> [    6.213228] [drm] DMUB hardware initialized: version=0x0202000C
> [    6.437322] [drm] REG_WAIT timeout 1us * 100000 tries - mpc2_assert_idle_mpcc line:479
> [    6.657918] [drm] kiq ring mec 2 pipe 1 q 0
> [    6.662202] [drm] VCN decode and encode initialized successfully(under DPG Mode).
> [    6.662464] [drm] JPEG decode initialized successfully.
> [    6.663341] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> [    6.705740] memmap_init_zone_device initialised 3145728 pages in 19ms
> [    6.705746] amdgpu: HMM registered 12272MB device memory
> [    6.705860] amdgpu: SRAT table not found
> [    6.705861] amdgpu: Virtual CRAT table created for GPU
> [    6.706013] amdgpu: Topology: Add dGPU node [0x73df:0x1002]
> [    6.706017] kfd kfd: amdgpu: added device 1002:73df
> [    6.706038] amdgpu 0000:0b:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 10, active_cu_number 40
> [    6.708963] [drm] fb mappable at 0xF8004CF000
> [    6.708965] [drm] vram apper at 0xF800000000
> [    6.708966] [drm] size 14745600
> [    6.708966] [drm] fb depth is 24
> [    6.708967] [drm]    pitch is 10240
> [    6.709032] fbcon: amdgpudrmfb (fb0) is primary device
> [    6.709034] fbcon: Deferring console take-over
> [    6.709035] amdgpu 0000:0b:00.0: [drm] fb0: amdgpudrmfb frame buffer device
> [    6.717488] amdgpu 0000:0b:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
> [    6.717491] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
> [    6.717492] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
> [    6.717493] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
> [    6.717494] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
> [    6.717496] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
> [    6.717497] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
> [    6.717498] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
> [    6.717499] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
> [    6.717500] amdgpu 0000:0b:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
> [    6.717501] amdgpu 0000:0b:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
> [    6.717502] amdgpu 0000:0b:00.0: amdgpu: ring sdma1 uses VM inv eng 13 on hub 0
> [    6.717504] amdgpu 0000:0b:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on hub 1
> [    6.717505] amdgpu 0000:0b:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on hub 1
> [    6.717506] amdgpu 0000:0b:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on hub 1
> [    6.717507] amdgpu 0000:0b:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hub 1
> [    6.718640] [drm] Initialized amdgpu 3.44.0 20150101 for 0000:0b:00.0 on minor 0
> [    6.994250] [drm] REG_WAIT timeout 1us * 100000 tries - mpc2_assert_idle_mpcc line:479
> [    7.828410] usb 1-3.2: new full-speed USB device number 9 using xhci_hcd
> [    7.924015] usb 1-3.2: New USB device found, idVendor=231d, idProduct=0121, bcdDevice=18.5b
> [    7.924018] usb 1-3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    7.924019] usb 1-3.2: Product: VKBsim Gladiator 
> [    7.924020] usb 1-3.2: Manufacturer: www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017
> [    7.981157] www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator : Invalid code 768 type 1
> [    7.981159] www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator : Invalid code 769 type 1
> [    7.981160] www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator : Invalid code 770 type 1
> [    7.981161] www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator : Invalid code 771 type 1
> [    7.981161] www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator : Invalid code 772 type 1
> [    7.981162] www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator : Invalid code 773 type 1
> [    7.981163] www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator : Invalid code 774 type 1
> [    7.981163] www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator : Invalid code 775 type 1
> [    7.981164] www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator : Invalid code 776 type 1
> [    7.981165] www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator : Invalid code 777 type 1
> [    7.981194] input: www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator  as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.1/usb1/1-3/1-3.2/1-3.2:1.0/0003:231D:0121.0007/input/input11
> [    7.981261] hid-generic 0003:231D:0121.0007: input,hidraw6: USB HID v1.00 Joystick [www.vkb-sim.pro www.forum.vkb-sim.pro ?? Alex Oz 2012-2017 VKBsim Gladiator ] on usb-0000:06:00.1-3.2/input0
> [  111.842940] fbcon: Taking over console
> [  111.854317] Console: switching to colour frame buffer device 320x90
> [  122.032260] kauditd_printk_skb: 18 callbacks suppressed
> [  122.032262] audit: type=1338 audit(1649445650.994:29): module=crypt op=ctr ppid=1 pid=594 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="systemd-cryptse" exe="/usr/lib/systemd/systemd-cryptsetup" subj=kernel dev=253:0 error_msg='success' res=1
> [  122.032412] audit: type=1300 audit(1649445650.994:29): arch=c000003e syscall=16 success=yes exit=0 a0=4 a1=c138fd09 a2=564d3c595bc0 a3=7ffcae8806c2 items=6 ppid=1 pid=594 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="systemd-cryptse" exe="/usr/lib/systemd/systemd-cryptsetup" subj=kernel key=(null)
> [  122.032416] audit: type=1307 audit(1649445650.994:29): cwd="/"
> [  122.032420] audit: type=1302 audit(1649445650.994:29): item=0 name=(null) inode=27 dev=00:07 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=unlabeled nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> [  122.032423] audit: type=1302 audit(1649445650.994:29): item=1 name=(null) inode=17376 dev=00:07 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=unlabeled nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> [  122.032425] audit: type=1302 audit(1649445650.994:29): item=2 name=(null) inode=23 dev=00:07 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=unlabeled nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> [  122.032427] audit: type=1302 audit(1649445650.994:29): item=3 name=(null) inode=17377 dev=00:07 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=unlabeled nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> [  122.032429] audit: type=1302 audit(1649445650.994:29): item=4 name=(null) inode=17377 dev=00:07 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=unlabeled nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> [  122.032431] audit: type=1302 audit(1649445650.994:29): item=5 name=(null) inode=17378 dev=00:07 mode=0100444 ouid=0 ogid=0 rdev=00:00 obj=unlabeled nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> [  122.032433] audit: type=1327 audit(1649445650.994:29): proctitle=2F7573722F6C69622F73797374656D642F73797374656D642D6372797074736574757000617474616368006C756B732D35383039346534612D393763632D343132662D393837352D336334313463316538393862002F6465762F6469736B2F62792D757569642F35383039346534612D393763632D343132662D393837352D33
> [  122.039279] BTRFS: device label fedora_localhost-live devid 1 transid 774121 /dev/dm-0 scanned by systemd-udevd (2688)
> [  122.206744] BTRFS info (device dm-0): flagging fs with big metadata feature
> [  122.206748] BTRFS info (device dm-0): disk space caching is enabled
> [  122.206749] BTRFS info (device dm-0): has skinny extents
> [  122.209835] BTRFS info (device dm-0): bdev /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b errs: wr 0, rd 0, flush 0, corrupt 818188739, gen 0
> [  122.297649] BTRFS info (device dm-0): enabling ssd optimizations
> [  122.297651] BTRFS info (device dm-0): start tree-log replay
> [  122.713871] systemd-journald[336]: Received SIGTERM from PID 1 (systemd).
> [  122.804595] SELinux:  Class mctp_socket not defined in policy.
> [  122.804599] SELinux:  Class io_uring not defined in policy.
> [  122.804599] SELinux: the above unknown classes and permissions will be allowed
> [  122.806565] SELinux:  policy capability network_peer_controls=1
> [  122.806566] SELinux:  policy capability open_perms=1
> [  122.806566] SELinux:  policy capability extended_socket_class=1
> [  122.806567] SELinux:  policy capability always_check_network=0
> [  122.806567] SELinux:  policy capability cgroup_seclabel=1
> [  122.806567] SELinux:  policy capability nnp_nosuid_transition=1
> [  122.806568] SELinux:  policy capability genfs_seclabel_symlinks=0
> [  122.836230] systemd[1]: Successfully loaded SELinux policy in 62.756ms.
> [  122.877125] systemd[1]: Relabelled /dev, /dev/shm, /run, /sys/fs/cgroup in 21.831ms.
> [  122.879292] systemd[1]: systemd v249.9-1.fc35 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
> [  122.890441] systemd[1]: Detected architecture x86-64.
> [  122.905028] systemd-sysv-generator[2816]: SysV service '/etc/rc.d/init.d/livesys' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
> [  122.905065] systemd-sysv-generator[2816]: SysV service '/etc/rc.d/init.d/livesys-late' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
> [  122.915383] zram: Added device: zram0
> [  122.994271] systemd[1]: /usr/lib/systemd/system/docker.socket:5: ListenStream= references a path below legacy directory /var/run/, updating /var/run/docker.sock ??? /run/docker.sock; please update the unit file accordingly.
> [  123.061070] systemd[1]: initrd-switch-root.service: Deactivated successfully.
> [  123.061219] systemd[1]: Stopped Switch Root.
> [  123.061470] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
> [  123.061756] systemd[1]: Created slice Slice /system/getty.
> [  123.062026] systemd[1]: Created slice Slice /system/modprobe.
> [  123.062297] systemd[1]: Created slice Slice /system/sshd-keygen.
> [  123.062580] systemd[1]: Created slice Slice /system/systemd-fsck.
> [  123.062850] systemd[1]: Created slice Slice /system/systemd-zram-setup.
> [  123.063115] systemd[1]: Created slice User and Session Slice.
> [  123.063136] systemd[1]: Condition check resulted in Dispatch Password Requests to Console Directory Watch being skipped.
> [  123.063203] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [  123.063477] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [  123.063526] systemd[1]: Reached target Block Device Preparation for /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b.
> [  123.063570] systemd[1]: Reached target Login Prompts.
> [  123.063610] systemd[1]: Stopped target Switch Root.
> [  123.063632] systemd[1]: Stopped target Initrd File Systems.
> [  123.063654] systemd[1]: Stopped target Initrd Root File System.
> [  123.063695] systemd[1]: Reached target Host and Network Name Lookups.
> [  123.063735] systemd[1]: Reached target Slice Units.
> [  123.063760] systemd[1]: Reached target Local Verity Protected Volumes.
> [  123.064019] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [  123.064507] systemd[1]: Listening on LVM2 poll daemon socket.
> [  123.064938] systemd[1]: Listening on multipathd control socket.
> [  123.068608] systemd[1]: Listening on RPCbind Server Activation Socket.
> [  123.068651] systemd[1]: Reached target RPC Port Mapper.
> [  123.069617] systemd[1]: Listening on Process Core Dump Socket.
> [  123.070338] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [  123.071878] systemd[1]: Listening on udev Control Socket.
> [  123.072066] systemd[1]: Listening on udev Kernel Socket.
> [  123.072876] systemd[1]: Listening on User Database Manager Socket.
> [  123.074248] systemd[1]: Mounting Huge Pages File System...
> [  123.074998] systemd[1]: Mounting POSIX Message Queue File System...
> [  123.075748] systemd[1]: Mounting NFSD configuration filesystem...
> [  123.076482] systemd[1]: Mounting Kernel Debug File System...
> [  123.077276] systemd[1]: Mounting Kernel Trace File System...
> [  123.077468] systemd[1]: Condition check resulted in Kernel Module supporting RPCSEC_GSS being skipped.
> [  123.078232] systemd[1]: Starting Create List of Static Device Nodes...
> [  123.078919] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> [  123.079647] systemd[1]: Starting Load Kernel Module configfs...
> [  123.080821] systemd[1]: Starting Load Kernel Module drm...
> [  123.082057] systemd[1]: Starting Load Kernel Module fuse...
> [  123.083355] systemd[1]: Starting Preprocess NFS configuration convertion...
> [  123.084017] systemd[1]: plymouth-switch-root.service: Deactivated successfully.
> [  123.084062] systemd[1]: Stopped Plymouth switch root service.
> [  123.085272] systemd[1]: systemd-fsck-root.service: Deactivated successfully.
> [  123.085297] systemd[1]: Stopped File System Check on Root Device.
> [  123.086421] systemd[1]: Stopped Journal Service.
> [  123.088864] systemd[1]: Starting Journal Service...
> [  123.089681] systemd[1]: Starting Load Kernel Modules...
> [  123.090831] systemd[1]: Starting Remount Root and Kernel File Systems...
> [  123.091101] systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
> [  123.091855] systemd[1]: Starting Coldplug All udev Devices...
> [  123.093038] systemd[1]: Mounted Huge Pages File System.
> [  123.093328] systemd[1]: Mounted POSIX Message Queue File System.
> [  123.094793] systemd[1]: Mounted Kernel Debug File System.
> [  123.095092] BTRFS info (device dm-0): disk space caching is enabled
> [  123.096326] systemd[1]: Mounted Kernel Trace File System.
> [  123.098527] systemd[1]: Finished Create List of Static Device Nodes.
> [  123.099743] systemd[1]: modprobe@configfs.service: Deactivated successfully.
> [  123.099880] systemd[1]: Finished Load Kernel Module configfs.
> [  123.101473] systemd[1]: Started Journal Service.
> [  123.118220] RPC: Registered named UNIX socket transport module.
> [  123.118223] RPC: Registered udp transport module.
> [  123.118224] RPC: Registered tcp transport module.
> [  123.118224] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [  123.118255] systemd-journald[2843]: Received client request to flush runtime journal.
> [  123.144251] systemd-journald[2843]: /var/log/journal/2afc4f205007429f894afa71f0ebb8d7/system.journal: Journal file corrupted, rotating.
> [  123.182521] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [  123.250850] acpi_cpufreq: overriding BIOS provided _PSD data
> [  123.309878] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\GSA1.SMBI) (20210930/utaddress-204)
> [  123.309885] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> [  123.315895] input: PC Speaker as /devices/platform/pcspkr/input/input12
> [  123.341531] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [  123.341982] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [  123.374176] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
> [  123.374179] RAPL PMU: hw unit of domain package 2^-16 Joules
> [  123.421201] Bluetooth: Core ver 2.22
> [  123.421425] NET: Registered PF_BLUETOOTH protocol family
> [  123.421427] Bluetooth: HCI device and connection manager initialized
> [  123.421430] Bluetooth: HCI socket layer initialized
> [  123.421432] Bluetooth: L2CAP socket layer initialized
> [  123.421438] Bluetooth: SCO socket layer initialized
> [  123.431289] Intel(R) Wireless WiFi driver for Linux
> [  123.443821] iwlwifi 0000:05:00.0: enabling device (0000 -> 0002)
> [  123.458387] SVM: TSC scaling supported
> [  123.458390] kvm: Nested Virtualization enabled
> [  123.458390] SVM: kvm: Nested Paging enabled
> [  123.458392] SEV supported: 509 ASIDs
> [  123.458425] SVM: Virtual VMLOAD VMSAVE supported
> [  123.458425] SVM: Virtual GIF supported
> [  123.458426] SVM: LBR virtualization supported
> [  123.464675] MCE: In-kernel MCE decoding enabled.
> [  123.482248] iwlwifi 0000:05:00.0: WRT: Overriding region id 0
> [  123.482253] iwlwifi 0000:05:00.0: WRT: Overriding region id 1
> [  123.482255] iwlwifi 0000:05:00.0: WRT: Overriding region id 2
> [  123.482256] iwlwifi 0000:05:00.0: WRT: Overriding region id 3
> [  123.482257] iwlwifi 0000:05:00.0: WRT: Overriding region id 4
> [  123.482258] iwlwifi 0000:05:00.0: WRT: Overriding region id 6
> [  123.482259] iwlwifi 0000:05:00.0: WRT: Overriding region id 8
> [  123.482260] iwlwifi 0000:05:00.0: WRT: Overriding region id 9
> [  123.482261] iwlwifi 0000:05:00.0: WRT: Overriding region id 10
> [  123.482262] iwlwifi 0000:05:00.0: WRT: Overriding region id 11
> [  123.482263] iwlwifi 0000:05:00.0: WRT: Overriding region id 15
> [  123.482264] iwlwifi 0000:05:00.0: WRT: Overriding region id 16
> [  123.482265] iwlwifi 0000:05:00.0: WRT: Overriding region id 18
> [  123.482266] iwlwifi 0000:05:00.0: WRT: Overriding region id 19
> [  123.482267] iwlwifi 0000:05:00.0: WRT: Overriding region id 20
> [  123.482269] iwlwifi 0000:05:00.0: WRT: Overriding region id 21
> [  123.482270] iwlwifi 0000:05:00.0: WRT: Overriding region id 28
> [  123.482521] iwlwifi 0000:05:00.0: loaded firmware version 46.fae53a8b.0 9260-th-b0-jf-b0-46.ucode op_mode iwlmvm
> [  123.487149] zram0: detected capacity change from 0 to 32768000
> [  123.491648] BTRFS info (device dm-0): devid 1 device path /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b changed to /dev/dm-0 scanned by systemd-udevd (2865)
> [  123.493580] BTRFS info (device dm-0): devid 1 device path /dev/dm-0 changed to /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b scanned by systemd-udevd (2865)
> [  123.523552] usbcore: registered new interface driver btusb
> [  123.530746] snd_hda_intel 0000:0b:00.1: enabling device (0000 -> 0002)
> [  123.530816] snd_hda_intel 0000:0b:00.1: Handle vga_switcheroo audio client
> [  123.530817] snd_hda_intel 0000:0b:00.1: Force to non-snoop mode
> [  123.530984] snd_hda_intel 0000:0d:00.4: enabling device (0000 -> 0002)
> [  123.536701] intel_rapl_common: Found RAPL domain package
> [  123.536703] intel_rapl_common: Found RAPL domain core
> [  123.562150] Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
> [  123.562178] Bluetooth: hci0: Boot Address: 0x40800
> [  123.562180] Bluetooth: hci0: Firmware Version: 174-4.22
> [  123.562181] Bluetooth: hci0: Firmware already loaded
> [  123.564960] snd_hda_intel 0000:0b:00.1: bound 0000:0b:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
> [  123.566479] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.1/0000:09:00.0/0000:0a:00.0/0000:0b:00.1/sound/card0/input13
> [  123.566534] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.1/0000:09:00.0/0000:0a:00.0/0000:0b:00.1/sound/card0/input14
> [  123.566541] Adding 16383996k swap on /dev/zram0.  Priority:100 extents:1 across:16383996k SSDscFS
> [  123.566576] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.1/0000:09:00.0/0000:0a:00.0/0000:0b:00.1/sound/card0/input15
> [  123.567110] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.1/0000:09:00.0/0000:0a:00.0/0000:0b:00.1/sound/card0/input16
> [  123.567150] input: HDA ATI HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.1/0000:09:00.0/0000:0a:00.0/0000:0b:00.1/sound/card0/input17
> [  123.567181] input: HDA ATI HDMI HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:03.1/0000:09:00.0/0000:0a:00.0/0000:0b:00.1/sound/card0/input18
> [  123.592269] snd_hda_codec_realtek hdaudioC1D0: ALCS1200A: SKU not ready 0x00000000
> [  123.592727] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALCS1200A: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
> [  123.592731] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [  123.592733] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> [  123.592735] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
> [  123.592736] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
> [  123.592737] snd_hda_codec_realtek hdaudioC1D0:    inputs:
> [  123.592738] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
> [  123.592740] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
> [  123.592741] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
> [  123.596299] iwlwifi 0000:05:00.0: Detected Intel(R) Wireless-AC 9260 160MHz, REV=0x324
> [  123.602889] thermal thermal_zone2: failed to read out thermal zone (-61)
> [  123.609789] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:0d:00.4/sound/card1/input19
> [  123.609844] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:0d:00.4/sound/card1/input20
> [  123.609886] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:0d:00.4/sound/card1/input21
> [  123.609916] input: HD-Audio Generic Line Out Front as /devices/pci0000:00/0000:00:08.1/0000:0d:00.4/sound/card1/input22
> [  123.609940] input: HD-Audio Generic Line Out Surround as /devices/pci0000:00/0000:00:08.1/0000:0d:00.4/sound/card1/input23
> [  123.609969] input: HD-Audio Generic Line Out CLFE as /devices/pci0000:00/0000:00:08.1/0000:0d:00.4/sound/card1/input24
> [  123.609991] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:0d:00.4/sound/card1/input25
> [  123.643468] iwlwifi 0000:05:00.0: base HW address: 48:89:e7:c8:71:84
> [  123.669670] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  123.671670] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  123.672669] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  123.675672] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  123.677671] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  123.679671] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  123.710268] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
> [  123.713399] iwlwifi 0000:05:00.0 wlp5s0: renamed from wlan0
> [  123.888397] md/raid1:md0: active with 2 out of 2 mirrors
> [  124.441437] md0: detected capacity change from 0 to 7813770880
> [  124.656004] FAT-fs (sde1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
> [  124.677260] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> [  124.757120] EXT4-fs (md0): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> [  125.706832] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> [  125.974395] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> [  126.467224] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [  126.467227] Bluetooth: BNEP filters: protocol multicast
> [  126.467229] Bluetooth: BNEP socket layer initialized
> [  126.588608] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  126.590609] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  126.592606] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  126.594607] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  126.596605] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  126.598605] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [  126.654149] vboxdrv: loading out-of-tree module taints kernel.
> [  126.654308] vboxdrv: module verification failed: signature and/or required key missing - tainting kernel
> [  126.658891] vboxdrv: Found 12 processor cores
> [  126.676541] vboxdrv: TSC mode is Invariant, tentative frequency 3593182673 Hz
> [  126.676545] vboxdrv: Successfully loaded version 6.1.32 r149290 (interface 0x00320000)
> [  126.726283] NET: Registered PF_QIPCRTR protocol family
> [  126.891190] VBoxNetFlt: Successfully started.
> [  126.892569] VBoxNetAdp: Successfully started.
> [  133.713200] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> [  133.716914] Bridge firewalling registered
> [  133.844256] RPC: Registered rdma transport module.
> [  133.844258] RPC: Registered rdma backchannel transport module.
> [  133.965966] NFSD: Using nfsdcld client tracking operations.
> [  133.965970] NFSD: no clients to reclaim, skipping NFSv4 grace period (net f0000098)
> [  140.391964] systemd-journald[2843]: /var/log/journal/2afc4f205007429f894afa71f0ebb8d7/user-1000.journal: Journal file corrupted, rotating.
> [  142.204287] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  142.252011] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  142.252185] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  142.252702] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  142.252999] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  142.253128] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  142.253321] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  142.253839] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  142.253998] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  142.254831] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  142.655327] wlp5s0: authenticate with 68:ff:7b:ab:80:06
> [  142.658157] wlp5s0: send auth to 68:ff:7b:ab:80:06 (try 1/3)
> [  142.697798] wlp5s0: authenticated
> [  142.699176] wlp5s0: associate with 68:ff:7b:ab:80:06 (try 1/3)
> [  142.701329] wlp5s0: RX AssocResp from 68:ff:7b:ab:80:06 (capab=0x11 status=0 aid=3)
> [  142.703824] wlp5s0: associated
> [  142.790332] IPv6: ADDRCONF(NETDEV_CHANGE): wlp5s0: link becomes ready
> [  143.331781] Bluetooth: RFCOMM TTY layer initialized
> [  143.331786] Bluetooth: RFCOMM socket layer initialized
> [  143.331811] Bluetooth: RFCOMM ver 1.11
> [  520.154339] validate_extent_buffer: 93 callbacks suppressed
> [  520.154344] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  520.154479] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  520.154648] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  520.154890] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  520.155047] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  520.155210] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  639.560827] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  644.066038] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  644.066217] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  649.390445] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [  649.390647] BTRFS warning (device dm-0): checksum verify failed on 831624151040 wanted 0x49e32d3c found 0x2ee8eaa8 level 0
> [ 1738.615540] BTRFS info (device dm-0): scrub: started on devid 1
> [ 1930.036759] BTRFS warning (device dm-0): checksum error at logical 831624151040 on dev /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b, physical 724249968640: metadata leaf (level 0) in tree 256
> [ 1930.036768] BTRFS warning (device dm-0): checksum error at logical 831624151040 on dev /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b, physical 724249968640: metadata leaf (level 0) in tree 256
> [ 1930.036773] BTRFS error (device dm-0): bdev /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b errs: wr 0, rd 0, flush 0, corrupt 818188740, gen 0
> [ 1930.036776] BTRFS error (device dm-0): unable to fixup (regular) error at logical 831624151040 on dev /dev/mapper/luks-58094e4a-97cc-412f-9875-3c414c1e898b
> [ 1984.580526] BTRFS info (device dm-0): scrub: finished on devid 1 with status: 0

