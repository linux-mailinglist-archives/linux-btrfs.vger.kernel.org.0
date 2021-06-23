Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC43B162C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhFWItK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 04:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhFWItA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 04:49:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D7B7611C1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624438003;
        bh=QYnKciDq8JHJN2PQmPRK11JKkfj+h4ZQ99P2xrHPnmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ND7zliPftrKubcXsT8NI606t7I0XfrEeFgXcqzzwHv4gAeivFjOi2d1d5SW/Pj7Ig
         WVBwMTM9BwhrrjbJP9KAc+sZ7gZCSZ0hbh0VY5E0oDvY8oZ3uNbuowiVoA3cIrO/YG
         x9HmFJl5PppurnZbces4Crdnppr/H3UALnFyTfNDGWripHwil+e5lPYSjRJ++R9TuV
         085Vrl70eZFE2xAT0HDClsyeFjzF23TEk0HVqzptlj2A9XdqPeNi9onrNoTWKEtMSW
         E4PbiWGYAvNyvSns1THhQxJ8pSq8BaXMYGDG7BFsP4aV5p/2sTSN6v+Fcr+3NbhCpe
         ohvqvDoKWhaNA==
Received: by mail-qv1-f54.google.com with SMTP id dj3so991076qvb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 01:46:43 -0700 (PDT)
X-Gm-Message-State: AOAM531RRK8blYuOcWPIyw3Z//5rulsWot1YYqJ1X+29/aFShJdCMTn9
        ysQcLUeoHT4ppvVb5ohXxeKjsG26rqpyOuGMeYc=
X-Google-Smtp-Source: ABdhPJxypK9SefVTT8anFSBsOnOwyVbQT8S8sVwV3XzTlEniqIOuz6tvAF1NL89FlbeAYPra5WGzAlKuoGhIzg9TkeU=
X-Received: by 2002:ad4:5d4d:: with SMTP id jk13mr3460652qvb.28.1624438002629;
 Wed, 23 Jun 2021 01:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <b8b7b585ec8b7b2924fd5995951a0d16d2e394d7.1624369954.git.fdmanana@suse.com>
 <20210622175811.GK28158@twin.jikos.cz> <CAL3q7H6tx3XG9a4=nCLyv+GG8uLJ40qLzqzUWaxTLwhqOhZSKg@mail.gmail.com>
 <20210623073724.diltq4hd7z6t6dmo@naota-xeon>
