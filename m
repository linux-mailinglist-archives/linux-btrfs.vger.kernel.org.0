Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E51301F4C
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 23:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbhAXWhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 17:37:47 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56420 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbhAXWhl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 17:37:41 -0500
Received: from dread.disaster.area (pa49-180-243-77.pa.nsw.optusnet.com.au [49.180.243.77])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 82C5A3C2E06;
        Mon, 25 Jan 2021 09:36:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l3o07-0022Th-VX; Mon, 25 Jan 2021 09:36:55 +1100
Date:   Mon, 25 Jan 2021 09:36:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <20210124223655.GD4626@dread.disaster.area>
References: <20210121222051.GB4626@dread.disaster.area>
 <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=juxvdbeFDU67v5YkIhU0sw==:117 a=juxvdbeFDU67v5YkIhU0sw==:17
        a=IkcTkHD0fZMA:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=k_XUTv7eyTzayb0ePFUA:9 a=WcPEqHpdf70jJhO-:21 a=-IhdhKC_e0Obngm1:21
        a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 23, 2021 at 04:42:33PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/1/22 上午6:20, Dave Chinner wrote:
> > Hi btrfs-gurus,
> > 
> > I'm running a simple reflink/snapshot/COW scalability test at the
> > moment. It is just a loop that does "fio overwrite of 10,000 4kB
> > random direct IOs in a 4GB file; snapshot" and I want to check a
> > couple of things I'm seeing with btrfs. fio config file is appended
> > to the email.
> > 
> > Firstly, what is the expected "space amplification" of such a
> > workload over 1000 iterations on btrfs? This will write 40GB of user
> > data, and I'm seeing btrfs consume ~220GB of space for the workload
> > regardless of whether I use subvol snapshot or file clones
> > (reflink).  That's a space amplification of ~5.5x (a lot!) so I'm
> > wondering if this is expected or whether there's something else
> > going on. XFS amplification for 1000 iterations using reflink is
> > only 1.4x, so 5.5x seems somewhat excessive to me.
> 
> This is mostly due to the way btrfs handles COW and the lazy extent
> freeing behavior.
> 
> For btrfs, an extent only get freed when there is no reference on any
> part of it, and
> 
> This means, if we have an file which has one 128K file extent written to
> disk, and then write 4K, which will be COWed to another 4K extent, the
> 128K extent is still kept as is, even the no longer referred 4K range is
> still kept there, with extra 4K space usage.

That's not relevant to the workload I'm running. Once it reaches
steady state, it's just doing 4kB overwrites of shared 4kB extents.

> Thus above reflink/snapshot + DIO write is going to be very unfriendly
> for fs with lazy extent freeing and default data COW behavior.

I'm not freeing any extents at all. I haven't even got to running
the parts of the tests where I remove random snapshots/reflink files
to measure the impact of decreasing reference counts. THis test just
looks at increasing reference counts and COW overwrite performance.

> That's also why btrfs has a worse fragmentation problem.

Every other filesystem I've tested is fragmenting the reflink files
to the same level. btrfs is not fragmenting the file any worse than
the others - the workload is intended to fragment the file into a
million individual 4kB extents and then keep overwriting and
snapshotting to examine how the filesystem structures age under such
workloads.

> > On a similar note, the IO bandwidth consumed by btrfs is way out of
> > proportion with the amount of user data being written. I'm seeing
> > multiple GBs being written by btrfs on every iteration - easily
> > exceeding 5GB of writes per cycle in the later iterations of the
> > test. Given that only 40MB of user data is being written per cycle,
> > there's a write amplification factor of well over 100x ocurring
> > here. In comparison, XFS is writing roughly consistently at 80MB/s
> > to disk over the course of the entire workload, largely because of
> > journal traffic for the transactions run during COW and clone
> > operations.  Is such a huge amount of of IO expected for btrfs in
> > this situation?
> 
> That's interesting. Any analyse on the type of bios submitted for the
> device?

No, and I don't actually care because it's not relevant to what
I'm trying to understand. I've given you enough information to
reproduce the behaviour if you want to analyse it yourself.

> > Next, subvol snapshot and clone time appears to be scale with the
> > number of snapshots/clones already present. The initial clone/subvol
> > snapshot command take a few milliseconds. At 50 snapshots it take
> > 1.5s. At 200 snapshots it takes 7.5s. At 500 it takes 15s and at
> > > 850 it seems to level off at about 30s a snapshot. There are
> > outliers that take double this time (63s was the longest) and the
> > variation between iterations can be quite substantial. Is this
> > expected scalablity?
> 
> The snapshot will make the current subvolume to be fully committed
> before really taking the snapshot.
> 
> Considering above metadata overhead, I believe most of the performance
> penalty should come from the metadata writeback, not the snapshot
> creation itself.
> 
> If you just create a big subvolume, sync the fs, and try to take as many
> snapshot as you wish, the overhead should be pretty the same as
> snapshotting an empty subvolume.

