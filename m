Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7204D5EE2A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 23:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGCVMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 17:12:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCVMO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jul 2019 17:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yZXhroajWNw9BNOuxviDRLOQ3mCCj/e8pGSC8NxyfJQ=; b=RMO35upBheitLFAGZ2L9N72FI
        SoCwXJFkIo7XXZNlBnWPXdBSx2i9ZvE0TShGq0vq+63D19cj0H3Obtd6Y1Eh+CI21fOJ9onmTn2xy
        mWRtFSYTTLpyuCv5ICs0UrpHNHSsWZXl2FZw0lF7b6qgqbQXW715/LW6l+5QLlN01uGehnVfrv5oI
        VMODmapdn6RU3RjuVVBwOPTFWRe0OmJt2yu3Y3LH77G8l+kVPsrJuVbSqFV9hOo685gdVBqnW+NMu
        jpbhKbI0KqfZ077WbH/vRcoS7Frp9tGhMvRi30Ta68rEJwsFLYfvIPYwYPlwVtPLDiMzyX38tAkbc
        w77EWVzew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1himY0-00057Y-HC; Wed, 03 Jul 2019 21:12:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FE6B98030B; Wed,  3 Jul 2019 23:12:10 +0200 (CEST)
Date:   Wed, 3 Jul 2019 23:12:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     mingo@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: Need help with a lockdep splat, possibly perf related?
Message-ID: <20190703211210.GJ16275@worktop.programming.kicks-ass.net>
References: <20190703135405.kwzg2am7voldx7ac@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703135405.kwzg2am7voldx7ac@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 03, 2019 at 09:54:06AM -0400, Josef Bacik wrote:
> Hello,
> 
> I've been seeing a variation of the following splat recently and I have no
> earthly idea what it's trying to tell me.

That you have a lock cycle; aka. deadlock, obviously :-)

> I either get this one, or I get one
> that tells me the same thing except it's complaining about &cpuctx_mutex instead
> of sb_pagefaults. 

Timing on where the cycle closes, most likely.

> There is no place we take the reloc_mutex and then do the
> pagefaults stuff,

That's not needed, What the below tells us, is that:

  btrfs->bio/mq->cpuhotplug->perf->mmap_sem->btrfs

is a cycle. The basic problem seems to be that btrfs, through blk_mq,
have the cpuhotplug lock inside mmap_sem, while perf (and I imagine
quite a few other places) allow pagefaults while holding cpuhotplug
lock.

This then presents a deadlock potential. Some of the actual chains are
clarified below; hope this helps.

> so I don't know where it's getting these dependencies from.
> The stacktraces make no sense because there's perf stuff in here, but it doesn't
> show me a path where we would be holding _any_ btrfs locks, so I'm not sure how
> we gain those dependencies.  Can you tell me where I'm being stupid?  Thanks,
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  5.2.0-rc7-00100-ga4067edd7814 #671 Not tainted
>  ------------------------------------------------------
>  python3.6/44461 is trying to acquire lock:
>  00000000674af011 (&fs_info->reloc_mutex){+.+.}, at: btrfs_record_root_in_trans+0x3c/0x70
> 
>  but task is already holding lock:
>  0000000091a6f027 (sb_pagefaults){.+.+}, at: btrfs_page_mkwrite+0x6a/0x4f0
> 
>  which lock already depends on the new lock.
> 
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #10 (sb_pagefaults){.+.+}:
>         __sb_start_write+0x12f/0x1d0
>         btrfs_page_mkwrite+0x6a/0x4f0
>         do_page_mkwrite+0x2b/0x70
>         __handle_mm_fault+0x6f2/0x10e0
>         handle_mm_fault+0x179/0x360
>         __do_page_fault+0x24d/0x4d0
>         page_fault+0x1e/0x30

	do_user_address_fault()
#9	  down_read(->mmap_sem)
	  handle_mm_fault()
	    do_page_mkwrite()
	      btrfs_page_mkwrite()
#10	        __sb_start_write()

>  -> #9 (&mm->mmap_sem#2){++++}:
>         __might_fault+0x6b/0x90
>         _copy_to_user+0x1e/0x70
>         perf_read+0x1a9/0x2c0
>         vfs_read+0x9b/0x150
>         ksys_read+0x5c/0xd0
>         do_syscall_64+0x4a/0x1b0
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe

	perf_read()
#8	  perf_event_ctx_lock()
	  copy_to_user
	    #PF
#9	      down_read(->mmap_sem)

> 
>  -> #8 (&cpuctx_mutex){+.+.}:
>         __mutex_lock+0x81/0x8f0
>         perf_event_init_cpu+0x9c/0x150
>         perf_event_init+0x1d0/0x1fe
>         start_kernel+0x365/0x513
>         secondary_startup_64+0xa4/0xb0

	perf_event_init_cpu()
#7	  mutex_lock(&pmus_lock);
#8	  mutex_lock(&ctx->lock);

