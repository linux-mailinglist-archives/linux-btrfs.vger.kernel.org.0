Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2CF18DDC9
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Mar 2020 04:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCUD3M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 20 Mar 2020 23:29:12 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48620 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCUD3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 23:29:12 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 57ADC62072B; Fri, 20 Mar 2020 23:29:11 -0400 (EDT)
Date:   Fri, 20 Mar 2020 23:29:11 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
Message-ID: <20200321032911.GR13306@hungrycats.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 20, 2020 at 06:56:38PM +0100, Goffredo Baroncelli wrote:
> Hi all,
> 
> for a btrfs filesystem, how an user can understand which is the {data,mmetadata,system} [raid] profile in use ? E.g. the next chunk which profile will have ?

It's the profile used by the highest-numbered block group for the
allocation type (one for data, one for metadata/system).  There
are two profiles to consider, one for data and one for metadata.
'btrfs fi df', 'btrfs fi us', or 'btrfs dev usage' will all indicate
which profiles these are.

It is valid for the two profiles to be different, and different profile
combinations have different use cases.  In most cases the only one that
matters is the data profile, as that's the one POSIX 'df' reports and
data block writes consume, and the one that typically occupies more than
99% of the total space.  Adminstrators and system designers have to be
more aware of metadata usage when filesystems become extremely full or
extremely small (less than 16 GB).  Users (without root or CAP_SYS_ADMIN)
generally can't do anything about metadata usage, except as a tiny
side-effect of their data usage.

> For simple filesystem it is easy looking at the output of (e.g)  "btrfs fi df" or "btrfs fi us". But what if the filesystem is not simple ?

"Not simple" is not a normal operating mode for btrfs.  The filesystem
allows multiple profiles to be active, so the filesystem can be
converted to a new profile while old data is still accessible; however,
the conversion is expected to end at some point, and all block groups
will use the same profile when that happens.

The allocator will only use one RAID profile, and will ignore free
space in block groups of other profiles, while 'df' reports the total
space on the filesystem in each profile, and metadata allocation does
something else.  'btrfs fi us' reports a mess and can't give any accurate
free space estimate.  Disk space will apparently be free while writes
fail with ENOSPC.

This is not a problem if a conversion is running to eliminate all the
"competing" profiles, but if the conversion stops, you can expect some
problems with space until it resumes again.

> btrfs fi us t/.
> Overall:
>     Device size:		  40.00GiB
>     Device allocated:		  19.52GiB
>     Device unallocated:		  20.48GiB
>     Device missing:		     0.00B
>     Used:			  16.75GiB
>     Free (estimated):		  12.22GiB	(min: 8.27GiB)
>     Data ratio:			      1.90
>     Metadata ratio:		      2.00
>     Global reserve:		   9.06MiB	(used: 0.00B)
> 
> Data,single: Size:1.00GiB, Used:512.00MiB (50.00%)
>    /dev/loop0	   1.00GiB
> 
> Data,RAID5: Size:3.00GiB, Used:2.48GiB (82.56%)
>    /dev/loop1	   1.00GiB
>    /dev/loop2	   1.00GiB
>    /dev/loop3	   1.00GiB
>    /dev/loop0	   1.00GiB
> 
> Data,RAID6: Size:4.00GiB, Used:3.71GiB (92.75%)
>    /dev/loop1	   2.00GiB
>    /dev/loop2	   2.00GiB
>    /dev/loop3	   2.00GiB
>    /dev/loop0	   2.00GiB
> 
> Data,RAID1C3: Size:2.00GiB, Used:1.88GiB (93.76%)
>    /dev/loop1	   2.00GiB
>    /dev/loop2	   2.00GiB
>    /dev/loop3	   2.00GiB
> 
> Metadata,RAID1: Size:256.00MiB, Used:9.14MiB (3.57%)
>    /dev/loop2	 256.00MiB
>    /dev/loop3	 256.00MiB
> 
> System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
>    /dev/loop2	   8.00MiB
>    /dev/loop3	   8.00MiB
> 
> Unallocated:
>    /dev/loop1	   5.00GiB
>    /dev/loop2	   4.74GiB
>    /dev/loop3	   4.74GiB
>    /dev/loop0	   6.00GiB
> 
> This is an example of a strange but valid filesystem. 

Valid, but the filesystem is in a state designed for temporary use during
conversions, and you will want to exit that state as soon as possible.

> So the question is: the next chunk which profile will have ?
> Is there any way to understand what will happens ?
> 
> I expected that the next chunk will be allocated as the last "convert". However I discovered that this is not true.

That's correct in most cases--a convert will create a new block group,
which will have the highest bytenr in the filesystem, and its profile
will be used to allocate new data, thus converting the filesystem to
the new profile; however, if you pause the convert and delete all the
files in the new block group, it's possible that the new block group gets
deleted too, and then the filesystem reverts to the previous RAID profile.
Again, not a problem if you run the convert until it completely removes
all old block groups!

> Looking at the code it seems to me that the logic is the following (from btrfs_reduce_alloc_profile())
> 
>         if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>                 allowed = BTRFS_BLOCK_GROUP_RAID6;
>         else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>                 allowed = BTRFS_BLOCK_GROUP_RAID5;
>         else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>                 allowed = BTRFS_BLOCK_GROUP_RAID10;
>         else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>                 allowed = BTRFS_BLOCK_GROUP_RAID1;
>         else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>                 allowed = BTRFS_BLOCK_GROUP_RAID0;
> 
>         flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
> 
> So in the case above the profile will be RAID6. And in the general if a RAID6 chunk is a filesystem, it wins !

This code is used to determine whether a conversion reduces the level of
redundancy, e.g. you are going from raid6 (2 redundant disks) to raid5
(1 redundant disk) or raid0 (0 redundant disks).  There are warnings and
a force flag required when that happens.  It doesn't determine the raid
profile of the next block group--that's just a straight copy of the raid
profile of the last block group.

> But I am not sure.. Moreover I expected to see also reference to DUP and/or RAID1C[34] ...

If you get through that 'if' statement without hitting any of the
branches, then you're equal to raid0 (0 redundant disks) but raid0
is a special case because it requires 2 disks for allocation.  'dup'
(0 redundant disks) and 'single' (which is the absence of any profile
bits) also have 0 redundant disks and require only 1 disk for allocation,
there is no need to treat them differently.

raid1c[34] probably should be there.  Patches welcome.

> Does someone have any suggestion ?
> 
> BR
> G.Baroncelli
> 
