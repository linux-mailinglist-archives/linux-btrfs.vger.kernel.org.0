Return-Path: <linux-btrfs+bounces-10382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C09F2281
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 08:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679411886B72
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 07:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F7B49638;
	Sun, 15 Dec 2024 07:50:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C60946426
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734249000; cv=none; b=kDvpjDDkUwvZhXFMCwJ8615biQkuaAEC7vLrYGeXLzbPLA7bE5kQ+FrMGVB+Lcx8JkZfK2yt0OjLDWnOSOUSgw0nwct4eckFCi+ItqhV3aZ9GdStOtSWkfqy3SgFxWQdxLZj/ZgN3vvxGKUEbjOJvhmoLAH1rCjw6Hd5X1u8QkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734249000; c=relaxed/simple;
	bh=Y/b4mwLTVCBgwLi5E/+lchnc0M/TQgnb/ZZPkqf2V8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDy2OejHXf40kAf41rxe7utEoUPGeXQZcLxkU+GXESZzHT7h0qmx8q8ss30ThrG5ayGbOgIMKodzRug/OwL8b3p1rXdSofjf2FzxKAsx970dXHwaqWgPMZKafv3KCayJq1FL2ZIDuL2k9SHKv5B8u+hLNX9Br0sN3etsSpXZ9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id 60EB0113E00E; Sun, 15 Dec 2024 02:49:50 -0500 (EST)
Date: Sun, 15 Dec 2024 02:49:50 -0500
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: Goffredo Baroncelli <kreijack@inwind.it>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>,
	Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
Subject: Re: Using btrfs raid5/6
Message-ID: <Z16KHsma7foNV2ff@hungrycats.org>
References: <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
 <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
 <b5f70481-34a1-4d65-a607-a3151009964d@suse.com>
 <9ae3c85e-6f0b-4e33-85eb-665b3292638e@gmail.com>
 <cfa74363-b310-49f0-b4bf-07a98c1be972@gmx.com>
 <Z1eonzLzseG2_vny@hungrycats.org>
 <08082848-9633-4b3c-9d9d-6135efab8e2d@libero.it>
 <Z1k-rlpwCqdynfWe@hungrycats.org>
 <014edba0-5edc-4c71-9a6b-35a0227adb30@inwind.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <014edba0-5edc-4c71-9a6b-35a0227adb30@inwind.it>

On Wed, Dec 11, 2024 at 08:39:04PM +0100, Goffredo Baroncelli wrote:
> On 11/12/2024 08.26, Zygo Blaxell wrote:
> > On Tue, Dec 10, 2024 at 08:36:05PM +0100, Goffredo Baroncelli wrote:
> > > On 10/12/2024 03.34, Zygo Blaxell wrote:
> > > > On Sun, Dec 08, 2024 at 06:56:00AM +1030, Qu Wenruo wrote:
> > > 
> > > Hi Zygo,
> > > 
> > > thank for this excellent analisys
> > > 
> > > [...]
> > > 
> > > > There's several options to fix the write hole:
> > > > 
> > > > 1.  Modify btrfs so it behaves the way Qu thinks it does:  no allocations
> > > > within a partially filled raid56 stripe, unless the stripe was empty
> > > > at the beginning of the current transaction (i.e. multiple RMW writes
> > > > are OK, as long as they all disappear in the same crash event).  This
> > > > ensures a stripe is never written from two separate btrfs transactions,
> > > > eliminating the write hole.  This option requires an allocator change,
> > > > and some rework/optimization of how ordered extents are written out.
> > > > It also requires more balances--space within partially filled stripes
> > > > isn't usable until every data block within the stripe is freed, and
> > > > balances do exactly that.
> > > 
> > > My impression  is that this solution would degenerate in a lot of
> > > waste space, in case of small/frequent/sync writes.
> > 
> > "A lot" is relative.
> > 
> > If we first coalesce small writes, e.g. put a hook in delalloc or ordered
> > extent handling that defers small writes until there are enough to fill a
> > stripe, and only get to partial stripe writes during a commit or a fsync,
> > then there far fewer of these then there are now.  This would be a big
> > performance gain for btrfs raid5, without even considering the gains
> > in robustness.
> 
> Are you considered the "write in the middle of a file case" ? In this case
> the old data will be an hole in the stripe that will not filled until
> a re - balance. My impression is that this approach for some workload will
> degenerate badly with an high number of half empty stripe (more below)

