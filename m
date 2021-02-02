Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD630B3F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 01:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhBBAO2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 19:14:28 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:50786 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231219AbhBBAO1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 19:14:27 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id A97FE110256;
        Tue,  2 Feb 2021 11:13:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l6jK2-0054Zy-Oc; Tue, 02 Feb 2021 11:13:34 +1100
Date:   Tue, 2 Feb 2021 11:13:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <20210202001334.GJ4626@dread.disaster.area>
References: <20210121222051.GB4626@dread.disaster.area>
 <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
 <20210124223655.GD4626@dread.disaster.area>
 <20210129232550.GA32440@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210129232550.GA32440@hungrycats.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=IkcTkHD0fZMA:10 a=qa6Q16uM49sA:10 a=7-415B0cAAAA:8
        a=60dAR7PMznLgQXSNQiMA:9 a=lLNgXvEriVyIiN2-:21 a=uS_bIDlN39Fwrznf:21
        a=QEXdDO2ut3YA:10 a=O9AXEBkhxAUA:10 a=s60lmKuYGeEA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 29, 2021 at 06:25:50PM -0500, Zygo Blaxell wrote:
> On Mon, Jan 25, 2021 at 09:36:55AM +1100, Dave Chinner wrote:
> > On Sat, Jan 23, 2021 at 04:42:33PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/1/22 上午6:20, Dave Chinner wrote:
> > > > Hi btrfs-gurus,
> > > > 
> > > > I'm running a simple reflink/snapshot/COW scalability test at the
> > > > moment. It is just a loop that does "fio overwrite of 10,000 4kB
> > > > random direct IOs in a 4GB file; snapshot" and I want to check a
> > > > couple of things I'm seeing with btrfs. fio config file is appended
> > > > to the email.
> > > > 
> > > > Firstly, what is the expected "space amplification" of such a
> > > > workload over 1000 iterations on btrfs? This will write 40GB of user
> > > > data, and I'm seeing btrfs consume ~220GB of space for the workload
> > > > regardless of whether I use subvol snapshot or file clones
> > > > (reflink).  That's a space amplification of ~5.5x (a lot!) so I'm
> > > > wondering if this is expected or whether there's something else
> > > > going on. XFS amplification for 1000 iterations using reflink is
> > > > only 1.4x, so 5.5x seems somewhat excessive to me.
> 
> Each iteration produces a little under 80MB of metadata (the forward
> and backward refs are pretty big compared to the size of 4K data blocks,
> a little under 10% of the size).  You're writing randomly over 0.3% of
> the subvol (4GB / 40MB = about 1%, plus or minus random) so each snapshot
> unshares most of its metadata pages and degenerates into reflink copies.
> That works out to a little under 80GB of metadata by the time the 1000
> snapshots are created.
> 
> If you have dup metadata, multiply metadata size by 2.  Add the original
> 44GB of data (the extra 4G is because of prealloc) to the metadata size
> assuming dup, and there's 204GB, not too far away from 220.
> 
> > > This is mostly due to the way btrfs handles COW and the lazy extent
> > > freeing behavior.
> > > 
> > > For btrfs, an extent only get freed when there is no reference on any
> > > part of it, and
> > > 
> > > This means, if we have an file which has one 128K file extent written to
> > > disk, and then write 4K, which will be COWed to another 4K extent, the
> > > 128K extent is still kept as is, even the no longer referred 4K range is
> > > still kept there, with extra 4K space usage.
> > 
> > That's not relevant to the workload I'm running. Once it reaches
> > steady state, it's just doing 4kB overwrites of shared 4kB extents.
> 
> Actually it is relevant, because that's _not_ what your workload is doing.
> 
> Despite having 'prealloc=0' in fio_config, fio preallocates the testfile.

I'm using fallocate=none, so preallocation uses write(), not
fallocate() to preallocation unwritten extents. I explicitly chose
this so that there was no interactions with unwritten extents in the
workload and it therefore is a pure overwrite test.

strace output of fio laying out the base file in iteration 0 before
any overwrites are done:

