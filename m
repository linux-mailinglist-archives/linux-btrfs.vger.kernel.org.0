Return-Path: <linux-btrfs+bounces-6279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F62929C49
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 08:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7132E1F2100E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E830018AEA;
	Mon,  8 Jul 2024 06:31:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE5A1946F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420314; cv=none; b=vDQNGdkuFeteBv4xpGhB18NaEbtjR2yCHl1nIfyIx7bZkg953dLo37gNzHrr7ElBRGb0pTpNQUAonXOIs/buI76x919pVXFRvAbsBsXqNbXJiLQzN5eIVmCOp7gikE7Fig7t5ksNYctq/uwid3/EOfnuJNLkqIVLBenB5y7MD+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420314; c=relaxed/simple;
	bh=4dpKF/F4iUSKC+qmxGuR0eOJ7mR60AETIbwAzcx8ss0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6+XyQQHQkKSRZtIeBnDmsfV3P3RjlAyA+gxxSmKEfjk9zHQvpoJY3RhDVL2jlOFw0Az0QjR9t6jnowHIKILLLQXgJY5bP7mogJ6MCaNceKWl9f6IvqN8C1pHt8yqMI4NJu+Zj7FJcmujZqKPPXcZGtx/GK8dmhDAxl2ytlxjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id 7FA1AEB05CE; Mon,  8 Jul 2024 02:25:37 -0400 (EDT)
Date: Mon, 8 Jul 2024 02:25:37 -0400
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: raid5 silent data loss in 6.2 and later, after "7a3150723061
 btrfs: raid56: do data csum verification during RMW cycle"
Message-ID: <ZouGYZWkKM_W4hby@hungrycats.org>
References: <ZlqUe+U9hJ87jJiq@hungrycats.org>
 <a9d16fd4-2fec-40c7-94cc-c53aa208c9b9@gmx.com>
 <ZmO6IPV0aEirG5Vk@hungrycats.org>
 <5a8c1fbf-3065-4cea-9cf9-48e49806707d@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a8c1fbf-3065-4cea-9cf9-48e49806707d@suse.com>

On Sat, Jun 08, 2024 at 12:50:35PM +0930, Qu Wenruo wrote:
> 在 2024/6/8 11:25, Zygo Blaxell 写道:
> > On Sat, Jun 01, 2024 at 05:22:46PM +0930, Qu Wenruo wrote:
> > After this change, we now end up in an infinite loop:
> > 
> > 1.  Allocator picks a stripe with some unrecoverable csum blocks
> > and some free blocks
> > 
> > 2.  Writeback tries to put data in the stripe
> > 
> > 3.  rmw_rbio aborts after it can't repair the existing blocks
> > 
> > 4.  Writeback deletes the extent, often silently (the application
> > has to use fsync to detect it)
> > 
> > 5.  Go to step 1, where the allocator picks the same blocks again
> > 
> > The effect is pretty dramatic--even a single unrecoverable sector in
> > one stripe will bring an application server to its knees, constantly
> > discarding an application's data whenever it tries to write.  Once the
> > allocator reaches the point where the "next" block is in a bad rmw stripe,
> > it keeps allocating that same block over and over again.
> 
> I'm afraid the error path (no way to inform the caller) is an existing
> problem. Buffered write can always success (as long as no ENOMEM/ENOSPC
> etc), but the real writeback is not ensured to success.
> It doesn't even need RAID56 to trigger.
> 
> But "discarding" the dirty pages doesn't sound correct.
> If a writeback failed, the dirty pages should still stay dirty, not
> discarded.
> 
> It may be a new bug in the error handling path.

I found the code that does this.  It's more than 11 years old:

commit 0bec9ef525e33233d7739b71be83bb78746f6e94
Author: Josef Bacik <jbacik@fusionio.com>
Date:   Thu Jan 31 14:58:00 2013 -0500

    Btrfs: unreserve space if our ordered extent fails to work

    When a transaction aborts or there's an EIO on an ordered extent or any
    error really we will not free up the space we reserved for this ordered
    extent.  This results in warnings from the block group cache cleanup in the
    case of a transaction abort, or leaking space in the case of EIO on an
    ordered extent.  Fix this up by free'ing the reserved space if we have an
    error at all trying to complete an ordered extent.  Thanks,

