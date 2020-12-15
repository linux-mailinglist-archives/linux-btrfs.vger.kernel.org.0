Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1662DB38A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 19:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbgLOSTY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 15 Dec 2020 13:19:24 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35604 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbgLOSTN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 13:19:13 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5FF9E8F8568; Tue, 15 Dec 2020 13:18:28 -0500 (EST)
Date:   Tue, 15 Dec 2020 13:18:28 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Unrecoverable filesystem (ERROR: child eb corrupted: parent
 bytenr=1106952192 item=75 parent level=1 child level=1)
Message-ID: <20201215181828.GN31381@hungrycats.org>
References: <5FD3816B020000A10003D798@gwsmtp.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <5FD3816B020000A10003D798@gwsmtp.uni-regensburg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 11, 2020 at 03:25:47PM +0100, Ulrich Windl wrote:
> Hi!
> 
> While configuring a VM environment in a cluster I had setup an SLES15 SP2 test VM using BtrFS. Due to some problem with libvirt (or the VirtualDomain RA) the VM was active on more than one cluster node at a time, corrupting the filesystem beyond repair it seems:
> hvc0:rescue:~ # btrfs check /dev/xvda2
> Opening filesystem to check...
> Checking filesystem on /dev/xvda2
> UUID: 1b651baa-327b-45fe-9512-e7147b24eb49
> [1/7] checking root items
> ERROR: child eb corrupted: parent bytenr=1107230720 item=75 parent level=1 child level=1
> ERROR: failed to repair root items: Input/output error
> hvc0:rescue:~ # btrfsck -b /dev/xvda2
> Opening filesystem to check...
> Checking filesystem on /dev/xvda2
> UUID: 1b651baa-327b-45fe-9512-e7147b24eb49
> [1/7] checking root items
> ERROR: child eb corrupted: parent bytenr=1106952192 item=75 parent level=1 child level=1
> ERROR: failed to repair root items: Input/output error
> hvc0:rescue:~ # btrfsck --repair /dev/xvda2
> enabling repair mode
> Opening filesystem to check...
> Checking filesystem on /dev/xvda2
> UUID: 1b651baa-327b-45fe-9512-e7147b24eb49
> [1/7] checking root items
> ERROR: child eb corrupted: parent bytenr=1107230720 item=75 parent level=1 child level=1
> ERROR: failed to repair root items: Input/output error
> 
> Two questions arising:
> 1) Can't the kernel set some "open flag" early when opening the
> filesystem, and refuse to open it again (the other VM) when the flag
> is set? That could avoid such situations I guess

If btrfs wrote "the filesystem is open" to the disk, the filesystem
would not be mountable after a crash.

The kernel does set an "open flag" (it detects that it is about to mount
the same btrfs by uuid, and does something like a bind mount instead)
but that applies only to multiple btrfs mounts on the _same_ kernel.
In your case there are multiple kernels present (one in each node)
and there's no way for them to communicate with each other.

There are at least 3 different ways libvirt or other hosting
infrastructure software on the VM host could have avoided passing the
same physical device to multiple VM guests.  I would suggest implementing
some or all of them.

> 2) Can't btrfs check try somewhat harder to rescue anything, or is
> the fs structure in a way that everything is lost?

> What really puzzles me is this:
> There are several snapshots and subvolumes on the BtFS device. It's
> hard to believe that absolutely nothing seems to be recoverable.

The most likely outcome is that the root tree nodes and most of the
interior nodes of all the filesystem trees are broken.  The kernel
relies on the trees to work--everything in btrfs except the superblocks
can be at any location on disk--so the filesystem will be unreadable by
the kernel.  Only recovery tools would be able to read the filesystem now.

Recovery requires a brute force search of the disk to find as many
surviving leaf nodes as possible and rebuild the filesystem trees.
This is more or less what 'btrfs check --repair --init-extent-tree' does.

If you run --init-extent-tree, assuming it works (you should not assume
that it will work), you would then have to audit the filesystem contents
to see what data was not recovered.  At a minimum, you would lose a few
hundred filesystem items, since each metadata leaf node contains around
200 items and you definitely will not recover them all.  The data csum
trees might not be in sync with the rest of the filesytem, so you can't
rely on scrub to check data integrity.  If this is successful, you will
have a similar result to mounting ext4 on multiple VMs simultaneously--
fsck runs, the filesystem is read-write again, but you don't get all
the data back, nor even a list of data that was lost or corrupted.

--init-extent-tree can be quite slow, especially if you don't have enough
RAM to hold all the filesystem's metadata.  It's still under development,
so one possible outcome is that it crashes with an assertion failure
and leaves you with a even more broken filesystem.

It's usually faster and easier to mkfs and restore from backups instead.

> I have this:
> hvc0:rescue:~ # btrfs inspect-internal dump-super /dev/xvda2
> superblock: bytenr=65536, device=/dev/xvda2
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x659898f3 [match]
> bytenr                  65536
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    1b651baa-327b-45fe-9512-e7147b24eb49
> metadata_uuid           1b651baa-327b-45fe-9512-e7147b24eb49
> label
> generation              280
> root                    1107214336
> sys_array_size          97
> chunk_root_generation   35
> root_level              0
> chunk_root              1048576
> chunk_root_level        0
> log_root                0
> log_root_transid        0
> log_root_level          0
> total_bytes             10727960576
> bytes_used              1461825536
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)           16384
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x0
> incompat_flags          0x163
>                         ( MIXED_BACKREF |
>                           DEFAULT_SUBVOL |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           SKINNY_METADATA )
> cache_generation        280
> uuid_tree_generation    40
> dev_item.uuid           2abdf93e-2f2d-4eef-a1d8-9325f809ebce
> dev_item.fsid           1b651baa-327b-45fe-9512-e7147b24eb49 [match]
> dev_item.type           0
> dev_item.total_bytes    10727960576
> dev_item.bytes_used     2436890624
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          1
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> 
> Regards,
> Ulrich Windl
> 
> 
