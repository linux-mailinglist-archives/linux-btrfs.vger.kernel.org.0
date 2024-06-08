Return-Path: <linux-btrfs+bounces-5563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C519F900F28
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 03:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00271C210FF
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 01:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60618C1A;
	Sat,  8 Jun 2024 01:55:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B763C8
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717811754; cv=none; b=jbRyjY+Fzhll42lWKEu3xio3WxvcCwMzsDRa5AWNafdstKbCQMW7vZMlu4ayay2ZaLeGwkMFYBYlrOpHKrPT+KdjcJ3XQEGw60foxPRCgUcJFaDNIe3UTrMvRFX4CLwuIM+C/3syLLfUYHAeU2MxbG9neytRZUy4y66YNyz3tiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717811754; c=relaxed/simple;
	bh=HN2mNSAl88FK2mJZzNO/2tXM+WWuKJgWxizgUVR7QI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A948AnQjtpL0UUFGUlhTeCMW0Nc6HriTcUzl0eqmvnttssNd8bhyUutfHZC0AiM26h1U0t3Mbg+6Zj0l5NFHig1sIsAnepvt42U1IB7PA0bViQB/Gg2kb2jJv7HbnXBqRmpqqCOryMInn8PmgdwoLqbsWAeL7GqHXKGKfgTZxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id 00071E3D6F2; Fri,  7 Jun 2024 21:55:44 -0400 (EDT)
Date: Fri, 7 Jun 2024 21:55:44 -0400
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: raid5 silent data loss in 6.2 and later, after "7a3150723061
 btrfs: raid56: do data csum verification during RMW cycle"
Message-ID: <ZmO6IPV0aEirG5Vk@hungrycats.org>
References: <ZlqUe+U9hJ87jJiq@hungrycats.org>
 <a9d16fd4-2fec-40c7-94cc-c53aa208c9b9@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9d16fd4-2fec-40c7-94cc-c53aa208c9b9@gmx.com>

On Sat, Jun 01, 2024 at 05:22:46PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/6/1 12:54, Zygo Blaxell 写道:
> > There is a new silent data loss bug in kernel 6.2 and later.
> > The requirements for the bug are:
> > 
> > 	1.  6.2 or later kernel
> > 	2.  raid5 data in the filesystem
> > 	3.  one device severely corrupted
> > 	4.  some free space fragmentation to trigger a lot of rmw cycles
> 
> I'm still not convinced this can be the condition to trigger the bug.
> 
> As RAID56 now does csum verification before RMW, even if some range is
> fully corrupted, as long as the recovered data matches csum, it would
> use the recovered data instead.
> 
> And if any vertical stripe is not good, the whole RMW cycle would error out.

> [...]
> > --------
> > 
> > In the commit, I notice that when reading the rmw stripe, any blocks with
> > csum errors are flagged in rbio->error_bitmap, but nothing ever clears
> > those error bits once they are set.
> 
> Nope, rmw_rbio() would call bitmap_clear() on the error_bitmap before
> doing any RMW.

This is true, but the code looks like this:

                ret = rmw_read_wait_recover(rbio);
                if (ret < 0)
                        goto out;
        }

[some other stuff]

        bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);

The problem happens before the bitmap_clear, at `goto out`.  Actually it
happens in rmw_read_wait_recover() (formerly rmw_read_and_wait()),
because that function now changes 'ret' if the repair fails:

@@ -2136,6 +2215,12 @@ static int rmw_read_and_wait(struct btrfs_raid_bio *rbio)

        submit_read_bios(rbio, &bio_list);
        wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+
+       /*
+        * We may or may not have any corrupted sectors (including missing dev
+        * and csum mismatch), just let recover_sectors() to handle them all.
+        */
+       ret = recover_sectors(rbio);
        return ret;
 out:
        while ((bio = bio_list_pop(&bio_list)))

Before this change, if all the blocks in the stripe were readable, we
would recompute parity based on the data that was read, and proceed
to finish the rbio.  As long as the writes were also successful,
the new blocks that were written would be updated and recoverable.
(The old unrecoverable blocks would still be unrecoverable, but there's
no fixing those.)

