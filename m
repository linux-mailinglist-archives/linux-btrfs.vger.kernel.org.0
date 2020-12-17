Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AADD2DD26D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgLQNss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 08:48:48 -0500
Received: from mx3.uni-regensburg.de ([194.94.157.148]:37708 "EHLO
        mx3.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgLQNsr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 08:48:47 -0500
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 96C4A600004F
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 14:48:02 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id 30A5E600004D
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 14:48:01 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Thu, 17 Dec 2020 14:48:01 +0100
Message-Id: <5FDB6190020000A10003DA53@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.0 
Date:   Thu, 17 Dec 2020 14:48:00 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <ce3g8jdj@umail.furryterror.org>
Cc:     <linux-btrfs@vger.kernel.org>
Subject: Antw: [EXT] Re: Unrecoverable filesystem (ERROR: child eb
 corrupted: parent bytenr=1106952192 item=75 parent level=1 child
 level=1)
References: <5FD3816B020000A10003D798@gwsmtp.uni-regensburg.de>
 <20201215181828.GN31381@hungrycats.org>
In-Reply-To: <20201215181828.GN31381@hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>>> Zygo Blaxell <ce3g8jdj@umail.furryterror.org> schrieb am 15.12.2020 um
19:18 in
Nachricht <20201215181828.GN31381@hungrycats.org>:
> On Fri, Dec 11, 2020 at 03:25:47PM +0100, Ulrich Windl wrote:
>> Hi!
>> 
>> While configuring a VM environment in a cluster I had setup an SLES15 SP2 
> test VM using BtrFS. Due to some problem with libvirt (or the VirtualDomain

> RA) the VM was active on more than one cluster node at a time, corrupting
the 
> filesystem beyond repair it seems:
>> hvc0:rescue:~ # btrfs check /dev/xvda2
>> Opening filesystem to check...
>> Checking filesystem on /dev/xvda2
>> UUID: 1b651baa‑327b‑45fe‑9512‑e7147b24eb49
>> [1/7] checking root items
>> ERROR: child eb corrupted: parent bytenr=1107230720 item=75 parent level=1

> child level=1
>> ERROR: failed to repair root items: Input/output error
>> hvc0:rescue:~ # btrfsck ‑b /dev/xvda2
>> Opening filesystem to check...
>> Checking filesystem on /dev/xvda2
>> UUID: 1b651baa‑327b‑45fe‑9512‑e7147b24eb49
>> [1/7] checking root items
>> ERROR: child eb corrupted: parent bytenr=1106952192 item=75 parent level=1

> child level=1
>> ERROR: failed to repair root items: Input/output error
>> hvc0:rescue:~ # btrfsck ‑‑repair /dev/xvda2
>> enabling repair mode
>> Opening filesystem to check...
>> Checking filesystem on /dev/xvda2
>> UUID: 1b651baa‑327b‑45fe‑9512‑e7147b24eb49
>> [1/7] checking root items
>> ERROR: child eb corrupted: parent bytenr=1107230720 item=75 parent level=1

> child level=1
>> ERROR: failed to repair root items: Input/output error
>> 
>> Two questions arising:
>> 1) Can't the kernel set some "open flag" early when opening the
>> filesystem, and refuse to open it again (the other VM) when the flag
>> is set? That could avoid such situations I guess
> 
> If btrfs wrote "the filesystem is open" to the disk, the filesystem
> would not be mountable after a crash.
> 
> The kernel does set an "open flag" (it detects that it is about to mount
> the same btrfs by uuid, and does something like a bind mount instead)
> but that applies only to multiple btrfs mounts on the _same_ kernel.
> In your case there are multiple kernels present (one in each node)
> and there's no way for them to communicate with each other.
> 
> There are at least 3 different ways libvirt or other hosting
> infrastructure software on the VM host could have avoided passing the
> same physical device to multiple VM guests.  I would suggest implementing
> some or all of them.
> 
>> 2) Can't btrfs check try somewhat harder to rescue anything, or is
>> the fs structure in a way that everything is lost?
> 
>> What really puzzles me is this:
>> There are several snapshots and subvolumes on the BtFS device. It's
>> hard to believe that absolutely nothing seems to be recoverable.
> 
> The most likely outcome is that the root tree nodes and most of the
> interior nodes of all the filesystem trees are broken.  The kernel
> relies on the trees to work‑‑everything in btrfs except the superblocks
> can be at any location on disk‑‑so the filesystem will be unreadable by
> the kernel.  Only recovery tools would be able to read the filesystem now.
> 
> Recovery requires a brute force search of the disk to find as many
> surviving leaf nodes as possible and rebuild the filesystem trees.
> This is more or less what 'btrfs check ‑‑repair ‑‑init‑extent‑tree' does.

