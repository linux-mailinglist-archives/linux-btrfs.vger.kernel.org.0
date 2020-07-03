Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068BB213212
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 05:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGCDQN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 23:16:13 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44530 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGCDQN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 23:16:13 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id B0878743CC9; Thu,  2 Jul 2020 23:16:11 -0400 (EDT)
Date:   Thu, 2 Jul 2020 23:16:11 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "Lakshmipathi.G" <lakshmipathi.g@gmail.com>
Cc:     kreijack@inwind.it, dsterba <dsterba@suse.cz>,
        DanglingPointer <danglingpointerexception@gmail.com>,
        btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
Message-ID: <20200703031611.GD10769@hungrycats.org>
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
 <20200618204317.GM10769@hungrycats.org>
 <65eeb90a-e983-2ae8-14ad-79bcd2960851@gmail.com>
 <20200619050402.GN10769@hungrycats.org>
 <20200619131117.GD27795@twin.jikos.cz>
 <79672577-6189-10fe-b4bc-8cf45547b192@libero.it>
 <20200622224556.GP10769@hungrycats.org>
 <CAKuJGC_eDi3isqJHxn6XG8GerOthYeVTb1j5cTPYSiuV_oFgaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKuJGC_eDi3isqJHxn6XG8GerOthYeVTb1j5cTPYSiuV_oFgaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 01:57:57PM +0530, Lakshmipathi.G wrote:
> Hi Zygo.
> 
> >dduper is a proof of concept that is so much
> >faster than the other block-oriented dedupers on btrfs that it overcomes a
> >ridiculously inefficient implementation and wins benchmarks--but it also
> >saves the least amount of space of any of the block-oriented dedupers on
> >the wiki.
> 
> Regarding dduper, do you have a script to re-create your dataset? I'd like to
> investigate why dduper saves the least amount of space. thanks!

My data set is a bunch of Windows raw disk images taken right after the
MS installer runs.  I don't think I can share it, but it's easy enough to
roll your own.  To avoid btrfs backref performance bugs, I split the disk
images into 1GB files, removed those files that were entirely duplicate
(all-zero or hard disk sector initialization pattern), and deduped the
rest.  For repeatability, once I had set up the btrfs filesystem with
all the 1GB raw image fragment files, I dd'ed it to a raw partition on
a dedicated disk and ran the test in a VN, so that all tools deduped an
identical filesystem image on the same hardware (which has since died,
so here I will use the saved results of the last run).

On btrfs, extents are immutable.  To remove a duplicate extent, the
deduper must remove every reference to every block in an extent, even
if some of the blocks do not contain duplicate data.  If any reference
to the extent remains anywhere in the filesystem, no space is saved.
If anything, space is lost due to metadata growth.

One way to achieve removal of a partially matched extent is to copy the
unique data so that the entire extent contains duplicate data (which
bees does).  Another option is to not attempt dedupe at all unless the
entire content of one extent matches (which duperemove might do...in a
dev branch?).  This does not gain more free space, but it avoids wasting
time issuing dedupe ioctl calls that will cost time.

duperemove will do parts of this analysis depending on command-line
options.  dduper doesn't do any such analysis that I've seen, and
its performance seems to be comparable to duperemove with a crippling
set of command-line options.  The space efficiency of both dduper and
duperemove is poor on btrfs--they are only effective when deduping files
with small extents, or files that are entirely duplicate.  In test runs,
both dduper and duperemove issue a lot of dedupe ioctls that have no
effect on free space (though duperemove has command-line options that
avoid the worst losses).

In my uncompressed test, the extents are all large (many are at the
maximum 128MB size), so a deduper that doesn't split extents will be able
to recover almost no space.  The only successes dduper and duperemove
were able to achieve were exploiting the fact that Windows disks have
contiguous gigabytes of identical content in their recovery-tools
partitions.

bees is able to recover more of the duplicate space it finds because it
slices up large extents along dedupe-friendly boundaries.  This slows bees
down on uncompressed filesystems because the incoming extents are larger.

My test result for 140GB of uncompressed data was:

	bees saved 31% in 1h 40m (0.31%/min)

	duperemove -d -r saved 12% in 2h 30m (0.08%/min)

	duperemove -d -r --dedupe-options=same saved 12% in 25 minutes
	(0.48%/min)

	dduper saved 9% in 16m (0.56%/min)

	duperemove -d -r --dedupe-options=nofiemap,noblock,same -A
	--lookup-extents=no saved 7% in 25 min (0.28%/min)

dduper is the fastest, but saves less total space than two variations
of duperemove command-line options.

dduper is even faster than the above numbers suggest--it deduped 8.5% of
the data in 6 minutes, a rate of 1.41%/minute, 3x faster than duperemove's
best score...then dduper wasted the following 10 minutes doing futile
dedupe ioctl calls that didn't free any space.

All that said, scoring the highest free space %/minute rate in a race with
other dedupers _while wasting 67% of the time and 71% of the available
space_ is pretty impressive!

duperemove -d -r took 2h 30m because it hits an old btrfs backref
performance bug (now fixed in 5.7?).  It actually saved 12% in 25 minutes
too, but it created a toxic extent and spent 2 hours burning CPU in the
kernel to process it.  The other duperemove command-line argument sets
mentioned here avoid this bug.

The result for 100GB of compressed data (the same data, but compressed
with compress-force=zstd) was:

	bees saved 44% in 1h 15m (0.58%/min)

	duperemove -d -r --dedupe-options=nofiemap,noblock,same -A
	--lookup-extents=no saved 3% in 12 minutes (0.25%/min)

	dduper saved 1% in 24 minutes (0.04%/min)

On compressed filesystem tests, dduper gains almost no space.  This is
expected, because dduper only looks at btrfs csums, and the btrfs csums
can only match when the compressed data representation of both copies
is exactly the same.  In btrfs-compressed files the compressed extent
block alignment is effectively random for large files, since it depends
on timing details at the time of the btrfs commit, so on average only 3%
(1 in 32 blocks) of extents with duplicate data will have matching csums
after compression.  bees and duperemove read the data after decompression,
so they are not limited by differences in compression encoding.

The only way for dduper to catch up here is to detect compressed
extents and fall back to reading them the slow way.  This is a reasonable
tradeoff for filesystem workloads that have low proportions of compressed
data; otherwise, duperemove's optimized multi-threaded implementation
might run slightly faster than dduper on a fast device, if dduper is
forced to read all the blocks because they are compressed.

I don't recall why I didn't run duperemove with other options on a
compressed filesystem during this test--possibly to avoid a bug?

I have not looked in further detail into why dduper frees slightly less
space than duperemove under some conditions.  A simple deduper with a
minimal awareness of btrfs's extent reference counting structure can
easily match or slightly outperform the best deduper without one; with a
non-minimal awareness of btrfs structure, a slow and broken deduper can
outperform by an order of magnitude.  duperemove's command-line options do
provide or suppress some awareness of extent structure, so I would expect
those options to increase or decrease space saved slightly compared to
a tool that has no such awareness, and that seems to be what happens.
The test results of dduper, duperemove, and bees are all consistent
with that.

> ----
> Cheers,
> Lakshmipathi.G
> http://www.giis.co.in https://www.webminal.org
