Return-Path: <linux-btrfs+bounces-6309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F392AA7D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 22:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B812830E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2945214B963;
	Mon,  8 Jul 2024 20:22:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF20146A98
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470157; cv=none; b=tS+DAT9sCanGW2AwN3qpVP/WwTPeH/OdH5fxHLGVKkf421gPk8jcj/bRXC/lYfoXM4jCYbjifW0hk7yvc1ORTsM/AZi/fH4F/yXybOXgNw2x+znIN9/ao2ebARoMqTqlzgnWffPr43StaUDgdR575i6G9TH9LAGYjP2h3UrXMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470157; c=relaxed/simple;
	bh=PTeSXSiyqBS6JR5ylCjxnmoJMy4yYyZIB3Qw0XnZVDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSxhJhbTWseG16uckgzfUcaSjiVeJb4PYgHpXbE67erM0GxCsEdMgI/XzWLhjoCJoLmNuZ4PvxMxTWlUdFV+9kfyXwMYzI4toZtDU1+brxqd7JPZFWFfXlCpKXkY4piP0EcFEssRcK1JEbYfVTkvvbiViigYdXiKpZmHl9UWfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id 68DE3EB2CFF; Mon,  8 Jul 2024 16:22:34 -0400 (EDT)
Date: Mon, 8 Jul 2024 16:22:34 -0400
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: Lukas Straub <lukasstraub2@web.de>
Cc: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	linux-btrfs@vger.kernel.org
Subject: Write error handling in btrfs (was: Re: raid5 silent data loss in
 6.2 and later, after "7a3150723061 btrfs: raid56: do data csum verification
 during RMW cycle")
Message-ID: <ZoxKitr-yaMAyVa7@hungrycats.org>
References: <ZlqUe+U9hJ87jJiq@hungrycats.org>
 <a9d16fd4-2fec-40c7-94cc-c53aa208c9b9@gmx.com>
 <ZmO6IPV0aEirG5Vk@hungrycats.org>
 <5a8c1fbf-3065-4cea-9cf9-48e49806707d@suse.com>
 <ZouGYZWkKM_W4hby@hungrycats.org>
 <20240708100927.652b2bc7@penguin>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708100927.652b2bc7@penguin>

On Mon, Jul 08, 2024 at 10:26:32AM +0200, Lukas Straub wrote:
> > I found the code that does this.  It's more than 11 years old:
> > 
> > commit 0bec9ef525e33233d7739b71be83bb78746f6e94
> > Author: Josef Bacik <jbacik@fusionio.com>
> > Date:   Thu Jan 31 14:58:00 2013 -0500
> > 
> >     Btrfs: unreserve space if our ordered extent fails to work
> > 
> >     When a transaction aborts or there's an EIO on an ordered extent or any
> >     error really we will not free up the space we reserved for this ordered
> >     extent.  This results in warnings from the block group cache cleanup in the
> >     case of a transaction abort, or leaking space in the case of EIO on an
> >     ordered extent.  Fix this up by free'ing the reserved space if we have an
> >     error at all trying to complete an ordered extent.  Thanks,
> > 
> > [...]
> 
> Before this escalates further in IMHO the wrong direction:

Now we're drifting away from raid56-specific issues, and into general
btrfs write error handling theory.  OK, I'm up for that...

> I think the current btrfs behavior correct. See also this paper[1] that
> examines write failure of buffered io in different filesystems.
> Especially Table 2. Ext4 and xfs for example do not discard the page
> cache on write failure, but this is worse since now you have a mismatch
> of what is in the cache and what is on disk. They do not retry to write
> back the page cache.

ext4 and xfs don't retry the write, but they also don't deallocate the
block from the filesystem, then try to use the same block immediately
in a future allocation.  Of the filesystems in the paper, only btrfs
does write-failure data loss in a rapidly cycling _loop_.

xfs and ext4 (and btrfs on a nodatacow file) leave the failing extent
allocated, so future reads return garbage, but future created or extended
files pick different, hopefully error-free sectors on the disk.  ext4 and
xfs thus avoid having a data loss loop, more or less accidentally.

We could replicate that to break the loop on btrfs, by introducing an
"IOERROR" extent type.  This would be like a PREALLOC extent, in the sense
that it reserves space on disk without writing data to the space, but it
would be always datacow for write, and always return EIO on read instead
of zero-fill.  Scrub would not attempt reading such an extent, and would
report it as a distinct failure type from the existing read/csum/write/etc
failures.  Balance would make IOERROR extent references point to a
zero bytenr when they are relocated (so they become IOERROR holes in
files, with no physical extent behind them, and so that balance can
dispose of the block group without tripping over an IO error itself).
btrfs send would transmit them, btrfs receive would replicate them,
btrfs qgroup would count their space if they have a physical extent
(i.e. they're not a synthetic extent created by balance or receive).
IOERROR extents would persist until they are deleted by a user action,
like removing the file, or overwriting the entire extent.

An IOERROR extent would be created by flipping a few bits in the extent
item when the write failure is detected, then proceeding to write out
the extent metadata for the lost extent data (instead of deleting it).
This breaks the loop after btrfs writes to a broken sector (or at least
pauses the loop until the user deletes the broken file and releases the
broken sectors for another allocation).  IOERROR doesn't need additional
space like retries do, since we're writing out the same number of extents
to disk that we already have reserved, so an IO error can't cascade to
an ENOSPC error.

IOERROR extents break the rapid data loss loop and replicate the better
behaviors of ext4 and xfs, without introducing their bad behaviors to
btrfs.  Users can reliably detect lost data after the fact by reading
the files or running scrub, so they don't need to rely on unreliable
and invasive methods like fsync() or syncfs() for detection.

It's an interesting idea for future enhancement, but it's no
solution to the rmw regression.  It just breaks the loop and makes
write-error-extent-drop detection easier, but the problem for rmw is
that the write errors shouldn't happen in the first place.

> The source of confusion here is rather that write errors do not happen
> in the real world: Disks do not verify if they wrote data correctly and
> neither does any layer (raid, etc.) above it.

Disks do go offline in the real world, and that presents as write errors.
I've had systems running raid1 where 2 disks go offline, but neither
disk contains any metadata, so btrfs runs the write-delete-repeat data
loss loop for many hours.  I didn't care much about that, because raid1
isn't expected to work with 2 disks offline, but I do care about raid5
not working with 0 disks offline.

There are some small changes we can make to error handling that might
quickly improve things for users.  While debugging the RMW issues,
I have been using a patch that makes the extent drops visible in dmesg:

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f38eefc8acd..be3cda596bb8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3214,6 +3214,22 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
                    clear_reserved_extent &&
                    !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
                    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
+                       /*
+                        * Notify the user that some data has been lost due
+                        * to an error, unless we were already expected to
+                        * remove the data because of truncate.
+                        *
+                        * Put both logical and physical addresses here
+                        * because we're about to remove the mapping that
+                        * would have allowed the user to translate from
+                        * one to the other.
+                        */
+                       if (ret && !truncated)
+                               btrfs_err_rl(fs_info,
+"dropping unwritten extent at root %lld ino %llu offset [%llu,%llu] physical %llu length %llu",
+                                       btrfs_root_id(inode->root), btrfs_ino(inode),
+                                       unwritten_start, end, ordered_extent->disk_bytenr,
+                                       ordered_extent->disk_num_bytes);
                        /*
                         * Discard the range before returning it back to the
                         * free space pool


This has been useful when debugging the RMW issue, and valuable on
production filesystems too.  It also lights up when some of the other
recently fixed data loss bugs in btrfs are reproduced during bisection
searches.  I'll submit that as a patch separately.

That new 'if' statement could easily check a mount flag, and throw in
a courtesy call to btrfs_abort_transaction or btrfs_panic if set.  That
would be welcome for users who value data consistency over availability.
I've seen several prospective btrfs users go back to ext4/xfs because
btrfs doesn't support 'errors=remount-ro' or 'errors=panic' for data
writes, and they absolutely prefer to crash instead running with known
inconsistent data anywhere in the filesystem.

btrfs could also do stats counting for dropped extents somewhere,
but it can't use dev stats exactly as the event is happening above the
individual device level.  We'd need a different stats item for that.

> Thus handling of write failure is completely untested in all
> applications (See the paper again) and it seems the problems you see
> are due to wrongly handling of write errors. 

Not quite.  It's a failure of expectations between two components of
btrfs, and fixes can be implemented in either or both components.

The new RMW code assumed that the ordered-data error-handling code would
recover from RMW returning a synthetic write error and preserve the data,
but that assumption is wrong:  the ordered-data error-handling code has
never done that.  The data is lost in kernel 6.2 and later, because both
of these subsystems now assume the other will work around the dependent
read failures and get the data written somewhere.  In kernel 6.1 and
earlier, the raid5 component was responsible for working around the
read failures during writes, so there was no need for ordered data to
handle them.

> The data loss is not
> silent it's just that many applications and scripts do not use fsync()
> at all.

fsync()'s return value is a terrible non-solution.  Diagnostic coverage
is less than 100% and not all of the gaps can be eliminated (e.g. if
you're running syncfs() in a continuous loop, you don't get notified if
writebacks win races against you).  It's invasive, relying on the entire
workload to be redesigned so that processes can stick around until writes
finish without blocking everything on IO performance (try that with a
parallel Makefile tree near you).  The engineering hours and runtime cost
of application-level synchronous monitoring of every individual write
isn't reasonable for an event that is extremely rare for a properly
provisioned and monitored redundant RAID system, and generally considered
catastrophic if it should occur.

I guess I'm agreeing with you there.  Many applications have good reasons
to never use fsync.

> I think the proper way of resolving this is for btrfs to retry writing
> the extent, but to another (possibly clean) stripe. Or perhaps a fresh
> raid5 block group altogether.

That's what I proposed as a long term solution, but I also propose
shorter-term fixes to fix the specific rmw regression immediately.

> I very much approve btrfs' current design of handling (and reporting)
> write errors in the most correct way possible.

I think btrfs's current handling of write errors is some distance away
from the most correct way possible, or even from the most correct
way currently implemented in a mainstream filesystem; however, it's
good enough for now, and there are more important issues that need
our attention.

> Regards,
> Lukas Straub
> 
> 
> [1] https://www.usenix.org/system/files/atc20-rebello.pdf



