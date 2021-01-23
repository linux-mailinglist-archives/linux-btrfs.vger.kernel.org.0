Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28981301718
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 18:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbhAWROG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 12:14:06 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35356 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAWROF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 12:14:05 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8EB11951445; Sat, 23 Jan 2021 12:13:22 -0500 (EST)
Date:   Sat, 23 Jan 2021 12:13:22 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     alexino@cobios.de
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: performance implications of btrfs filesystem sync vs btrfs
 subvolume snaphot
Message-ID: <20210123171322.GO31381@hungrycats.org>
References: <50f51b01788af83b1bf542f2089a56fe@cobios.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f51b01788af83b1bf542f2089a56fe@cobios.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 23, 2021 at 12:22:11PM +0000, alexino@cobios.de wrote:
> Hello everybody :)
> 
> first time participant on linux-btrfs@vger.kernel.org mailinglist, 
> hence please excuse (yet tell me about) any problems. thank you.
> 
> My question/topic is:
> Wanting to generate backups of a btrfs filesystems on a running system
> it seems that using `btrfs subvolume snapshot` would be a possible way
> to make certain that data kept in RAM (i.e. buffer/cache) would be 
> synced to the disk.  
> 
> Reading this mailing list I stumpled upon this:
> 
> >> Subject:    Re: freezes during snapshot creation/deletion -- to be expected? (Was: Re: btrfs based backup?)
> >> From:       Zygo Blaxell <ce3g8jdj () umail ! furryterror ! org>
> >>
> >> [..]
> >>
> >> Snapshot create has unbounded running time on 5.0 kernels.  The creation
> >> process has to flush dirty buffers to the filesystem to get a clean
> >> snapshot state.  Any process that is writing data while the flush is
> >> running gets its data included in the snapshot flush, so in the worst
> >> possible case, the snapshot flush never ends (unless you run out of disk
> >> space, or whatever was writing new data stops, whichever comes first).
> >> [..]
> 
> Now I wonder that if `btrfs filesystem sync` would be a viable alternative 
> to `btrfs subvolume snapshot`, with respect of not having to risk a 
> "snapshot flush never ends" situation? 
> 
> My layman perception is that.
> 
> 1) "btrfs on-disk-persistet data is ideally alway non-corrupted". Since
> changes are commited via COW and hence in a atomic fashion, meaning that
> at worst data on disk is outdated, but never corrupt. (unless hardware or 
> blockdevice issues )
> 
> 2) btrfs filesystem sync or sync(1) should flush data out from memory
> to disk - which would once finished - lead to a "more recent" consistent
> data on disk. 

> 3) btrfs subvolume snapshot implies a sync
>
> Are those perceptions roughly correct?

1 and 2 are flipped--data is written first, then metadata pointing to
the data, then superblocks pointing to the metadata; however, delalloc
can delay data writes that occurred before the current commit so they
don't reach the disk until after the current commit.  In that case,
the following commit will reference the delayed data.

So with noflushonocommit, by default, assuming nobody ever calls
fsync(), we get:

	1.  process does some writes 1, 2, 3, 4, 5...

	2.  delalloc puts writes 1, 2, 3 on disk, updates in-memory
	metadata

	3.  kernel commit starts, flushes in-memory metadata to disk for
	writes 1, 2, 3.  4 and 5 are not complete yet so no metadata
	points to them.  Inodes are updated (especially file size),
	so after a crash we will have data for 1, 2, 3, and holes for
	4 and 5 (this is why noflushoncommit is bad).

	4.  metadata written to disk, disk write barrier prevents and
	writes after this line from being reordered before this line.

	5.  superblock updated to point to root of new metadata trees,
	disk write barrier again.

	6.  meanwhile delalloc was still writing out 4 and 5 to disk.
	No metadata points to them during the write, so incomplete writes
	don't matter; however, once the writes are complete, in-memory
	metadata is updated to point to them.

	7.  also meanwhile the process wrote more data writes 6, 7, 8
	which delalloc hasn't processed yet.

	8.  kernel commit starts, flushes in-memory metadata to disk for
	writes 4, 5 which are now done, but not 6, 7, 8 because delalloc
	hasn't started them yet.  Inodes are updated, now after a crash
	we have data for 1-5 but holes for 6, 7, or 8.

With 'flushoncommit', 'btrfs sub snap', and 'sync', the commit at step
3 waits for all delalloc writes to finish first, which fills in all
the holes that 'noflushoncommit' would normally leave behind and gives
snapshots their atomic behavior; however, delalloc at step 6 and the
process at step 7 may not be blocked, and they can keep adding more
writes to the transaction while the transaction commits.

> If so I am unsure if the issue with a "neverending flush" is related to
> the btrfs filesystem sync and consequently relying on btrfs filesystem 
> sync as alternative to btrfs snapshot to prevent "a neverending flush"
> is not a possibility. 

The issue is that processes can queue up more work for delalloc writes
while a sync is running.  If they can do that faster than the sync can
flush the data to disk, and if the disk still has remaining space for
metadata and data writes, then the transaction never gets to the point
where it has finished flushing out new data, so the sync runs until the
filesystem runs out of space.

Note the filesystem can't delete anything while a commit is running
(deletes are implied by the change in free space maps after a transaction
commit, so nothing gets deleted until a transaction commit is completed).
We _are_ guaranteed to eventually run out of space and complete or abort
this transaction, even if the process is overwriting data in the same
logical locations or deleting files as it goes.

There was a patch which corrects this for the one subvol that is directly
involved in the snapshot.  So

	cat /dev/zero > /mnt/sub1/file &
	btrfs sub snap /mnt/sub1 /mnt/snap1

no longer runs forever, because all of the writes before the sub snap
starts are tagged differently from all of the writes after the sub snap
starts, and the sub snap only waits for writes with the "before" tag.
Thus, the sub snap is guaranteed to finish in bounded time (proportional
to the size of vm.dirty_bytes).  Unfortunately, the patch that does this
(v5.0-rc1: 3cd24c698004 "btrfs: use tagged writepage to mitigate livelock
of snapshot") doesn't handle this case:

	cat /dev/zero > /mnt/sub1/file &
	btrfs sub snap /mnt/sub2 /mnt/snap2

because it only tags the subvolume that is being snapshotted--it still
has the unbounded running time for writes to any _other_ subvol.
A similar problem happens for sync, except sync doesn't even have the
above mitigation.

> Tahnk yo and best regards,
> 
> Alexander Mahr
