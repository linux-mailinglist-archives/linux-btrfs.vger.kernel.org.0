Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211FF231484
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 23:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgG1VUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 17:20:07 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37340 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1VUG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 17:20:06 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8BB09786BEE; Tue, 28 Jul 2020 17:20:05 -0400 (EDT)
Date:   Tue, 28 Jul 2020 17:20:05 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Understanding "Used" in df
Message-ID: <20200728212005.GI5890@hungrycats.org>
References: <3225288.0drLW0cIUP@merkaba>
 <20200723045106.GL10769@hungrycats.org>
 <1622535.kDMmNaIAU4@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1622535.kDMmNaIAU4@merkaba>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 27, 2020 at 01:38:13PM +0200, Martin Steigerwald wrote:
> Zygo Blaxell - 23.07.20, 06:51:06 CEST:
> > On Wed, Jul 22, 2020 at 05:10:19PM +0200, Martin Steigerwald wrote:
> > > I have:
> > > 
> > > % LANG=en df -hT /home
> > > Filesystem            Type   Size  Used Avail Use% Mounted on
> > > /dev/mapper/sata-home btrfs  300G  175G  123G  59% /home
> > > 
> > > And:
> > > 
> > > merkaba:~> btrfs fi sh /home
> > > Label: 'home'  uuid: […]
> > > 
> > >         Total devices 2 FS bytes used 173.91GiB
> > >         devid    1 size 300.00GiB used 223.03GiB path
> > >         /dev/mapper/sata-home
> > >         devid    2 size 300.00GiB used 223.03GiB path
> > >         /dev/mapper/msata-home
> > > 
> > > merkaba:~> btrfs fi df /home
> > > Data, RAID1: total=218.00GiB, used=171.98GiB
> > > System, RAID1: total=32.00MiB, used=64.00KiB
> > > Metadata, RAID1: total=5.00GiB, used=1.94GiB
> > > GlobalReserve, single: total=490.48MiB, used=0.00B
> > > 
> > > As well as:
> > > 
> > > merkaba:~> btrfs fi usage -T /home
> > > 
> > > Overall:
> > >     Device size:                 600.00GiB
> > >     Device allocated:            446.06GiB
> > >     Device unallocated:          153.94GiB
> > >     Device missing:                  0.00B
> > >     Used:                        347.82GiB
> > >     Free (estimated):            123.00GiB      (min: 123.00GiB)
> > >     Data ratio:                       2.00
> > >     Metadata ratio:                   2.00
> > >     Global reserve:              490.45MiB      (used: 0.00B)
> > >     Multiple profiles:                  no
> > >     
> > >                           Data      Metadata System
> > > 
> > > Id Path                   RAID1     RAID1    RAID1    Unallocated
> > > -- ---------------------- --------- -------- -------- -----------
> > > 
> > >  1 /dev/mapper/sata-home  218.00GiB  5.00GiB 32.00MiB    76.97GiB
> > >  2 /dev/mapper/msata-home 218.00GiB  5.00GiB 32.00MiB    76.97GiB
> > > 
> > > -- ---------------------- --------- -------- -------- -----------
> > > 
> > >    Total                  218.00GiB  5.00GiB 32.00MiB   153.94GiB
> > >    Used                   171.97GiB  1.94GiB 64.00KiB
> > > 
> > > I think I understand all of it, including just 123G instead of
> > > 300 - 175 = 125 GiB "Avail" in df -hT.
> > > 
> > > But why 175 GiB "Used" in 'df -hT' when just 173.91GiB (see 'btrfs
> > > fi sh') is allocated *within* the block group / chunks?
> > 
> > statvfs (the 'df' syscall) does not report a "used" number, only total
> > and available btrfs data blocks (no metadata blocks are counted).
> > 'df' computes "used" by subtracting f_blocks - f_bavail.
> > 
> > 	122.99875 = 300 - 171.97 - 5 - .03125
> > 
> > 	df_free = total - data_used - metadata_allocated - system_allocated
> 
> I get that one. That is for what is still free.
> 
> But I do not understand "Used" in df as.

df "used" is f_blocks - f_bfree.  f_bfree is f_blocks - total_used,
where total_used is all space used in the filesystem.  f_bavail is the
sum of all free space in existing data block groups plus a simulation of
how much space would be available if all unallocated block groups were
converted to the current data profile.  f_blocks is the total number of
blocks in the raw filesystem divided by the RAID redundancy of the last
data block group.

These values count different, partially overlapping things, potentially
in different units, so no relation holds between f_blocks, f_bavail
and f_bfree.

> 1) It it would be doing 300 GiB - what is still available, it would do 300-122.99 = 177.01
> 
> 2) If it would add together all allocated within a chunk… 
> 
> 171.98 GiB used in data + 64 KiB used in system + 1,94 GiB used in metadata ~= 174 GiB
> 
> 3) It may consider all allocated system and metadata chunks as lost for writing
> data:
> 
> 171.98 used in date + 32 MiB allocated in system + 5 GiB allocated in metadata ~= 176.98 GiB
> 
> 4) It may consider 2 of those 5 GiB chunks for metadata as reclaimable and
> then it would go like this:

