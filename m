Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AEC30912E
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 02:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhA3BLX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 20:11:23 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38624 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhA3BET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 20:04:19 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E6BEC96124C; Fri, 29 Jan 2021 20:03:29 -0500 (EST)
Date:   Fri, 29 Jan 2021 20:03:29 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <20210130010329.GB32440@hungrycats.org>
References: <20210121222051.GB4626@dread.disaster.area>
 <20210124001903.GS31381@hungrycats.org>
 <20210124214346.GC4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124214346.GC4626@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 25, 2021 at 08:43:46AM +1100, Dave Chinner wrote:
> On Sat, Jan 23, 2021 at 07:19:03PM -0500, Zygo Blaxell wrote:
> > On Fri, Jan 22, 2021 at 09:20:51AM +1100, Dave Chinner wrote:
> > > Hi btrfs-gurus,
> > > 
> > > I'm running a simple reflink/snapshot/COW scalability test at the
> > > moment. It is just a loop that does "fio overwrite of 10,000 4kB
> > > random direct IOs in a 4GB file; snapshot" and I want to check a
> > > couple of things I'm seeing with btrfs. fio config file is appended
> > > to the email.
> 
> ....
> 
> > >  --
> > >  snapshot 945 15.32
> > >  snapshot 946 0.05
> > >  snapshot 947 15.52
> > >  --
> > >  snapshot 971 15.30
> > >  snapshot 972 0.03
> > >  snapshot 973 14.88
> > > 
> > > It seems .... unlikely that random snapshots of exactly the same
> > > repeating workloadi have such a variance in execution time. And then
> > 
> > btrfs delays a lot of metadata updates (millions, if you have enough
> > memory) and then runs them in giant batches during commits, so they can
> > show up as latency spikes at random times while you're benchmarking.
> > That is likely part of what is happening here.
> 
> Evidence points to this being exactly the problem - multiple
> gigabytes of page cache dirtying at writeback points leading to
> memory pressure and huge amounts of physical IO being issued. A
> single CPU running this workload basically stalls a kernel on a mostly idle
> 32GB/32p machine with 150,000 random 4kB write IOPS capability for
> seconds at a time.
> 
> > The current behavior is something of a regression--there used to be a
> > latency feedback loop to avoid queueing up too many metadata updates
> > before throttling the processes that were generating the updates.
> > It's not clear that simply reverting that change is a good way forward.
> 
> I see. Rock and a hard place. Am I correct in assuming that that I
> shouldn't expect a fix for either the excessive metadata writeback
> bandwidth or the non-deterministic system-wide behaviour that
> results from it any time soon?

Josef did some investigation into it a year ago based on some of my
test cases.  There were some simple patches that made big improvements,
but they uncovered other problems.  Fixes for those are working their
way through the dev pipeline.

Part of the problem in your test case is just the sheer size of the
metadata.  That's unlikely to change soon, but you could throw RAM at
the problem.

> > > ---
> > > fio loop 971:   write: IOPS=8539, BW=33.4MiB/s (34.0MB/s)(39.1MiB/1171msec); 0 zone resets
> > > fio loop 972:   write: IOPS=579, BW=2317KiB/s (2372kB/s)(39.1MiB/17265msec); 0 zone resets
> > > fio loop 973:   write: IOPS=6265, BW=24.5MiB/s (25.7MB/s)(39.1MiB/1596msec); 0 zone resets
> > > ---
> > > 
> > > 
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

> > Somewhere in that workload, there's probably a pretty high write
> > multiplier for unsharing subvol metadata pages in snapshots.  The worst
> > case is about 300x write multiply for the first few pages after a snapshot
> > is created, because every item referenced on the shared subvol metadata
> > page (there can be 150-300 of them) must have a new backreference added
> > to the newly created unshared metadata page, and in the worst case every
> > one of those new items lives in a separate metadata page that also
> > has to be read, modified, and written.  The write multiplier rapidly
> > levels off to 1x once all the snapshot's metadata pages are unshared,
> > after random writes to around 0.3% of the subvol.  So writing 4K to a
> > file in a subvol right after a snapshot was taken could hit the disks
> > with up to 20MB of random read and write iops before it's over.
> 
> That's .... really bad. but it tallies with 10,000 4kB data writes
> triggering 10GB of dirty metadata pages and GB/s of write bandwidth.
> 
> Given this is how the snapshot+COW algorithm is designed, I having
> trouble seeing how this problem could be mitigated. Am I correct in
> assuming that this level of write amplification as snapshot cycles
> increase "is what it is"?

