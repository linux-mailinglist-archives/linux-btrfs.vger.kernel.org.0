Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0D118A5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 15:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfLJOE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 09:04:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:55670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbfLJOEz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 09:04:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B098AAC82;
        Tue, 10 Dec 2019 14:04:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7AEA5DA7A1; Tue, 10 Dec 2019 15:04:41 +0100 (CET)
Date:   Tue, 10 Dec 2019 15:04:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 00/22] btrfs: async discard support
Message-ID: <20191210140438.GU2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1575919745.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 09, 2019 at 11:45:45AM -0800, Dennis Zhou wrote:
> Hello,
> 
> Dave reported that with async discard enabled, relocation fails [1].
> This could be caused by two things. First, if we unpin extents, that
> means we haven't fully discarded the block group and need to let async
> discard revisit it. Second, relocation removes block_groups outside of
> the normal. I fixed both issues and now it successfully passes xfstests
> btrfs/003.
> 
> Changes in v5:
>  - Changed the rules so free space is always added as the right type
>    based on discard settings (see btrfs_add_free_space()), this removes
>    the need to pass around trim_state in unpin_extent_range().
>  - Handled relocation block group deletion (xfstests btrfs/003)
>  - When adding to the discard lists, make sure the work queue is active.
>    (made all additions go through either btrfs_discard_queue_work() or
>    btrfs_discard_check_filter()).
>  - Added 10 sec reuse timeout for fully empty block groups.

btrfs/011 reports potential deadlock:

