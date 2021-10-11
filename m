Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02824295F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJKRoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhJKRoR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 13:44:17 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A93C061570
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 10:42:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r17so11842751qtx.10
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wnz0UBgb84wsPPN41N0yVF1mWRwAMgdzSsbz6VlboAc=;
        b=qS8Ybg0b7aDM48Nt8MrQDhOweROFPuvXwaW/tku2tiHIrMR3djPhDhra1vp5u3yqdZ
         TNlqwfMuP+EM7LS2E7tT3AAxfP051ATQuUVHuGq/NyoxIdxQoVu/QGdI1aFeITKHp6OI
         25mBxXEFRNBFKrHTSUlh14CAoxCOJF9bPv1khzwTw6YVWRvSeJPabIUYD4/Uq9GipFgq
         ROZFd0aDJFMSa20QtMAUnjUyUdjSPqqSZdfiJ61gptOz3OAm8F8qcUBwQLy4hoyKHDjW
         973NfWNAkde8tYdqj1CNLi2lFDk+FO1uerKWhHVTBKcCl4NEvCmxCdMjMYYE8gUtvsqK
         MVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wnz0UBgb84wsPPN41N0yVF1mWRwAMgdzSsbz6VlboAc=;
        b=EvvUVHHF8m1jSkewc1SQs/jBkrExLYqXDnAfklVct9a5/uEpfSgMkM3X8z1XZe+F56
         ODyiiJiBTi4zEdXG/c7UJGBcAySY3avalSGg5e3pTCIrXpb2YEg3ZRqWXrVNzqjwA4cY
         ZKf2qJHGCG9zeuYXTWurPxDqWTbtp0wDaZFBBMc0zU6VAkpdYF/prbtOESzhD9lyWzm5
         gS6g+0lI3kkmWqppGOTHIaj4oDZt0LoMmKShzPn/fh+IoliiLh9pyBaGYNTl5wni9o2x
         wO19y5bzodxFgZR/R3HvBP0IYs3IETpc5lDWZR3zXQgFA9kXiNmWXCLiq97lrrsCC6xw
         ZWAw==
X-Gm-Message-State: AOAM532CDUy4whGUq+9KbIPsF41U7pcQcnjEwIO/xg2fvV8FvEXyHK1H
        3kC2khmMfNaOCgZbTAuAQdz9iWb9XOLaEw==
X-Google-Smtp-Source: ABdhPJzbiDUqBvFV+I8Ub9e0BRoZcDLEmQoVqErhy3bDZcKCmhIvL491xy68DoS9CZQLC3my+luXfw==
X-Received: by 2002:a05:622a:60b:: with SMTP id z11mr8130867qta.214.1633974136264;
        Mon, 11 Oct 2021 10:42:16 -0700 (PDT)
Received: from [192.168.1.211] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl28sm4583755qkb.114.2021.10.11.10.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 10:42:15 -0700 (PDT)
Message-ID: <fd9b37b9-6a4f-08f9-54af-f14864030aab@toxicpanda.com>
Date:   Mon, 11 Oct 2021 13:42:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 1/2] btrfs: fix deadlock between chunk allocation and
 chunk btree modifications
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1633705660.git.fdmanana@suse.com>
 <dc480ee9a7be60b4d33b5c5df58ee51aa0b9e331.1633705660.git.fdmanana@suse.com>
 <YWRgzE9YZYTmlhlM@localhost.localdomain>
 <CAL3q7H5EvvrhAea-RCOVayXS9auvtvtiAA7Dg4kARDTnvR1CBw@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <CAL3q7H5EvvrhAea-RCOVayXS9auvtvtiAA7Dg4kARDTnvR1CBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/11/21 1:31 PM, Filipe Manana wrote:
