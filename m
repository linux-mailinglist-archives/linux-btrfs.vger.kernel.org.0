Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E137C431F0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhJROMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 10:12:14 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44828 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhJROMG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 10:12:06 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 473C1BCB1EA; Mon, 18 Oct 2021 10:09:45 -0400 (EDT)
Date:   Mon, 18 Oct 2021 10:09:45 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     mailing@dmilz.net
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Filesystem Read Only due to errno=-28 during metadata allocation
Message-ID: <20211018140936.GA1208@hungrycats.org>
References: <f2ed8b05b03db6a4fec4cba7ed17222a@dmilz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ed8b05b03db6a4fec4cba7ed17222a@dmilz.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 02:35:39PM +0200, mailing@dmilz.net wrote:
> Hello,
> 
> I faced issue with btrfs FS /var forced to RO due to errno=-28 (no space
> left).
> 
> The server was restarted to bring back FS in RW.
> 
> Before reboot:
> $ btrfs fi usage /var -m
> Overall:
>     Device size:         2560.00MiB
>     Device allocated:         2559.00MiB
>     Device unallocated:            1.00MiB
>     Device missing:            0.00MiB
>     Used:         1116.00MiB
>     Free (estimated):          451.25MiB (min: 451.25MiB)
>     Data ratio:               1.00
>     Metadata ratio:               2.00
>     Global reserve:           13.00MiB (used: 0.00MiB)
> 
> Data,single: Size:1559.25MiB, Used:1108.00MiB
>    /dev/mapper/rootvg-varvol 1559.25MiB
> 
> Metadata,DUP: Size:467.88MiB, Used:3.94MiB
>    /dev/mapper/rootvg-varvol  935.75MiB
> 
> System,DUP: Size:32.00MiB, Used:0.06MiB
>    /dev/mapper/rootvg-varvol   64.00MiB
> 
> Unallocated:
>    /dev/mapper/rootvg-varvol    1.00MiB

This is a tiny filesystem, below the minimum practical size for separate
data and metadata block groups, but above the size for mixed block
groups to be the mkfs default.  It might be better to format it with
the mixed-bg option.

> The FS went RO on Sunday, with this trace:
> 2021-10-10T00:13:12.790042+02:00 SERVERNAME kernel: BTRFS: Transaction
> aborted (error -28)
[...]
> 2021-10-10T00:13:12.790124+02:00 SERVERNAME kernel: BTRFS: error (device
> dm-22) in btrfs_run_delayed_refs:2353: errno=-28 No space left
> 2021-10-10T00:13:12.790125+02:00 SERVERNAME kernel: btrfs_printk: 12
> callbacks suppressed
> 2021-10-10T00:13:12.790127+02:00 SERVERNAME kernel: BTRFS info (device
> dm-22): forced readonly
> 
> $ btrfs --version
> btrfs-progs v4.5.3+20160729
> 
> $ btrfs fi show /var
> Label: none  uuid: f96f4980-4682-4d2d-8d7a-3c0e2c1c6680
>         Total devices 1 FS bytes used 1.06GiB
>         devid    1 size 2.50GiB used 2.50GiB path /dev/mapper/rootvg-varvol
> 
> uname -a
> Linux SERVERNAME 4.12.14-122.83-default #1 SMP Tue Aug 3 08:37:22 UTC 2021
> (c86c48c) ppc64le ppc64le ppc64le GNU/Linux

This kernel is 4 years old.  It may have additional practical problems in
the implementation beyond the design-level issues I've described here.

> On the previous Friday after weekly balance:
> btrfs fi usage /var
> Overall:
>     Device size:                   2.50GiB
>     Device allocated:              1.73GiB
>     Device unallocated:          792.75MiB
>     Device missing:                  0.00B
>     Used:                          1.09GiB
>     Free (estimated):              1.11GiB      (min: 739.62MiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:               13.00MiB      (used: 0.00B)
> 
> Data,single: Size:1.41GiB, Used:1.08GiB
>    /dev/mapper/rootvg-varvol       1.41GiB
> 
> Metadata,DUP: Size:128.00MiB, Used:3.94MiB
>    /dev/mapper/rootvg-varvol     256.00MiB
> 
> System,DUP: Size:32.00MiB, Used:64.00KiB
>    /dev/mapper/rootvg-varvol      64.00MiB
> 
> Unallocated:
>    /dev/mapper/rootvg-varvol     792.75MiB
> 
> 
> I don't have extract of btrfs fi usage /var command during the weekend, but
> a script is extracting the Space allocated ("Size") and Used in Data and
> Metadata. I observed twice during the weekend space allocated to metadata is
> suddenly growing while the metadata used remains the same. The first time I
> had enough "Device unallocated" and no problem was observed, the second (on
> Sunday after midnight), it leads to FS RO (no space left).
> 
> Is there any situation that can lead to metadata allocation but without
> actual usage of metadata?

Some btrfs maintenance operations lock block groups to prevent concurrent
modification, such as balance, scrub, and discard.  When this occurs,
any free space that has been allocated in the metadata block groups
is temporarily unavailable, and if there's no free space in any other
block group, then btrfs will need to allocate another metadata block
group to continue.  (The same happens with data block groups but the
impact is smaller due to the much larger data sizes.)  The worst case
for metadata on a normal filesystem is:

	raid_profile_redundancy (2 for dup metadata) * (
		chunk_size (usually 1GB) * (
			number_of_disks (for scrub) +
			1 (for discard) +
			1 (for balance)
		) + global_reserve (up to 512MB)
	)

i.e. on a single-disk filesystem with dup metadata, there should be at
least 7GB allocated or available for metadata (3.5GB dup metadata takes
7GB of raw space, you can have either the 3.5GB allocated-but-free
metadata or 7GB unallocated, or any combination totalling at least 7GB).

Obviously, keeping 7GB reserved for metadata doesn't work on a device
that is only 2.5GB to start with.  Even if you elect not to use discard
or scrub, you'd still need 2.5GB for dup metadata.

btrfs has two ways to deal with this: mixed block groups (mixed-bg mkfs
option), which puts all the space into a single pool with no distinction
between data and metadata, and reducing block group chunk size for
non-mixed-bg filesystems.

On a filesystem this size, the block groups use 128MB chunks instead
of 1GB.  Global reserve is also reduced (it is computed based on device
size and capped at 512MB).  In this case, the worst case metadata free
space requirement is 128MB chunk size * (1 disk + 2) + global_reserve
which works out to 397MB of free metadata space or 794MB of unallocated
space with dup metadata.

You have 467MB allocated to metadata and most of it is free space, which
is theoretically enough, but if you count space in terms of block groups,
it's exactly full--if the first 3 block groups are locked, the 4th block
group is the last one where space might be allocated, and it's an odd
size so it might not be large enough.

Mixed block groups (mixed-bg mkfs option) put all the space is in a
single pot that can be allocated to metadata or data blocks as needed.
This is the default for filesystems below 1GB, but it's a good idea to
use mixed-bg for larger filesystems as well because the metadata block
group locking cost is so high relative to the filesystem size.

While it's possible to use non-mixed block groups on a filesystem that
has only a few GB, it's not possible to use a significant number of
btrfs features, including scrub, balance, RAID disk replacement, online
conversion to other RAID profiles, device shrink, or discard, due to
the requirement to have an extra unlocked block group with available
free space during these operations.
