Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917ED3B14EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhFWHkG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 03:40:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63437 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFWHjo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 03:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624433849; x=1655969849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wYE1VyDahZ1Q30CU9FhxmfOZbmbHnUnr5Hn/KtJegd0=;
  b=YBstdSrd/ljUqXm2DYyy25s3DFSevq+y+QYRLFXchLNx3CWCMuGSBXlh
   bdKH/BzyBu4ZWPqEWb9AmFBAMz9zh0LSJNuuWyvQJjTuiMzTM3aSGXg/a
   cLm3xltSxPWRYjRlqMrRCmr59e5YYyDtrpy2OCz23MfEb8sPuaw/WU56C
   Nx6ZQZ+skE8atccM0fL5jBfqSYiDxQyV5APSBz7RX4L7tlbY7/NZIArW4
   p1XIOX6XrmdGDsMcZ2KZIVqljEv2D9NlwmOLRotRaQLneIE/P+af4QsZK
   BQpcbDaglCidI3Q/yn00bgyDmhj1I4EXMLhmaQkot5g5So97N7HzGXQqi
   Q==;
IronPort-SDR: t06cJD5IyVJU8jJ333ewHWeI8/U+i3kFIPCwg6+MMLmLhMV1+vdzuzcxUXfucIkHmfYIeQBdJM
 kXalukHJ1fNESyHuS4PIlitjivjK2ytzstp5FFbA3DZRgX4x8oTDhq+uQ668xyr45jdOJjgy2+
 HwGMAYeGIHlLdLHODIaVURnE62bcNKKCOA1JWDKkGTRJfXOrdUCnuM+0de2qs2Xa9sSLgOIJBm
 VMnnHQfPaloH528ulVMhY80uZbwq/n0vLug15tMx8k5vLXrH9B9+atzZOibd/aBTVCfhFWkQoC
 Fow=
X-IronPort-AV: E=Sophos;i="5.83,293,1616428800"; 
   d="scan'208";a="276458303"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 15:37:27 +0800
IronPort-SDR: yV8cY4pG+SXFVzv7Rv+wGxSEY9QQzMAHjRF1p842LcBRDc70BkaiUl9qCMffcRrYJVI4oTW90Z
 ZDJdrbaFaxXgsI/MHJREgnMzTVZ0PRhydwsxKDfDq0q0wY33EuQBHUncMKSwcrdm7W+0wDCfRV
 9BlDszZ3NnuAI/fznhK/CYn4hTYiN1xXp3ismMiGFaepkh5rsC79Tjtg3fkF87FOi9N1h8QunX
 e1GebWOKS1Qz6T9oLIunbWmLYWVsPi7Cu3aGFM600rBMvWLvrhhDet3/tYJzFiQ4TT7x//yEAb
 aReY570eMCegnZV+ikdTf7dv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 00:16:02 -0700
IronPort-SDR: 6oAJo8CEzRGOJd3FO+cAVKt0OJcMsKP72ghlggUnKyQOpWnxJzFbEKUlU4YKzhYNFXl5KvX2YH
 TZBUDRG1KZDzmCuW9Bxiz639eRlY4Y8l8USHdjlN61+7FJbOKuI6B+8KM0ocsQe7wkJ2rgqvXt
 ZQywWZhDG6ThGUOorfaSgBC4rKtesZozH7GaRQlXwUUbja8Ix46WrJLtXuM2/29uOgzcV9o3ej
 ln07Qq4BjvJ8Pzwk4BrUW/h1Lj0dMqgUWuqRz46fbdP5guAUIH/cYWLqwOwsDuyYLmnhQ/PHP1
 GdY=
WDCIronportException: Internal
Received: from 75b91z2.ad.shared (HELO naota-xeon) ([10.225.50.161])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 00:37:26 -0700
Date:   Wed, 23 Jun 2021 16:37:24 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix deadlock with concurrent chunk allocations
 involving system chunks
Message-ID: <20210623073724.diltq4hd7z6t6dmo@naota-xeon>
References: <b8b7b585ec8b7b2924fd5995951a0d16d2e394d7.1624369954.git.fdmanana@suse.com>
 <20210622175811.GK28158@twin.jikos.cz>
 <CAL3q7H6tx3XG9a4=nCLyv+GG8uLJ40qLzqzUWaxTLwhqOhZSKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6tx3XG9a4=nCLyv+GG8uLJ40qLzqzUWaxTLwhqOhZSKg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 22, 2021 at 07:20:25PM +0100, Filipe Manana wrote:
