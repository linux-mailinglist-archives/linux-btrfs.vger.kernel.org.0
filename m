Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7B0309093
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 00:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhA2X1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 18:27:23 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43928 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhA2X1N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 18:27:13 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D49F99610BD; Fri, 29 Jan 2021 18:25:50 -0500 (EST)
Date:   Fri, 29 Jan 2021 18:25:50 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <20210129232550.GA32440@hungrycats.org>
References: <20210121222051.GB4626@dread.disaster.area>
 <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
 <20210124223655.GD4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210124223655.GD4626@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 25, 2021 at 09:36:55AM +1100, Dave Chinner wrote:
> On Sat, Jan 23, 2021 at 04:42:33PM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2021/1/22 上午6:20, Dave Chinner wrote:
> > > Hi btrfs-gurus,
> > > 
> > > I'm running a simple reflink/snapshot/COW scalability test at the
> > > moment. It is just a loop that does "fio overwrite of 10,000 4kB
> > > random direct IOs in a 4GB file; snapshot" and I want to check a
> > > couple of things I'm seeing with btrfs. fio config file is appended
> > > to the email.
> > > 
> > > Firstly, what is the expected "space amplification" of such a
> > > workload over 1000 iterations on btrfs? This will write 40GB of user
> > > data, and I'm seeing btrfs consume ~220GB of space for the workload
> > > regardless of whether I use subvol snapshot or file clones
> > > (reflink).  That's a space amplification of ~5.5x (a lot!) so I'm
> > > wondering if this is expected or whether there's something else
> > > going on. XFS amplification for 1000 iterations using reflink is
> > > only 1.4x, so 5.5x seems somewhat excessive to me.

Each iteration produces a little under 80MB of metadata (the forward
and backward refs are pretty big compared to the size of 4K data blocks,
a little under 10% of the size).  You're writing randomly over 0.3% of
the subvol (4GB / 40MB = about 1%, plus or minus random) so each snapshot
unshares most of its metadata pages and degenerates into reflink copies.
That works out to a little under 80GB of metadata by the time the 1000
snapshots are created.

If you have dup metadata, multiply metadata size by 2.  Add the original
44GB of data (the extra 4G is because of prealloc) to the metadata size
assuming dup, and there's 204GB, not too far away from 220.

> > This is mostly due to the way btrfs handles COW and the lazy extent
> > freeing behavior.
> > 
> > For btrfs, an extent only get freed when there is no reference on any
> > part of it, and
> > 
> > This means, if we have an file which has one 128K file extent written to
> > disk, and then write 4K, which will be COWed to another 4K extent, the
> > 128K extent is still kept as is, even the no longer referred 4K range is
> > still kept there, with extra 4K space usage.
> 
> That's not relevant to the workload I'm running. Once it reaches
> steady state, it's just doing 4kB overwrites of shared 4kB extents.

Actually it is relevant, because that's _not_ what your workload is doing.

Despite having 'prealloc=0' in fio_config, fio preallocates the testfile.
That triggers btrfs's preallocation behavior for datacow extents: every
unshared block is written in place, inside the original 128MB prealloc
extents.  The writes to snapshots are creating shared references to
these blocks within the original extents, instead of creating separate
physical extents with unshared references.  Once the blocks contain data,
an overwrite will create a separate physical extent, but that applies
only when a previously written block is overwritten, and that doesn't
start happening in large numbers until later in the test.

So you are not creating a million 4K extents with an average of just
under 500 refs each (1 to 1000 snapshots minus some that get overwritten
at random).  You are creating 32 128M extents, with an average of around
16 million shared references each (32768 reflinks * 500 snapshots on
average, minus a little for random overlap).

By the time you look at these extents with FIEMAP, FIEMAP is stuck
potentially running tens of trillions of iterations trying to fill in
the "SHARED" bit for millions of extents.

Also, because you're doing prealloc on a datacow file, you are taking
a hit to calculate the block sharing on the writes, too.  Every write
that lands on the prealloc extent has to check to see if the written
block overlaps any other written block in the same extent, and that's
a shared reference check.  Overwrites don't need this check, so
performance might level out or even get better toward the end of the
test as the number of references to the original 128M extents starts to
fall off.

