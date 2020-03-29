Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F56C196F85
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 20:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgC2SzS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 29 Mar 2020 14:55:18 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45178 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgC2SzS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 14:55:18 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 45FD363E795; Sun, 29 Mar 2020 14:55:14 -0400 (EDT)
Date:   Sun, 29 Mar 2020 14:55:13 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Jason Clara <jason@clarafamily.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Device Delete Stuck
Message-ID: <20200329185513.GD13306@hungrycats.org>
References: <B7A6E37C-C10A-49C3-B98A-0D659CA4E33B@clarafamily.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <B7A6E37C-C10A-49C3-B98A-0D659CA4E33B@clarafamily.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 29, 2020 at 10:13:05AM -0400, Jason Clara wrote:
> I had a previous post about when trying to do a device delete that
> it would cause my whole system to hang.  I seem to have got past
> that issue.
>
> For that, it seems like even though all the SCRUBs finished without
> any errors I still had a problem with some files.  By forcing a read
> of every single file I was able to detect the bad files in DMESG.
> Not sure though why SCRUB didn’t detect this.  BTRFS warning (device
> sdd1): csum failed root 5 ino 14654354 off 163852288 csum 0

That sounds like it could be the raid5/6 bug I reported

	https://www.spinics.net/lists/linux-btrfs/msg94594.html

To trigger that bug you need pre-existing corruption on the disk.

You can work around by:

	1.  Read every file, e.g. 'find -type f -exec cat {} + >/dev/null'
	This avoids dmesg ratelimiting which will hide some errors.

	2.  If there are read errors in step 1, remove any that have
	failures.

	3.  Run full scrub to fix parity or inject new errors.

	4.  Repeat until there are no errors at step 1.

The bug will introduce new errors in a small fraction (<0.1%) of corrupted
raid stripes as you do this.  Each pass through the loop will remove
existing errors, but may add a few more new errors at the same time.
The rate of removal is much faster than the rate of addition, so the
loop will eventually terminate at zero errors.  You'll be able to use
the filesystem normally again after that.

This bug is not a regression--there has not been a kernel release with
working btrfs raid5/6 yet.  All releases from 4.15 to 5.5.3 fail my test
case, and versions before 4.15 have worse bugs.  At the moment, btrfs
raid5/6 should only be used by developers who intend to test, debug,
and fix btrfs raid5/6.

> But now when I attempt to delete a device from the array it seems to
> get stuck.  Normally it will show in the log that it has found some
> extents and then another message saying they were relocated.
>
> But for the last few days it has just been repeating the same found
> value and never relocating anything, and the usage of the device
> doesn’t change at all.
>
> This line has now been repeating for more then 24 hours, and the
> previous attempt was similar.  [Sun Mar 29 09:59:50 2020] BTRFS info
> (device sdd1): found 133 extents

Kernels starting with 5.1 have a known regression where block group
relocation gets stuck in loops.  Everything in the block group gets
relocated except for shared data backref items, then the relocation can't
seem to move those and no further progress is made.  This has not been
fixed yet.

> Prior to this run I had tried with an earlier kernel (5.5.10) and had
> the same results.  It starts with finding and then relocating, but
> then relocating.  So I upgraded my kernel to see if that would help,
> and it has not.

Use kernel 4.19 for device deletes or other big relocation operations.
(5.0 and 4.20 are OK too, but 4.19 is still maintained and has fixes
for non-btrfs issues).