> On Tue, Jun 22, 2021 at 7:01 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Jun 22, 2021 at 02:54:10PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When a task attempting to allocate a new chunk verifies that there is not
> > > currently enough free space in the system space_info and there is another
> > > task that allocated a new system chunk but it did not finish yet the
> > > creation of the respective block group, it waits for that other task to
> > > finish creating the block group. This is to avoid exhaustion of the system
> > > chunk array in the superblock, which is limited, when we have a thundering
> > > herd of tasks allocating new chunks. This problem was described and fixed
> > > by commit eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array
> > > due to concurrent allocations").
> > >
> > > However there are two very similar scenarios where this can lead to a
> > > deadlock:
> > >
> > > 1) Task B allocated a new system chunk and task A is waiting on task B
> > >    to finish creation of the respective system block group. However before
> > >    task B ends its transaction handle and finishes the creation of the
> > >    system block group, it attempts to allocate another chunk (like a data
> > >    chunk for an fallocate operation for a very large range). Task B will
> > >    be unable to progress and allocate the new chunk, because task A set
> > >    space_info->chunk_alloc to 1 and therefore it loops at
> > >    btrfs_chunk_alloc() waiting for task A to finish its chunk allocation
> > >    and set space_info->chunk_alloc to 0, but task A is waiting on task B
> > >    to finish creation of the new system block group, therefore resulting
> > >    in a deadlock;
> > >
> > > 2) Task B allocated a new system chunk and task A is waiting on task B to
> > >    finish creation of the respective system block group. By the time that
> > >    task B enter the final phase of block group allocation, which happens
> > >    at btrfs_create_pending_block_groups(), when it modifies the extent
> > >    tree, the device tree or the chunk tree to insert the items for some
> > >    new block group, it needs to allocate a new chunk, so it ends up at
> > >    btrfs_chunk_alloc() and keeps looping there because task A has set
> > >    space_info->chunk_alloc to 1, but task A is waiting for task B to
> > >    finish creation of the new system block group and release the reserved
> > >    system space, therefore resulting in a deadlock.
> > >
> > > In short, the problem is if a task B needs to allocate a new chunk after
> > > it previously allocated a new system chunk and if another task A is
> > > currently waiting for task B to complete the allocation of the new system
> > > chunk.
> > >
> > > Fix this by making a task that previously allocated a new system chunk to
> > > not loop at btrfs_chunk_alloc() and proceed if there is another task that
> > > is waiting for it.
> > >
> > > Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > Link: https://lore.kernel.org/linux-btrfs/20210621015922.ewgbffxuawia7liz@naota-xeon/
> > > Fixes: eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array due to concurrent allocations")
> >
> > So this is a regression in 5.13-rc, the final release is most likely the
> > upcoming Sunday. This fixes a deadlock so that's an error that could be
> > considered urgent.
> >
> > Option 1 is to let Aota test it for a day or two (adding it to our other
> > branches for testing as well) and then I'll send a pull request on
> > Friday at the latest.
> >
> > Option 2 is to put it to pull request branch with a stable tag, so it
> > would propagate to 5.13.1 in three weeks from now.
> >
> > I'd prefer option 1 for release completeness sake but if there are
> > doubts or tests show otherwise, we can always do 2.
> 
> Either way is fine for me. I didn't even notice before that it was in
> 5.13-rcs, I was thinking about 5.12 on top of my head.
> 
> The issue is probably easier for Aota to trigger on zoned filesystems,
> I suppose it triggers more chunk allocations than non-zoned
> filesystems due to the zoned device constraints.
> 
> Thanks.

Unfortunately, I still have a hung with the patch.

This time there was a recursive dependency between PID 1212 (in the
busy loop) and 1214 (waiting for a tree lock PID 1212 is holding).

PID 1212 is at the busy loop.

crash> bt -S ffffc900037568d0 1212
PID: 1212   TASK: ffff88819c7ec000  CPU: 0   COMMAND: "fsstress"
 #0 [ffffc900037568d0] __schedule at ffffffff8260d345
 #1 [ffffc90003756910] rcu_read_lock_sched_held at ffffffff812c08b1
 #2 [ffffc90003756928] lock_acquire at ffffffff8127bf1c
 #3 [ffffc90003756a40] btrfs_chunk_alloc at ffffffffa03cb7ad [btrfs]
 #4 [ffffc90003756ae0] find_free_extent at ffffffffa01abfa2 [btrfs]
 #5 [ffffc90003756ca0] btrfs_reserve_extent at ffffffffa01bd7d0 [btrfs]
 #6 [ffffc90003756d30] btrfs_alloc_tree_block at ffffffffa01be74f [btrfs]
 #7 [ffffc90003756ed0] alloc_tree_block_no_bg_flush at ffffffffa018b9e5 [btrfs]
 #8 [ffffc90003756f30] __btrfs_cow_block at ffffffffa0192fb1 [btrfs]
 #9 [ffffc90003757080] btrfs_cow_block at ffffffffa01940b5 [btrfs]
#10 [ffffc90003757100] btrfs_search_slot at ffffffffa019f5c7 [btrfs]
#11 [ffffc90003757270] lookup_inline_extent_backref at ffffffffa01afbb3 [btrfs]
#12 [ffffc900037573a0] lookup_extent_backref at ffffffffa01b173c [btrfs]
#13 [ffffc900037573f8] __btrfs_free_extent at ffffffffa01b1a56 [btrfs]
#14 [ffffc90003757578] __btrfs_run_delayed_refs at ffffffffa01b4486 [btrfs]
#15 [ffffc90003757760] btrfs_run_delayed_refs at ffffffffa01b723c [btrfs]
#16 [ffffc900037577c0] btrfs_commit_transaction at ffffffffa01ecbfd [btrfs]
#17 [ffffc90003757918] btrfs_mksubvol at ffffffffa02a5569 [btrfs]
#18 [ffffc900037579a8] btrfs_mksnapshot at ffffffffa02a5c88 [btrfs]
#19 [ffffc90003757a00] __btrfs_ioctl_snap_create at ffffffffa02a5f9d [btrfs]
#20 [ffffc90003757a60] btrfs_ioctl_snap_create_v2 at ffffffffa02a630f [btrfs]
...