The same thing happens with reflink copies, except that the nested loop
over the 500 * 32768 extent refs to detect sharing moves some parts to
the inner loop (with deeper metadata tree walks) and some to the outer
loop when there are snapshots.  It'll affect the timing of FIEMAP and
the prealloc writes.

IMHO, PREALLOC should be ignored for all datacow files on btrfs.  It can't
do things people expect with a datacow file (in particular the ENOSPC
guarantee is only possible for the first write), and it does a bunch of
expensive, counterintuitive stuff that people don't expect.

PREALLOC is useful for nodatacow files and does implement expected
behavior, but it should only be used on those.

> > Thus above reflink/snapshot + DIO write is going to be very unfriendly
> > for fs with lazy extent freeing and default data COW behavior.
> 
> I'm not freeing any extents at all. I haven't even got to running
> the parts of the tests where I remove random snapshots/reflink files
> to measure the impact of decreasing reference counts. THis test just
> looks at increasing reference counts and COW overwrite performance.
> 
> > That's also why btrfs has a worse fragmentation problem.
> 
> Every other filesystem I've tested is fragmenting the reflink files
> to the same level. btrfs is not fragmenting the file any worse than
> the others - the workload is intended to fragment the file into a
> million individual 4kB extents and then keep overwriting and
> snapshotting to examine how the filesystem structures age under such
> workloads.
> 
> > > On a similar note, the IO bandwidth consumed by btrfs is way out of
> > > proportion with the amount of user data being written. I'm seeing
> > > multiple GBs being written by btrfs on every iteration - easily
> > > exceeding 5GB of writes per cycle in the later iterations of the
> > > test. Given that only 40MB of user data is being written per cycle,
> > > there's a write amplification factor of well over 100x ocurring
> > > here. In comparison, XFS is writing roughly consistently at 80MB/s
> > > to disk over the course of the entire workload, largely because of
> > > journal traffic for the transactions run during COW and clone
> > > operations.  Is such a huge amount of of IO expected for btrfs in
> > > this situation?
> > 
> > That's interesting. Any analyse on the type of bios submitted for the
> > device?
> 
> No, and I don't actually care because it's not relevant to what
> I'm trying to understand. I've given you enough information to
> reproduce the behaviour if you want to analyse it yourself.
> 
> > > Next, subvol snapshot and clone time appears to be scale with the
> > > number of snapshots/clones already present. The initial clone/subvol
> > > snapshot command take a few milliseconds. At 50 snapshots it take
> > > 1.5s. At 200 snapshots it takes 7.5s. At 500 it takes 15s and at
> > > > 850 it seems to level off at about 30s a snapshot. There are
> > > outliers that take double this time (63s was the longest) and the
> > > variation between iterations can be quite substantial. Is this
> > > expected scalablity?
> > 
> > The snapshot will make the current subvolume to be fully committed
> > before really taking the snapshot.
> > 
> > Considering above metadata overhead, I believe most of the performance
> > penalty should come from the metadata writeback, not the snapshot
> > creation itself.
> > 
> > If you just create a big subvolume, sync the fs, and try to take as many
> > snapshot as you wish, the overhead should be pretty the same as
> > snapshotting an empty subvolume.
> 
> The fio workload runs fsync at the end of the overwrite, which means
> all the writes and the metadata needed to reference it *must* be on
> stable storage. 

That is not how btrfs fsync works, and your assertions that follow from
this misunderstanding are also wrong.

fsync doesn't make the delayed refs update queue smaller.  It might
even make the queue bigger, by moving dealloc writes that would have
been deferred to the next transaction into the current transaction.

btrfs fsync flushes out the data blocks to disk, then it writes journal
commands that say "create a file, point an extent record at those data
blocks, reflink the extent into the file" to the log tree, then it returns
to the user.  All the metadata reference updates for those data blocks
are left for the following btrfs transaction to commit to the filesystem
trees in the background.  If there is a crash, the following mount reads
the log tree and requeues the metadata updates in memory, so persistence
is achieved.  After each commit is finished, the log tree is discarded.