After this change, we now end up in an infinite loop:

1.  Allocator picks a stripe with some unrecoverable csum blocks
and some free blocks

2.  Writeback tries to put data in the stripe

3.  rmw_rbio aborts after it can't repair the existing blocks

4.  Writeback deletes the extent, often silently (the application
has to use fsync to detect it)

5.  Go to step 1, where the allocator picks the same blocks again

The effect is pretty dramatic--even a single unrecoverable sector in
one stripe will bring an application server to its knees, constantly
discarding an application's data whenever it tries to write.  Once the
allocator reaches the point where the "next" block is in a bad rmw stripe,
it keeps allocating that same block over and over again.

So there are some different cases to handle at this point:

1.  We can read all the blocks and they have good csums:  proceed
to write data and update parity.  This is the normal good case.

2.  We can read all the blocks, there are csums failures, but they
can be repaired:  proceed to write data and update parity.  This is
the case fixed in the patch.

3.  We can read all the blocks, there are csums failures, but they
can't be repaired:  proceed to write data and update parity.  This case
is broken in the patch.  The data in the unrecoverable blocks is lost
already, but we can still write the new data in the stripe and update
the parity to recover the new blocks if we go into degraded mode in
the future.

4.  We can read enough of the blocks to attempt repair, and the
repair succeeds:  proceed to write data and update parity.  This is
the degraded good case.

5.  We can read enough of the blocks to attempt repair, and the
repair fails:  proceed to write data and update parity.  The lost
data block is gone, but we can still write the new data blocks and
compute a usable parity block.  This is another case broken by the
patch, the degraded-mode version of case 3.

6.  We can't read enough of the blocks to attempt repair:  we can't
compute parity any more, because we don't know what data is in the
missing blocks.  We can't assume it's some constant value (e.g. zero)
because then the new parity would be wrong if some but not all of the
failing drives came back.  

For case 1-5, we can ignore the return value of verify_one_sector()
(or at least not pass it up to the caller of recover_vertical()).
Either we restored the sector we didn't, but either outcome doesn't
affect whether a new parity block can be computed to enable recovery of
the new data blocks and the remaining recoverable data blocks.  The other
error cases in recover_vertical() are either fatal problems like ENOMEM,
or there's too many read failures and we're actually in case 6.

For case 6, the options are:

A.  abort the rbio and drop the write

B.  force the filesystem read-only

I like B for this case, but AIUI the other btrfs raid profiles currently
do A if all the data block mirror writes fail.

> The same for finish_parity_scrub(), scrub_rbio().
> 
> Yes, this means we can have the cache rbio with error bitmap, but it
> doesn't make any difference, as rmw_rbio() is always the entrance for a
> RMW cycle.
> 
> Maybe I can enhance that by clearing the error bitmap after everything
> is done, but I prefer to get a proper cause analyse before doing any
> random fix.
> 
> [...]
> > 
> > My third experiment breaks the error recovery code, but it does prevent
> > the sync failures and missing extent holes, so it shows that the error
> > recovery code itself is not what is causing the dropped writes--it's
> > the bits left set in error_bitmap after recovery is done.
> 
> Yep, that's expected.

> So I'm more interested in a proper (better minimal) reproducer other
> than any fix attempt (since there is no patch sent, it already shows the
> attempt failed).