PID 1214 is holding the reserved chunk bytes. So, PID 1212 is waiting
for PID 1214 to finish chunk allocation.

crash> task -R journal_info 1214
PID: 1214   TASK: ffff8881c8be4000  CPU: 0   COMMAND: "fsstress"
  journal_info = 0xffff88812cc343f0,
crash> struct btrfs_trans_handle 0xffff88812cc343f0
struct btrfs_trans_handle {
  transid = 218, 
  bytes_reserved = 0, 
  chunk_bytes_reserved = 393216, 
  delayed_ref_updates = 0, 
  transaction = 0xffff8881c631e000, 
  block_rsv = 0x0, 
  orig_rsv = 0x0, 
  use_count = {
    refs = {
      counter = 1
    }
  }, 
  type = 513, 
  aborted = 0, 
  adding_csums = false, 
  allocating_chunk = false, 
  can_flush_pending_bgs = true, 
  reloc_reserved = false, 
  dirty = true, 
  in_fsync = false, 
  root = 0xffff8881d04c0000, 
  fs_info = 0xffff8881f6f94000, 
  new_bgs = {
    next = 0xffff8881b369d1c8, 
    prev = 0xffff8881b369d1c8
  }
}
crash> struct btrfs_transaction.chunk_bytes_reserved 0xffff8881c631e000
  chunk_bytes_reserved = {
    counter = 393216
  }

PID 1214 is trying to take a read lock of a tree root.

crash> bt 1214
PID: 1214   TASK: ffff8881c8be4000  CPU: 0   COMMAND: "fsstress"
 #0 [ffffc90003777228] __schedule at ffffffff8260d345
 #1 [ffffc90003777330] schedule at ffffffff8260eb67
 #2 [ffffc90003777360] rwsem_down_read_slowpath at ffffffff826194bd
 #3 [ffffc900037774b8] __down_read_common at ffffffff812648cc
 #4 [ffffc90003777568] down_read_nested at ffffffff81264d44
 #5 [ffffc900037775b8] btrfs_read_lock_root_node at ffffffffa02b2fe7 [btrfs]
 #6 [ffffc900037775e0] btrfs_search_slot at ffffffffa019f81b [btrfs]
 #7 [ffffc900037777b8] do_raw_spin_unlock at ffffffff81285004
 #8 [ffffc900037777f8] btrfs_create_pending_block_groups at ffffffffa03c672c [btrfs]
 #9 [ffffc90003777938] __btrfs_end_transaction at ffffffffa01e8138 [btrfs]
#10 [ffffc90003777978] btrfs_end_transaction at ffffffffa01e8ffb [btrfs]
#11 [ffffc90003777988] btrfs_cont_expand at ffffffffa02209d6 [btrfs]
#12 [ffffc90003777b00] btrfs_clone_files at ffffffffa03d53df [btrfs]
#13 [ffffc90003777b58] btrfs_remap_file_range at ffffffffa03d601f [btrfs]
#14 [ffffc90003777c50] do_clone_file_range at ffffffff8179f72c
#15 [ffffc90003777ca0] vfs_clone_file_range at ffffffff8179fbdb
#16 [ffffc90003777cf8] ioctl_file_clone at ffffffff8171a1b4
...

And the extent buffer looks like to be held by PID 1212, making the
dependency loop.

crash> bt -FF 1214
...
 #4 [ffffc90003777568] down_read_nested at ffffffff81264d44
    ffffc90003777570: [ffff88817afc7c20:btrfs_extent_buffer] 0000000000000000 
    ffffc90003777580: 0000000000000000 ffffc900037775b0 
    ffffc90003777590: __btrfs_tree_read_lock+40 [ffff88817afc7c20:btrfs_extent_buffer] 
    ffffc900037775a0: ffffed102e623800 dffffc0000000000 
    ffffc900037775b0: ffffc900037775d8 btrfs_read_lock_root_node+71
...
crash> struct extent_buffer ffff88817afc7c20
struct extent_buffer {
  start = 1979629568, 
  len = 16384, 
...
  lock_owner = 1212,
...

I now started to think waiting in btrfs_chunk_alloc() is generally bad
idea. Since the function is called with tree locks held, it's quite
easy to hit a recursive dependency. The previous busy loop was OK
because it only waits for an allocating process which leave there
really soon.

And, with the loop-exiting condition is getting complex, can't we use
some proper lock/synchronization mechanism here? The hung this time
was not straight forward because I did not see PID 1212 and 1214 in the
hung task list. Also, using proper lock would make it possible to
catch such recursion with the lockdep.

Thanks,