> >  This case
> > is broken in the patch.  The data in the unrecoverable blocks is lost
> > already, but we can still write the new data in the stripe and update
> > the parity to recover the new blocks if we go into degraded mode in
> > the future.
> 
> We should only continue if our write range covers the bad sector, but that's
> impossible as that breaks DATACOW.
> 
> I can do extra handling, like if the write range covers a bad sector, we do
> not try to recover that one.
> 
> But I strongly doubt if that would have any meaning, since that means we're
> writing into a sector which already has csum.

The point here is to:

 - keep the P/Q in sync with the a consistent view of data in the
stripe, even when some of that data is known to be uncorrectable

 - not overwrite any block in the stripe unless we are sure its
contents are correct or don't matter

 - always write out the new data and matching P/Q in rmw_rbio

i.e. if we fail to read a block, or if its csum fails, and we can't
reconstruct the block, we must not write the block out to disk because
that will prevent a read retry from succeeding in the future.  We must
still update P/Q because we modify other blocks in the stripe.  The only
thing P/Q needs to work is some repeatable data that we can read from
the stripe in the future.  P/Q doesn't have to be correct wrt the csums,
only with the blocks.  As long as P/Q matches the other blocks, then
any block in the stripe can be reconstructed to its current value.

Note we only need to do this for rmw, because we _have_ to finish
rmw to avoid data loss from not making a best effort to do the write.
Scrub and read can report the problem and move on to the next stripe,
because there's no write to be lost in the rbio.

> > 6.  We can't read enough of the blocks to attempt repair:  we can't
> > compute parity any more, because we don't know what data is in the
> > missing blocks.  We can't assume it's some constant value (e.g. zero)
> > because then the new parity would be wrong if some but not all of the
> > failing drives came back.
> > 
> > For case 1-5, we can ignore the return value of verify_one_sector()
> > (or at least not pass it up to the caller of recover_vertical()).
> 
> Nope, that falls back to the old behavior, a corrupted section would only
> spread to P/Q.

Yeah, I tested this and it's the wrong point in the logic.  Another
problem with doing it there is that code is shared with scrub, and we
don't want scrub to be doing best-effort, we want scrub to be perfect
or do nothing.

A better place to do it is when recover_blocks() returns.  This is specific
to the rmw_rbio code, so it doesn't affect other parts of btrfs that
can afford to stop when there's an uncorrectable sector.

> We can not do the data loss decision for the end users.

There is no decision that doesn't have at least potential data loss.
RMW is writing data.  If our RMW bbio chooses not to write data when it's
possible to do so, then we've actively made the decision to lose data.

In the current architecture, RMW must make a best effort to correct any
correctable errors before modifying the stripe, but if that effort fails,
RMW still has to update the stripe anyway, so that one bad stripe doesn't
break the entire filesystem.

The alternative is to not do RMW at all (or at least remove the dependency
on it), which is a much larger problem to solve.  There's a few ways to
do that:

1.  In btrfs_finish_one_ordered, instead of dropping the failed extent,
try to allocate it somewhere else (hopefully in a stripe without an
uncorrectable sector, or just switch to a full-stripe allocation for
that specific case), and restart the write operation.  That trades extra
disk space for availability.  We'd need some way to remember where writes
have failed so the allocator isn't constantly trying to put new data on
broken stripes.  Also it means that we can end up silently dropping data
due to ENOSPC instead of EIO (i.e. we try to write to the last available
sectors and they're in a broken stripe) (similar to another bug in 6.6,
now fixed).

2.  Avoid RMW writes in the allocator.  This requires some aggressive
merging of writes so that we fill up stripes (that would be nice to have
anyway as a pure speed optimization for raid5, as the current code will
happily write 4 64K files in 4 RMW operations instead of packing them
all into one full-stripe write).  We'd need bg reclaim to free up space
in partially filled stripes (i.e. raid5 would effectively behave like a
zoned device).  We'd still need RMW for nodatacow files, but nodatasum
files can't ever have corrupt sectors so we can always update P/Q when
we write a stripe.  Prealloc wouldn't work.  We might return ENOSPC,
but we'll do that at write() time, not in writeback, so userspace will
be informed and we won't silently discard any data.

3.  Use raid-stripe-tree.  AFAICT raid-stripe-tree is basically option 2,
but implemented between the extent layer and the device layer so it's
a less invasive change wrt the rest of btrfs.  raid-stripe-tree doesn't
support prealloc or nodatacow either.

> Any shorter reproducer?

