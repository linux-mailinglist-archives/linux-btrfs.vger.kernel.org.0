Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD22201AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 03:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGOBSo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 21:18:44 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46098 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgGOBSo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 21:18:44 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4590A761A3C; Tue, 14 Jul 2020 21:18:43 -0400 (EDT)
Date:   Tue, 14 Jul 2020 21:18:43 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     John Petrini <john.d.petrini@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Filesystem Went Read Only During Raid-10 to Raid-6 Data
 Conversion
Message-ID: <20200715011843.GH10769@hungrycats.org>
References: <CADvYWxeiNynEWUYwfQxP7fQTK4k2Q+eDZsA8j7rLcaTSeND9fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvYWxeiNynEWUYwfQxP7fQTK4k2Q+eDZsA8j7rLcaTSeND9fg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 14, 2020 at 12:13:56PM -0400, John Petrini wrote:
> Hello All,
> 
> My filesystem went read only while converting data from raid-10 to
> raid-6. 

When the filesystem forces itself read-only, the filesystem goes into
an inert but broken state:  there's enough filesytem left to avoid having
to kill all processes using it, it no longer writes to the disk so it
doesn't damage any data, but the filesystem doesn't really work any more.

The next thing you should do is umount and mount the filesystem again,
because...

> I attempted a scrub but it immediately aborted. 

...none of the tools will work properly until the filesystem is mounted
again.

You may need to mount with -o skip_balance, then run 'btrfs balance
cancel' on the filesystem to abort the balance; otherwise, it will
resume when you mount the filesystem again and probably have the same
problem.

> Can anyone
> provide some guidance on possibly recovering?
> 
> Thank you!

Aside:  data-raid6 metadata-raid10 isn't a sane configuration.  It
has 2 redundant disks for data and 1 redundant disk for metadata, so
the second parity disk in raid6 is wasted space.

The sane configurations for parity raid are:

	data-raid6 metadata-raid1c3 (2 parity stripes for data, 3 copies
	for metadata, 2 disks can fail, requires 3 or more disks)

	data-raid5 metadata-raid10 (1 parity stripe for data, 2 copies
	for metadata, 1 disk can fail, requires 4 or more disks)

	data-raid5 metadata-raid1 (1 parity stripe for data, 2 copies
	for metadata, 1 disk can fail, requires 2 or more disks)

> ##System Details##
> Ubuntu 18.04
> 
> # This shows some read errors but they are not new. I had a SATA cable
> come loose on a drive some months back that caused these. They haven't
> increased since I reseated the cable
> sudo btrfs device stats /mnt/storage-array/ | grep sde
> [/dev/sde].write_io_errs    0
> [/dev/sde].read_io_errs     237
> [/dev/sde].flush_io_errs    0
> [/dev/sde].corruption_errs  0
> [/dev/sde].generation_errs  0

You can clear these numbers with 'btrfs dev stats -z' once the cause
has been resolved.

> btrfs fi df /mnt/storage-array/
> Data, RAID10: total=32.68TiB, used=32.64TiB
> Data, RAID6: total=1.04TiB, used=1.04TiB
> System, RAID10: total=96.00MiB, used=3.06MiB
> Metadata, RAID10: total=40.84GiB, used=39.94GiB
> GlobalReserve, single: total=512.00MiB, used=512.00MiB

Please post 'btrfs fi usage' output.  'btrfs fi usage' reports how much
is unallocated, allocated, and used on each drive.  This information is
required to understand and correct ENOSPC issues.

You didn't post the dmesg messages from when the filesystem went
read-only, but metadata 'total' is very close to 'used', you were doing
a balance, and the filesystem went read-only, so I'm guessing you hit
ENOSPC for metadata due to lack of unallocated space on at least 4 drives
(minimum for raid10).

If you have a cron job or similar scheduled task that does 'btrfs balance
start -m', remove it, as that command will reduce metadata allocation,
which will lead directly to ENOSPC panic as the filesystem gets full.

If the filesystem became read-only for non-ENOSPC reasons, it is likely
in-memory or on-disk metadata corruption.  The former is trivially
recoverable, just mount again (preferably with an updated kernel,
see below).  The latter is not trivially recoverable, and with 40 GB
of metadata you may not want to wait for btrfs check.  Hopefully it's
just ENOSPC.