> System Info
> Ubuntu 18.04
> btrfs-progs v5.4.1
> Linux FileServer 5.5.13-050513-generic #202003251631 SMP Wed Mar 25 16:35:59 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> 
> DEVICE USAGE
> /dev/sdd1, ID: 1
>    Device size:             2.73TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:            888.43GiB
>    Unallocated:             1.00MiB
> 
> /dev/sdb1, ID: 2
>    Device size:             2.73TiB
>    Device slack:            2.73TiB
>    Data,RAID6:            188.67GiB
>    Data,RAID6:            508.82GiB
>    Data,RAID6:              2.00GiB
>    Unallocated:          -699.50GiB
> 
> /dev/sdc1, ID: 3
>    Device size:             2.73TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:            888.43GiB
>    Unallocated:             1.00MiB
> 
> /dev/sdi1, ID: 5
>    Device size:             2.73TiB
>    Device slack:            1.36TiB
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.18TiB
>    Unallocated:             1.00MiB
> 
> /dev/sdh1, ID: 6
>    Device size:             4.55TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:              1.23TiB
>    Data,RAID6:            888.43GiB
>    Data,RAID6:              2.00GiB
>    Metadata,RAID1:          2.00GiB
>    Unallocated:           601.01GiB
> 
> /dev/sda1, ID: 7
>    Device size:             7.28TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:              1.23TiB
>    Data,RAID6:            888.43GiB
>    Data,RAID6:              2.00GiB
>    Metadata,RAID1:          2.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             3.32TiB
> 
> /dev/sdf1, ID: 8
>    Device size:             7.28TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:              1.23TiB
>    Data,RAID6:            888.43GiB
>    Data,RAID6:              2.00GiB
>    Metadata,RAID1:          8.00GiB
>    Unallocated:             3.31TiB
> 
> /dev/sdj1, ID: 9
>    Device size:             7.28TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:              1.23TiB
>    Data,RAID6:            888.43GiB
>    Data,RAID6:              2.00GiB
>    Metadata,RAID1:          8.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             3.31TiB
> 
> 
> FI USAGE
> WARNING: RAID56 detected, not implemented
> Overall:
>     Device size:		  33.20TiB
>     Device allocated:		  20.06GiB
>     Device unallocated:		  33.18TiB
>     Device missing:		     0.00B
>     Used:			  19.38GiB
>     Free (estimated):		     0.00B	(min: 8.00EiB)
>     Data ratio:			      0.00
>     Metadata ratio:		      2.00
>     Global reserve:		 512.00MiB	(used: 0.00B)
> 
> Data,RAID6: Size:15.42TiB, Used:15.18TiB (98.44%)
>    /dev/sdd1	   2.73TiB
>    /dev/sdb1	 699.50GiB
>    /dev/sdc1	   2.73TiB
>    /dev/sdi1	   1.36TiB
>    /dev/sdh1	   3.96TiB
>    /dev/sda1	   3.96TiB
>    /dev/sdf1	   3.96TiB
>    /dev/sdj1	   3.96TiB
> 
> Metadata,RAID1: Size:10.00GiB, Used:9.69GiB (96.90%)
>    /dev/sdh1	   2.00GiB
>    /dev/sda1	   2.00GiB
>    /dev/sdf1	   8.00GiB
>    /dev/sdj1	   8.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:1.19MiB (3.71%)
>    /dev/sda1	  32.00MiB
>    /dev/sdj1	  32.00MiB
> 
> Unallocated:
>    /dev/sdd1	   1.00MiB
>    /dev/sdb1	-699.50GiB
>    /dev/sdc1	   1.00MiB
>    /dev/sdi1	   1.00MiB
>    /dev/sdh1	 601.01GiB
>    /dev/sda1	   3.32TiB
>    /dev/sdf1	   3.31TiB
>    /dev/sdj1	   3.31TiB
> 
> 
> FI SHOW
> Label: 'Pool1'  uuid: 99935e27-4922-4efa-bf76-5787536dd71f
> 	Total devices 8 FS bytes used 15.19TiB
> 	devid    1 size 2.73TiB used 2.73TiB path /dev/sdd1
> 	devid    2 size 0.00B used 699.50GiB path /dev/sdb1
> 	devid    3 size 2.73TiB used 2.73TiB path /dev/sdc1
> 	devid    5 size 1.36TiB used 1.36TiB path /dev/sdi1
> 	devid    6 size 4.55TiB used 3.96TiB path /dev/sdh1
> 	devid    7 size 7.28TiB used 3.96TiB path /dev/sda1
> 	devid    8 size 7.28TiB used 3.97TiB path /dev/sdf1
> 	devid    9 size 7.28TiB used 3.97TiB path /dev/sdj1
> 
> FI DF
> Data, RAID6: total=15.42TiB, used=15.18TiB
> System, RAID1: total=32.00MiB, used=1.19MiB
> Metadata, RAID1: total=10.00GiB, used=9.69GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