1.  Create a -draid5 -mraid1 filesystem from 5 devices:  2x 750G, 2x 700G.
The larger devices will have all the metadata on them, so we can corrupt
everything on a small device and not worry about clobbering metadata.

2.  Put some data on the filesystem, delete every second file to make a lot
of small holes in the raid5 stripes.

3.  Corrupt the two smaller devices (the ones without metadata) with your
choice of garbage data (leave the first 1M intact for the superblock):

    yes | dd of=dev-3 iflag=fullblock bs=1024k
    yes | dd of=dev-4 iflag=fullblock bs=1024k

4.  On the filesystem, create a new directory and use it normally.
I like 'git clone' for this, because it does a lot of fsyncs and sha1 hash
integrity checking, and every kernel developer already has it installed.

    git clone http://github.com/kdave/btrfs-progs.git git-test

The git clone, git gc, commits, etc. should all run without error,
and the number of errors in files in the rest of the filesystem should
be stable, i.e. writes work for new data, and old data isn't (more)
corrupted by the writes.

> If I understand you correct, the problem only happens when we have all the
> following conditions met:
> 
> - the sector has csum
>   Or we won't very the content anyway
> 
> - both the original and repaired contents mismatch csum
> 
> This already means there are errors beyond the RAID5 tolerance.

Yes, all the problems arise when one stripe goes beyond RAID5 tolerance.
It doesn't look like it matters whether it's read or csum failure,
but csum failure is much more common due to earlier bugs in btrfs
raid5 leaving broken stripes on disk for later kernels to trip over,
or a replaced drive combined with an uncorrected write hole error on a
second drive.

If the errors are within RAID5 tolerance, it all works perfectly:
the "best effort to repair" is a completely successful repair, so
recover_blocks returns 0, we don't prematurely exit from rmw_rbio,
and writes work properly.

> So that's something else in v6.2 causing beyond-raid5-tolerance.
> And the data drop problem is definitely a big problem but I do not think
> it's really RAID56 specific.

It's raid56 specific because only raid56 has data block writes which
depend on the outcome of data block reads, i.e. a write fails because
of something that happens during a read.  No other profile has that
possibility.

If I run the test case with raid1 or single data instead of raid5,
there will never be a data loss on a write because of a csum failure,
because the write bbios simply never try to read anything.  Even raid5
full-stripe writes can't fail that way, because they don't mix read
operations into their write bbios.

(I'm excluding metadata here--there are plenty of dependencies between
data writes and metadata reads, but they aren't very interesting.
If metadata is broken then the entire filesystem is broken.)

> > On 6.6, all the automation was broken by the regression: when we replaced
> > a broken file or added a new one, the new file was almost always silently
> > corrupted,
> 
> A quick search through the data writeback path indeed shows we do nothing
> extra when hitting a writeback error.

That's because it's not in the writeback path--it's in the bio completions
for ordered data.  This is the sequence of events:

1.  btrfs allocator places an extent within an existing raid5 data stripe
that contains some unreadable or corrupt data blocks.

2.  rmw_rbio is called to perform a rmw operation on the stripe.

3.  rmw_read_wait_recover attempts to find all csums in the stripe.

4.  rmw_read_wait_recover issues read requests to
submit_read_wait_bio_list to fill the stripe in memory.

5.  raid_wait_read_end_io sets error bits in the rbio error_bitmap for
read failures, and passes successful reads to verify_bio_data_sectors.

6.  verify_bio_data_sectors verifies those sectors which have csums
(i.e. not the free sectors, nodatasum files, or the P/Q sector(s)).
Sectors that have mismatched csums are marked in the rbio error_bitmap.

7.  back to rmw_read_wait_recover, which calls recover_sectors.

8.  recover_sectors attempts to repair any sectors with a bit set in
error_bitmap.  If there are too many bad sectors, recover_sectors exits
early without doing anything.  After reconstructing the bad sector
contents from remaining data and P/Q blocks, the csums of the repaired
sectors are verified with verify_one_sector().

9.  if recover_sectors is unable to repair all sectors in the stripe,
recover_sectors returns an error to rmw_read_wait_recover, which
returns the error to rmw_rbio.

10.  when rmw_read_wait_recover returns an error to rmw_rbio, rmw_rbio
sets bi_status to IOERR on all the bios in the stripe, and returns
without performing the parity update and write operations originally
requested at step 2.

11.  the rbio work function finishes

12.  the btrfs_finish_ordered_io work function starts

13.  btrfs_finish_one_ordered notices the error in bi_status on the bios