> On Mon, Oct 11, 2021 at 5:05 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On Fri, Oct 08, 2021 at 04:10:34PM +0100, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> When a task is doing some modification to the chunk btree and it is not in
>>> the context of a chunk allocation or a chunk removal, it can deadlock with
>>> another task that is currently allocating a new data or metadata chunk.
>>>
>>> These contextes are the following:
>>>
>>> * When relocating a system chunk, when we need to COW the extent buffers
>>>    that belong to the chunk btree;
>>>
>>> * When adding a new device (ioctl), where we need to add a new device item
>>>    to the chunk btree;
>>>
>>> * When removing a device (ioctl), where we need to remove a device item
>>>    from the chunk btree;
>>>
>>> * When resizing a device (ioctl), where we need to update a device item in
>>>    the chunk btree and may need to relocate a system chunk that lies beyond
>>>    the new device size when shrinking a device.
>>>
>>> The problem happens due to a sequence of steps like the following:
>>>
>>> 1) Task A starts a data or metadata chunk allocation and it locks the
>>>     chunk mutex;
>>>
>>> 2) Task B is relocating a system chunk, and when it needs to COW an extent
>>>     buffer of the chunk btree, it has locked both that extent buffer as
>>>     well as its parent extent buffer;
>>>
>>> 3) Since there is not enough available system space, either because none
>>>     of the existing system block groups have enough free space or because
>>>     the only one with enough free space is in RO mode due to the relocation,
>>>     task B triggers a new system chunk allocation. It blocks when trying to
>>>     acquire the chunk mutex, currently held by task A;
>>>
>>> 4) Task A enters btrfs_chunk_alloc_add_chunk_item(), in order to insert
>>>     the new chunk item into the chunk btree and update the existing device
>>>     items there. But in order to do that, it has to lock the extent buffer
>>>     that task B locked at step 2, or its parent extent buffer, but task B
>>>     is waiting on the chunk mutex, which is currently locked by task A,
>>>     therefore resulting in a deadlock.
>>>
>>> One example report when the deadlock happens with system chunk relocation:
>>>
>>>    INFO: task kworker/u9:5:546 blocked for more than 143 seconds.
>>>          Not tainted 5.15.0-rc3+ #1
>>>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>    task:kworker/u9:5    state:D stack:25936 pid:  546 ppid:     2 flags:0x00004000
>>>    Workqueue: events_unbound btrfs_async_reclaim_metadata_space
>>>    Call Trace:
>>>     context_switch kernel/sched/core.c:4940 [inline]
>>>     __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
>>>     schedule+0xd3/0x270 kernel/sched/core.c:6366
>>>     rwsem_down_read_slowpath+0x4ee/0x9d0 kernel/locking/rwsem.c:993
>>>     __down_read_common kernel/locking/rwsem.c:1214 [inline]
>>>     __down_read kernel/locking/rwsem.c:1223 [inline]
>>>     down_read_nested+0xe6/0x440 kernel/locking/rwsem.c:1590
>>>     __btrfs_tree_read_lock+0x31/0x350 fs/btrfs/locking.c:47
>>>     btrfs_tree_read_lock fs/btrfs/locking.c:54 [inline]
>>>     btrfs_read_lock_root_node+0x8a/0x320 fs/btrfs/locking.c:191
>>>     btrfs_search_slot_get_root fs/btrfs/ctree.c:1623 [inline]
>>>     btrfs_search_slot+0x13b4/0x2140 fs/btrfs/ctree.c:1728
>>>     btrfs_update_device+0x11f/0x500 fs/btrfs/volumes.c:2794
>>>     btrfs_chunk_alloc_add_chunk_item+0x34d/0xea0 fs/btrfs/volumes.c:5504
>>>     do_chunk_alloc fs/btrfs/block-group.c:3408 [inline]
>>>     btrfs_chunk_alloc+0x84d/0xf50 fs/btrfs/block-group.c:3653
>>>     flush_space+0x54e/0xd80 fs/btrfs/space-info.c:670
>>>     btrfs_async_reclaim_metadata_space+0x396/0xa90 fs/btrfs/space-info.c:953
>>>     process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
>>>     worker_thread+0x90/0xed0 kernel/workqueue.c:2444
>>>     kthread+0x3e5/0x4d0 kernel/kthread.c:319
>>>     ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>>>    INFO: task syz-executor:9107 blocked for more than 143 seconds.
>>>          Not tainted 5.15.0-rc3+ #1
>>>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>    task:syz-executor    state:D stack:23200 pid: 9107 ppid:  7792 flags:0x00004004
>>>    Call Trace:
>>>     context_switch kernel/sched/core.c:4940 [inline]
>>>     __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
>>>     schedule+0xd3/0x270 kernel/sched/core.c:6366
>>>     schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
>>>     __mutex_lock_common kernel/locking/mutex.c:669 [inline]
>>>     __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
>>>     btrfs_chunk_alloc+0x31a/0xf50 fs/btrfs/block-group.c:3631
>>>     find_free_extent_update_loop fs/btrfs/extent-tree.c:3986 [inline]
>>>     find_free_extent+0x25cb/0x3a30 fs/btrfs/extent-tree.c:4335
>>>     btrfs_reserve_extent+0x1f1/0x500 fs/btrfs/extent-tree.c:4415
>>>     btrfs_alloc_tree_block+0x203/0x1120 fs/btrfs/extent-tree.c:4813
>>>     __btrfs_cow_block+0x412/0x1620 fs/btrfs/ctree.c:415
>>>     btrfs_cow_block+0x2f6/0x8c0 fs/btrfs/ctree.c:570
>>>     btrfs_search_slot+0x1094/0x2140 fs/btrfs/ctree.c:1768
>>>     relocate_tree_block fs/btrfs/relocation.c:2694 [inline]
>>>     relocate_tree_blocks+0xf73/0x1770 fs/btrfs/relocation.c:2757
>>>     relocate_block_group+0x47e/0xc70 fs/btrfs/relocation.c:3673
>>>     btrfs_relocate_block_group+0x48a/0xc60 fs/btrfs/relocation.c:4070
>>>     btrfs_relocate_chunk+0x96/0x280 fs/btrfs/volumes.c:3181
>>>     __btrfs_balance fs/btrfs/volumes.c:3911 [inline]
>>>     btrfs_balance+0x1f03/0x3cd0 fs/btrfs/volumes.c:4301
>>>     btrfs_ioctl_balance+0x61e/0x800 fs/btrfs/ioctl.c:4137
>>>     btrfs_ioctl+0x39ea/0x7b70 fs/btrfs/ioctl.c:4949
>>>     vfs_ioctl fs/ioctl.c:51 [inline]
>>>     __do_sys_ioctl fs/ioctl.c:874 [inline]
>>>     __se_sys_ioctl fs/ioctl.c:860 [inline]
>>>     __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>>>     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>     do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>>     entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> So fix this by making sure that whenever we try to modify the chunk btree
>>> and we are neither in a chunk allocation context nor in a chunk remove
>>> context, we reserve system space before modifying the chunk btree.
>>>
>>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>>> Link: https://lore.kernel.org/linux-btrfs/CACkBjsax51i4mu6C0C3vJqQN3NR_iVuucoeG3U1HXjrgzn5FFQ@mail.gmail.com/
>>> Fixes: 79bd37120b1495 ("btrfs: rework chunk allocation to avoid exhaustion of the system chunk array")
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> A few things, because I'm having a hard time wrapping my head around this stuff
>>
>> 1) We're no longer allowing SYSTEM chunk allocations via btrfs_chunk_alloc(),
>>     instead it's only via the reserve_chunk_space().  That is triggered at the
>>     beginning of btrfs_search_slot() when we go to modify the chunk root.
>> 2) We do this because we would normally trigger it when we do the
>>     btrfs_use_block_rsv() when we go to modify the chunk tree, and at that point
>>     we're holding chunk root locks and thus run into the describe deadlock.
>>
>> So what you're wanting to do is to force us to do the enospc chunk allocation
>> dance prior to searching down the chunk root.  This makes sense.  However it's
>> hard for me to wrap my head around the new rules for this stuff, and now we have
>> a global "check to see if we need to reserve space for the chunk root" at the
>> beginning of search slot.
>>
>> Doing at the btrfs_use_block_rsv() part isn't awesome either.  What if instead
>> we just added a btrfs_reserve_chunk_space() everywhere we do a
>> btrfs_search_slot() on the chunk_root as there are not many of them.
> 
> That was my initial idea, but I didn't find it better because it's
> easy to forget to make the reservation.
> I didn't like having to repeat it in several places either.
> 
> If it makes things cleaner, I can change it back, no problem.
> 