Oof, there are a number of misconceptions to unpack here...

Write to the middle of a file does not leave a hole in the stripe.
It doesn't free the overwritten extent at all, until the last reference
to the last block is removed--and then the entire extent is freed,
which would empty the stripe.  This is extent bookending, which can
waste a lot of space on btrfs, e.g.

	# compsize vm-raw.bin
	Processed 1 file, 1097037 regular extents (1196454 refs), 0 inline.
	Type       Perc     Disk Usage   Uncompressed Referenced
	TOTAL       97%       31G          32G          25G
	none       100%       31G          31G          23G
	zlib        56%      2.0M         3.5M         1.0M
	zstd        32%      442M         1.3G         1.1G

That's about 25% of the space waiting to be freed by an as-yet-unwritten
garbage collection tool, the extent tree v2 filesystem on-disk format
change, or as a side-effect of `btrfs fi defrag`.  I don't care about
1% of the space when I'm already overprovisioning by 25% on btrfs compared
to other filesystems.

If the extent is longer than the raid stripe, then the raid stripe
simply remains on disk, complete with csums that can participate in
error detection and correction.

If the extent is shorter than the stripe, then there is a hole left
behind; however, this is the case _now_ on btrfs.  The extent allocator
will try to align allocated extents on 64K boundaries, and will not fill
in any hole smaller than 64K until there are no holes larger than 64K
left in the filesystem (in other words, the allocator will prefer to
allocate a new block group before filling in the smaller holes).

This second allocation pass is _slow_ on large filesystems.  Like,
"your disks will crumble to dust before you fill a large filesystem
past 99.5%, because btrfs gets exponentially slower toward the end,
and the filesystem will take thousands of years to fill in the last 0.1%
on a big array" slow.

This is one of the more frustrating aspects of the current situation:
if the allocator simply didn't do the second pass, it 1) would not hang
as it gets too close to full, but could promptly return ENOSPC instead,
and 2) would not have the raid5 write hole today if the cluster size
and alignment was reliably aligned with the stripe size.

> [..]
> > 
> > In the real world this may not be a problem.  On my RAID5 arrays, all
> > extents smaller than a RAID stripe combined represent only 1-3% percent
> > of the total space.  Part of this is self-selection: if I have a workload
> > that hammers the filesystem with 4K fsyncs, I'm not going to run it on
> > top of raid5 in the stack because the random write performance will suck.
> > I'll move that thing to a raid1 filesystem, and use raid5 for bulk data
> > storage.  On my raid1 filesystems, small extents are 10-15% of the space.
> 
> 1-3% ? In effect I expected a lot more. Do you perform regular balances ?

More misconceptions:  balances do not change existing extent lengths.
Balance defragments larger free spaces, but does not fill in
sub-cluster-sized free space holes (indeed, it makes _more_ of them
because the allocator's clustering parameters used during balance are
different from the parameters used for normal writes).

The 1-3% is simple math:  if 90% of the filesystem's extents are 32K
long, and 10% of the extents are 32M long, then 1% of the filesystem
blocks are in 32K extents (smaller than a 9-drive-wide raid5 stripe),
and 99.9% of the rest of the blocks are in extents much larger than any
raid5 stripe.  Real filesystems have a wider variety of extent sizes,
but they end up with similar averages.

Some btrfs raid1 filesystems end up with higher percentages of small
writes (I have one with 11% small extents); however, with those higher
percentages come severe performance issues on btrfs.  Performance would
get _much_ worse on raid5 because so many writes go through RMW.