14.  btrfs_finish_one_ordered calls btrfs_mark_ordered_extent_error,
so syncfs() and fsync() can return EIO.

15.  btrfs_finish_one_ordered calls btrfs_drop_extent_map_range to
delete the extent from the filesystem.

16.  the blocks in the uncorrectable stripe are now free to be allocated
again, so return to step 1 and do it all again in the next transaction.

Note that this is a loop!  So we don't lose one extent of data and then
move on--we lose one extent of data _in each transaction_, and then set up
the next transaction to fail in the same way.  This continues as long as
an uncorrectable sector exists in one of the first available free spaces.

Also note that after a while, the allocator fills up all the good stripes
between the bad stripes, but it can't fill the bad stripes because they
keep getting returned to free space at the end of each transaction.
If there are a lot of bad stripes on the filesystem, bad stripes move
to the the head of the free space list where they accumulate over time.
We might end up dropping hundreds or thousands of extents before we
finally allocate something in a good stripe.

During my original failure event I did notice that these dropped writes
seemed to come in "waves", but I couldn't reproduce that effect.  Now I
know how to trigger it.

> I think we should change the behavior of clearing dirty flags, so that the
> dirty page flag only got cleared if the writeback is successful.

The entire page is deleted, so it stops having any flags.

> This change is going to be huge

Yeah, all the real solutions are far more development work, and have more
ways to fail, than handing everything with a better best-effort in RMW.

In the short term, it's more important to fix the RMW regression as soon
as possible, so that users with raid5 filesystems can upgrade from 6.1 to
later kernels without having worse data loss problems than 6.1 had in the
supported cases (drive failures <= tolerance).  The most straightforward
way to do that is to handle everything we can within rmw_rbio.

Once the larger fixes are in place, so that btrfs can handle a dropped
data write or so that btrfs doesn't need to do RMW any more, we can then
go back to strictly failing RMW on uncorrectable raid56 stripes.  It's
too early to do that now.

Best-effort RMW has low marginal risk of data loss, whereas aborting RMW
absolutely guarantees data loss.  As you point out, none of the data loss
cases arise when the stripe is within correctable tolerances, i.e. you
need to start with too many failures so that you have uncorrectable
sectors, and we don't claim that btrfs can recover data in that case even
without RMW updates.  If errors are within tolerance, they're correctable,
so rmw_rbio will simply correct them.

I propose 3 phases of fix:

1.  One-line patch to ignore recover_blocks return value, to get raid56
writes working in the presence of uncorrectable sectors again.

2.  Fix up the rbio handling so that we can compute P/Q for RMW stripes
even with uncorrectable sectors, so that we don't make a mess on
uncorrectable sectors (discussed in more detail below).

3.  Fix the upper layers of btrfs so that we can have write bbios fail
and not lose data in general.

> and I have to check other fses to be extra
> safe.

No other filesystem tries to do parity RMW writes with data csums, because
that's a bad system design choice that they were able to avoid making.
Only btrfs has btrfs problems.  ;)

Other filesystems use strictly immutable extents with parity embedded
within them (ZFS), or they use allocators that aggressively coalesce
allocations and writes so that all parity raid writes are full-stripe
writes with garbage collection (bcachefs).

Parity raid block devices don't have csums.  They don't have to handle
corrupted block because they don't know if any block is corrupted or not.
They simply update the P/Q blocks whenever enough devices are readable,
and go completely read-only if too many are not readable.

> But even with that fixed, the do-not-touch-bad-full-stripe policy is not
> doing anything helpful, unless the corrupted sector get full deleted, which
> can be very hard detect.
> 
> Maybe you can try a different recovery behavior?
> 
> E.g. always read the file, and the read failed, delete and then copy a new
> one from the backup server.
> 
> Then it may solve the problem as the bad sectors would be deleted (along
> with its csum)

There's some problems with this:

- The falures occur when rmw_rbio reads a file that happens to share
a raid5 stripe with the extent we are trying to create.  The files are
not related in any way except for the position of some of their blocks
on disk.  Finding these files takes time.  Scrub takes a long time
(weeks) and 'find -type f...' may not find the bad sectors at all, so
there's a high risk that a writer will discover an uncorrectable sector
before anything else does, and in that case the first signal that we
have a problem is silent data loss.

