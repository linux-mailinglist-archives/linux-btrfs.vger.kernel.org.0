Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895113814F4
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 03:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhEOBkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 21:40:17 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43766 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhEOBkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 21:40:16 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1EBF7A5E311; Fri, 14 May 2021 21:39:04 -0400 (EDT)
Date:   Fri, 14 May 2021 21:39:04 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christian =?iso-8859-1?Q?V=F6lker?= <cvoelker@knebb.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Removal of Device and Free Space
Message-ID: <20210515013903.GE32440@hungrycats.org>
References: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 10:54:16AM +0200, Christian Völker wrote:
> 
> Hi all,
> 
> I am running a three device DRBD setup (non-RAID!).
> When I do "df -h" I see loads of free space:
> 
> root@backuppc:~# df -h
> [...]
> /dev/mapper/crypt_drbd2          2,8T    1,7T  1,1T   63% /var/lib/backuppc
> 
> As written, the fs consists of three devices:
> 
> root@backuppc:~# btrfs fi sh /var/lib/backuppc/
> Label: 'backuppc'  uuid: 73b98c7b-832a-437a-a15b-6cb00734e5db
>         Total devices 3 FS bytes used 1.70TiB
>         devid    3 size 799.96GiB used 799.96GiB path dm-5
>         devid    4 size 1.07TiB used 1.07TiB path dm-4
>         devid    7 size 899.96GiB used 327.00GiB path dm-6
> 
> root@backuppc:~# btrfs fi usage /var/lib/backuppc/
> Overall:
>     Device size:                   2.73TiB
>     Device allocated:              2.61TiB
>     Device unallocated:          128.00GiB
>     Device missing:                  0.00B
>     Used:                          1.70TiB
>     Free (estimated):              1.03TiB      (min: 1.03TiB)
>     Free (statfs, df):             1.03TiB
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:2.60TiB, Used:1.69TiB (65.17%)
>    /dev/mapper/crypt_drbd2       790.93GiB
>    /dev/mapper/crypt_drbd1         1.07TiB
>    /dev/mapper/crypt_drbd3       774.96GiB
> 
> Metadata,single: Size:9.00GiB, Used:3.95GiB (43.91%)
>    /dev/mapper/crypt_drbd2         6.00GiB
>    /dev/mapper/crypt_drbd1         3.00GiB
> 
> System,single: Size:32.00MiB, Used:320.00KiB (0.98%)
>    /dev/mapper/crypt_drbd2        32.00MiB
> 
> Unallocated:
>    /dev/mapper/crypt_drbd2         3.00GiB
>    /dev/mapper/crypt_drbd1         1.03MiB
>    /dev/mapper/crypt_drbd3       125.00GiB
> 
> So it tells me there is an estimated of ~1TB free. As the crypt_drbd3 device
> has a size of 899G I wanted to remove the device. I expected no issue as
> "Free" shows 1.03TiB. There should still be 200GB of free space afterwards.
> But the removal failed after two hours:
> 
> root@backuppc:~# btrfs dev remove /dev/mapper/crypt_drbd3 /var/lib/backuppc/
> ERROR: error removing device '/dev/mapper/crypt_drbd3': No space left on
> device
> 
> Now it looks like this:
> root@backuppc:~# btrfs fi usage /var/lib/backuppc/
> Overall:
>     Device size:                   2.73TiB
>     Device allocated:              2.17TiB
>     Device unallocated:          572.96GiB
>     Device missing:                  0.00B
>     Used:                          1.70TiB
>     Free (estimated):              1.03TiB      (min: 1.03TiB)
>     Free (statfs, df):             1.03TiB
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:2.17TiB, Used:1.69TiB (78.24%)
>    /dev/mapper/crypt_drbd2       793.93GiB
>    /dev/mapper/crypt_drbd1         1.07TiB
>    /dev/mapper/crypt_drbd3       327.00GiB
> 
> Metadata,single: Size:9.00GiB, Used:3.89GiB (43.23%)
>    /dev/mapper/crypt_drbd2         6.00GiB
>    /dev/mapper/crypt_drbd1         3.00GiB
> 
> System,single: Size:32.00MiB, Used:288.00KiB (0.88%)
>    /dev/mapper/crypt_drbd2        32.00MiB
> 
> Unallocated:
>    /dev/mapper/crypt_drbd2         1.03MiB
>    /dev/mapper/crypt_drbd1         1.03MiB
>    /dev/mapper/crypt_drbd3       572.96GiB
> 
> 
> So some questions arise:
> 
>     Why can btrfs device remove not check in advance if there is enough free
> space available? Instead of working for hours and then failing...

Relocation (balance and device remove) cannot change the size of any
extent, so they cannot use free space regions that are too small.  It is
not enough to have raw free space--it has to be contiguous free space.

This is not computed in advance because it is not trivial to compute--it
is a significant chunk of the cost of device removal.

>     Do I have to balance my fs after the failed removal now?

Balancing before removal would coalesce the free space and make device remove
more likely to succeed.  Something like:

	btrfs balance start -ddevid=3,limit=160 /var/lib/backuppc/

	btrfs balance start -ddevid=4,limit=160 /var/lib/backuppc/

or use btrfs-balance-least-used from the python-btrfs package, which will
start with chunks that have the most free space.

>     Why is it not possible to remove the device when all information tell me
> there is enough free space available?
> 
>     What is occupying so much disk space as the data only has 1.7TB which
> should fit in 1.8TB (two) devices? (no snapshot, nothing special configured
> on btrfs). Looks like there are ~400GB allocated which are not from data.

Chunks are deallocated only when completely empty.  If you recently
deleted a large number of files, then you'll have chunks with low data
density and high free space fragmentation.  Normally this does not matter,
as the free spaces in chunks would be filled in by new data allocations,
and those allocations would split writes into smaller extents that exactly
fit the free spaces.  Relocation can't do this--it can only occupy free
spaces that are equal or larger, and will make free space fragmentation
even worse.

> Just for completeness:
> 
> Debian Buster
> 
> root@backuppc:~# btrfs --version
> btrfs-progs v5.10.1
> 
> Thanks for letting me know.
> 
> 
> Greetings
> 
> /CV
> 
> 
> 
