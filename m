Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F322527DD49
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 02:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgI3AOM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 29 Sep 2020 20:14:12 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47938 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgI3AOM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 20:14:12 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 20:14:12 EDT
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D619782EAEE; Tue, 29 Sep 2020 20:04:26 -0400 (EDT)
Date:   Tue, 29 Sep 2020 20:04:26 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Giovanni Biscuolo <g@xelera.eu>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: how to recover from "enospc errors during balance"
Message-ID: <20200930000417.GH5890@hungrycats.org>
References: <87r1qk4q4d.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87r1qk4q4d.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 29, 2020 at 04:25:06PM +0200, Giovanni Biscuolo wrote:
> Hello,
> 
> please also reply to me since I'm not subscribed to linux-btrfs, thanks!
> 
> My BTRFS filesystem is full, I got ENOSPC during a (scheduled) balance:
> 
> --8<---------------cut here---------------start------------->8---
> 
> [6928066.755704] BTRFS info (device sda3): balance: start -dusage=50 -musage=70 -susage=70

Never balance metadata on a schedule.  If it is done too often, and the
disk fills up, it will eventually lead to ENOSPC errors that are hard
to get out of...

> [6928066.760485] BTRFS info (device sda3): relocating block group 139449073664 flags metadata|raid1
> [6928075.142462] BTRFS: error (device sda3) in btrfs_drop_snapshot:5421: errno=-28 No space left

...like this one.

> [6928075.146566] BTRFS info (device sda3): forced readonly
> [6928075.150851] BTRFS info (device sda3): 2 enospc errors during balance
> [6928075.155422] BTRFS info (device sda3): balance: ended with status: -30
> [6928083.483820] BTRFS info (device sda3): delayed_refs has NO entry
> 
> --8<---------------cut here---------------end--------------->8---
> 
> and now it's mounted read-only:
> 
> --8<---------------cut here---------------start------------->8---
> 
> /dev/sda3 on / type btrfs (ro,relatime,ssd,space_cache,subvolid=5,subvol=/)
> /dev/sda3 on /gnu/store type btrfs (ro,relatime,ssd,space_cache,subvolid=5,subvol=/gnu/store)
> 
> --8<---------------cut here---------------end--------------->8---
> 
> If I try to remount rw (to try to free space) I get:
> 
> --8<---------------cut here---------------start------------->8---
> 
> [7323937.312122] BTRFS info (device sda3): disk space caching is enabled
> [7323937.316478] BTRFS error (device sda3): Remounting read-write after error is not allowed
> 
> --8<---------------cut here---------------end--------------->8---
> 
> I tried to add a new device (I have 2 spare disks) but it does not work
> with a read-only filesystem.
> 
> Please how can I remount the filesystem read-write and free some space
> deleting some files?

Add 'skip_balance' to mount options so that the next mount will not
attempt to resume balancing metadata.  Keep mounting and umounting
(not remounting) until it completes orphan and relocation cleanup (it
may take more than one attempt, probably fewer than 20 attempts).

Once you have the filesystem mounted, run 'btrfs balance cancel' on
the mount point.  Then edit your maintenance scripts and remove the
metadata balance (-m flag to 'btrfs balance start').

> Additional data:
> 
> --8<---------------cut here---------------start------------->8---
> 
> ~$ uname -a
> Linux myhost 5.4.50-gnu #1 SMP 1 x86_64 GNU/Linux
> 
> ~$ btrfs --version
> btrfs-progs v5.6
> 
> ~$ sudo btrfs balance status /
> No balance found on '/'
> 
> ~$ btrfs fi df /
> Data, RAID1: total=446.50GiB, used=446.42GiB
> System, RAID1: total=32.00MiB, used=80.00KiB
> Metadata, RAID1: total=3.00GiB, used=2.11GiB
> GlobalReserve, single: total=512.00MiB, used=5.53MiB
> 
> ~$ sudo btrfs fi usage /
> Overall:
>     Device size:                 899.07GiB
>     Device allocated:            899.07GiB
>     Device unallocated:            2.01MiB
>     Device missing:                  0.00B
>     Used:                        897.05GiB
>     Free (estimated):             85.87MiB      (min: 85.87MiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 5.53MiB)
> 
> Data,RAID1: Size:446.50GiB, Used:446.42GiB (99.98%)
>    /dev/sda3     446.50GiB
>    /dev/sdb3     446.50GiB
> 
> Metadata,RAID1: Size:3.00GiB, Used:2.11GiB (70.22%)
>    /dev/sda3       3.00GiB
>    /dev/sdb3       3.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:80.00KiB (0.24%)
>    /dev/sda3      32.00MiB
>    /dev/sdb3      32.00MiB
> 
> Unallocated:
>    /dev/sda3       1.00MiB
>    /dev/sdb3       1.00MiB

A metadata balance will require a GB of temporary free space so that
it can relocate and delete one of the existing metadata block groups.
This space isn't available (there is no unallocated space and less than
1GB free in allocated metadata), so the metadata balance is failing now.

If scheduled metadata balances continue, eventually the filesystem will
reach a point where there would be no space available for the metadata
to expand with the data, and the next ordinary data write will force the
filesystem read-only.  Just before that happens, the filesystem will
slow down a _lot_, reducing the amount of data written per committed
transaction in an attempt to avoid this failure.

To avoid this, never run metadata balances from a scheduled job (or for
any reason other than working around a kernel bug or adding disks to a
RAID array) so that an appropriate number of metadata block groups is
allocated and _stay_ allocated.

Scheduled data balances (-d) are OK.  They defragment free space and
improve allocator performance, and make unallocated space available so
that additional metadata block groups can be allocated when necessary.

> ~$ sudo btrfs device stats /
> [/dev/sda3].write_io_errs    0
> [/dev/sda3].read_io_errs     0
> [/dev/sda3].flush_io_errs    0
> [/dev/sda3].corruption_errs  0
> [/dev/sda3].generation_errs  0
> [/dev/sdb3].write_io_errs    0
> [/dev/sdb3].read_io_errs     0
> [/dev/sdb3].flush_io_errs    0
> [/dev/sdb3].corruption_errs  0
> [/dev/sdb3].generation_errs  0
> 
> --8<---------------cut here---------------end--------------->8---
> 
> Thank you for any useful hint!
> Best regards, Giovanni
> 
> -- 
> Giovanni Biscuolo
> 
> Xelera IT Infrastructures


