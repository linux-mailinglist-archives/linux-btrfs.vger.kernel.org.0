Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551EB373DEE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 May 2021 16:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhEEOus (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 10:50:48 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36184 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhEEOus (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 May 2021 10:50:48 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 13C7CA46014; Wed,  5 May 2021 10:49:49 -0400 (EDT)
Date:   Wed, 5 May 2021 10:49:49 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Abdulla Bubshait <darkstego@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Array extremely unbalanced after convert to Raid5
Message-ID: <20210505144949.GB32440@hungrycats.org>
References: <CADOXG6Fj3zCzu46q-nLKOdszxQHPGLk6r5rDn80KNLKY5sn3iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADOXG6Fj3zCzu46q-nLKOdszxQHPGLk6r5rDn80KNLKY5sn3iQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 05, 2021 at 09:41:49AM -0400, Abdulla Bubshait wrote:
> I ran a balance convert of my data single setup to raid 5. Once
> complete the setup is extremely unbalanced and doesn't even make sense
> as a raid 5. I tried to run a balance with dlimit of 1000, but it just
> seems to make things worse.

Balancing a full single array to raid5 requires a better device selection
algorithm than the kernel provides, especially if the disks are of
different sizes and were added to the array over a long period of time.
The kernel will strictly relocate the newest block groups first, which
may leave space occupied on some disks for most of the balance, and
cause many chunks to be created with suboptimal stripe width.

> After convert the array looked like this:
> 
> btrfs fi show gives:
> Label: 'horde'  uuid: 26debbc1-fdd0-4c3a-8581-8445b99c067c
>        Total devices 4 FS bytes used 25.53TiB
>        devid    1 size 16.37TiB used 2.36TiB path /dev/sdd
>        devid    2 size 14.55TiB used 14.27TiB path /dev/sdc
>        devid    3 size 12.73TiB used 12.69TiB path /dev/sdf
>        devid    4 size 16.37TiB used 16.32TiB path /dev/sde

For raid5 conversion, you need equal amounts of unallocated space on
each disk.  Convert sufficient raid5 block groups back to single profile
to redistribute the unallocated space:

	btrfs balance start -dconvert=single,devid=2,limit=4000 /fs

	btrfs balance start -dconvert=single,devid=3,limit=4000 /fs

	btrfs balance start -dconvert=single,devid=4,limit=4000 /fs

After this, each disk should have 3-4 TB of unallocated space on it
(devid 2-4 will have data moved to devid 1).  The important thing is to
have equal unallocated space--you can cancel balancing as soon as that
is achieved.  The limits above are higher than necessary to be sure
that happens.

Now use the stripes filter to get rid of all chunks that have fewer
than the optimum number of stripes on each disk.  Cycle through these
commands until they report 0 chunks relocated (you can just leave these
running in a shell loop and check on it every few hours, when they get
to 0 they will just become no-ops):

	btrfs balance start -dlimit=100,convert=raid5,stripes=1..3,devid=3 /fs

	btrfs balance start -dlimit=100,convert=raid5,stripes=1..2,devid=2 /fs

	btrfs balance start -dlimit=100,convert=raid5,stripes=1..1,devid=1 /fs

	btrfs balance start -dlimit=100,convert=raid5,stripes=1..1,devid=4 /fs

The filters select chunks that have undesirable stripe counts and force
them into raid5 profile.  Single chunks have stripe count 1 and will
be converted to raid5.  RAID5 chunks have stripe count >1 and will be
relocated (converted from raid5 to raid5, but in a different location
with more disks in the chunk).  RAID5 chunks that already occupy the
correct number of drives will not be touched.

It is important to select chunks from every drive in turn in order to
keep some free space available on all disks.  Each command will spread
out 100 chunks from one disk over all the disks, making space on one
disk and filling all the others.  The balance must change to another
devid at regular intervals to ensure all disks maintain free space as
long as possible.

If you want to avoid converting to single profile then you might be able
to use only the balance commands in the second section; however, if you
run out of space on one or more drives then the balances will push data
around but be unable to make any progress on changing the chunk sizes.
In that case you will need to convert some raid5 back to single chunks
to continue.

> btrfs fi usage gives:
> Overall:
>    Device size:                  60.03TiB
>    Device allocated:             45.64TiB
>    Device unallocated:           14.39TiB
>    Device missing:                  0.00B
>    Used:                         45.59TiB
>    Free (estimated):              8.08TiB      (min: 4.81TiB)
>    Free (statfs, df):           410.67GiB
>    Data ratio:                       1.78
>    Metadata ratio:                   3.00
>    Global reserve:              512.00MiB      (used: 80.00KiB)
>    Multiple profiles:                  no
> 
> Data,RAID5: Size:25.51TiB, Used:25.50TiB (99.93%)
>   /dev/sdd        2.33TiB
>   /dev/sdc       14.23TiB
>   /dev/sdf       12.66TiB
>   /dev/sde       16.31TiB
> 
> Metadata,RAID1C3: Size:35.00GiB, Used:28.54GiB (81.55%)
>   /dev/sdd       34.00GiB
>   /dev/sdc       35.00GiB
>   /dev/sdf       30.00GiB
>   /dev/sde        6.00GiB
> 
> System,RAID1C3: Size:32.00MiB, Used:3.06MiB (9.57%)
>   /dev/sdd       32.00MiB
>   /dev/sdc       32.00MiB
>   /dev/sde       32.00MiB
> 
> Unallocated:
>   /dev/sdd       14.01TiB
>   /dev/sdc      292.99GiB
>   /dev/sdf       47.00GiB
>   /dev/sde       53.00GiB
> 
> After doing some balance I currently have:
> btrfs fi usage
> Overall:
>    Device size:                  60.03TiB
>    Device allocated:             45.52TiB
>    Device unallocated:           14.51TiB
>    Device missing:                  0.00B
>    Used:                         45.50TiB
>    Free (estimated):              8.16TiB      (min: 4.85TiB)
>    Free (statfs, df):           414.97GiB
>    Data ratio:                       1.78
>    Metadata ratio:                   3.00
>    Global reserve:              512.00MiB      (used: 80.00KiB)
>    Multiple profiles:                  no
> 
> Data,RAID5: Size:25.52TiB, Used:25.51TiB (99.96%)
>   /dev/sdd        2.23TiB
>   /dev/sdc       14.13TiB
>   /dev/sdf       12.71TiB
>   /dev/sde       16.37TiB
> 
> Metadata,RAID1C3: Size:29.00GiB, Used:28.51GiB (98.31%)
>   /dev/sdd       29.00GiB
>   /dev/sdc       29.00GiB
>   /dev/sdf       27.00GiB
>   /dev/sde        2.00GiB
> 
> System,RAID1C3: Size:32.00MiB, Used:3.03MiB (9.47%)
>   /dev/sdd       32.00MiB
>   /dev/sdc       32.00MiB
>   /dev/sde       32.00MiB
> 
> Unallocated:
>   /dev/sdd       14.12TiB
>   /dev/sdc      404.99GiB
>   /dev/sdf        1.00MiB
>   /dev/sde        1.00MiB
> 
> 
> So the estimated freespace is 8TB, When it should be closer to 15. I
> am guessing the freespace would be better if it was properly balanced.
> I am unsure how to properly balance this array though.