[ 2233.150902] ======================================================
[ 2233.155184] WARNING: possible circular locking dependency detected
[ 2233.159746] 5.5.0-rc1-default+ #902 Not tainted
[ 2233.162553] ------------------------------------------------------
[ 2233.165116] btrfs-cleaner/3837 is trying to acquire lock:
[ 2233.166725] ffff909174ab6218 (&(&ctl->tree_lock)->rlock){+.+.}, at: btrfs_is_free_space_trimmed+0x17/0x70 [btrfs]
[ 2233.168932]
[ 2233.168932] but task is already holding lock:
[ 2233.170626] ffff909160b24c28 (&(&cache->lock)->rlock){+.+.}, at: btrfs_delete_unused_bgs+0x113/0x880 [btrfs]
[ 2233.173347]
[ 2233.173347] which lock already depends on the new lock.
[ 2233.173347]
[ 2233.176447]
[ 2233.176447] the existing dependency chain (in reverse order) is:
[ 2233.179479]
[ 2233.179479] -> #3 (&(&cache->lock)->rlock){+.+.}:
[ 2233.182365]        lock_acquire+0x95/0x1a0
[ 2233.183768]        _raw_spin_lock+0x31/0x80
[ 2233.185260]        btrfs_add_reserved_bytes+0x3c/0x440 [btrfs]
[ 2233.186583]        find_free_extent+0x63e/0xf10 [btrfs]
[ 2233.187736]        btrfs_reserve_extent+0x9b/0x180 [btrfs]
[ 2233.188923]        btrfs_alloc_tree_block+0xc1/0x350 [btrfs]
[ 2233.190150]        alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
[ 2233.200938]        __btrfs_cow_block+0x143/0x7a0 [btrfs]
[ 2233.202579]        btrfs_cow_block+0x15f/0x310 [btrfs]
[ 2233.204288]        commit_cowonly_roots+0x55/0x310 [btrfs]
[ 2233.206106]        btrfs_commit_transaction+0x505/0xaf0 [btrfs]
[ 2233.207801]        sync_filesystem+0x6e/0x90
[ 2233.209176]        generic_shutdown_super+0x22/0x100
[ 2233.210647]        kill_anon_super+0x14/0x30
[ 2233.212040]        btrfs_kill_super+0x12/0xa0 [btrfs]
[ 2233.213704]        deactivate_locked_super+0x2c/0x70
[ 2233.215428]        cleanup_mnt+0x100/0x160
[ 2233.216996]        task_work_run+0x90/0xc0
[ 2233.218500]        exit_to_usermode_loop+0x96/0xa0
[ 2233.220150]        do_syscall_64+0x1df/0x210
[ 2233.221654]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 2233.223667]
[ 2233.223667] -> #2 (&(&space_info->lock)->rlock){+.+.}:
[ 2233.226158]        lock_acquire+0x95/0x1a0
[ 2233.227665]        _raw_spin_lock+0x31/0x80
[ 2233.229209]        __btrfs_block_rsv_release+0x1a6/0x440 [btrfs]
[ 2233.231268]        btrfs_inode_rsv_release+0x4f/0x190 [btrfs]
[ 2233.232915]        btrfs_clear_delalloc_extent+0x155/0x4b0 [btrfs]
[ 2233.234643]        clear_state_bit+0x84/0x1c0 [btrfs]
[ 2233.236127]        __clear_extent_bit+0x22d/0x5b0 [btrfs]
[ 2233.237741]        clear_extent_bit+0x15/0x20 [btrfs]
[ 2233.239452]        btrfs_invalidatepage+0x29b/0x2f0 [btrfs]
[ 2233.241379]        truncate_cleanup_page+0x42/0xa0
[ 2233.243061]        truncate_inode_pages_range+0x2bf/0xb40
[ 2233.244935]        truncate_pagecache+0x44/0x60
[ 2233.246513]        btrfs_setsize+0x11f/0x4d0 [btrfs]
[ 2233.248233]        btrfs_setattr+0x5c/0xe0 [btrfs]
[ 2233.249655]        notify_change+0x283/0x415
[ 2233.251138]        do_truncate+0x76/0xd0
[ 2233.252472]        do_last+0x4a5/0x7e0
[ 2233.253775]        path_openat+0xa2/0x250
[ 2233.255239]        do_filp_open+0x91/0x100
[ 2233.256626]        do_sys_open+0x184/0x220
[ 2233.258098]        do_syscall_64+0x50/0x210
[ 2233.259539]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 2233.261337] -> #1 (&(&tree->lock)->rlock){+.+.}:
[ 2233.263598]        lock_acquire+0x95/0x1a0
[ 2233.265134]        _raw_spin_lock+0x31/0x80
[ 2233.266726]        find_first_extent_bit+0x32/0x150 [btrfs]
[ 2233.268354]        write_pinned_extent_entries+0xc5/0x100 [btrfs]
[ 2233.270202]        __btrfs_write_out_cache+0x16d/0x4a0 [btrfs]
[ 2233.272011]        btrfs_write_out_cache+0x7a/0xf0 [btrfs]
[ 2233.273581]        btrfs_write_dirty_block_groups+0x286/0x3a0 [btrfs]
[ 2233.275305]        commit_cowonly_roots+0x24f/0x310 [btrfs]
[ 2233.276808]        btrfs_commit_transaction+0x505/0xaf0 [btrfs]
[ 2233.278699]        sync_filesystem+0x6e/0x90
[ 2233.280351]        generic_shutdown_super+0x22/0x100
[ 2233.282198]        kill_anon_super+0x14/0x30
[ 2233.283907]        btrfs_kill_super+0x12/0xa0 [btrfs]
[ 2233.285774]        deactivate_locked_super+0x2c/0x70
[ 2233.287660]        cleanup_mnt+0x100/0x160
[ 2233.289326]        task_work_run+0x90/0xc0
[ 2233.291035]        exit_to_usermode_loop+0x96/0xa0
[ 2233.292580]        do_syscall_64+0x1df/0x210
[ 2233.293892]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 2233.295558]
[ 2233.295558] -> #0 (&(&ctl->tree_lock)->rlock){+.+.}:
[ 2233.298058]        check_prev_add+0xa2/0xa90
[ 2233.299576]        __lock_acquire+0xe97/0x1320
[ 2233.301189]        lock_acquire+0x95/0x1a0
[ 2233.302709]        _raw_spin_lock+0x31/0x80
[ 2233.304283]        btrfs_is_free_space_trimmed+0x17/0x70 [btrfs]
[ 2233.306283]        btrfs_delete_unused_bgs+0x2b3/0x880 [btrfs]
[ 2233.308376]        cleaner_kthread+0x162/0x170 [btrfs]
[ 2233.310020]        kthread+0x122/0x140
[ 2233.311285]        ret_from_fork+0x24/0x30
[ 2233.312619]
[ 2233.312619] other info that might help us debug this:
[ 2233.312619]
[ 2233.315394] Chain exists of:
[ 2233.315394]   &(&ctl->tree_lock)->rlock --> &(&space_info->lock)->rlock --> &(&cache->lock)->rlock
[ 2233.315394]
[ 2233.319913]  Possible unsafe locking scenario:
[ 2233.319913]
[ 2233.322174]        CPU0                    CPU1
[ 2233.323685]        ----                    ----
[ 2233.325156]   lock(&(&cache->lock)->rlock);
[ 2233.326601]                                lock(&(&space_info->lock)->rlock);
[ 2233.328588]                                lock(&(&cache->lock)->rlock);
[ 2233.330542]   lock(&(&ctl->tree_lock)->rlock);
[ 2233.332055]
[ 2233.332055]  *** DEADLOCK ***
[ 2233.332055]
[ 2233.334678] 3 locks held by btrfs-cleaner/3837:
[ 2233.336219]  #0: ffff90914c2bfb88 (&fs_info->delete_unused_bgs_mutex){+.+.}, at: btrfs_delete_unused_bgs+0x103/0x880 [btrfs]
[ 2233.339756]  #1: ffff909160b235c8 (&space_info->groups_sem){++++}, at: btrfs_delete_unused_bgs+0x10b/0x880 [btrfs]
[ 2233.343098]  #2: ffff909160b24c28 (&(&cache->lock)->rlock){+.+.}, at: btrfs_delete_unused_bgs+0x113/0x880 [btrfs]
[ 2233.346574]
[ 2233.346574] stack backtrace:
[ 2233.348723] CPU: 0 PID: 3837 Comm: btrfs-cleaner Not tainted 5.5.0-rc1-default+ #902
[ 2233.351558] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-rebuilt.opensuse.org 04/01/2014
[ 2233.355122] Call Trace:
[ 2233.356104]  dump_stack+0x71/0xa0
[ 2233.357228]  check_noncircular+0x177/0x190
[ 2233.358640]  check_prev_add+0xa2/0xa90
[ 2233.359958]  ? kvm_sched_clock_read+0x14/0x30
[ 2233.361305]  __lock_acquire+0xe97/0x1320
[ 2233.362583]  lock_acquire+0x95/0x1a0
[ 2233.363853]  ? btrfs_is_free_space_trimmed+0x17/0x70 [btrfs]
[ 2233.365428]  _raw_spin_lock+0x31/0x80
[ 2233.366644]  ? btrfs_is_free_space_trimmed+0x17/0x70 [btrfs]
[ 2233.368228]  btrfs_is_free_space_trimmed+0x17/0x70 [btrfs]
[ 2233.369861]  btrfs_delete_unused_bgs+0x2b3/0x880 [btrfs]
[ 2233.371672]  ? __mutex_unlock_slowpath+0x45/0x2a0
[ 2233.373291]  cleaner_kthread+0x162/0x170 [btrfs]
[ 2233.374767]  ? __btrfs_btree_balance_dirty+0x60/0x60 [btrfs]
[ 2233.376396]  kthread+0x122/0x140
[ 2233.377525]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 2233.379210]  ret_from_fork+0x24/0x30