>  -> #7 (pmus_lock){+.+.}:
>         __mutex_lock+0x81/0x8f0
>         perf_event_init_cpu+0x69/0x150
>         cpuhp_invoke_callback+0xb8/0x950
>         _cpu_up.constprop.29+0xad/0x140
>         do_cpu_up+0x92/0xe0
>         smp_init+0xcf/0xd4
>         kernel_init_freeable+0x13a/0x290
>         kernel_init+0xa/0x110
>         ret_from_fork+0x24/0x30

	_cpu_up()
#6	  cpus_write_lock()
	    ...
	     perf_event_init_cpu()
#7	       mutex_lock(&pmus_lock)

>  -> #6 (cpu_hotplug_lock.rw_sem){++++}:
>         cpus_read_lock+0x43/0x90
>         kmem_cache_create_usercopy+0x28/0x250
>         kmem_cache_create+0x18/0x20
>         bioset_init+0x157/0x2a0
>         init_bio+0xa1/0xa7
>         do_one_initcall+0x67/0x2f4
>         kernel_init_freeable+0x1ec/0x290
>         kernel_init+0xa/0x110
>         ret_from_fork+0x24/0x30

	bio_find_or_create_slab()
#5	  mutex_lock(&bio_slab_lock)
	  kmem_cache_create()
	    kmem_cache_create_usercopy()
#6	      get_online_cpus()


>  -> #5 (bio_slab_lock){+.+.}:
>         __mutex_lock+0x81/0x8f0
>         bioset_init+0xb0/0x2a0
>         blk_alloc_queue_node+0x80/0x2d0
>         blk_mq_init_queue+0x1b/0x60
> 
>         0xffffffffa0022131
>         do_one_initcall+0x67/0x2f4
>         do_init_module+0x5a/0x22e
>         load_module+0x1ebc/0x2570
>         __do_sys_finit_module+0xb2/0xc0
>         do_syscall_64+0x4a/0x1b0
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe

This one is weird, but something like:

#4	mutex_lock(&loop_ctl_mutex)
	loop_add()
	  blk_mq_init_queue()
	    blk_alloc_queue_node()
	      bioset_init()
	        bio_find_or_create_slab()
#5		  mutex_lock(&bio_slab_lock)

is entirely possible when you look at block/loop.c

>  -> #4 (loop_ctl_mutex){+.+.}:
>         __mutex_lock+0x81/0x8f0
> 
>         __blkdev_get+0xba/0x530
>         blkdev_get+0x1bd/0x340
>         do_dentry_open+0x1fb/0x390
>         path_openat+0x4f7/0xd30
>         do_filp_open+0x91/0x100
>         do_sys_open+0x127/0x220
>         do_syscall_64+0x4a/0x1b0
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe

	__blkdev_get()
#3	  mutex_lock(->bd_mutex);
	  disk->fops->open() := lo_open
#4	    mutex_lock(&loop_ctl_mutex);