> > 
> > 
> > Test Case
> > ---------
> > 
> > My test case uses three loops running in parallel on a 500 GiB test filesystem:
> > 
> > 		    Data      Metadata System
> > 	Id Path     RAID5     RAID1    RAID1    Unallocated Total     Slack
> > 	-- -------- --------- -------- -------- ----------- --------- --------
> > 	 1 /dev/vdb  71.00GiB  1.00GiB  8.00MiB   647.99GiB 720.00GiB 19.59GiB
> > 	 2 /dev/vdc  71.00GiB  1.00GiB  8.00MiB   647.99GiB 720.00GiB  3.71GiB
> > 	 3 /dev/vdd  71.00GiB  2.00GiB        -   647.00GiB 720.00GiB  3.71GiB
> > 	 4 /dev/vde  71.00GiB  2.00GiB        -   647.00GiB 720.00GiB 11.00GiB
> > 	 5 /dev/vdf  71.00GiB  2.00GiB        -   647.00GiB 720.00GiB 11.00GiB
> > 	-- -------- --------- -------- -------- ----------- --------- --------
> > 	   Total    284.00GiB  4.00GiB  8.00MiB     3.16TiB   3.52TiB 49.02GiB
> > 	   Used     262.97GiB  2.61GiB 64.00KiB
> > 
> > The data is a random collection of small files, half of which have been deleted
> > to make lots of small free space holes for rmw.
> > 
> > Loop 1 alternates between corrupting device 3 and repairing it with scrub:
> 
> The reproducer is not good enough, in fact it's pretty bad...
> 
> Using anything not normalized is never a good way to reproduce, but I
> guess it's already the best scenario you have.
> 
> Can you try to do it with newly created fs instead?

Already did (I needed to do that many times to run bisect...).

> > 	while true; do
> > 		# Any big file will do, usually faster than /dev/random
> > 		# Skipping the first 1M leaves the superblock intact
> > 		while cat vmlinux; do :; done | dd of=/dev/vdd bs=1024k seek=1
> > 		# This should fix all the corruption as long as there are no
> > 		# reads or writes anywhere on the filesystem
> > 		btrfs scrub start -Bd /dev/vdd
> > 	done
> 
> [IMPROVE THE TEST]
> If you want to cause interleaved free space, just create a ton of 4K
> files, and delete them interleavely.
> 
> And instead of vmlinux or whatever file, you can always go with
> randomly/pattern filled file, and saves its md5sum to do verification.

> [MY CURRENT GUESS]
> My current guess is some race with dd corruption and RMW.
> AFAIK the last time I am working on RAID56, I always do a offline
> corruption (aka, with fs unmounted) and it always works like a charm.
> 
> So the running corruption may be a point of concern.

Generally, we expect the hardware to introduce corruption at any time.
Ideally, a btrfs raid[156] should be able to work when one of its devices
returns 4K blocks from /dev/random on every read, and if it can't,
that's always a bug.

> Another thing is, if a full stripe is determined to have unrepairable
> data, no RMW can be done on that full stripe forever (unless one
> manually fixed the problem).

Yeah, that's the serious new problem introduced in this patch for 6.2.
6.1 didn't do that in two cases where 6.2 and later do.

> So if by somehow you corrupted the full stripe by just corrupting one
> device (maybe some existing csum mismatch etc?), then the full stripe
> would never be written back, thus causing the data not to be written back.

My reproducer wasn't sufficient to trigger the bug--it would only generate
csum errors on one device, but there need to be csum errors on two devices
(for raid5) to get into the data-loss loop.  Apparently 6.2 still has
a bug somewhere that introduces extra errors (it crashes a lot, that
might be related), because when I tested on 6.2 I was observing the
two-csum-failure case not the intended one-csum-failure case.

