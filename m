Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C0F45E718
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Nov 2021 06:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhKZFUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Nov 2021 00:20:17 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:40766 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235223AbhKZFSQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Nov 2021 00:18:16 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 3BE109B5B4; Fri, 26 Nov 2021 00:15:03 -0500 (EST)
Date:   Fri, 26 Nov 2021 00:15:03 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andrey Melnikov <temnota.am@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs with huge numbers of hardlinks is extremely slow
Message-ID: <20211126051503.GG17148@hungrycats.org>
References: <CA+PODjrE4V9hL1bXEEghU6NAFgPgfUu4f75FCQn+0vKUaeu1zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PODjrE4V9hL1bXEEghU6NAFgPgfUu4f75FCQn+0vKUaeu1zg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 26, 2021 at 12:56:25AM +0300, Andrey Melnikov wrote:
> Every night a new backup is stored on this fs with 'rsync
> --link-dest=$yestoday/ $today/' - 1402700 hardlinks and 23000
> directories are created, 50-100 normal files transferred.
> Now, FS contains 351 copies of backup data with 486086495 hardlinks
> and ANY operations on this FS take significant time. For example -
> simple count hardlinks with
> "time find . -type f -links +1 | wc -l" take:
> real    28567m33.611s
> user    31m33.395s
> sys     506m28.576s
> 
> 19 days 20 hours 10 mins with constant reads from storage 2-4Mb/s.

That works out to reading the entire drive 4x in 20 days, or all of the
metadata 30x.  Certainly hardlinks will not result in optimal object
placement, and you probably don't have enough RAM to cache the entire
metadata tree, and you're using WD Purple drives in a fileserver for
some reason, so those numbers seem plausible.

> - BTRFS not suitable for this workload?

There are definitely better ways to do this on btrfs, e.g.

	btrfs sub snap $yesterday $today
	rsync ... (no link-dest) ... $today

This will avoid duplicating the entire file tree every time.  It will also
store historical file attributes correctly, which --link-dest sometimes
does not.

You might also consider doing it differently:

	rsync ... (no link-dest) ... working-dir/. &&
	btrfs sub snap -r working-dir $today

so that your $today directory doesn't exist until it is complete with
no rsync errors.  'working-dir' will have to be a subvol, but you only
have to create it once and you can keep reusing it afterwards.

> - using reflinks helps speedup FS operations?

Snapshots are lazy reflink copies, so they'll do a little better than
reflinks.  You'll only modify the metadata for the 50-100 files that you
transfer each day, instead of completely rewriting all of the metadata
in the filesystem every day with hardlinks.

Hardlinks put the inodes further and further away from their directory
nodes each day, and add some extra searching overhead within directories
as well.  You'll need more and more RAM to cache the same amount of
each filesystem tree, because they're all in the same metadata tree.
With snapshots they'll end up in separate metadata trees.

> - readed metadata not cached at all? 

If you have less than about 640GB of RAM (4x the size of your metadata)
then you're going to be rereading metadata pages at some point.  Because
you're using hardlinks, the metadata pages from different days are all
mashed together, and 'find' will flood the cache chasing references to
them.

Other recommendations:

- Use the right drive model for your workload.  WD Purple drives are for
continuous video streaming, they are not for seeky millions-of-tiny-files
rsync workloads.  Almost any other model will outperform them, and
better drives for this workload (e.g. CMR WD Red models) are cheaper.
Your WD Purple drives are getting 283 links/s.  Compare that with some
other drive models:

	1665 links/s:  WD Green (2x1TB + 1x2TB btrfs raid1)

	6850 links/s:  Sandisk Extreme MicroSD (1x256GB btrfs single/dup)

	12511 links/s:  WD Red (2x1TB btrfs raid1)

	13371 links/s:  WD Red SSD + Seagate Ironwolf SSD (6x1TB btrfs raid1)

	14872 links/s:  WD Black (1x1TB btrfs single/dup, 8 years old)

	25498 links/s:  WD Gold + Seagate Exos (3x16TB btrfs raid1)

	27341 links/s:  Toshiba NVME (1x2TB btrfs single/dup)

	311284 links/s:  Sabrent Rocket 4 NVME (2x1TB btrfs raid1)
	(1344748222 links, 111 snapshots)

Some of these numbers are lower than they should be, because I ran
'find' commands on some machines that were busy doing other work.
The point is that even if some of these numbers are too low, all of
these numbers are higher what we can expect from a WD Purple.

- Use btrfs raid1 instead of hardware RAID1, i.e. expose each disk
separately through the RAID interface to btrfs.  This will enable btrfs
to correct errors and isolate faults if one of your drives goes bad.
You can also use iostat to see if one of the drives is running much
slower than the other, which might be an early indication of failure
(and it might be the only indication of failure you get, if your drive's
firmware doesn't support SCTERC and hides failures).

> What BTRFS read 19 days from disks???
> 
> Hardware: dell r300 with 2 WD Purple 1Tb disk on LSISAS1068E RAID 1
> (without cache).
> Linux nlxc 5.14-51412-generic #0~lch11 SMP Wed Oct 13 15:57:07 UTC
> 2021 x86_64 GNU/Linux
> btrfs-progs v5.14.1
> 
> # btrfs fi show
> Label: none  uuid: a840a2ca-bf05-4074-8895-60d993cb5bdd
>         Total devices 1 FS bytes used 474.26GiB
>         devid    1 size 931.00GiB used 502.23GiB path /dev/sdb1
> 
> # btrfs fi df /srv
> Data, single: total=367.19GiB, used=343.92GiB
> System, single: total=32.00MiB, used=128.00KiB
> Metadata, single: total=135.00GiB, used=130.34GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> # btrfs fi us /srv
> Overall:
>     Device size:                 931.00GiB
>     Device allocated:            502.23GiB
>     Device unallocated:          428.77GiB
>     Device missing:                  0.00B
>     Used:                        474.26GiB
>     Free (estimated):            452.04GiB      (min: 452.04GiB)
>     Free (statfs, df):           452.04GiB
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:367.19GiB, Used:343.92GiB (93.66%)
>    /dev/sdb1     367.19GiB
> 
> Metadata,single: Size:135.00GiB, Used:130.34GiB (96.55%)
>    /dev/sdb1     135.00GiB
> 
> System,single: Size:32.00MiB, Used:128.00KiB (0.39%)
>    /dev/sdb1      32.00MiB
> 
> Unallocated:
>    /dev/sdb1     428.77GiB