In-Reply-To: <20210623073724.diltq4hd7z6t6dmo@naota-xeon>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 23 Jun 2021 09:46:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4=+7KhC=mE9uHOeN2WDrhVj+Uz_8t_Gvyt_N9rL_KhKA@mail.gmail.com>
Message-ID: <CAL3q7H4=+7KhC=mE9uHOeN2WDrhVj+Uz_8t_Gvyt_N9rL_KhKA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix deadlock with concurrent chunk allocations
 involving system chunks
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 23, 2021 at 8:37 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> On Tue, Jun 22, 2021 at 07:20:25PM +0100, Filipe Manana wrote:
> > On Tue, Jun 22, 2021 at 7:01 PM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Tue, Jun 22, 2021 at 02:54:10PM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > When a task attempting to allocate a new chunk verifies that there is not
> > > > currently enough free space in the system space_info and there is another
> > > > task that allocated a new system chunk but it did not finish yet the
> > > > creation of the respective block group, it waits for that other task to
> > > > finish creating the block group. This is to avoid exhaustion of the system
> > > > chunk array in the superblock, which is limited, when we have a thundering
> > > > herd of tasks allocating new chunks. This problem was described and fixed
> > > > by commit eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array
> > > > due to concurrent allocations").
> > > >
> > > > However there are two very similar scenarios where this can lead to a
> > > > deadlock:
> > > >
> > > > 1) Task B allocated a new system chunk and task A is waiting on task B
> > > >    to finish creation of the respective system block group. However before
> > > >    task B ends its transaction handle and finishes the creation of the
> > > >    system block group, it attempts to allocate another chunk (like a data
> > > >    chunk for an fallocate operation for a very large range). Task B will
> > > >    be unable to progress and allocate the new chunk, because task A set
> > > >    space_info->chunk_alloc to 1 and therefore it loops at
> > > >    btrfs_chunk_alloc() waiting for task A to finish its chunk allocation
> > > >    and set space_info->chunk_alloc to 0, but task A is waiting on task B
> > > >    to finish creation of the new system block group, therefore resulting
> > > >    in a deadlock;
> > > >
> > > > 2) Task B allocated a new system chunk and task A is waiting on task B to
> > > >    finish creation of the respective system block group. By the time that
> > > >    task B enter the final phase of block group allocation, which happens
> > > >    at btrfs_create_pending_block_groups(), when it modifies the extent
> > > >    tree, the device tree or the chunk tree to insert the items for some
> > > >    new block group, it needs to allocate a new chunk, so it ends up at
> > > >    btrfs_chunk_alloc() and keeps looping there because task A has set
> > > >    space_info->chunk_alloc to 1, but task A is waiting for task B to
> > > >    finish creation of the new system block group and release the reserved
> > > >    system space, therefore resulting in a deadlock.
> > > >
> > > > In short, the problem is if a task B needs to allocate a new chunk after
> > > > it previously allocated a new system chunk and if another task A is
> > > > currently waiting for task B to complete the allocation of the new system
> > > > chunk.
> > > >
> > > > Fix this by making a task that previously allocated a new system chunk to
> > > > not loop at btrfs_chunk_alloc() and proceed if there is another task that
> > > > is waiting for it.
> > > >
> > > > Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > > Link: https://lore.kernel.org/linux-btrfs/20210621015922.ewgbffxuawia7liz@naota-xeon/
> > > > Fixes: eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array due to concurrent allocations")
> > >
> > > So this is a regression in 5.13-rc, the final release is most likely the
> > > upcoming Sunday. This fixes a deadlock so that's an error that could be
> > > considered urgent.
> > >
> > > Option 1 is to let Aota test it for a day or two (adding it to our other
> > > branches for testing as well) and then I'll send a pull request on
> > > Friday at the latest.
> > >
> > > Option 2 is to put it to pull request branch with a stable tag, so it
> > > would propagate to 5.13.1 in three weeks from now.
> > >
> > > I'd prefer option 1 for release completeness sake but if there are
> > > doubts or tests show otherwise, we can always do 2.
> >
> > Either way is fine for me. I didn't even notice before that it was in
> > 5.13-rcs, I was thinking about 5.12 on top of my head.
> >
> > The issue is probably easier for Aota to trigger on zoned filesystems,
> > I suppose it triggers more chunk allocations than non-zoned
> > filesystems due to the zoned device constraints.
> >
> > Thanks.
>
> Unfortunately, I still have a hung with the patch.
>
> This time there was a recursive dependency between PID 1212 (in the
> busy loop) and 1214 (waiting for a tree lock PID 1212 is holding).
>
> PID 1212 is at the busy loop.
>
> crash> bt -S ffffc900037568d0 1212
> PID: 1212   TASK: ffff88819c7ec000  CPU: 0   COMMAND: "fsstress"
>  #0 [ffffc900037568d0] __schedule at ffffffff8260d345
>  #1 [ffffc90003756910] rcu_read_lock_sched_held at ffffffff812c08b1
>  #2 [ffffc90003756928] lock_acquire at ffffffff8127bf1c
>  #3 [ffffc90003756a40] btrfs_chunk_alloc at ffffffffa03cb7ad [btrfs]
>  #4 [ffffc90003756ae0] find_free_extent at ffffffffa01abfa2 [btrfs]
>  #5 [ffffc90003756ca0] btrfs_reserve_extent at ffffffffa01bd7d0 [btrfs]
>  #6 [ffffc90003756d30] btrfs_alloc_tree_block at ffffffffa01be74f [btrfs]
>  #7 [ffffc90003756ed0] alloc_tree_block_no_bg_flush at ffffffffa018b9e5 [btrfs]
>  #8 [ffffc90003756f30] __btrfs_cow_block at ffffffffa0192fb1 [btrfs]
>  #9 [ffffc90003757080] btrfs_cow_block at ffffffffa01940b5 [btrfs]
> #10 [ffffc90003757100] btrfs_search_slot at ffffffffa019f5c7 [btrfs]
> #11 [ffffc90003757270] lookup_inline_extent_backref at ffffffffa01afbb3 [btrfs]
> #12 [ffffc900037573a0] lookup_extent_backref at ffffffffa01b173c [btrfs]
> #13 [ffffc900037573f8] __btrfs_free_extent at ffffffffa01b1a56 [btrfs]
> #14 [ffffc90003757578] __btrfs_run_delayed_refs at ffffffffa01b4486 [btrfs]
> #15 [ffffc90003757760] btrfs_run_delayed_refs at ffffffffa01b723c [btrfs]
> #16 [ffffc900037577c0] btrfs_commit_transaction at ffffffffa01ecbfd [btrfs]
> #17 [ffffc90003757918] btrfs_mksubvol at ffffffffa02a5569 [btrfs]
> #18 [ffffc900037579a8] btrfs_mksnapshot at ffffffffa02a5c88 [btrfs]
> #19 [ffffc90003757a00] __btrfs_ioctl_snap_create at ffffffffa02a5f9d [btrfs]
> #20 [ffffc90003757a60] btrfs_ioctl_snap_create_v2 at ffffffffa02a630f [btrfs]
> ...
>
> PID 1214 is holding the reserved chunk bytes. So, PID 1212 is waiting
> for PID 1214 to finish chunk allocation.
>
> crash> task -R journal_info 1214
> PID: 1214   TASK: ffff8881c8be4000  CPU: 0   COMMAND: "fsstress"
>   journal_info = 0xffff88812cc343f0,
> crash> struct btrfs_trans_handle 0xffff88812cc343f0
> struct btrfs_trans_handle {
>   transid = 218,
>   bytes_reserved = 0,
>   chunk_bytes_reserved = 393216,
>   delayed_ref_updates = 0,
>   transaction = 0xffff8881c631e000,
>   block_rsv = 0x0,
>   orig_rsv = 0x0,
>   use_count = {
>     refs = {
>       counter = 1
>     }
>   },
>   type = 513,
>   aborted = 0,
>   adding_csums = false,
>   allocating_chunk = false,
>   can_flush_pending_bgs = true,
>   reloc_reserved = false,
>   dirty = true,
>   in_fsync = false,
>   root = 0xffff8881d04c0000,
>   fs_info = 0xffff8881f6f94000,
>   new_bgs = {
>     next = 0xffff8881b369d1c8,
>     prev = 0xffff8881b369d1c8
>   }
> }
> crash> struct btrfs_transaction.chunk_bytes_reserved 0xffff8881c631e000
>   chunk_bytes_reserved = {
>     counter = 393216
>   }
>
> PID 1214 is trying to take a read lock of a tree root.
>
> crash> bt 1214
> PID: 1214   TASK: ffff8881c8be4000  CPU: 0   COMMAND: "fsstress"
>  #0 [ffffc90003777228] __schedule at ffffffff8260d345
>  #1 [ffffc90003777330] schedule at ffffffff8260eb67
>  #2 [ffffc90003777360] rwsem_down_read_slowpath at ffffffff826194bd
>  #3 [ffffc900037774b8] __down_read_common at ffffffff812648cc
>  #4 [ffffc90003777568] down_read_nested at ffffffff81264d44
>  #5 [ffffc900037775b8] btrfs_read_lock_root_node at ffffffffa02b2fe7 [btrfs]
>  #6 [ffffc900037775e0] btrfs_search_slot at ffffffffa019f81b [btrfs]
>  #7 [ffffc900037777b8] do_raw_spin_unlock at ffffffff81285004
>  #8 [ffffc900037777f8] btrfs_create_pending_block_groups at ffffffffa03c672c [btrfs]
>  #9 [ffffc90003777938] __btrfs_end_transaction at ffffffffa01e8138 [btrfs]
> #10 [ffffc90003777978] btrfs_end_transaction at ffffffffa01e8ffb [btrfs]
> #11 [ffffc90003777988] btrfs_cont_expand at ffffffffa02209d6 [btrfs]
> #12 [ffffc90003777b00] btrfs_clone_files at ffffffffa03d53df [btrfs]
> #13 [ffffc90003777b58] btrfs_remap_file_range at ffffffffa03d601f [btrfs]
> #14 [ffffc90003777c50] do_clone_file_range at ffffffff8179f72c
> #15 [ffffc90003777ca0] vfs_clone_file_range at ffffffff8179fbdb
> #16 [ffffc90003777cf8] ioctl_file_clone at ffffffff8171a1b4
> ...
>
> And the extent buffer looks like to be held by PID 1212, making the
> dependency loop.

