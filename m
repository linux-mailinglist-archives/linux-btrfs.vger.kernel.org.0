Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CFC42DDF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhJNPWw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJNPWv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 11:22:51 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC3C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:20:46 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id v10so3916592qvb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KMdcyFexEPEDLJHvJOHpXBCAE5TDTPC1wbX8o0wlS/4=;
        b=VwkJaAE1gMfwKcBe+tejmF1fLtBG+Tdo3aIWwctVwtIN442nSqwrBaLIyGPUnWy6u7
         J9LpQ7/GoraFHG46p4ytm+hTxvEFBg3Vhbrd3hstlTTS9diAiBDIT+FqHqFzK+mKMBp2
         WUgcx0EnVcfuU1HyDMC/VbUa2KB6aMEX8Gns5krauvlhvftYfzdDif8bRbT50bxzTCvw
         btlyFnPRjgAm5PiB10n3b7U5zpg7yFBatqzKhon0z1kWSYq+kmWFVzNnGBwmls03lHFo
         b0TTcfCUjq/7222PJJL+zv4iPIRvyU8QGtJLPoVCOrQw4XsO/DbbKMLizqsXRpqlHqnb
         snfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMdcyFexEPEDLJHvJOHpXBCAE5TDTPC1wbX8o0wlS/4=;
        b=O360dAqEUk0RuYtfRraqMtA3YwgmpAWavuOoVqrqUrmMsL5M4GmrY9qBdmBOk+/J7X
         RCZ9sAo7JS3JDhTPKKPXrFrHky60HZ+fKD9zPrKorvIIaibdNI2RPHbhbw82/tCmB/Rg
         BE3WWg1gZ9egF1h1p+k/mxBP6Ksn6RHQc5rLWi//IdG1Zib2wr5ofbVmQ7A0bBUJTvPd
         PFwl5nD6QVCTkrU4f23mS6rbkOvi5pkohwUaehCLaYsWQwbXfHKBSUWvGnSbx+55OQUJ
         7T/zAfPmPXdnWOdFkrBJdFm7sNKOZ3O0XOBeOSOlZN0zgHKa3OfcrAXUr2yeQAN1Hd1a
         p+bA==
X-Gm-Message-State: AOAM532hhj/3rnKceRM5lQWNAEju+IMC+EQfDPQAFjh2OQwRd8hXKTEM
        OnLz2XVPMrYunMId9MERiCjS1rYSbSADWA==
X-Google-Smtp-Source: ABdhPJwzHItCN+KC4JlPxBZ8N4hTsezRFATYAmpfBQD2KMOXgNNWOYuAo7jby5S07BzeQqzMmrKkuQ==
X-Received: by 2002:ad4:4b63:: with SMTP id m3mr5877785qvx.35.1634224845879;
        Thu, 14 Oct 2021 08:20:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g18sm1482366qto.71.2021.10.14.08.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:20:45 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:20:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs: fix deadlock between chunk allocation and
 chunk btree modifications
Message-ID: <YWhKzHgFFRopolVA@localhost.localdomain>
References: <cover.1634115580.git.fdmanana@suse.com>
 <0747812264412ce1a8474ff2ec223010a6dce3a0.1634115580.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0747812264412ce1a8474ff2ec223010a6dce3a0.1634115580.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 10:12:49AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When a task is doing some modification to the chunk btree and it is not in