155715 unlink("/mnt/scr/testdir/testfile") = -1 ENOENT (No such file or directory)
155715 openat(AT_FDCWD, "/mnt/scr/testdir/testfile", O_WRONLY|O_CREAT|O_TRUNC, 0644) = 5
155715 ftruncate(5, 4294967296)         = 0
155715 write(5, "\37\256\233\346J EH\303\365\303\205\2730\374\37\270\376\326u5\3036\17\327\337^/{\35T\t"..., 4096) = 4096
155715 write(5, "\341\7\3477j\36,\30\374`\f\303\331g\267\6\37\214\343\7u\v\316\4\203\361\354\332|=\370\23"..., 4096) = 4096
155715 write(5, "\250\241\264\10\27\375*\0275\224B\220H\333\361\5\206\322\355\307G\363L\27P\272\272\17r\272o\1"..., 4096) = 4096
155715 write(5, "\261P=\300\371\303fN\26*\257\217`\370f\4B\345\352|4\227v\35\250\\\374\34q\224b\24"..., 4096) = 4096
155715 write(5, "\222Z\340\254\335\37R,R\vS\210\213m\31\23jaa\353\207i[\16-,\267L\200wm\4"..., 4096) = 4096
....
155715 write(5, "z\306bv\3\322$>\317X\217\v\17\337\230\25\31k\n5\32\226\24\31c\315\24\21>x\204\23"..., 4096) = 4096
155715 write(5, "\215w\352\252FN\332b\361\316\226\231S\364\322\n\336Y\272\v\277\221\207\7;K\210\264Zl\243\r"..., 4096) = 4096
155715 write(5, "`\201Qe\331L$\5,0\372k\362\326\327\v\5Fi5\341\3045\f\300\250\252\203\347\35\371\v"..., 4096) = 4096
155715 fsync(5 <unfinished ...>
....
155715 <... fsync resumed> )            = 0
155715 fadvise64(5, 0, 4294967296, POSIX_FADV_DONTNEED <unfinished ...>
....
155715 <... fadvise64 resumed> )        = 0
155715 close(5)                         = 0
....
155715 stat("/mnt/scr/testdir/testfile", {st_mode=S_IFREG|0644, st_size=4294967296, ...}) = 0

> That triggers btrfs's preallocation behavior for datacow extents: every
> unshared block is written in place, inside the original 128MB prealloc
> extents.

I still think this is irrelevant, because there are no preallocated
extents created by fio. Hence this whole analysis based on the
initial file being laid out with preallocated unwritten extents
looks wrong to me, unless btrfs is shooting itself in the foot and
doing preallocation of unwritten space behind the scenes for
sequential writes into a sparse file.

> So you are not creating a million 4K extents with an average of just
> under 500 refs each (1 to 1000 snapshots minus some that get overwritten
> at random).  You are creating 32 128M extents, with an average of around
> 16 million shared references each (32768 reflinks * 500 snapshots on
> average, minus a little for random overlap).
> 
> By the time you look at these extents with FIEMAP, FIEMAP is stuck
> potentially running tens of trillions of iterations trying to fill in
> the "SHARED" bit for millions of extents.

Yup, that's pretty bad. Is there any plan to fix this?

> Also, because you're doing prealloc on a datacow file, you are
> taking a hit to calculate the block sharing on the writes, too.
> Every write that lands on the prealloc extent has to check to see
> if the written block overlaps any other written block in the same
> extent, and that's a shared reference check.  Overwrites don't
> need this check, so performance might level out or even get better
> toward the end of the test as the number of references to the
> original 128M extents starts to fall off.
> 
> The same thing happens with reflink copies, except that the nested
> loop over the 500 * 32768 extent refs to detect sharing moves some
> parts to the inner loop (with deeper metadata tree walks) and some
> to the outer loop when there are snapshots.  It'll affect the
> timing of FIEMAP and the prealloc writes.
> 
> IMHO, PREALLOC should be ignored for all datacow files on btrfs.
> It can't do things people expect with a datacow file (in
> particular the ENOSPC guarantee is only possible for the first
> write), and it does a bunch of
> expensive, counterintuitive stuff that people don't expect.

So what you are saying is that preallocated extents in btrfs are
compromised from an architectural POV and are largely
unfixable?

> PREALLOC is useful for nodatacow files and does implement expected
> behavior, but it should only be used on those.

Yeah, that's not an option for general use filesystems
that run applications that use fallocate() for preallocation and the
user either doesn't know about it or cannot turn it off.

> > > > Next, subvol snapshot and clone time appears to be scale with the
> > > > number of snapshots/clones already present. The initial clone/subvol
> > > > snapshot command take a few milliseconds. At 50 snapshots it take
> > > > 1.5s. At 200 snapshots it takes 7.5s. At 500 it takes 15s and at
> > > > > 850 it seems to level off at about 30s a snapshot. There are
> > > > outliers that take double this time (63s was the longest) and the
> > > > variation between iterations can be quite substantial. Is this
> > > > expected scalablity?
> > > 
> > > The snapshot will make the current subvolume to be fully committed
> > > before really taking the snapshot.
> > > 
> > > Considering above metadata overhead, I believe most of the performance
> > > penalty should come from the metadata writeback, not the snapshot
> > > creation itself.
> > > 
> > > If you just create a big subvolume, sync the fs, and try to take as many
> > > snapshot as you wish, the overhead should be pretty the same as
> > > snapshotting an empty subvolume.
> > 
> > The fio workload runs fsync at the end of the overwrite, which means
> > all the writes and the metadata needed to reference it *must* be on
> > stable storage. 
> 
> That is not how btrfs fsync works, and your assertions that follow from
> this misunderstanding are also wrong.