Hi!

As I didn't have a backup (it was just a test VM to test HA cluster
configuration), I tried your command:
It finished rather quickly even with little RAM, but found *many* problems:
...
Deleting bad dir index [715,96,8] root 257
Deleting bad dir index [257,96,14] root 257
Deleting bad dir index [257,96,15] root 257
Deleting bad dir index [259,96,21] root 257
Deleting bad dir index [291,96,6] root 257
Deleting bad dir index [1804,96,2] root 257
Deleting bad dir index [1804,96,3] root 257
Deleting bad dir index [1804,96,4] root 257
Deleting bad dir index [1804,96,5] root 257
Deleting bad dir index [320,96,5] root 257
Deleting bad dir index [1805,96,2] root 257
Deleting bad dir index [257,96,16] root 257
Deleting bad dir index [326,96,6] root 257
ERROR: errors found in fs roots
found 30851072 bytes used, error(s) found
total csum bytes: 1370452
total tree bytes: 3211264
total fs tree bytes: 1458176
total extent tree bytes: 16384
btree space waste bytes: 597304
file data blocks allocated: 27607040
 referenced 27607040

A subsequent " btrfs check /dev/xvda2" found many problems again:
...
root 257 inode 7589 errors 2001, no inode item, link count wrong
        unresolved ref dir 1804 index 0 namelen 7 name main.cf filetype 1
errors 6, no dir index, no inode ref
root 257 inode 7590 errors 2001, no inode item, link count wrong
        unresolved ref dir 320 index 0 namelen 18 name postfix.configured
filetype 1 errors 6, no dir index, no inode ref
root 257 inode 7591 errors 2001, no inode item, link count wrong
        unresolved ref dir 1806 index 0 namelen 3 name pid filetype 2 errors
6, no dir index, no inode ref
root 257 inode 7593 errors 2001, no inode item, link count wrong
        unresolved ref dir 1805 index 0 namelen 11 name master.lock filetype 1
errors 6, no dir index, no inode ref
root 257 inode 7641 errors 2001, no inode item, link count wrong
        unresolved ref dir 257 index 0 namelen 11 name snapper.log filetype 1
errors 6, no dir index, no inode ref
root 257 inode 7644 errors 2001, no inode item, link count wrong
        unresolved ref dir 326 index 0 namelen 16 name logrotate.status
filetype 1 errors 6, no dir index, no inode ref
ERROR: errors found in fs roots
found 30965760 bytes used, error(s) found
total csum bytes: 1370452
total tree bytes: 3342336
total fs tree bytes: 1523712
total extent tree bytes: 81920
btree space waste bytes: 669123
file data blocks allocated: 27607040
 referenced 27607040