> the context of a chunk allocation or a chunk removal, it can deadlock with
> another task that is currently allocating a new data or metadata chunk.
> 
> These contextes are the following:
> 
> * When relocating a system chunk, when we need to COW the extent buffers
>   that belong to the chunk btree;
> 
> * When adding a new device (ioctl), where we need to add a new device item
>   to the chunk btree;
> 
> * When removing a device (ioctl), where we need to remove a device item
>   from the chunk btree;
> 
> * When resizing a device (ioctl), where we need to update a device item in
>   the chunk btree and may need to relocate a system chunk that lies beyond
>   the new device size when shrinking a device.
> 
> The problem happens due to a sequence of steps like the following:
> 
> 1) Task A starts a data or metadata chunk allocation and it locks the
>    chunk mutex;
> 
> 2) Task B is relocating a system chunk, and when it needs to COW an extent
>    buffer of the chunk btree, it has locked both that extent buffer as
>    well as its parent extent buffer;
> 
> 3) Since there is not enough available system space, either because none
>    of the existing system block groups have enough free space or because
>    the only one with enough free space is in RO mode due to the relocation,
>    task B triggers a new system chunk allocation. It blocks when trying to
>    acquire the chunk mutex, currently held by task A;
> 
> 4) Task A enters btrfs_chunk_alloc_add_chunk_item(), in order to insert
>    the new chunk item into the chunk btree and update the existing device
>    items there. But in order to do that, it has to lock the extent buffer
>    that task B locked at step 2, or its parent extent buffer, but task B
>    is waiting on the chunk mutex, which is currently locked by task A,
>    therefore resulting in a deadlock.
> 
> One example report when the deadlock happens with system chunk relocation:
> 
>   INFO: task kworker/u9:5:546 blocked for more than 143 seconds.
>         Not tainted 5.15.0-rc3+ #1
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:kworker/u9:5    state:D stack:25936 pid:  546 ppid:     2 flags:0x00004000
>   Workqueue: events_unbound btrfs_async_reclaim_metadata_space
>   Call Trace:
>    context_switch kernel/sched/core.c:4940 [inline]
>    __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
>    schedule+0xd3/0x270 kernel/sched/core.c:6366
>    rwsem_down_read_slowpath+0x4ee/0x9d0 kernel/locking/rwsem.c:993
>    __down_read_common kernel/locking/rwsem.c:1214 [inline]
>    __down_read kernel/locking/rwsem.c:1223 [inline]
>    down_read_nested+0xe6/0x440 kernel/locking/rwsem.c:1590
>    __btrfs_tree_read_lock+0x31/0x350 fs/btrfs/locking.c:47
>    btrfs_tree_read_lock fs/btrfs/locking.c:54 [inline]
>    btrfs_read_lock_root_node+0x8a/0x320 fs/btrfs/locking.c:191
>    btrfs_search_slot_get_root fs/btrfs/ctree.c:1623 [inline]
>    btrfs_search_slot+0x13b4/0x2140 fs/btrfs/ctree.c:1728
>    btrfs_update_device+0x11f/0x500 fs/btrfs/volumes.c:2794
>    btrfs_chunk_alloc_add_chunk_item+0x34d/0xea0 fs/btrfs/volumes.c:5504
>    do_chunk_alloc fs/btrfs/block-group.c:3408 [inline]
>    btrfs_chunk_alloc+0x84d/0xf50 fs/btrfs/block-group.c:3653
>    flush_space+0x54e/0xd80 fs/btrfs/space-info.c:670
>    btrfs_async_reclaim_metadata_space+0x396/0xa90 fs/btrfs/space-info.c:953
>    process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
>    worker_thread+0x90/0xed0 kernel/workqueue.c:2444
>    kthread+0x3e5/0x4d0 kernel/kthread.c:319
>    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>   INFO: task syz-executor:9107 blocked for more than 143 seconds.
>         Not tainted 5.15.0-rc3+ #1
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:syz-executor    state:D stack:23200 pid: 9107 ppid:  7792 flags:0x00004004
>   Call Trace:
>    context_switch kernel/sched/core.c:4940 [inline]
>    __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
>    schedule+0xd3/0x270 kernel/sched/core.c:6366
>    schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
>    __mutex_lock_common kernel/locking/mutex.c:669 [inline]
>    __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
>    btrfs_chunk_alloc+0x31a/0xf50 fs/btrfs/block-group.c:3631
>    find_free_extent_update_loop fs/btrfs/extent-tree.c:3986 [inline]
>    find_free_extent+0x25cb/0x3a30 fs/btrfs/extent-tree.c:4335
>    btrfs_reserve_extent+0x1f1/0x500 fs/btrfs/extent-tree.c:4415
>    btrfs_alloc_tree_block+0x203/0x1120 fs/btrfs/extent-tree.c:4813
>    __btrfs_cow_block+0x412/0x1620 fs/btrfs/ctree.c:415
>    btrfs_cow_block+0x2f6/0x8c0 fs/btrfs/ctree.c:570
>    btrfs_search_slot+0x1094/0x2140 fs/btrfs/ctree.c:1768
>    relocate_tree_block fs/btrfs/relocation.c:2694 [inline]
>    relocate_tree_blocks+0xf73/0x1770 fs/btrfs/relocation.c:2757
>    relocate_block_group+0x47e/0xc70 fs/btrfs/relocation.c:3673
>    btrfs_relocate_block_group+0x48a/0xc60 fs/btrfs/relocation.c:4070
>    btrfs_relocate_chunk+0x96/0x280 fs/btrfs/volumes.c:3181
>    __btrfs_balance fs/btrfs/volumes.c:3911 [inline]
>    btrfs_balance+0x1f03/0x3cd0 fs/btrfs/volumes.c:4301
>    btrfs_ioctl_balance+0x61e/0x800 fs/btrfs/ioctl.c:4137
>    btrfs_ioctl+0x39ea/0x7b70 fs/btrfs/ioctl.c:4949
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:874 [inline]
>    __se_sys_ioctl fs/ioctl.c:860 [inline]
>    __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> So fix this by making sure that whenever we try to modify the chunk btree
> and we are neither in a chunk allocation context nor in a chunk remove
> context, we reserve system space before modifying the chunk btree.
> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CACkBjsax51i4mu6C0C3vJqQN3NR_iVuucoeG3U1HXjrgzn5FFQ@mail.gmail.com/
> Fixes: 79bd37120b1495 ("btrfs: rework chunk allocation to avoid exhaustion of the system chunk array")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
