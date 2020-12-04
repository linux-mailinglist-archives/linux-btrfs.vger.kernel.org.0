Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850BE2CF21B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgLDQmm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 11:42:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:53266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbgLDQmm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 11:42:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE33BACC1;
        Fri,  4 Dec 2020 16:42:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5B5EFDA7E3; Fri,  4 Dec 2020 17:40:27 +0100 (CET)
Date:   Fri, 4 Dec 2020 17:40:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix deadlock when cloning inline extent and low
 on free metadata space
Message-ID: <20201204164027.GU6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <39c2a60aa682f69f9823f51aa119d37ef4b9f834.1606909923.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c2a60aa682f69f9823f51aa119d37ef4b9f834.1606909923.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 02, 2020 at 11:55:58AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When cloning an inline extent there are cases where we can not just copy
> the inline extent from the source range to the target range (e.g. when the
> target range starts at an offset greater than zero). In such cases we copy
> the inline extent's data into a page of the destination inode and then
> dirty that page. However, after that we will need to start a transaction
> for each processed extent and, if we are ever low on available metadata
> space, we may need to flush existing delalloc for all dirty inodes in an
> attempt to release metadata space - if that happens we may deadlock:
> 
> * the async reclaim task queued a delalloc work to flush delalloc for
>   the destination inode of the clone operation;
> 
> * the task executing that delalloc work gets blocked waiting for the
>   range with the dirty page to be unlocked, which is currently locked
>   by the task doing the clone operation;
> 
> * the async reclaim task blocks waiting for the delalloc work to complete;
> 
> * the cloning task is waiting on the waitqueue of its reservation ticket
>   while holding the range with the dirty page locked in the inode's
>   io_tree;
> 
> * if metadata space is not released by some other task (like delalloc for
>   some other inode completing for example), the clone task waits forever
>   and as a consequence the delalloc work and async reclaim tasks will hang
>   forever as well. Releasing more space on the other hand may require
>   starting a transaction, which will hang as well when trying to reserve
>   metadata space, resulting in a deadlock between all these tasks.
> 
> When this happens, traces like the following show up in dmesg/syslog:
> 
> [87452.323003] INFO: task kworker/u16:11:1810830 blocked for more than 120 seconds.
> [87452.323644]       Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
> [87452.324248] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [87452.324852] task:kworker/u16:11  state:D stack:    0 pid:1810830 ppid:     2 flags:0x00004000
> [87452.325520] Workqueue: btrfs-flush_delalloc btrfs_work_helper [btrfs]
> [87452.326136] Call Trace:
> [87452.326737]  __schedule+0x5d1/0xcf0
> [87452.327390]  schedule+0x45/0xe0
> [87452.328174]  lock_extent_bits+0x1e6/0x2d0 [btrfs]
> [87452.328894]  ? finish_wait+0x90/0x90
> [87452.329474]  btrfs_invalidatepage+0x32c/0x390 [btrfs]
> [87452.330133]  ? __mod_memcg_state+0x8e/0x160
> [87452.330738]  __extent_writepage+0x2d4/0x400 [btrfs]
> [87452.331405]  extent_write_cache_pages+0x2b2/0x500 [btrfs]
> [87452.332007]  ? lock_release+0x20e/0x4c0
> [87452.332557]  ? trace_hardirqs_on+0x1b/0xf0
> [87452.333127]  extent_writepages+0x43/0x90 [btrfs]
> [87452.333653]  ? lock_acquire+0x1a3/0x490
> [87452.334177]  do_writepages+0x43/0xe0
> [87452.334699]  ? __filemap_fdatawrite_range+0xa4/0x100
> [87452.335720]  __filemap_fdatawrite_range+0xc5/0x100
> [87452.336500]  btrfs_run_delalloc_work+0x17/0x40 [btrfs]
> [87452.337216]  btrfs_work_helper+0xf1/0x600 [btrfs]
> [87452.337838]  process_one_work+0x24e/0x5e0
> [87452.338437]  worker_thread+0x50/0x3b0
> [87452.339137]  ? process_one_work+0x5e0/0x5e0
> [87452.339884]  kthread+0x153/0x170
> [87452.340507]  ? kthread_mod_delayed_work+0xc0/0xc0
> [87452.341153]  ret_from_fork+0x22/0x30
> [87452.341806] INFO: task kworker/u16:1:2426217 blocked for more than 120 seconds.
> [87452.342487]       Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
> [87452.343274] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [87452.344049] task:kworker/u16:1   state:D stack:    0 pid:2426217 ppid:     2 flags:0x00004000
> [87452.344974] Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
> [87452.345655] Call Trace:
> [87452.346305]  __schedule+0x5d1/0xcf0
> [87452.346947]  ? kvm_clock_read+0x14/0x30
> [87452.347676]  ? wait_for_completion+0x81/0x110
> [87452.348389]  schedule+0x45/0xe0
> [87452.349077]  schedule_timeout+0x30c/0x580
> [87452.349718]  ? _raw_spin_unlock_irqrestore+0x3c/0x60
> [87452.350340]  ? lock_acquire+0x1a3/0x490
> [87452.351006]  ? try_to_wake_up+0x7a/0xa20
> [87452.351541]  ? lock_release+0x20e/0x4c0
> [87452.352040]  ? lock_acquired+0x199/0x490
> [87452.352517]  ? wait_for_completion+0x81/0x110
> [87452.353000]  wait_for_completion+0xab/0x110
> [87452.353490]  start_delalloc_inodes+0x2af/0x390 [btrfs]
> [87452.353973]  btrfs_start_delalloc_roots+0x12d/0x250 [btrfs]
> [87452.354455]  flush_space+0x24f/0x660 [btrfs]
> [87452.355063]  btrfs_async_reclaim_metadata_space+0x1bb/0x480 [btrfs]
> [87452.355565]  process_one_work+0x24e/0x5e0
> [87452.356024]  worker_thread+0x20f/0x3b0
> [87452.356487]  ? process_one_work+0x5e0/0x5e0
> [87452.356973]  kthread+0x153/0x170
> [87452.357434]  ? kthread_mod_delayed_work+0xc0/0xc0
> [87452.357880]  ret_from_fork+0x22/0x30
> (...)
> < stack traces of several tasks waiting for the locks of the inodes of the
>   clone operation >
> (...)
> [92867.444138] RSP: 002b:00007ffc3371bbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
> [92867.444624] RAX: ffffffffffffffda RBX: 00007ffc3371bea0 RCX: 00007f61efe73f97
> [92867.445116] RDX: 0000000000000000 RSI: 0000560fbd5d7a40 RDI: 0000560fbd5d8960
> [92867.445595] RBP: 00007ffc3371beb0 R08: 0000000000000001 R09: 0000000000000003
> [92867.446070] R10: 00007ffc3371b996 R11: 0000000000000246 R12: 0000000000000000
> [92867.446820] R13: 000000000000001f R14: 00007ffc3371bea0 R15: 00007ffc3371beb0
> [92867.447361] task:fsstress        state:D stack:    0 pid:2508238 ppid:2508153 flags:0x00004000
> [92867.447920] Call Trace:
> [92867.448435]  __schedule+0x5d1/0xcf0
> [92867.448934]  ? _raw_spin_unlock_irqrestore+0x3c/0x60
> [92867.449423]  schedule+0x45/0xe0
> [92867.449916]  __reserve_bytes+0x4a4/0xb10 [btrfs]
> [92867.450576]  ? finish_wait+0x90/0x90
> [92867.451202]  btrfs_reserve_metadata_bytes+0x29/0x190 [btrfs]
> [92867.451815]  btrfs_block_rsv_add+0x1f/0x50 [btrfs]
> [92867.452412]  start_transaction+0x2d1/0x760 [btrfs]
> [92867.453216]  clone_copy_inline_extent+0x333/0x490 [btrfs]
> [92867.453848]  ? lock_release+0x20e/0x4c0
> [92867.454539]  ? btrfs_search_slot+0x9a7/0xc30 [btrfs]
> [92867.455218]  btrfs_clone+0x569/0x7e0 [btrfs]
> [92867.455952]  btrfs_clone_files+0xf6/0x150 [btrfs]
> [92867.456588]  btrfs_remap_file_range+0x324/0x3d0 [btrfs]
> [92867.457213]  do_clone_file_range+0xd4/0x1f0
> [92867.457828]  vfs_clone_file_range+0x4d/0x230
> [92867.458355]  ? lock_release+0x20e/0x4c0
> [92867.458890]  ioctl_file_clone+0x8f/0xc0
> [92867.459377]  do_vfs_ioctl+0x342/0x750
> [92867.459913]  __x64_sys_ioctl+0x62/0xb0
> [92867.460377]  do_syscall_64+0x33/0x80
> [92867.460842]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> (...)
> < stack traces of more tasks blocked on metadata reservation like the clone
>   task above, because the async reclaim task has deadlocked >
> (...)
> 
> Another thing to notice is that the worker task that is deadlocked when
> trying to flush the destination inode of the clone operation is at
> btrfs_invalidatepage(). This is simply because the clone operation has a
> destination offset greater than the i_size and we only update the i_size
> of the destination file after cloning an extent (just like we do in the
> buffered write path).
> 
> Since the async reclaim path uses btrfs_start_delalloc_roots() to trigger
> the flushing of delalloc for all inodes that have delalloc, add a runtime
> flag to an inode to signal it should not be flushed, and for inodes with
> that flag set, start_delalloc_inodes() will simply skip them. When the
> cloning code needs to dirty a page to copy an inline extent, set that flag
> on the inode and then clear it when the clone operation finishes.
> 
> This could be sporadically triggered with test case generic/269 from
> fstests, which exercises many fsstress processes running in parallel with
> several dd processes filling up the entire filesystem.
> 
> Fixes: 05a5a7621ce6 ("Btrfs: implement full reflink support for inline extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