- While researching all this, I discovered that in 6.4, 1009254bf22a
("btrfs: scrub: use scrub_stripe to implement RAID56 P/Q scrub") scrub is
broken:  it aborts on the first stripe with an uncorrectable sector.
So users can't discover more than one uncorrectable sector at a time.

- Even if we know of a bad file, we can't replace the bad file because
it requires us to have reliable writes to the filesystem.  All files
referencing bad stripes have to be removed before any replacement files
can be loaded onto the filesystem.  That's a weeks-long interruption
in service, and poses some logistical issues (e.g. temporary additional
space to store the files we can't write to the original filesystem).

- Once the allocator has found an uncorrectable sector, write failures
happen continually, at increasing rates.  It only stops when _every_
uncorrectable sector is removed from the filesystem.  This is not a
proportional response to a single bad sector, especially when it's so
easy to fix.

In kernel 6.1 and earlier, a damaged btrfs raid5 filesystem has no
availability for writes because bugs in RMW would corrupt good data
if we write to the filesystem.  We can write to our filesystems only
because we have a full replica of all the data somewhere else, so the
btrfs bugs only cause corruption in files we can replace.  Ours is
a specialist application.  6.1's raid5 isn't usable as a rootfs or
unreplicated primary data store.

In kernel 6.2 and later, a damaged btrfs raid5 filesystem has no
availability for writes because we can't be sure that the filesystem
doesn't have any uncorrectable stripes.  If at least one uncorrectable
stripe exists, we can't expect any data we write to stick.  This
makes 6.2 and later unusable as a rootfs or unreplicated primary data
store, even though the corruption bugs in 6.1 were fixed.


This patch makes RMW work again, mostly:

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 39bec672df0c..2964ff380671 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2277,7 +2277,13 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
         * and csum mismatch), just let recover_sectors() to handle them all.
         */
        submit_read_wait_bio_list(rbio, &bio_list);
-       return recover_sectors(rbio);
+       recover_sectors(rbio);
+       /*
+        * Whether we recover corrupted sectors or not, we must proceed
+        * with the rmw operation, or we will drop the extent we are
+        * trying to write.
+        */
+       return 0;
 }
 
 static void raid_wait_write_end_io(struct bio *bio)

With that patch, my raid5 test cases work for the first time since I wrote
them in 2016:  writes are fully available, and there's no new corruption
of existing files (any uncorrectable sectors remain uncorrectable and
no new ones appear).  It's good enough to unblock users who are currently
stuck on 6.1 due to the RMW regression.

For the "mostly":  there are some unresolved issues.  With the above
patch, the set of uncorrectable sectors is stable (nothing that wasn't
corrupted before gets corrupted by RMW), but the _contents_ of the
uncorrectable sectors get replaced with garbage, because the code isn't
leaving the stripe data in a usable state for P/Q update, and it always
writes out the full stripe including known garbage data.  P/Q does match
the garbage, so the stripe will work in degraded mode for the new data.

The rmw code has to do something like this:

1.  do the R operation:  for unreadable blocks, zero-fill the block

2.  for readable blocks, verify csums (no change)

3.  reconstruct missing or corrupt blocks in separate memory from the
block read from disk (i.e. don't overwrite in place)

4.  verify again.  If verification fails, keep the original version
of the data (or zeros if the block could not be read).

5.  keep track of which blocks are bad, i.e. don't clear error_bitmap
in rmw_rbio unless the block verifies OK

6.  do the M operation:  modify the blocks to be written, and compute
new P/Q blocks for the stripe.

7.  clear the bad bits for the modified blocks and the P/Q blocks.

8.  do the W operation:  write out only the blocks that are not marked
as bad, i.e. the corrected blocks, the modified blocks, and the P/Q
blocks.  If a block can't be corrected, don't write it out, to give
the device another chance to get the data on the next read.

9.  if too many writes fail, then rmw_rbio can return an error.
(Note: this last line opens up a can of worms for the read error
handling cases)



For scrub, the problem is that scrub_raid56_parity_stripe exits the entire
scrub loop when it sees an unrepaired sector, instead of continuing to
the next stripe.  Everything else there is OK, it's a one-line fix:

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c7fcb6408eb6..12c3ce0efafa 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1972,7 +1972,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 "unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
                                  full_stripe_start, i, stripe->nr_sectors,
                                  &error);
-                       ret = -EIO;
+                       ret = 0;
                        goto out;
                }
                bitmap_or(&extent_bitmap, &extent_bitmap,

I'll post these patches separately.


> Thanks,
> Qu