I don't see any way to get rid of that write multiplication case without
making incompatible disk format changes, and maybe rethinking the entire
snapshot concept.

In normal workloads (even yours), the write multiplication burst ends
pretty quickly, but you also keep creating new snapshots and starting
new bursts.

It's more of a concern for user desktops that run backups overnight.
Things run many times slower as the user logs in in the morning,
and unshares metadata in $HOME.  By the time the user has logged in,
the write multiplication is mostly over.

> > Fragmentation pushes everything toward the worst-case scenario because it
> > spreads the referenced items around to separate pages, which could explain
> > the asymptotic performance curve for snapshots.
> 
> THe performance continues to worsen long after the per-file extent
> count maxxes out at just over 1 million (about cyle 100). So it
> seems more to be related to the metadata overhead of the subvol, not
> su much the individual file.
> 
> FWIW, concentrating on "it's a single file with lots of extents"
> misses the bigger picture of "it's a compact simulation of a subvol
> with tens of thousands of files in it and being randomly updated by
> the production workload between snapshots". IOWs, I'm using this
> workload to perform accelerated aging on a constantly modified
> filesystem under a rolling snapshot regime. A snapshot every few
> minutes, 24x7, is ~5-10,000 snapshots a year. I'm compressing the
> modification time domain down from 5-10 minutes to a few hundred
> milliseconds so I can run thousands of iterations a day and hence
> see what happens over a period of months in a couple of hours...

I'm thinking of the effects of free space fragmentation here, not
individual file fragmentation, i.e. objects get spread out over the
disk because they are landing in free space holes that are spread out
over the disk.  These objects have related items that are closely packed
in some trees (subvols) and sparsely packed in other trees (extent, csum)
because one tree is keyed by logical address and the other by physical.

There's not much difference in btrfs between a lot of small files and
a few big ones--in subvol metadata, they get densely packed into btree
pages either way.  A whole directory tree of files can live on one page.

> > Without fragmentation,
> > all the referenced items tend to appear on the same or at least a few
> > adjacent pages, so the unsharing cost is much lower.  It's the same
> > number of pages to unshare whether it's 1 snapshot or 1000, but the
> > referenced items will get spread around a lot after 1000 iterarations
> > of that fio loop.
> 
> Yeah, sure, but when the data is not physically located (such as a
> large dataset in a subvol), you get the random overwrite behaviour
> this test exercises....
> 
> > Reflinks don't share metadata pages, so they don't have this problem
> > (except when the dst of the reflink is modifying metadata pages that are
> > shared with a snapshot, like any other write).
> 
> Evidence suggests that they do have the same problem.  i.e. this:
> 
> > > And before you ask, reflink copies of the fio file rather than
> > > subvol snapshots have largely the same performance, IO and
> > > behavioural characteristics. The only difference is that clone
> > > copying also has a cyclic FIO performance dip (every 3-4 cycles)
> > > that corresponds with the system driving hard into memory reclaim
> > > during periodic writeback from btrfs.
> 
> would be explained by the same metadata COW explosion after a
> reflink on the per-inode extent tree, rather than full subvol
> tree. Is that the case?

I don't think so.  The metadata COW explosion would explain why reflinks
are _faster_ than snapshots, which I think you said you didn't observe.
(Are we talking about the 300x write multiplication explosion for
fresh snapshots here?  There are arguably multiple events that could be
described as "metadata explosion" in this test case.)

The 300x metadata write multiplication transforms a snapshot (immutable
shared subvol metadata) into a reflink copy (mutable unshared subvol
metadata).  If the file is a reflink copy to start with, then there's
no need to do any more work to make it one.

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
> > There were severe performance issues with FIEMAP (or anything else that
> > does backref lookup) on kernels before 5.7, especially on files bigger
> > than a few hundred MB (among other things, it was searching the entire
> > file for matching forward ref instead of just around the area where the
> > backref was).  FIEMAP looks at backrefs to populate the 'shared' bit,
> > so it was affected by this bug.
> 
> I'm testing on a vanilla 5.10 kernel, so this bug should not be
> present in the kernel.
> 
> > There might still be a big IO overhead for backref search on current
> > kernels.  The worst case is some gigabytes of metadata pages for extent
> > references, if every referencing item ends up stored on its own metadata
> > page, and if FIEMAP has to read many of them before it finds a reference
> > that matches the logical file offset so it can set or clear the 'shared'
> > bit.
> 
> So it's a least a quadratic complexity algorithm?

Worst case is O(number_of_reflinks * number_of_snapshots * btree_depth)
for each query (which for FIEMAP would be the first block in each
logical extent reference).

