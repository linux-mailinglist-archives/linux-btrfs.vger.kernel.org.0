Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB42301EF4
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 22:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhAXVoc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 16:44:32 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53236 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbhAXVob (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 16:44:31 -0500
Received: from dread.disaster.area (pa49-180-243-77.pa.nsw.optusnet.com.au [49.180.243.77])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9523E3C2E0E;
        Mon, 25 Jan 2021 08:43:47 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l3nAg-0021fY-2c; Mon, 25 Jan 2021 08:43:46 +1100
Date:   Mon, 25 Jan 2021 08:43:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <20210124214346.GC4626@dread.disaster.area>
References: <20210121222051.GB4626@dread.disaster.area>
 <20210124001903.GS31381@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124001903.GS31381@hungrycats.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=juxvdbeFDU67v5YkIhU0sw==:117 a=juxvdbeFDU67v5YkIhU0sw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=rNoU0BqFLqi70Dmay1cA:9 a=s65H3bQn2Ul1F-IG:21 a=F6tm7FsK-35V11Zf:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 23, 2021 at 07:19:03PM -0500, Zygo Blaxell wrote:
> On Fri, Jan 22, 2021 at 09:20:51AM +1100, Dave Chinner wrote:
> > Hi btrfs-gurus,
> > 
> > I'm running a simple reflink/snapshot/COW scalability test at the
> > moment. It is just a loop that does "fio overwrite of 10,000 4kB
> > random direct IOs in a 4GB file; snapshot" and I want to check a
> > couple of things I'm seeing with btrfs. fio config file is appended
> > to the email.

....

> >  --
> >  snapshot 945 15.32
> >  snapshot 946 0.05
> >  snapshot 947 15.52
> >  --
> >  snapshot 971 15.30
> >  snapshot 972 0.03
> >  snapshot 973 14.88
> > 
> > It seems .... unlikely that random snapshots of exactly the same
> > repeating workloadi have such a variance in execution time. And then
> 
> btrfs delays a lot of metadata updates (millions, if you have enough
> memory) and then runs them in giant batches during commits, so they can
> show up as latency spikes at random times while you're benchmarking.
> That is likely part of what is happening here.

Evidence points to this being exactly the problem - multiple
gigabytes of page cache dirtying at writeback points leading to
memory pressure and huge amounts of physical IO being issued. A
single CPU running this workload basically stalls a kernel on a mostly idle
32GB/32p machine with 150,000 random 4kB write IOPS capability for
seconds at a time.

> The current behavior is something of a regression--there used to be a
> latency feedback loop to avoid queueing up too many metadata updates
> before throttling the processes that were generating the updates.
> It's not clear that simply reverting that change is a good way forward.

I see. Rock and a hard place. Am I correct in assuming that that I
shouldn't expect a fix for either the excessive metadata writeback
bandwidth or the non-deterministic system-wide behaviour that
results from it any time soon?

> > ---
> > fio loop 971:   write: IOPS=8539, BW=33.4MiB/s (34.0MB/s)(39.1MiB/1171msec); 0 zone resets
> > fio loop 972:   write: IOPS=579, BW=2317KiB/s (2372kB/s)(39.1MiB/17265msec); 0 zone resets
> > fio loop 973:   write: IOPS=6265, BW=24.5MiB/s (25.7MB/s)(39.1MiB/1596msec); 0 zone resets
> > ---
> > 
> > 
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
> Somewhere in that workload, there's probably a pretty high write
> multiplier for unsharing subvol metadata pages in snapshots.  The worst
> case is about 300x write multiply for the first few pages after a snapshot
> is created, because every item referenced on the shared subvol metadata
> page (there can be 150-300 of them) must have a new backreference added
> to the newly created unshared metadata page, and in the worst case every
> one of those new items lives in a separate metadata page that also
> has to be read, modified, and written.  The write multiplier rapidly
> levels off to 1x once all the snapshot's metadata pages are unshared,
> after random writes to around 0.3% of the subvol.  So writing 4K to a
> file in a subvol right after a snapshot was taken could hit the disks
> with up to 20MB of random read and write iops before it's over.

That's .... really bad. but it tallies with 10,000 4kB data writes
triggering 10GB of dirty metadata pages and GB/s of write bandwidth.

Given this is how the snapshot+COW algorithm is designed, I having
trouble seeing how this problem could be mitigated. Am I correct in
assuming that this level of write amplification as snapshot cycles
increase "is what it is"?

> Fragmentation pushes everything toward the worst-case scenario because it
> spreads the referenced items around to separate pages, which could explain
> the asymptotic performance curve for snapshots.

THe performance continues to worsen long after the per-file extent
count maxxes out at just over 1 million (about cyle 100). So it
seems more to be related to the metadata overhead of the subvol, not
su much the individual file.

FWIW, concentrating on "it's a single file with lots of extents"
misses the bigger picture of "it's a compact simulation of a subvol
with tens of thousands of files in it and being randomly updated by
the production workload between snapshots". IOWs, I'm using this
workload to perform accelerated aging on a constantly modified
filesystem under a rolling snapshot regime. A snapshot every few
minutes, 24x7, is ~5-10,000 snapshots a year. I'm compressing the
modification time domain down from 5-10 minutes to a few hundred
milliseconds so I can run thousands of iterations a day and hence
see what happens over a period of months in a couple of hours...

> Without fragmentation,
> all the referenced items tend to appear on the same or at least a few
> adjacent pages, so the unsharing cost is much lower.  It's the same
> number of pages to unshare whether it's 1 snapshot or 1000, but the
> referenced items will get spread around a lot after 1000 iterarations
> of that fio loop.

Yeah, sure, but when the data is not physically located (such as a
large dataset in a subvol), you get the random overwrite behaviour
this test exercises....

> Reflinks don't share metadata pages, so they don't have this problem
> (except when the dst of the reflink is modifying metadata pages that are
> shared with a snapshot, like any other write).

Evidence suggests that they do have the same problem.  i.e. this:

> > And before you ask, reflink copies of the fio file rather than
> > subvol snapshots have largely the same performance, IO and
> > behavioural characteristics. The only difference is that clone
> > copying also has a cyclic FIO performance dip (every 3-4 cycles)
> > that corresponds with the system driving hard into memory reclaim
> > during periodic writeback from btrfs.

would be explained by the same metadata COW explosion after a
reflink on the per-inode extent tree, rather than full subvol
tree. Is that the case?

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
> There were severe performance issues with FIEMAP (or anything else that
> does backref lookup) on kernels before 5.7, especially on files bigger
> than a few hundred MB (among other things, it was searching the entire
> file for matching forward ref instead of just around the area where the
> backref was).  FIEMAP looks at backrefs to populate the 'shared' bit,
> so it was affected by this bug.

I'm testing on a vanilla 5.10 kernel, so this bug should not be
present in the kernel.

> There might still be a big IO overhead for backref search on current
> kernels.  The worst case is some gigabytes of metadata pages for extent
> references, if every referencing item ends up stored on its own metadata
> page, and if FIEMAP has to read many of them before it finds a reference
> that matches the logical file offset so it can set or clear the 'shared'
> bit.

So it's a least a quadratic complexity algorithm?

> I'm not sure the worst case is even bounded--you could have billions of
> references to an extent and I don't know of any reason why you couldn't
> fill a disk with them (other than btrfs getting too slow to finish before
> the disk crumbles to dust).

Hmmm. This also sounds like a result of the way btrfs is physically
structured. Am I correct to assume this behaviour won't change any
time soon?

> TREE_SEARCH_V2 doesn't have a 'shared' bit to populate, so it runs _much_
> faster than FIEMAP.

Assuming I don't need to know about shared extents. The whole point
of using fiemap here is to be able to look at the shared extents in
the file. That's a diagnostic we use in the field for analysing
problems with reflink copied files on XFS, so I see no reason why we
wouldn't need that information on btrfs. So using a special ioctl
that doesn't provide shared extent visiblity is not a viable
solution here...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
