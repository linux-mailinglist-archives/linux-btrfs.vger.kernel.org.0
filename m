Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5171F429755
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhJKTMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 15:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232072AbhJKTMV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 15:12:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6B0860E8B
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633979420;
        bh=gDSeGES3BJPHE5r1Xg3b3PV/C6v9lkU5kt+stVEuNas=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PfXOxPOHDjn5PRMAJwG/CLYcD//RmbcguGzk+u3eQ31qYZlY2D4zM72oXJ5klZD4o
         8ZPhqMkzOhI+Gi28Wip5SYcYGNqghnx+hi2nW2saCMkF3nRnw3PE+hQ2kovfT77JGk
         zlzuU0aoGR3Fw5lmz3/x7RPt8lrqxd3IbNTaUJZS9paawxodK1EpSkXX0wRkE0Wszh
         FG7weZ81TQcCF4z8dOSsZwqXdDki++ZQA4/+3MuIHPlgp0RB00Qr1uEmV4hblp2+WR
         yN8lzh6gG6U2HV6x3S7QsC4BHHYWrhl305iK9D803SMy/kmprtjcxus23KsXAehVkH
         xjbvExOgVZwPw==
Received: by mail-qt1-f177.google.com with SMTP id w2so9109254qtn.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 12:10:20 -0700 (PDT)
X-Gm-Message-State: AOAM5302W/tGmntuhpRrnhTxEWTPuEb9sEAEXox2zT5nhDwXQ7NdkffW
        16sKcm+nFxaGtkOByAWqxLKo3FXcBHMnEhyStSw=
X-Google-Smtp-Source: ABdhPJxDm9qD41g8ypc5XDfEWKwTaBjP8oD11zelN8bgEdMf2bjgLcg521DyR6JNs+X6nEDgElC/zPnYaXyUVKtYkkY=
X-Received: by 2002:a05:622a:180c:: with SMTP id t12mr17179165qtc.304.1633979419960;
 Mon, 11 Oct 2021 12:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633705660.git.fdmanana@suse.com> <dc480ee9a7be60b4d33b5c5df58ee51aa0b9e331.1633705660.git.fdmanana@suse.com>
 <YWRgzE9YZYTmlhlM@localhost.localdomain> <CAL3q7H5EvvrhAea-RCOVayXS9auvtvtiAA7Dg4kARDTnvR1CBw@mail.gmail.com>
 <fd9b37b9-6a4f-08f9-54af-f14864030aab@toxicpanda.com> <CAL3q7H762Mp1EzaqQ0Cq3aVhm31Sai1sa2MFd+z2pn1bJZOJkg@mail.gmail.com>
 <54e19a68-bd46-b4f3-28ae-eec4f9aa0969@toxicpanda.com>