The goal is that the caller of fsync() doesn't have to wait for the whole
filesystem tree to be committed.  The caller only pays the cost to have
the specific parts of the tree they care about persisted.

In your workload, the fsync() doesn't do anything useful--it flushes
out a few MB of data blocks and a breadcrumb trail of journal commands.
When you call snapshot create, everything that was previously deferred
has to be turned into a concrete filesystem tree, both data and metadata.
The snapshot create is paying for all the work fsync() avoided.

In the rare cases where fsync() happens to run at the same time as a
transaction commit (or maybe just before), the transaction commit and
the fsync() get synchronized by trying to touch the same locks, and
return at close to the same time.  In those cases, the snapshot only
has to write out a new subvol root and some free space map changes,
which takes 0.02s.

> Everything else is snapshot overhead, whether it be
> the freeze of the filesystem in the case of dm-thin snapshots or
> xfs-on-loopback-with-reflink-snapshots, of the internal sync that
> btrfs does so that the snapshot produces a consistent snapshot
> image...
> 
> > > On subvol snapshot execution, there appears to be a bug manifesting
> > > occasionally and may be one of the reasons for things being so
> > > variable. The visible manifestation is that every so often a subvol
> > > snapshot takes 0.02s instead of the multiple seconds all the
> > > snapshots around it are taking:
> > 
> > That 0.02s the real overhead for snapshot creation.
> > 
> > The short snapshot creation time means those snapshot creation just wait
> > for the same transaction to be committed, thus they don't need to wait
> > for the full transaction committment, just need to do the snapshot.
> 
> That doesn't explain why fio sometimes appears to be running much
> slower than at other times. Maybe this implies a fsync() bug w.r.t.
> DIO overwrites and that btrfs should always be running the fio
> worklaod at 500-1000 iops and snapshots should always run at 0.02s
> 
> IOWs, the problem here is the inconsistent behaviour: the workload
> is deterministic and repeats in exactly the same way every time, so
> the behaviour of the filesystem should be the same for every single
> iteration. Snapshot should either always take 0.02s and fio is
> really slow, or fio should be fast and the snapshot really slow
> because the snapshot has wider "metadata on stable storage"
> requirements than fsync. The workload should not be swapping
> randomly between the two behaviours....

There is a transaction commit on a periodic timer, every 30 seconds
by default.  If it doesn't compete for locks and block the fio process,
it will at least compete for disk bandwidth and slow it down.  The amount
of work the snapshot create has to do in your test case is dominated by
the amount of delayed ref work queued up between the end of the previous
periodic commit and the start of the snapshot create (your metadata
outnumbers your data by 4 to 1).  This timing will be nondeterministic
in your test setup.

If you mount with -o commit=999999999 (or some sufficiently large value)
then you'll get more determinism, as all the transaction commits will
then be triggered by memory pressure and your snapshot creates.

> > [...]
> > 
> > > In these instances, fio takes about as long as I would expect the
> > > snapshot to have taken to run. Regardless of the cause, something
> > > looks to be broken here...
> > > 
> > > An astute reader might also notice that fio performance really drops
> > > away quickly as the number of snapshots goes up. Loop 0 is the "no
> > > snapshots" performance. By 10 snapshots, performance is half the
> > > no-snapshot rate. By 50 snapshots, performance is a quarter of the
> > > no-snapshot peroframnce. It levels out around 6-7000 IOPS, which is
> > > about 15% of the non-snapshot performance. Is this expected
> > > performance degradation as snapshot count increases?

Performance immediately following a snapshot is expected to degrade as
the number of distinct parent or child pages referenced by a metadata
page increases.  This is not the same thing as snapshot count.

Your test is causing both to increase at the same time, and also keeping
the testfile in the "immediately following a snapshot" state.

If you have 1000 snapshots and your writes have high metadata locality
(e.g. you are appending to a single log file in each snapshot) then
the write multipliers are very close to 1.0x.  If you have low metadata
locality, even one snapshot will be followed by a big write multiplication
burst.

> > No, this is mostly due to the exploding amount of metadata caused by the
> > near-worst case workload.

Every 2 orders of magnitude more metadata items increases the O(log(N))
costs of btrfs by one unit.  By 50 snapshots or reflinks you have hundreds
of millions of metadata items, it's 6x slower and not increasing very
much any more...not too far off what we'd expect.