I see. That type of dependency on btree locks is why we have chunk
allocation in two distinct phases.

>
> crash> bt -FF 1214
> ...
>  #4 [ffffc90003777568] down_read_nested at ffffffff81264d44
>     ffffc90003777570: [ffff88817afc7c20:btrfs_extent_buffer] 0000000000000000
>     ffffc90003777580: 0000000000000000 ffffc900037775b0
>     ffffc90003777590: __btrfs_tree_read_lock+40 [ffff88817afc7c20:btrfs_extent_buffer]
>     ffffc900037775a0: ffffed102e623800 dffffc0000000000
>     ffffc900037775b0: ffffc900037775d8 btrfs_read_lock_root_node+71
> ...
> crash> struct extent_buffer ffff88817afc7c20
> struct extent_buffer {
>   start = 1979629568,
>   len = 16384,
> ...
>   lock_owner = 1212,
> ...
>
> I now started to think waiting in btrfs_chunk_alloc() is generally bad
> idea. Since the function is called with tree locks held, it's quite
> easy to hit a recursive dependency. The previous busy loop was OK
> because it only waits for an allocating process which leave there
> really soon.
>
> And, with the loop-exiting condition is getting complex, can't we use
> some proper lock/synchronization mechanism here?

Unfortunately it wouldn't be that simple.
We have chunk allocation in two phases to prevent deadlocks on btree locks:

1) First phase is btrfs_chunk_alloc() - basically all it does is
allocate space for the chunk, create the in memory btrfs block group
and add it to the transaction handle's list of pending block groups;

2) Second phase is when the transaction handle is released ("ended"),
where we go through the list of pending block groups and then add all
the items of each new block group to the device, extent and chunk
btrees.
    This is because if we did these btree updates in the first phase,
a task could deadlock with itself - a chunk allocation is triggered
while updating the extent tree for example, and then when adding the
block group item to the extent tree we could deadlock because we
previously locked some node in the path from the root to the leaf.

Let me try something else, to have btrfs_chunk_alloc() or
check_system_chunk() actually due the chunk tree updates instead of
doing them in the second phase, since all chunk tree updates are done
while holding fs_info->chunk_mutex (basically block group allocation
and removal). If this works, it will make things a bit simpler.

I'll get back to you later today.

Thanks.

> The hung this time
> was not straight forward because I did not see PID 1212 and 1214 in the
> hung task list. Also, using proper lock would make it possible to
> catch such recursion with the lockdep.
>
> Thanks,