I suspect you misunderstand what I said.

"metadata on stable storage" for a journalling filesystem means
"stable in the journal", not at it's final resting place. I'll snip
your description of the btrfs fsync journal because I know that
btrfs does this and why it was implmented the way it was and not the
way WAFL or ZFS solved the same "COW metadata is expensive
for fsync()" problem...

> In your workload, the fsync() doesn't do anything useful--it flushes
> out a few MB of data blocks and a breadcrumb trail of journal commands.
> When you call snapshot create, everything that was previously deferred
> has to be turned into a concrete filesystem tree, both data and metadata.
> The snapshot create is paying for all the work fsync() avoided.

Yup that's the same as other filesystems. in the case of XFS, a
filesystem freeze before a device snapshot performs the metadata
writeback.


> In the rare cases where fsync() happens to run at the same time as a
> transaction commit (or maybe just before), the transaction commit and
> the fsync() get synchronized by trying to touch the same locks, and
> return at close to the same time.  In those cases, the snapshot only
> has to write out a new subvol root and some free space map changes,
> which takes 0.02s.

Ok, so there are internal transaction commit/metadata COW lock-step
conflicts in btrfs? I'm guessing that they can hit anything that
runs fsync() and at any time? i.e. non-deterministic long tail
latencies can hit at any time?

> > > The short snapshot creation time means those snapshot creation just wait
> > > for the same transaction to be committed, thus they don't need to wait
> > > for the full transaction committment, just need to do the snapshot.
> > 
> > That doesn't explain why fio sometimes appears to be running much
> > slower than at other times. Maybe this implies a fsync() bug w.r.t.
> > DIO overwrites and that btrfs should always be running the fio
> > worklaod at 500-1000 iops and snapshots should always run at 0.02s
> > 
> > IOWs, the problem here is the inconsistent behaviour: the workload
> > is deterministic and repeats in exactly the same way every time, so
> > the behaviour of the filesystem should be the same for every single
> > iteration. Snapshot should either always take 0.02s and fio is
> > really slow, or fio should be fast and the snapshot really slow
> > because the snapshot has wider "metadata on stable storage"
> > requirements than fsync. The workload should not be swapping
> > randomly between the two behaviours....
> 
> There is a transaction commit on a periodic timer, every 30 seconds
> by default.  If it doesn't compete for locks and block the fio process,
> it will at least compete for disk bandwidth and slow it down.  The amount
> of work the snapshot create has to do in your test case is dominated by
> the amount of delayed ref work queued up between the end of the previous
> periodic commit and the start of the snapshot create (your metadata
> outnumbers your data by 4 to 1).  This timing will be nondeterministic
> in your test setup.
> 
> If you mount with -o commit=999999999 (or some sufficiently large value)
> then you'll get more determinism, as all the transaction commits will
> then be triggered by memory pressure and your snapshot creates.

I doubt that aggregating more changes in memory will improve
determinism. Sure, it might delay the interference for some time,
but then the machine will eventually be out of memory. That can be
trigger by a user allocation and so the user will now complain about
long application stalls due to kernel memory reclaim....

Besides, I'm not trying to tune out bad behaviours - I'm trying to
learn where the bad behaviours lie and how easy they are to
trigger...

> > > > In these instances, fio takes about as long as I would expect the
> > > > snapshot to have taken to run. Regardless of the cause, something
> > > > looks to be broken here...
> > > > 
> > > > An astute reader might also notice that fio performance really drops
> > > > away quickly as the number of snapshots goes up. Loop 0 is the "no
> > > > snapshots" performance. By 10 snapshots, performance is half the
> > > > no-snapshot rate. By 50 snapshots, performance is a quarter of the
> > > > no-snapshot peroframnce. It levels out around 6-7000 IOPS, which is
> > > > about 15% of the non-snapshot performance. Is this expected
> > > > performance degradation as snapshot count increases?
> 
> Performance immediately following a snapshot is expected to degrade as
> the number of distinct parent or child pages referenced by a metadata
> page increases.  This is not the same thing as snapshot count.
> 
> Your test is causing both to increase at the same time, and also keeping
> the testfile in the "immediately following a snapshot" state.

Of course it does this - I'm compressing the time for all the
overwrites down from minutes or hours into seconds. It doesn't
change the amount of COW or metadata that needs to be updated if the
writes are spread out over 10 minutes or an hour, it just means the
metadata updates are less of a limiting factor.

> If you have 1000 snapshots and your writes have high metadata locality
> (e.g. you are appending to a single log file in each snapshot) then
> the write multipliers are very close to 1.0x.  If you have low metadata
> locality, even one snapshot will be followed by a big write multiplication
> burst.