> > There are probably half a dozen ways to fix this problem, if it is
> > a problem.  Other filesystems degenerate to raid1 in this case, so they
> > can lose a lot of space this way.  The existing btrfs allocator doesn't
> > completely fill block groups even without raid5, and requires balance to
> > get the space back (unless you're willing to burn CPU all day running
> > the allocator's search algorithm).  Nobody is currently running OLTP
> > workloads on btrfs raid5 because of the risk they'll explode from the
> > write hole.
> 
> The hard part of a filesystem is to not suck for *any workload* even at the
> cost to not be the best for *all workloads*.

I don't disagree with that.  Why did you think I did?

> > Off the top of my head.
> > 
> > We only ever need one partially filled stripe, so we can keep it in
> > memory and add blocks to it as we get more data to write.  For the first
> > short fsync in a transaction, write a new partially filled stripe to a
> > new location (this is a full write, no RMW, but some of the data blocks
> > are empty so they'll be zero-filled) and save the data's location in
> > the log tree (except for the full write, this is what btrfs does now).
> > 
> > For the next short fsync, write a stripe which contains the first
> > and second fsync's data, and save the new location of both blocks in
> > the log tree (since there are only a few of these, they can also be
> > kept in kernel memory).
> > 
> > For the third short fsync, write a stripe which contains first, second,
> > and third fsync's data, and save the new location of all 3 blocks in the
> > log tree.  During transaction commit, write out only the last stripe's
> > location in the metadata (the first two stripes remain free space).
> > During log replay after a crash, replay all the add/delete operations up
> > to the last completed fsync.  There's never a RMW write here, so nothing
> > ever gets lost in a write hole.  There's never an overwrite of data in
> > any form, which is better than most journalling writeback schemes where
> > overwrites are mandatory.
> 
> If I understood correctly, to write 3 short data+fsync, you write 1+2+3=6
> fsync data: 2 times the data and 3 fsync. This is the same cost of a journal.

I write 1 unit of data for each of 3 fsyncs, so 1 write per fsync (the
unit is always a full stripe, it just has fewer zero blocks in later
fsyncs because more of the empty blocks are filled in).  These writes are
always to the final location of the data (the same approach used by the
btrfs log tree) so there are no further read or write operations as there
would be with a journal.  The stripes that are replaced by fsyncs during
the same tree update become free space at the end of the transaction
(again with no additional writes, same as the current log tree).

For a filesystem with metadata on SSD, the journal adds data block writes
to the SSD side.  Writing the full stripe goes directly to the HDD side,
without any head movement on spinning drives.

> > I think we can also hack up balance so that it only relocates extents
> > that begin or end in partially filled/partially empty raid56 stripes,
> > with some additional heuristics like "don't move a 60M extent to get 4K
> > free space."  That would be much faster than moving around all data that
> > already occupies full stripes.
> > 
> > > > 2.  Add a stripe journal.  Requires on-disk format change to add the
> > > > journal, and recovery code at startup to replay it.  It's the industry
> > > > standard way to fix the write hole in a traditional raid5 implementation,
> > > > so it's the first idea everyone proposes.  It's also quite slow if you
> > > > don't have dedicated purpose-built hardware for the journal.  It's the
> > > > only option for closing the write hole on nodatacow files.
> > > 
> > > I am not sure about the "quite slow" part.
> > 
> > "Journal" means writing the same data to two different locations.
> > That's always slower than writing once to a single location, after all
> > other optimizations have been done.
> 
> Why you say write only once ? In the example above, you write the data
> two times.

One data write per fsync, one block per disk:

First write:   [ data1 zero  zero zero parity ]

Second write:  [ data1 data2 zero zero parity ]

The log tree records the first write in the first fsync.  In the second
fsync, the log tree atomically deletes the metadata pointers to data1 in
the first write and replaces them with pointers to data1 in the second
write, then adds pointers to data2.  The committed tree records only
the metadata pointing to both data blocks in the second write.  The first
write becomes free space at the end of thte transaction.

If there are two more blocks written with fsync, we write a new stripe:

Third write:  [ data1 data2 data3 data4 parity ]

At this point we can throw away the partially filled stripe that we've
been keeping in memory, because there are no more empty blocks to fill in.
We leave the log tree items on disk to be replayed after a crash, and
incorporate the final block locations into the metadata tree on commit.

(Note:  in reality, the parity block would be moving around from stripe
to stripe.  I left that detail out for clarity).

> > bcachefs (grossly oversimplified) writes a raid1 journal, then batches
> > up and replays the writes as raid5 in the background.  That's great if
> > you have long periods of idle IO bandwidth, but it can suck a lot if
> > the background thread doesn't keep up.  It's functionally the same as
> > using balance to reclaim space on btrfs.
> 
> My understanding is that, more or less all the proposed solution try to
> reduce the number of RMW cycles putting the data in a journal/log/raid1 bg.

Another misconception:  journalling in raid5 does not change the number
of RMW cycles.  Journalling provides a mechanism to _restart_ RMW cycles
that are interrupted.

RMW cycles are difficult to repair if you don't have a complete copy of
the data before and after the update.  If there are csum errors detected
after using a partial parity log block, that combinatorially expands the
number of possible corrections (OK, for raid5 we go from 1 to 2, but for
raid6 we multiply the number of combinations by N).  With crc32c csums,
you can run into false positives when recovering blocks because crc32(A
^ corruption) = crc32(A) ^ crc32(corruption).  If you're journalling
full block stripes to avoid that complexity, then you might as well
do it the way the log tree does:  write a full stripe in free space,
and point the metadata tree to it for recovery.

> Then the data is move in a raid5/6 bg. The main difference is how big is this
> journal. Depending by this size, a "balance" is required more or less frequently.

You might be thinking of something like the approach bcachefs used here:
write updates to something raid1, then have a background process copy
that data to raid5 stripes.  That can cause problems where the filesystem
ends up being forced to stop allowing more writes because it has fallen
too far behind.

Balances can be run at any time to reclaim free space on a CMR drive.
When using this scheme, the balance must be run to keep the journal from
filling up the filesystem with metadata.  On a filesystem with continuous
write load, it will eventually force writes to stop because there's no
metadata space left.  It would behave like a SMR drive in that respect.

> The current btrfs design, is based on the fact that the raid profile is managed at
> the block-group level, and it is completely independent by the btree/extents
> managements. This scaled very well with the different raid model until the raid
> parity based. This because the COW model (needed to maintain the sync between the
> checksum and the data) is not enough to maintain the sync between the parity and the data.

This is a correct statement of the cause of the raid5 write hole on btrfs.

> Time to time I thought a variable stripe length, where the parity is stored
> inside the extent at fixed offset, where this offset depend by the number
> of disk and the height of the stripe.

This is the ZFS approach.  bcachefs rejected this approach because it causes
short fsyncs to degenerate to raid1, i.e. they take up more space because
the ratio of data to parity shrinks from N:1 to 1:1.

I'm not particularly bothered by that ratio change (apart from anything
else, it's the fastest option for continuous small-write fsync-heavy
workloads on very fast SSDs).  What bothers me about this is that we
effectively need a new encoding method, i.e. the parity blocks have to
be represented in the extent tree, and reading and writing them will
be like compressed files.  That means inserting and debugging a new
compression-like layer to run on top of raid5 data block groups (can't
do this for metadata block groups without undoing skinny-metadata and
all the changes to metadata behavior that implies).

I want btrfs raid5 write hole fixed *today*, not 5-10 years from now
when a new encoding type finally gets debugged enough to be usable.

> Having the parity inside the extents would solve this part of the problem, until you need
> to update in the middle a file. In this case the thing became very complex until
> the point that it is easier to write a full stripe.

Another misconception here:  btrfs already has proven mechanisms in
place to handle similar cases.

Recall that btrfs extents are immutable.  There is no update in the
middle of a file.  btrfs writes the new data to a new extent, then makes
the middle of the file point to the new extent.

> > > In the journal only the "small" write should go. The "bigger" write
> > > should go directly in the "fully empty" stripe (where it is not needed
> > > a RMW cycle).
> > 
> > Yes, the best first step is to remove as many RMW operations as possible
> > in the upper layers of the filesystem.  If we don't have RMW, we don't
> > need to journal or do anything else with it.  We also don't have the
> > severe performance hit that unnecessary RMW does, either.
> > 
> > > So a typical transaction  would be composed by:
> > > 
> > > - update the "partial empty" stripes with a RMW cycle with the data
> > > that were stored in the journal in the *previous* transaction
> > > 
> > > - updated the journal with the new "small" write
> > 
> > A naive design of the journal implementation would store PPL blocks
> > in metadata, as this is more efficient than storing entire stripes or
> > copies of data.  Metadata is necessarily non-parity raid, both to avoid
> > the write hole and for performance reasons, so it can redundantly store
> > PPL information.
> > 
> > Error handling with PPL might be challenging:  what happens if we need
> > to correct a corrupt stripe while updating it?
> 
> I think the same thing that happens when you do a standard RMW cycle with a corruption:
> pause the transaction: read the full stripe and the data checksum, try all the
> possible combination between data and parity until you get good data, rewrite the stripe
> (passing by a journal !); resume the transaction.

All of which is terrible:  while under memory pressure, in the middle
of doing some writes, we stop the world to do a read, because we didn't
completely eliminate RMW in btrfs.

That's an unforced error.  Let's not do that.

> > But maybe journalling full stripe writes is a better match for btrfs.
> > To do a PPL update, the PPL has to be committed first, which would mean it
> > has to be written out _before_ the transaction that modifies the target
> > raid5 stripe.  That would mean the updated stripe has to be written
> > during a later transaction than the one that updated it, so it needs to
> > be stored somewhere until that can happen.  Given those requirements,
> > it might be better to simply write out the whole new stripe to a free
> > stripe in a raid5 data block group, and write a log tree item to copy
> > that stripe to the destination location.  That starts to sound a lot
> > like option 1 with the fix above...why overwrite, when you can put data
> > in the log tree and commit it from there without moving it?
> > 
> > In mdadm-land, PPL burns 30-40% of write performance.  We can assume that
> > will be higher on btrfs.
> 
> My suspects is that this happens because md is not in the position to relocate
> data to fill a stripe. BTRFS can join different writes and put together in a
> stripe. And if this happens BTRFS can bypass the journal because no RMW cycle is
> needed. So I expected BTRFS would performs better.

Well...OK, you're right.  It wouldn't be 30-40% of all write performance.
Only nodatacow files and short fsyncs would be subject to the slowdown.

> > For me, if the tradeoff is losing 1.5% of a 100 TB filesystem for
> > unreclaimed free space vs. a 30% performance hit on all writes with
> > journalling, I'll just delete one day's worth of snapshots to make that
> > space available, and never consider journalling again.
> > 
> > Journalling isn't so great for nodatacow either:  the whole point of
> > nodatacow is to reduce overhead comparable to plain xfs/ext4 on mdadm,
> > and journalling puts that overhead back in.  I'd expect to see users in
> > both camps, those who want btrfs to emulate ext4 on mdadm raid5 without
> > PPL, and those who want btrfs to emulate ext4 on mdadm raid5 with PPL.
> > So that would add two more options to either mount flags or inode flags.
> > 
> > > - pass-through the "big write" directly to the "fully empty" stripes
> > > 
> > > - commit the transaction (w/journal)
> > > 
> > > 
> > > The key point is that the allocator should know if a stripe is fully
> > > empty or is partially empty. A classic block-based raid doesn't have
> > > this information. BTRFS has this information.
> > > 
> > > 
> > > 
> > > BR
> > > 
> > > G.Baroncelli
> > > 
> > > -- 
> > > gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > > Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> > > 
> > > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