6.6 and 6.9 don't have any of those problems--no crashes, no cross-device
corruption. I've been running the reproducer on 6.6 and 6.9 for a week
now, and there are no csum failures on any device other than the one
being intentionally corrupted, and there are no data losses because the
code never hits the "goto out" line in rmw_rbio (confirmed with both
a kgdb breakpoint on the test kernel and some printk's).  So on 6.6
and 6.9 btrfs fixes everything my reproducer throws at it.

It was a bad reproducer.  Sorry about that!

> Finally for the lack of any dmesg, it's indeed a problem, that there is
> *NO* error message at all if we failed to recover a full stripe.
> Just check recover_sectors() call and its callers.

The trouble with dmesg errors is that there are so many of them when
there's a failure of a wide RAID5 stripe, and they can end up ratelimited,
so admins can't see all of them.  But they're also better than nothing
for case 6, so I approve adding a new one here.

For case 6, it might be reasonable to throw the entire filesystem
read-only; otherwise, there's silent data loss, and not having silent
data loss is a critical feature of btrfs.  It would still be possible
to scrub, find the affected files, and remove them, without triggering a
rmw cycle.  Maybe some future btrfs enhancement could handle it better,
but for now a dead stop is better than any amount of silent loss.

One possible such enhancement is to keep the blocks from being
allocated again, e.g. put them on an in-memory list to break the
allocate-write-fail-free-allocate loop above.

Having said that, I think the other raid1* profiles actually do drop
writes silently when all mirror writes fail for a data block.  Maybe we
can have a sysfs flag to decide what to do in that case: continue with
EIO on fsync as we do now, or go fully RO.

> And I believe that may contribute to the confusion, that btrfs consider
> the fs is fine, meanwhile it catches tons of error and abort all writes
> to that full stripes.

> I appreciate the effort you put into this case, but I really hope to get
> a more reproducible procedure, or it's really hard to say what is going
> wrong.

Thanks for the tip on bitmap_clear() - it led me straight to the problem,
even before you explained it a few pages further on...

> If needed I can craft some debug patches for you to test, but I believe
> you won't really want to run testing kernels on your large RAID5 array
> anyway.

I have plenty of VMs for testing kernel patches if you have some.

We run every kernel through a gauntlet of tests on staging VMs.  Those
tests cases didn't have any coverage for raid5 corruption recovery on
read because it doesn't work on any prior kernel version (only recovery
on scrub was tested).  That gap let 6.6 kernels get through acceptance
and deployment, and led to a server getting rebooted from 6.1 to 6.6
in the middle of a pvmove to replace a drive, which combined massive
corruption of one disk, 6.1's bug, and 6.2's bug.  That didn't end well.
Fortunately we keep only redundant data on raid5.

To fix the original failing RAID5 array, we reverted to 6.1, which
allowed the server to operate more or less normally for a few weeks
during recovery.  We did have 6.1's cross-device error-propagation bug
(ironically the one fixed in this patch), but that bug was far more
manageable because we already had automation in place to detect any data
that was lost and replace it from another server.  Scrub combined with
rewriting broken files eventually eliminated all the errors.

On 6.6, all the automation was broken by the regression: when we replaced
a broken file or added a new one, the new file was almost always silently
corrupted, and we had no IO error signal to trigger replacement of the
data from another server, so corrupted files became visible to users.
git-based tools for deployment were fully unusable on 6.6:  any commit
would break the local repo, while deleting and recloning the repo simply
hit the same broken stripe rmw bug and broke the replacement repo.

At the end of recovery we did a full verification of SHA hashes and
found only a few errors, all in files that were created or modified
while running 6.6.

> So a more normalized test would help us both.
> 
> Thanks,
> Qu
> 
> > 
> > Loop 2 runs `sync -f` to detect sync errors and drops caches:
> > 
> > 	while true; do
> > 		# Sometimes throws EIO
> > 		sync -f /testfs
> > 		sysctl vm.drop_caches=3
> > 		sleep 9
> > 	done
> > 
> > Loop 3 does some random git activity on a clone of the 'btrfs-progs'
> > repo to detect lost writes at the application level:
> > 
> > 	while true; do
> > 		cd /testfs/btrfs-progs
> > 		# Sometimes fails complaining about various files being corrupted
> > 		find * -type f -print | unsort -r | while read -r x; do
> > 			date >> "$x"
> > 			git commit -am"Modifying $x"
> > 		done
> > 		git repack -a
> > 	done
> > 
> > The errors occur on the sync -f and various git commands, e.g.:
> > 
> > 	sync: error syncing '/media/testfs/': Input/output error
> > 	vm.drop_caches = 3
> > 
> > 	error: object file .git/objects/39/c876ad9b9af9f5410246d9a3d6bbc331677ee5 is empty
> > 	fatal: loose object 39c876ad9b9af9f5410246d9a3d6bbc331677ee5 (stored in .git/objects/39/c876ad9b9af9f5410246d9a3d6bbc331677ee5) is corrupt
> > 