Even after iterating a "normal" check a few times, I could not mount the
"repaired" filesystem:
hvc0:rescue:~ # mount -r /dev/xvda2 /mnt
mount.bin: /mnt: wrong fs type, bad option, bad superblock on /dev/xvda2,
missing codepage or helper program, or other error.
hvc0:rescue:~ # journalctl -f
-- Logs begin at Thu 2020-12-17 13:36:57 UTC. --
Dec 17 13:44:33 rescue kernel: BTRFS info (device xvda2): disk space caching
is enabled
Dec 17 13:44:33 rescue kernel: BTRFS info (device xvda2): has skinny extents
Dec 17 13:44:33 rescue kernel: BTRFS error (device xvda2): chunk 1048576 has
missing dev extent, have 0 expect 1
Dec 17 13:44:33 rescue kernel: BTRFS error (device xvda2): failed to verify
dev extents against chunks: -117
Dec 17 13:44:33 rescue kernel: BTRFS error (device xvda2): open_ctree failed
^C

I'm not hoping to recover the system to a usable state, but out of curiosity
I'd like to get an impression what had survived and what had not.

Regards,
Ulrich

> 
> If you run ‑‑init‑extent‑tree, assuming it works (you should not assume
> that it will work), you would then have to audit the filesystem contents
> to see what data was not recovered.  At a minimum, you would lose a few
> hundred filesystem items, since each metadata leaf node contains around
> 200 items and you definitely will not recover them all.  The data csum
> trees might not be in sync with the rest of the filesytem, so you can't
> rely on scrub to check data integrity.  If this is successful, you will
> have a similar result to mounting ext4 on multiple VMs simultaneously‑‑
> fsck runs, the filesystem is read‑write again, but you don't get all
> the data back, nor even a list of data that was lost or corrupted.
> 
> ‑‑init‑extent‑tree can be quite slow, especially if you don't have enough
> RAM to hold all the filesystem's metadata.  It's still under development,
> so one possible outcome is that it crashes with an assertion failure
> and leaves you with a even more broken filesystem.
> 
> It's usually faster and easier to mkfs and restore from backups instead.
> 
>> I have this:
>> hvc0:rescue:~ # btrfs inspect‑internal dump‑super /dev/xvda2
>> superblock: bytenr=65536, device=/dev/xvda2
>> ‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑‑
>> csum_type               0 (crc32c)
>> csum_size               4
>> csum                    0x659898f3 [match]
>> bytenr                  65536
>> flags                   0x1
>>                         ( WRITTEN )
>> magic                   _BHRfS_M [match]
>> fsid                    1b651baa‑327b‑45fe‑9512‑e7147b24eb49
>> metadata_uuid           1b651baa‑327b‑45fe‑9512‑e7147b24eb49
>> label
>> generation              280
>> root                    1107214336
>> sys_array_size          97
>> chunk_root_generation   35
>> root_level              0
>> chunk_root              1048576
>> chunk_root_level        0
>> log_root                0
>> log_root_transid        0
>> log_root_level          0
>> total_bytes             10727960576
>> bytes_used              1461825536
>> sectorsize              4096
>> nodesize                16384
>> leafsize (deprecated)           16384
>> stripesize              4096
>> root_dir                6
>> num_devices             1
>> compat_flags            0x0
>> compat_ro_flags         0x0
>> incompat_flags          0x163
>>                         ( MIXED_BACKREF |
>>                           DEFAULT_SUBVOL |
>>                           BIG_METADATA |
>>                           EXTENDED_IREF |
>>                           SKINNY_METADATA )
>> cache_generation        280
>> uuid_tree_generation    40
>> dev_item.uuid           2abdf93e‑2f2d‑4eef‑a1d8‑9325f809ebce
>> dev_item.fsid           1b651baa‑327b‑45fe‑9512‑e7147b24eb49 [match]
>> dev_item.type           0
>> dev_item.total_bytes    10727960576
>> dev_item.bytes_used     2436890624
>> dev_item.io_align       4096
>> dev_item.io_width       4096
>> dev_item.sector_size    4096
>> dev_item.devid          1
>> dev_item.dev_group      0
>> dev_item.seek_speed     0
>> dev_item.bandwidth      0
>> dev_item.generation     0
>> 
>> Regards,
>> Ulrich Windl
>> 
>> 