Yup, so general use case with snapshots is low data and metadata
write locality as most files tend to get written once and then not
touched again. Hence seeing 10,000 individual random data overwrites
in a snapshot over a snapshot epoch is a fair estimation of what we
might see with a rolling snapshot every X minutes.

> > > No, this is mostly due to the exploding amount of metadata caused by the
> > > near-worst case workload.
> 
> Every 2 orders of magnitude more metadata items increases the O(log(N))
> costs of btrfs by one unit.  By 50 snapshots or reflinks you have hundreds
> of millions of metadata items, it's 6x slower and not increasing very
> much any more...not too far off what we'd expect.

Ok, so the problem is the exponential cost of maintaining all the
cross-btree references, not the btree itself. So it really is an
architectural issue and not something that can be fixed?

> One problem with this theory is that we'd expect the same behavior for
> reflinks too, so it might not be correct.

reflinks show the similar behaviour, just that it doesn't have "stop
the world" metadata writeback points like a snapshot has.

> > > Yeah, btrfs is pretty bad at handling small dio writes, which can easily
> > > explode the metadata usage.
> > > 
> > > Thus for such dio case, we recommend to use preallocated file +
> > > nodatacow, so that we won't create new extents (unless snapshot is
> > > involved).
> > 
> > Big picture. This is an accelerated aging test, not a prodcution
> > workload. Telling me how to work around the problems associated with
> > 4kB overwrite (as if I don't already know about nodatacow and all
> > the functionality you lose by enabling it!) doesn't make the
> > problems with increasing snapshot counts that I'm exposing go away.
> 
> I'm familiar with this workload.  I've been running something similar to
> your target workload since 2014.  We build NAS backup appliance boxes:
> each has about 100 client subvols ranging in size from 1GB to 10TB,
> thousands to millions of files each, 1-5% daily turnover.
> 
> Multiple snapshots per hour at this scale is a really ambitious target
> for btrfs.  We can theoretically do somewhere between 15 and 180 snapshot
> rotates per day before the machine starts falling behind on the deletes
> and running out of space.  Snapshot create and delete on btrfs come
> with giant unbounded latency spikes, so we don't run them all the time.
> We'll create snapshots any time a client finishes an update, but we only
> delete old snapshots to recover disk space during a 3-hour maintenance
> window.
>
> While the snapshot rotates are happening, btrfs leaves CPU cores and
> disks idle.  Current performance is far from the theoretical limits.

Which, IMO, is kinda sad because zero-cost snapshot-based
workload/workflows is what btrfs was specifically intended to
provide to users...

> There is some active development in this area, especially in the last
> year.  Several improvements happened in 2020, including a few silly bug
> fixes of the form "don't make two threads fight each other for locks"
> and "don't forget to wake up some important background process because
> we optimized away some trigger event it was waiting for."

But the problems of scalability don't look like bugs to me - the
exponential explosion of metadata objects when snapshots and
overwrites occur looks more like a fundamental architectural problem
than a minor implementation bug here or there.

> > > > Oh, I almost forget - FIEMAP performance. After the reflink test, I
> > > > map all the extents in all the cloned files to a) count the extents
> > > > and b) confirm that the difference between clones is correct (~10000
> > > > extents not shared with the previous iteration). Pulling the extent
> > > > maps out of XFS takes about 3s a clone (~850,000 extents), or 30
> > > > minutes for the whole set when run serialised. btrfs takes 90-100s
> > > > per clone - after 8 hours it had only managed to map 380 files and
> > > > was running at 6-7000 read IOPS the entire time. IOWs, it was taking
> > > > _half a million_ read IOs to map the extents of a single clone that
> > > > only had a million extents in it. Is it expected that FIEMAP is so
> > > > slow and IO intensive on cloned files?
> > > 
> > > Exploding fragments, definitely needs a lot of metadata read, right?
> > 
> > Well, at 1000 files, XFS does zero metadata read IO because the
> > extent lists for all 1000 snapshots easily fit in RAM - about 2GB of
> > RAM is needed, and that's the entire per-inode memory overhead of
> > the test. Hence when the fiemap cycle starts, it just pulls all this
> > from RAM and we do zero metadata read IO.
> 
> If, before you start the test, you run 'truncate -s 4g testfile', so
> that fio doesn't preallocate the file, things behave somewhat better,
> though "better" for 80GB of metadata is still pretty awful.

Yup, that's exactly how I have fio configured to behave. So the 80GB
of metadata is for what you consider to be the "better" case.

> If I run the test without the prealloc, filefrag takes about 4.5 seconds
> to iterate 1044066 extents from a cold cache, and does 10 snapshot files
> in 1.6 seconds with a warm cache (32 seconds from cold).

Yup, that cold cache behaviour is awful.

> The sheer size of the metadata does prevent the whole thing from being
> cached in RAM, at least on a 32G machine.

Yup, that's one of the problems I originally reported.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