In-Reply-To: <54e19a68-bd46-b4f3-28ae-eec4f9aa0969@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 11 Oct 2021 20:09:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5=BfMCC4Qmv5C4e4EViQhBgsuHgMt3RahuSOxcD0Hqxw@mail.gmail.com>
Message-ID: <CAL3q7H5=BfMCC4Qmv5C4e4EViQhBgsuHgMt3RahuSOxcD0Hqxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: fix deadlock between chunk allocation and
 chunk btree modifications
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 7:31 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 10/11/21 2:22 PM, Filipe Manana wrote:
> > On Mon, Oct 11, 2021 at 6:42 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >>
> >> On 10/11/21 1:31 PM, Filipe Manana wrote:
> >>> On Mon, Oct 11, 2021 at 5:05 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >>>>
> >>>> On Fri, Oct 08, 2021 at 04:10:34PM +0100, fdmanana@kernel.org wrote:
> >>>>> From: Filipe Manana <fdmanana@suse.com>
> >>>>>
> >>>>> When a task is doing some modification to the chunk btree and it is not in
> >>>>> the context of a chunk allocation or a chunk removal, it can deadlock with
> >>>>> another task that is currently allocating a new data or metadata chunk.
> >>>>>
> >>>>> These contextes are the following:
> >>>>>
> >>>>> * When relocating a system chunk, when we need to COW the extent buffers
> >>>>>     that belong to the chunk btree;
> >>>>>
> >>>>> * When adding a new device (ioctl), where we need to add a new device item
> >>>>>     to the chunk btree;
> >>>>>
> >>>>> * When removing a device (ioctl), where we need to remove a device item
> >>>>>     from the chunk btree;
> >>>>>
> >>>>> * When resizing a device (ioctl), where we need to update a device item in
> >>>>>     the chunk btree and may need to relocate a system chunk that lies beyond
> >>>>>     the new device size when shrinking a device.
> >>>>>
> >>>>> The problem happens due to a sequence of steps like the following:
> >>>>>
> >>>>> 1) Task A starts a data or metadata chunk allocation and it locks the
> >>>>>      chunk mutex;
> >>>>>
> >>>>> 2) Task B is relocating a system chunk, and when it needs to COW an extent
> >>>>>      buffer of the chunk btree, it has locked both that extent buffer as
> >>>>>      well as its parent extent buffer;
> >>>>>
> >>>>> 3) Since there is not enough available system space, either because none
> >>>>>      of the existing system block groups have enough free space or because
> >>>>>      the only one with enough free space is in RO mode due to the relocation,
> >>>>>      task B triggers a new system chunk allocation. It blocks when trying to
> >>>>>      acquire the chunk mutex, currently held by task A;
> >>>>>
> >>>>> 4) Task A enters btrfs_chunk_alloc_add_chunk_item(), in order to insert
> >>>>>      the new chunk item into the chunk btree and update the existing device
> >>>>>      items there. But in order to do that, it has to lock the extent buffer
> >>>>>      that task B locked at step 2, or its parent extent buffer, but task B
> >>>>>      is waiting on the chunk mutex, which is currently locked by task A,
> >>>>>      therefore resulting in a deadlock.
> >>>>>
> >>>>> One example report when the deadlock happens with system chunk relocation:
> >>>>>
> >>>>>     INFO: task kworker/u9:5:546 blocked for more than 143 seconds.
> >>>>>           Not tainted 5.15.0-rc3+ #1
> >>>>>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>>>>     task:kworker/u9:5    state:D stack:25936 pid:  546 ppid:     2 flags:0x00004000
> >>>>>     Workqueue: events_unbound btrfs_async_reclaim_metadata_space
> >>>>>     Call Trace:
> >>>>>      context_switch kernel/sched/core.c:4940 [inline]
> >>>>>      __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
> >>>>>      schedule+0xd3/0x270 kernel/sched/core.c:6366
> >>>>>      rwsem_down_read_slowpath+0x4ee/0x9d0 kernel/locking/rwsem.c:993
> >>>>>      __down_read_common kernel/locking/rwsem.c:1214 [inline]
> >>>>>      __down_read kernel/locking/rwsem.c:1223 [inline]
> >>>>>      down_read_nested+0xe6/0x440 kernel/locking/rwsem.c:1590
> >>>>>      __btrfs_tree_read_lock+0x31/0x350 fs/btrfs/locking.c:47
> >>>>>      btrfs_tree_read_lock fs/btrfs/locking.c:54 [inline]
> >>>>>      btrfs_read_lock_root_node+0x8a/0x320 fs/btrfs/locking.c:191
> >>>>>      btrfs_search_slot_get_root fs/btrfs/ctree.c:1623 [inline]
> >>>>>      btrfs_search_slot+0x13b4/0x2140 fs/btrfs/ctree.c:1728
> >>>>>      btrfs_update_device+0x11f/0x500 fs/btrfs/volumes.c:2794
> >>>>>      btrfs_chunk_alloc_add_chunk_item+0x34d/0xea0 fs/btrfs/volumes.c:5504
> >>>>>      do_chunk_alloc fs/btrfs/block-group.c:3408 [inline]
> >>>>>      btrfs_chunk_alloc+0x84d/0xf50 fs/btrfs/block-group.c:3653
> >>>>>      flush_space+0x54e/0xd80 fs/btrfs/space-info.c:670
> >>>>>      btrfs_async_reclaim_metadata_space+0x396/0xa90 fs/btrfs/space-info.c:953
> >>>>>      process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
> >>>>>      worker_thread+0x90/0xed0 kernel/workqueue.c:2444
> >>>>>      kthread+0x3e5/0x4d0 kernel/kthread.c:319
> >>>>>      ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> >>>>>     INFO: task syz-executor:9107 blocked for more than 143 seconds.
> >>>>>           Not tainted 5.15.0-rc3+ #1
> >>>>>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>>>>     task:syz-executor    state:D stack:23200 pid: 9107 ppid:  7792 flags:0x00004004
> >>>>>     Call Trace:
> >>>>>      context_switch kernel/sched/core.c:4940 [inline]
> >>>>>      __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
> >>>>>      schedule+0xd3/0x270 kernel/sched/core.c:6366
> >>>>>      schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
> >>>>>      __mutex_lock_common kernel/locking/mutex.c:669 [inline]
> >>>>>      __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
> >>>>>      btrfs_chunk_alloc+0x31a/0xf50 fs/btrfs/block-group.c:3631
> >>>>>      find_free_extent_update_loop fs/btrfs/extent-tree.c:3986 [inline]
> >>>>>      find_free_extent+0x25cb/0x3a30 fs/btrfs/extent-tree.c:4335
> >>>>>      btrfs_reserve_extent+0x1f1/0x500 fs/btrfs/extent-tree.c:4415
> >>>>>      btrfs_alloc_tree_block+0x203/0x1120 fs/btrfs/extent-tree.c:4813
> >>>>>      __btrfs_cow_block+0x412/0x1620 fs/btrfs/ctree.c:415
> >>>>>      btrfs_cow_block+0x2f6/0x8c0 fs/btrfs/ctree.c:570
> >>>>>      btrfs_search_slot+0x1094/0x2140 fs/btrfs/ctree.c:1768
> >>>>>      relocate_tree_block fs/btrfs/relocation.c:2694 [inline]
> >>>>>      relocate_tree_blocks+0xf73/0x1770 fs/btrfs/relocation.c:2757
> >>>>>      relocate_block_group+0x47e/0xc70 fs/btrfs/relocation.c:3673
> >>>>>      btrfs_relocate_block_group+0x48a/0xc60 fs/btrfs/relocation.c:4070
> >>>>>      btrfs_relocate_chunk+0x96/0x280 fs/btrfs/volumes.c:3181
> >>>>>      __btrfs_balance fs/btrfs/volumes.c:3911 [inline]
> >>>>>      btrfs_balance+0x1f03/0x3cd0 fs/btrfs/volumes.c:4301
> >>>>>      btrfs_ioctl_balance+0x61e/0x800 fs/btrfs/ioctl.c:4137
> >>>>>      btrfs_ioctl+0x39ea/0x7b70 fs/btrfs/ioctl.c:4949
> >>>>>      vfs_ioctl fs/ioctl.c:51 [inline]
> >>>>>      __do_sys_ioctl fs/ioctl.c:874 [inline]
> >>>>>      __se_sys_ioctl fs/ioctl.c:860 [inline]
> >>>>>      __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
> >>>>>      do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>>>>      do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >>>>>      entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>>>>
> >>>>> So fix this by making sure that whenever we try to modify the chunk btree
> >>>>> and we are neither in a chunk allocation context nor in a chunk remove
> >>>>> context, we reserve system space before modifying the chunk btree.
> >>>>>
> >>>>> Reported-by: Hao Sun <sunhao.th@gmail.com>
> >>>>> Link: https://lore.kernel.org/linux-btrfs/CACkBjsax51i4mu6C0C3vJqQN3NR_iVuucoeG3U1HXjrgzn5FFQ@mail.gmail.com/
> >>>>> Fixes: 79bd37120b1495 ("btrfs: rework chunk allocation to avoid exhaustion of the system chunk array")
> >>>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>>>
> >>>> A few things, because I'm having a hard time wrapping my head around this stuff
> >>>>
> >>>> 1) We're no longer allowing SYSTEM chunk allocations via btrfs_chunk_alloc(),
> >>>>      instead it's only via the reserve_chunk_space().  That is triggered at the
> >>>>      beginning of btrfs_search_slot() when we go to modify the chunk root.
> >>>> 2) We do this because we would normally trigger it when we do the
> >>>>      btrfs_use_block_rsv() when we go to modify the chunk tree, and at that point
> >>>>      we're holding chunk root locks and thus run into the describe deadlock.
> >>>>
> >>>> So what you're wanting to do is to force us to do the enospc chunk allocation
> >>>> dance prior to searching down the chunk root.  This makes sense.  However it's
> >>>> hard for me to wrap my head around the new rules for this stuff, and now we have
> >>>> a global "check to see if we need to reserve space for the chunk root" at the
> >>>> beginning of search slot.
> >>>>
> >>>> Doing at the btrfs_use_block_rsv() part isn't awesome either.  What if instead
> >>>> we just added a btrfs_reserve_chunk_space() everywhere we do a
> >>>> btrfs_search_slot() on the chunk_root as there are not many of them.
> >>>
> >>> That was my initial idea, but I didn't find it better because it's
> >>> easy to forget to make the reservation.
> >>> I didn't like having to repeat it in several places either.
> >>>
> >>> If it makes things cleaner, I can change it back, no problem.
> >>>
> >>
> >> I'd rather keep space reservation stuff separate so it's clear what
> >> we're doing, instead of hiding it in btrfs_search_slot() where we have
> >> to remember that we use it for chunk allocation there.
> >
> > Ok, that can be done. I still don't like it that much, but I don't
> > hate it either.
> >
>
> Yeah it's not awesome, but I want to have clear delineation of the work
> all the functions are doing, so there's not a "surprise, this search
> also triggered a chunk allocation because of these X things were true."
>
> >>
> >>>>
> >>>> Then we use BTRFS_RESERVE_FLUSH_LIMIT instead of NO_FLUSH, or hell we add a
> >>>> RESERVE_FLUSH_CHUNK that only does the chunk allocation stage.  Then we can use
> >>>> the same path for all chunk allocation.
> >>>>
> >>>> This way everybody still uses the same paths and we don't have a completely
> >>>> separate path for system chunk modifications.  Thanks,
> >>>
> >>> I don't get it. What do we gain by using FLUSH_LIMIT?
> >>> We allocated the new system chunk (if needed) and then marked the
> >>> space as reserved in the chunk reserve.
> >>> The chunk reserve is only used to track reserved space until the chunk
> >>> bree updates are done (either during chunk allocation/removal or for
> >>> the other paths that update the chunk btree).
> >>> So I don't see any advantage of using it instead of NO_FLUSH - we are
> >>> not supposed to trigger chunk allocation at that point, as we just did
> >>> it ourselves (and neither run delayed inodes).
> >>> I.e. the btrfs_block_rsv_add(() is never supposed to fail if
> >>> btrfs_create_chunk() succeeded.
> >>>
> >>
> >> Because I want to keep chunk allocation clearly in the realm of the
> >> ENOSPC handling, so we are consistent as possible.
> >>
> >> What I want is instead of burying some
> >>
> >> if (we dont have enough chunk space)
> >>          do_system_chunk_allocation()
> >>
> >> in our chunk allocation paths, we instead make sure that everywhere
> >> we're doing chunk allocation we do a
> >>
> >> ret = btrfs_block_rsv_add(chunk_root, chunk_block_rsv, num_bytes,
> >>                            FLUSH_WHATEVER);
> >> do our operation
> >> btrfs_block_rsv_release();
> >>
> >> and then when we do btrfs_reserve_metadata_bytes() in the
> >> btrfs_block_rsv_add() and we need to allocate a new chunk, it happens
> >> there, where all the other chunk allocation things happen.
> >>
> >> What we gain is consistency, allocating a system chunk happens via the
> >> same path that every other chunk allocation occurs, and it uses the same
> >> mechanisms that every other metadata allocation uses.  Thanks,
> >
> > Ok, I see what you mean, and it should be possible after the changes
> > you have been doing to the space reservation code in the last couple
> > years or so.
> > But that is a separate change from the bug fix, it doesn't eliminate
> > the need to pre reserve space before doing the chunk btree updates for
> > those cases identified in the change log.
> > I'll do it, but obviously as a separate change.
> >
>
> Yup that's reasonable, thanks,

So I just realized that would not work for two reasons.
We still have to manually create the system chunk ourselves when
reserving system space.

In order to use only something like:

ret = btrfs_block_rsv_add(chunk_root, chunk_block_rsv, num_bytes,
                            BTRFS_RESERVE_FLUSH_LIMIT);

We would have to do it before locking the chunk mutex, otherwise we
would obviously deadlock when that triggers system chunk allocation
through the async reclaim job.

But by doing it before locking the chunk mutex, then if we have a
bunch of tasks concurrently allocating data or metadata blocks groups
we can end up over-reserving and eventually exhaust the system chunk
array in the superblock, leading to a transaction abort - it brings
back the problem that I tried to solve with:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eafa4fd0ad06074da8be4e28ff93b4dca9ffa407

from an internal report for powerpc (64K node size) using stress-ng,
which I eventually had to revert later and fix differently with commit
79bd37120b149532af5b21953643ed74af69654f.

Putting this problem of the system chunk array aside, by having the
system chunk allocation triggered by btrfs_block_rsv_add(chunk
reserve, RESERVE_FLUSH_LIMIT), wouldn't we still deadlock even if we
do it before locking the chunk mutex?
I.e. the async reclaim job is allocating a data block group, enters
chunk allocation, that tries to reserve system chunk space but there's
not enough free system space so it creates a ticket to eventually
allocate a system chunk - the reclaim job ends up waiting on a ticket
it created itself during the data chunk allocation - a deadlock
basically.

Thanks.


>
> Josef
>