df f_bavail doesn't consider reclaiming anything.  It's strictly "how
many data blocks could we theoretically fallocate in this instant" (and
even that is wrong since fallocate isn't atomic wrt space allocation).
It doesn't run a full simulation of the real allocator behavior.

> 171.98 used in date + 32 MiB allocated in system + 3 GiB metadata ~= 116.98 GiB = 174.98 GiB
> 
> That would be about right, but also as unpredictable as it can get.
> 
> > Inline files count as metadata instead of data, so even when you are
> > out of data blocks (zero blocks free in df), you can sometimes still
> > write small files.  Sometimes, when you write one small file, 1GB of
> > available space disappears as a new metadata block group is allocated.
> > 
> > 'df' doesn't take metadata or data sharing into account at all, or
> > the space required to store csums, or bursty metadata usage workloads.
> > 'df' can't predict these events, so its accuracy is limited to no
> > better than about 0.5% of the size of the filesystem or +/- 1GB,
> > whichever is larger.
> 
> So just assume that df output can be +/- 1 GiB off?

If anything, +/- 1GiB is a _lower_ bound on df estimation error.

df avail is an estimation of how much of a specific type of space resource
(data blocks) is available, based on currently available information,
so some error is expected.  Some error components change over time
and cannot be predicted.  Some of these errors are percentages of free
space, others are multiples of constant values (1GB per disk).  If df
says you have 300GB free, in theory you can write between 284GB and
299GB of data to that filesystem based on various factors (not including
dedupe or compression).  In practice there may be other error components
outside of the limited data model presented here (e.g. system block
group allocation).

If we write data with csums there's a 0.1-0.9% extra overhead depending
on csum algorithm and write sizes.  0.3% of 300GB is 1GB, so filesystem
with 300GB free can only hold 299GB of data with xxhash csums.

A metadata block group is normally 1 GB, and one could be allocated at
any time.  If df reports we have 1.1GB of space, we either have 1.1GB
or 100MB of space for data in reality, and we won't find out which it
is until after we do more than 100MB of writes (i.e. did we run out of
space while doing the write, or not?).

If we write a million 1K files, df available space won't change,
as they'll all be inline files, inline files are stored in metadata,
and statvfs doesn't count metadata in f_bavail.  If we write the next
file, 1 GB or more may be allocated for a new metadata block group
(depends on disk layout).  The average size of each file is 1K (multiplied
by metadata redundancy factor) but each individual file consumes either
0 or 1 GB of space if you compare df available space before and after
writing the file.

If the metadata is raid0 or raid10 (or raid5 or raid6, but don't use
those) then it's possible for a block group to contain more than 1GB
of data.  This multiplies the "1 GB" number across the board, so you
can jump from e.g. 5.1 GB to 0.1 GB at any time on a 5 disk array with
raid0 metadata, or adding 4K to a file could rarely but randomly allocate
5 GB of disk space for metadata.

If we write a million 4K blocks to a single file in random order or with
fsync() between each block, every 75 4K data blocks will come with an
extra 16K metadata block, 213MB total, 5.3%.  If we do that 4 times,
we'll use an extra GB of metadata and probably trigger a metadata block
group allocation.  If we write 4GB of file all at once, there will be
0 or 64K of metadata blocks due to rounding, and df's prediction will
be a closer match to reality (but even that 64K could still trigger a
1GB allocation).  Most workloads fall somewhere in between these extremes.