The fio workload runs fsync at the end of the overwrite, which means
all the writes and the metadata needed to reference it *must* be on
stable storage. Everything else is snapshot overhead, whether it be
the freeze of the filesystem in the case of dm-thin snapshots or
xfs-on-loopback-with-reflink-snapshots, of the internal sync that
btrfs does so that the snapshot produces a consistent snapshot
image...

> > On subvol snapshot execution, there appears to be a bug manifesting
> > occasionally and may be one of the reasons for things being so
> > variable. The visible manifestation is that every so often a subvol
> > snapshot takes 0.02s instead of the multiple seconds all the
> > snapshots around it are taking:
> 
> That 0.02s the real overhead for snapshot creation.
> 
> The short snapshot creation time means those snapshot creation just wait
> for the same transaction to be committed, thus they don't need to wait
> for the full transaction committment, just need to do the snapshot.

That doesn't explain why fio sometimes appears to be running much
slower than at other times. Maybe this implies a fsync() bug w.r.t.
DIO overwrites and that btrfs should always be running the fio
worklaod at 500-1000 iops and snapshots should always run at 0.02s

IOWs, the problem here is the inconsistent behaviour: the workload
is deterministic and repeats in exactly the same way every time, so
the behaviour of the filesystem should be the same for every single
iteration. Snapshot should either always take 0.02s and fio is
really slow, or fio should be fast and the snapshot really slow
because the snapshot has wider "metadata on stable storage"
requirements than fsync. The workload should not be swapping
randomly between the two behaviours....

> [...]
> 
> > In these instances, fio takes about as long as I would expect the
> > snapshot to have taken to run. Regardless of the cause, something
> > looks to be broken here...
> > 
> > An astute reader might also notice that fio performance really drops
> > away quickly as the number of snapshots goes up. Loop 0 is the "no
> > snapshots" performance. By 10 snapshots, performance is half the
> > no-snapshot rate. By 50 snapshots, performance is a quarter of the
> > no-snapshot peroframnce. It levels out around 6-7000 IOPS, which is
> > about 15% of the non-snapshot performance. Is this expected
> > performance degradation as snapshot count increases?
> 
> No, this is mostly due to the exploding amount of metadata caused by the
> near-worst case workload.
> 
> Yeah, btrfs is pretty bad at handling small dio writes, which can easily
> explode the metadata usage.
> 
> Thus for such dio case, we recommend to use preallocated file +
> nodatacow, so that we won't create new extents (unless snapshot is
> involved).

Big picture. This is an accelerated aging test, not a prodcution
workload. Telling me how to work around the problems associated with
4kB overwrite (as if I don't already know about nodatacow and all
the functionality you lose by enabling it!) doesn't make the
problems with increasing snapshot counts that I'm exposing go away.

I'm interesting in knowing how btrfs scales and performs with large
reflink/snapshot counts - I explicitly chose 4kB DIO overwrite as
the fastest method of exposing such scalability issues because I
know exactly how bad this is for the COW algorithms all current
snapshot/reflink technologies implement.

Please don't shoot the messenger because you think the workload is
unrealistic - it simply indicates that you haven't understood the
goal of the test worklaod I am running.

Accelerating aging involves using unfriendly workloads to push the
filesystem into bad places in minutes instead of months or years.
It is not a production workload that needs optimising - if anything,
I need to make it even more aggressive and nasty, because it's just
not causing XFS reflinks any serious scalability problems at all...

> > Oh, I almost forget - FIEMAP performance. After the reflink test, I
> > map all the extents in all the cloned files to a) count the extents
> > and b) confirm that the difference between clones is correct (~10000
> > extents not shared with the previous iteration). Pulling the extent
> > maps out of XFS takes about 3s a clone (~850,000 extents), or 30
> > minutes for the whole set when run serialised. btrfs takes 90-100s
> > per clone - after 8 hours it had only managed to map 380 files and
> > was running at 6-7000 read IOPS the entire time. IOWs, it was taking
> > _half a million_ read IOs to map the extents of a single clone that
> > only had a million extents in it. Is it expected that FIEMAP is so
> > slow and IO intensive on cloned files?
> 
> Exploding fragments, definitely needs a lot of metadata read, right?

Well, at 1000 files, XFS does zero metadata read IO because the
extent lists for all 1000 snapshots easily fit in RAM - about 2GB of
RAM is needed, and that's the entire per-inode memory overhead of
the test. Hence when the fiemap cycle starts, it just pulls all this
from RAM and we do zero metadata read IO.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