I'd rather keep space reservation stuff separate so it's clear what 
we're doing, instead of hiding it in btrfs_search_slot() where we have 
to remember that we use it for chunk allocation there.

>>
>> Then we use BTRFS_RESERVE_FLUSH_LIMIT instead of NO_FLUSH, or hell we add a
>> RESERVE_FLUSH_CHUNK that only does the chunk allocation stage.  Then we can use
>> the same path for all chunk allocation.
>>
>> This way everybody still uses the same paths and we don't have a completely
>> separate path for system chunk modifications.  Thanks,
> 
> I don't get it. What do we gain by using FLUSH_LIMIT?
> We allocated the new system chunk (if needed) and then marked the
> space as reserved in the chunk reserve.
> The chunk reserve is only used to track reserved space until the chunk
> bree updates are done (either during chunk allocation/removal or for
> the other paths that update the chunk btree).
> So I don't see any advantage of using it instead of NO_FLUSH - we are
> not supposed to trigger chunk allocation at that point, as we just did
> it ourselves (and neither run delayed inodes).
> I.e. the btrfs_block_rsv_add(() is never supposed to fail if
> btrfs_create_chunk() succeeded.
> 

Because I want to keep chunk allocation clearly in the realm of the 
ENOSPC handling, so we are consistent as possible.

What I want is instead of burying some

if (we dont have enough chunk space)
	do_system_chunk_allocation()

in our chunk allocation paths, we instead make sure that everywhere 
we're doing chunk allocation we do a

ret = btrfs_block_rsv_add(chunk_root, chunk_block_rsv, num_bytes,
			  FLUSH_WHATEVER);
do our operation
btrfs_block_rsv_release();

and then when we do btrfs_reserve_metadata_bytes() in the 
btrfs_block_rsv_add() and we need to allocate a new chunk, it happens 
there, where all the other chunk allocation things happen.

What we gain is consistency, allocating a system chunk happens via the 
same path that every other chunk allocation occurs, and it uses the same 
mechanisms that every other metadata allocation uses.  Thanks,

Josef