One problem with this theory is that we'd expect the same behavior for
reflinks too, so it might not be correct.

> > Yeah, btrfs is pretty bad at handling small dio writes, which can easily
> > explode the metadata usage.
> > 
> > Thus for such dio case, we recommend to use preallocated file +
> > nodatacow, so that we won't create new extents (unless snapshot is
> > involved).
> 
> Big picture. This is an accelerated aging test, not a prodcution
> workload. Telling me how to work around the problems associated with
> 4kB overwrite (as if I don't already know about nodatacow and all
> the functionality you lose by enabling it!) doesn't make the
> problems with increasing snapshot counts that I'm exposing go away.

I'm familiar with this workload.  I've been running something similar to
your target workload since 2014.  We build NAS backup appliance boxes:
each has about 100 client subvols ranging in size from 1GB to 10TB,
thousands to millions of files each, 1-5% daily turnover.

Multiple snapshots per hour at this scale is a really ambitious target
for btrfs.  We can theoretically do somewhere between 15 and 180 snapshot
rotates per day before the machine starts falling behind on the deletes
and running out of space.  Snapshot create and delete on btrfs come
with giant unbounded latency spikes, so we don't run them all the time.
We'll create snapshots any time a client finishes an update, but we only
delete old snapshots to recover disk space during a 3-hour maintenance
window.

While the snapshot rotates are happening, btrfs leaves CPU cores and
disks idle.  Current performance is far from the theoretical limits.

There is some active development in this area, especially in the last
year.  Several improvements happened in 2020, including a few silly bug
fixes of the form "don't make two threads fight each other for locks"
and "don't forget to wake up some important background process because
we optimized away some trigger event it was waiting for."

> I'm interesting in knowing how btrfs scales and performs with large
> reflink/snapshot counts - I explicitly chose 4kB DIO overwrite as
> the fastest method of exposing such scalability issues because I
> know exactly how bad this is for the COW algorithms all current
> snapshot/reflink technologies implement.
> 
> Please don't shoot the messenger because you think the workload is
> unrealistic - it simply indicates that you haven't understood the
> goal of the test worklaod I am running.
> 
> Accelerating aging involves using unfriendly workloads to push the
> filesystem into bad places in minutes instead of months or years.
> It is not a production workload that needs optimising - if anything,
> I need to make it even more aggressive and nasty, because it's just
> not causing XFS reflinks any serious scalability problems at all...
> 
> > > Oh, I almost forget - FIEMAP performance. After the reflink test, I
> > > map all the extents in all the cloned files to a) count the extents
> > > and b) confirm that the difference between clones is correct (~10000
> > > extents not shared with the previous iteration). Pulling the extent
> > > maps out of XFS takes about 3s a clone (~850,000 extents), or 30
> > > minutes for the whole set when run serialised. btrfs takes 90-100s
> > > per clone - after 8 hours it had only managed to map 380 files and
> > > was running at 6-7000 read IOPS the entire time. IOWs, it was taking
> > > _half a million_ read IOs to map the extents of a single clone that
> > > only had a million extents in it. Is it expected that FIEMAP is so
> > > slow and IO intensive on cloned files?
> > 
> > Exploding fragments, definitely needs a lot of metadata read, right?
> 
> Well, at 1000 files, XFS does zero metadata read IO because the
> extent lists for all 1000 snapshots easily fit in RAM - about 2GB of
> RAM is needed, and that's the entire per-inode memory overhead of
> the test. Hence when the fiemap cycle starts, it just pulls all this
> from RAM and we do zero metadata read IO.

If, before you start the test, you run 'truncate -s 4g testfile', so
that fio doesn't preallocate the file, things behave somewhat better,
though "better" for 80GB of metadata is still pretty awful.

If I run the test without the prealloc, filefrag takes about 4.5 seconds
to iterate 1044066 extents from a cold cache, and does 10 snapshot files
in 1.6 seconds with a warm cache (32 seconds from cold).

The sheer size of the metadata does prevent the whole thing from being
cached in RAM, at least on a 32G machine.

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