>  -> #3 (&bdev->bd_mutex){+.+.}:
>         __mutex_lock+0x81/0x8f0
>         __blkdev_get+0x158/0x530
>         blkdev_get+0x21f/0x340
>         blkdev_get_by_path+0x4a/0x80
>         btrfs_get_bdev_and_sb+0x1b/0xb0
>         open_fs_devices+0x15d/0x290
>         btrfs_open_devices+0x75/0xa0
>         btrfs_mount_root+0x237/0x680
>         legacy_get_tree+0x2d/0x50
>         vfs_get_tree+0x1e/0x100
>         fc_mount+0xe/0x40
>         vfs_kern_mount+0x7c/0x90
>         btrfs_mount+0x15b/0x82d
>         legacy_get_tree+0x2d/0x50
>         vfs_get_tree+0x1e/0x100
>         do_mount+0x6ee/0xab0
>         ksys_mount+0x7e/0xd0
>         __x64_sys_mount+0x21/0x30
>         do_syscall_64+0x4a/0x1b0
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  -> #2 (&fs_devs->device_list_mutex){+.+.}:
>         __mutex_lock+0x81/0x8f0
>         btrfs_run_dev_stats+0x4d/0x3c0
>         commit_cowonly_roots+0xb2/0x2a0
>         btrfs_commit_transaction+0x524/0xa80
>         btrfs_recover_log_trees+0x366/0x470
>         open_ctree+0x20a1/0x22dd
>         btrfs_mount_root+0x51e/0x680
>         legacy_get_tree+0x2d/0x50
>         vfs_get_tree+0x1e/0x100
>         fc_mount+0xe/0x40
>         vfs_kern_mount+0x7c/0x90
>         btrfs_mount+0x15b/0x82d
>         legacy_get_tree+0x2d/0x50
>         vfs_get_tree+0x1e/0x100
>         do_mount+0x6ee/0xab0
>         ksys_mount+0x7e/0xd0
>         __x64_sys_mount+0x21/0x30
>         do_syscall_64+0x4a/0x1b0
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  -> #1 (&fs_info->tree_log_mutex){+.+.}:
>         __mutex_lock+0x81/0x8f0
>         btrfs_commit_transaction+0x4c9/0xa80
>         btrfs_recover_log_trees+0x366/0x470
>         open_ctree+0x20a1/0x22dd
>         btrfs_mount_root+0x51e/0x680
>         legacy_get_tree+0x2d/0x50
>         vfs_get_tree+0x1e/0x100
>         fc_mount+0xe/0x40
>         vfs_kern_mount+0x7c/0x90
>         btrfs_mount+0x15b/0x82d
>         legacy_get_tree+0x2d/0x50
>         vfs_get_tree+0x1e/0x100
>         do_mount+0x6ee/0xab0
>         ksys_mount+0x7e/0xd0
>         __x64_sys_mount+0x21/0x30
>         do_syscall_64+0x4a/0x1b0
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  -> #0 (&fs_info->reloc_mutex){+.+.}:
>         lock_acquire+0xb0/0x1a0
>         __mutex_lock+0x81/0x8f0
>         btrfs_record_root_in_trans+0x3c/0x70
>         start_transaction+0xaa/0x510
>         btrfs_dirty_inode+0x49/0xe0
>         file_update_time+0xc7/0x110
>         btrfs_page_mkwrite+0x152/0x4f0
>         do_page_mkwrite+0x2b/0x70
>         do_wp_page+0x4b1/0x5e0
>         __handle_mm_fault+0x6b8/0x10e0
>         handle_mm_fault+0x179/0x360
>         __do_page_fault+0x24d/0x4d0
>         page_fault+0x1e/0x30
> 
>  other info that might help us debug this:
> 
>  Chain exists of:
>    &fs_info->reloc_mutex --> &mm->mmap_sem#2 --> sb_pagefaults
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(sb_pagefaults);
>                                 lock(&mm->mmap_sem#2);
>                                 lock(sb_pagefaults);
>    lock(&fs_info->reloc_mutex);
> 
>   *** DEADLOCK ***
> 
>  3 locks held by python3.6/44461:
>   #0: 000000005a6ec7ac (&mm->mmap_sem#2){++++}, at: __do_page_fault+0x13d/0x4d0
>   #1: 0000000091a6f027 (sb_pagefaults){.+.+}, at: btrfs_page_mkwrite+0x6a/0x4f0
>   #2: 00000000a7f74f74 (sb_internal){.+.+}, at: start_transaction+0x36b/0x510
> 
>  stack backtrace:
>  CPU: 10 PID: 44461 Comm: python3.6 Kdump: loaded Not tainted 5.2.0-rc7-00100-ga4067edd7814 #671
>  Hardware name: Quanta Leopard ORv2-DDR4/Leopard ORv2-DDR4, BIOS F06_3B17 03/16/2018
>  Call Trace:
>   dump_stack+0x5e/0x8b
>   print_circular_bug+0x1f1/0x1fe
>   __lock_acquire+0x1724/0x1970
>   ? find_held_lock+0x31/0xa0
>   lock_acquire+0xb0/0x1a0
>   ? btrfs_record_root_in_trans+0x3c/0x70
>   ? btrfs_record_root_in_trans+0x3c/0x70
>   __mutex_lock+0x81/0x8f0
>   ? btrfs_record_root_in_trans+0x3c/0x70
>   ? find_held_lock+0x31/0xa0
>   ? btrfs_record_root_in_trans+0x3c/0x70
>   ? join_transaction+0x39f/0x3f0
>   btrfs_record_root_in_trans+0x3c/0x70
>   start_transaction+0xaa/0x510
>   btrfs_dirty_inode+0x49/0xe0
>   ? current_time+0x46/0x80
>   file_update_time+0xc7/0x110
>   btrfs_page_mkwrite+0x152/0x4f0
>   ? find_held_lock+0x31/0xa0
>   ? do_wp_page+0x4a9/0x5e0
>   do_page_mkwrite+0x2b/0x70
>   do_wp_page+0x4b1/0x5e0
>   __handle_mm_fault+0x6b8/0x10e0
>   handle_mm_fault+0x179/0x360
>   ? handle_mm_fault+0x46/0x360
>   __do_page_fault+0x24d/0x4d0
>   ? page_fault+0x8/0x30
>   page_fault+0x1e/0x30
>  RIP: 0033:0x7fe888361860
>  Code: 00 48 89 df e8 e1 2b ff ff 48 89 c3 48 83 f8 ff 74 2b 4c 89 e1 45 0f b7 45 00 0f b7 c0 48 c1 f9 10 75 4b 48 8b 05 18 d7 20 00 <66> 41 89 5d 00 48 ff 00 48 83 c4 08 5b 41 5c 41 5d 5d c3 e8 a8 2c
>  RSP: 002b:00007fff4ab2ea70 EFLAGS: 00010246
>  RAX: 00007fe8b101c110 RBX: 0000000000000000 RCX: 0000000000000000
>  RDX: 00007fe8b1538708 RSI: 00007fe8b1014040 RDI: 00007fe8b1066d00
>  RBP: 00007fff4ab2ea90 R08: 0000000000000000 R09: 0000000000000000
>  R10: 00007fe8885843e0 R11: 00007fe8b1026540 R12: 0000000000000002
>  R13: 00007fe8b138e000 R14: 00007fe886ace730 R15: 00007fe8b1066d00