Some of the backref items come with CPU search overheads because the
backrefs sometimes point to pages, not individual items.

btree depth is O(log(n)) random seeks on btrees which are probably far
more expensive than the CPU, so the CPU term won't show up in O-notation.

If your extent references mostly overlap the same physical blocks, they
will short-circuit some computations for FIEMAP.  e.g. if a physical
extent has 32768 references, but they are all 4K and none overlap, then
FIEMAP will loop all 32768 times to determine a block is not SHARED.
e.g. 2 if an extent has 1000 references but they all refer to the entire
physical extent, then the loop will terminate on the second iteration.

I'd call it O(N * log(n)) for each extent, with some noticeably large
constant terms, assuming there aren't any silly bugs left.  There are
a lot of variables that can affect the performance.

There's no caching, so every FIEMAP call forgets everything it learns
before the next FIEMAP call.  I don't know if it even caches the metadata
pages it reads.

> > I'm not sure the worst case is even bounded--you could have billions of
> > references to an extent and I don't know of any reason why you couldn't
> > fill a disk with them (other than btrfs getting too slow to finish before
> > the disk crumbles to dust).
> 
> Hmmm. This also sounds like a result of the way btrfs is physically
> structured. Am I correct to assume this behaviour won't change any
> time soon?

FIEMAP, a foreign ioctl that originated on an alien filesystem, has
three basic problems on btrfs:

1.  On btrfs, physical extents and logical extent references have separate
offsets and sizes.  FIEMAP provides for only one size and offset in struct
fiemap_extent, so the btrfs version discards the physical size information
and adds the physical offset to the physical extent's base address.
This makes FIEMAP useless for analyzing physical extent sharing on btrfs
in any case where physical.offset != 0 or physical.size != logical.size
(i.e. when you use dedupe, reflinks, snapshots, compression, prealloc,
nodatacow, or just partially overwrite extents in files).

2.  Physical extent sharing in btrfs is a per-block property, not a
per-extent property as understood by FIEMAP.  The btrfs implementation
of FIEMAP doesn't break up logical extent records into contiguous
SHARED/not-SHARED pieces, so when the struct fiemap_extent describes more
than one logical block, the SHARED bit is not necessarily accurate for
the entire logical extent.

3.  btrfs doesn't maintain backref information to the precision required
to answer FIEMAP queries trivially.  In common cases the forward
reference information can be changed without needing to update the
backward reference information at all, even though the forward reference
changes location or is duplicated.

The obvious fix for item 1 is to add the two missing fields to struct
fiemap_extent.  The fix for item 2 is less obvious:  we could add a
fm_flag that says "I don't care about sharing (or I'll compute my own
sharing), please don't waste my time on SHARED thanks" or "I really
care about sharing, please split up logical extents into contiguous
SHARED/not-SHARED and do all the extra work to calculate that accurately"
or "I only care about definitely-not-shared blocks, you can have a
few false positives for speed" so btrfs FIEMAP users could control the
cost vs quality of FIEMAP's output.  It's not obvious that item 3 even
needs fixing.

If we make those changes, we get an ioctl that looks very much like
TREE_SEARCH_V2 in the low-cost mode.  Applications that need accurate
physical sharing information on btrfs already use TREE_SEARCH_V2, so
FIEMAP does not get much attention on btrfs.

FIEMAP is the equivalent of looking at btrfs through a funhouse mirror.
FIEMAP on btrfs is slow and full of lies.

> > TREE_SEARCH_V2 doesn't have a 'shared' bit to populate, so it runs _much_
> > faster than FIEMAP.
> 
> Assuming I don't need to know about shared extents. The whole point
> of using fiemap here is to be able to look at the shared extents in
> the file. That's a diagnostic we use in the field for analysing
> problems with reflink copied files on XFS, so I see no reason why we
> wouldn't need that information on btrfs. So using a special ioctl
> that doesn't provide shared extent visiblity is not a viable
> solution here...

In your specific case, FIEMAP doesn't indicate that the prealloc at the
beginning of your test created thousands of non-overlapping 4K references
to 128MB extents in every snapshot, because there's no place to put that
information in its output.

TREE_SEARCH_V2 makes this obvious, it shows every tiny extent is a slice
of a few unique huge extents.  I don't even need to process the output
to see that--the same physical extent base address appears over and over
again on every other line, with only the physical offset changing from
one logical extent to the next.

compsize calculates block-level reference overlap in less than a second
per file (at least until the reference data gets larger than memory).
It doesn't report any of that information filefrag-style, but it does
produce the data internally.

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