> uname -r
> 5.3.0-40-generic

Please upgrade to 5.4.13 or later.  Kernels 5.1 through 5.4.12 have a
rare but nasty bug that is triggered by writing at exactly the wrong
moment during balance.  5.3 has some internal defenses against that bug
(the "write time tree checker"), but if they fail, the result is metadata
corruption that requires btrfs check to repair.

> ##dmesg##
> [3813499.479570] BTRFS info (device sdd): no csum found for inode
> 44197278 start 401276928
> [3813499.480211] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 401276928 csum 0x0573112f expected csum 0x00000000 mirror
> 2

All of these are likely because you haven't umounted the filesystem yet.
The filesystem in memory is no longer in sync with the disk, and will
remain out of sync until umounted.

If umounting and mounting doesn't resolve the problem, please post the
kernel messages starting from before the mount.  We need to see the
_first_ errors.

> [3813506.750924] BTRFS error (device sdd): parent transid verify
> failed on 98952926429184 wanted 6618521 found 6618515
> [3813506.751395] BTRFS error (device sdd): parent transid verify
> failed on 98952926429184 wanted 6618521 found 6618515
> [3813506.751783] BTRFS info (device sdd): no csum found for inode
> 44197278 start 152698880
> [3813506.773031] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 152698880 csum 0x9b7d599f expected csum 0x00000000 mirror
> 1
> [3813506.773070] BTRFS error (device sdd): parent transid verify
> failed on 98952926429184 wanted 6618521 found 6618515
> [3813506.773596] BTRFS error (device sdd): parent transid verify
> failed on 98952926429184 wanted 6618521 found 6618515
> [3813506.774073] BTRFS info (device sdd): no csum found for inode
> 44197278 start 152698880
> [3813506.813401] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 152698880 csum 0x9b7d599f expected csum 0x00000000 mirror
> 2
> [3813506.813431] BTRFS error (device sdd): parent transid verify
> failed on 98952926429184 wanted 6618521 found 6618515
> [3813506.813439] BTRFS error (device sdd): parent transid verify
> failed on 98952926429184 wanted 6618521 found 6618515
> [3813506.813444] BTRFS info (device sdd): no csum found for inode
> 44197278 start 152698880
> [3813506.813612] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 152698880 csum 0x9b7d599f expected csum 0x00000000 mirror
> 3
> [3813506.813624] BTRFS error (device sdd): parent transid verify
> failed on 98952926429184 wanted 6618521 found 6618515
> [3813506.813628] BTRFS error (device sdd): parent transid verify
> failed on 98952926429184 wanted 6618521 found 6618515
> [3813506.813632] BTRFS info (device sdd): no csum found for inode
> 44197278 start 152698880
> [3813506.816222] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 152698880 csum 0x9b7d599f expected csum 0x00000000 mirror
> 4
> [3813510.542147] BTRFS error (device sdd): parent transid verify
> failed on 104091430649856 wanted 6618521 found 6618516
> [3813510.542731] BTRFS error (device sdd): parent transid verify
> failed on 104091430649856 wanted 6618521 found 6618516
> [3813510.543216] BTRFS info (device sdd): no csum found for inode
> 44197278 start 288227328
> [3813510.558299] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
> 1
> [3813510.558341] BTRFS info (device sdd): no csum found for inode
> 44197278 start 288227328
> [3813510.574681] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
> 2
> [3813510.574714] BTRFS info (device sdd): no csum found for inode
> 44197278 start 288227328
> [3813510.574965] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
> 3
> [3813510.574980] BTRFS info (device sdd): no csum found for inode
> 44197278 start 288227328
> [3813510.576050] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
> 4
> [3813510.576070] BTRFS info (device sdd): no csum found for inode
> 44197278 start 288227328
> [3813510.577198] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
> 5
> [3813510.577214] BTRFS info (device sdd): no csum found for inode
> 44197278 start 288227328
> [3813510.578222] BTRFS warning (device sdd): csum failed root 5 ino
> 44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
> 6