There are also prediction errors in the other direction.  If data is
overwritten or deleted during a transaction, it is not freed until the end
of the transaction, or even much later with async discard.  Balances and
scrubs can mark entire block groups as temporarily full.  These events
will cause df to temporarily underreport a block group's worth of free
space.  This imposes additional requirements on free-space-triggered
daemons like automatic file reapers--they can overdelete due to temporary
conditions, so they either need hysteresis, long time delay averaging,
or big error tolerances (i.e. they don't care if they're a GB or two
above target).  In these cases, df is not inaccurate--pinned extents
really do make disk space unavailable temporarily--but the reported
value from df is low compared to the number of data blocks that could
actually be allocated.

statvfs f_bfree is a better estimation of how much space is available if
all possible optimizations are performed, since it's "size of all disks
minus size of everything in use."  You'll never get exactly that much
space out of a filesystem, though, due to minimum block group sizes,
global reservations, data copy on write, fragmentation, metadata page
unsharing, and other assorted inefficiencies.

> I am just wondering cause I aimed to explaining this to participants of
> my Linux courses… and for now I have the honest answer that I have
> no clue why df displays "175 GiB" as used.

As a rule of thumb, a filesystem with less than 1GB free per disk is
effectively full, mostly due to that "may allocate extra GB at any
time" behavior.  Even filesystems with less than 10GB or even 100GB
per disk require extra attention to avoid sudden ENOSPC in some cases
and performance degradation due to fragmentation in others.

If the filesytem has more than 100GB unallocated on every disk, no special
attention is required.  Every half-percent of writes consumes an extra
GB, no big deal.

There are some scale factors in btrfs that change in smaller filesystems.
The block group allocation unit gets smaller, so e.g. for a filesystem
that is under 16GB the rule of thumb operates in units of 128MB per
disk instead of 1GB per disk.

Mixed block groups are recommended for tiny filesystems.  Mixed block
groups don't have separate metadata and data, so the 'df' behavior is
much more linear and predictive.

> > > Does this have something to do with that global reserve thing?
> > 
> > 'df' currently tells you nothing about metadata (except in kernels
> > before 5.6, when you run too low on metadata space, f_bavail is
> > abruptly set to zero).  That's about the only impact global reserve
> > has on 'df'.
> 
> But it won't claim used or even just allocated metadata space as available
> for writing data?

Correct.  Metadata space is never counted in df as available for data
(f_bavail).  It is counted in f_bfree (which df uses to calculate "used"),
but f_bfree is a fairly meaningless internal statistic.

If a metadata block group is deleted (e.g. by resize, device delete,
balance, or if it becomes completely empty) then its space will be counted
as available, but not before.  Balances may change the available space in
df by changing on-disk layout so that future allocations become possible
that are not possible with the present on-disk layout (e.g. when a new
empty disk is added to a full raid5 array, initially none of the free
space can be used).  Converting balances can change the filesystem size
in df too, which will change "used" since df used = size - free, sometimes
in strange ways if there are block groups with multiple profiles present.

> > Global reserve is metadata allocated-but-unused space, and all
> > metadata is not visible to df.  The reserve ensures that critical
> > btrfs metadata operations can complete without running out of space,
> > by forcing non-critical long-running operations to commit
> > transactions when no metadata space is available outside the reserved
> > pool.  It mostly works, though there are still a few bugs left that
> > lead to EROFS when metadata runs low.
> 
> Hmmm, thanks.
> 
> But as far as I understood also from the other post, Global Reserve is
> reserved but not reported as used in df?

Global reserve overlaps with metadata.  Some of global reserve inevitably
gets counted in f_bfree (or more correctly f_blocks - f_bfree) because
global reserve blocks are also metadata blocks, and f_bfree is affected
by the number of metadata blocks in use.  Changes in global reserve will
therefore correlate with changes in df "used" output some of the time.

Global reserve isn't a physical region on disk like a metadata or system
block group.  Global reserve is just a block counter in the kernel that
deducts future metadata allocations from the amount of free space that
appears in metadata block groups in the present, so that later allocations
required to commit the transaction are guaranteed to succeed.  The usage
numbers for global reserve and metadata cannot be meaningfully separated.

> I am not sure whether I am getting it though.
> 
> Best,
> -- 
> Martin
> 
> 
