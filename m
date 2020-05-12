Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713371CF6D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 16:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgELOQn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 10:16:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:38452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbgELOQn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 10:16:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE583AF72
        for <linux-btrfs@vger.kernel.org>; Tue, 12 May 2020 14:16:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 685A6DA70B; Tue, 12 May 2020 16:15:50 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Bug 5.7-rc: lockdep warning, fs_reclaim
Date:   Tue, 12 May 2020 16:15:50 +0200
Message-Id: <7a73fed7c40f83f620a0e519fb0cf8da6d13c26721f20e3d72f264492f7d4289.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
References: 
MIME-Version: 1.0
Reference: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

lockdep warning on chunk_mutex/fs_reclaim/delayed_node->mutex

btrfs/073               [16:46:49][ 4389.528850] run fstests btrfs/073 at 2020-05-11 16:46:49

[ 4394.208553] BTRFS info (device vdb): disk space caching is enabled
[ 4394.208698] BTRFS info (device vdb): scrub: finished on devid 4 with status: 0
[ 4394.212495] BTRFS info (device vdb): scrub: finished on devid 5 with status: 0
[ 4394.276890] BTRFS info (device vdb): scrub: finished on devid 6 with status: 0
[ 4394.408713] BTRFS info (device vdb): scrub: finished on devid 1 with status: 0
[ 4394.408814] BTRFS info (device vdb): use zlib compression, level 3
[ 4394.413630] BTRFS info (device vdb): disk space caching is enabled
[ 4394.452197] BTRFS info (device vdb): scrub: started on devid 5
[ 4394.452587] BTRFS info (device vdb): scrub: started on devid 4
[ 4394.462946] BTRFS info (device vdb): scrub: finished on devid 5 with status: 0
[ 4394.473072] BTRFS info (device vdb): scrub: started on devid 3
[ 4394.483089] BTRFS info (device vdb): scrub: started on devid 1
[ 4394.490128] BTRFS info (device vdb): scrub: started on devid 6
[ 4394.494793] BTRFS info (device vdb): scrub: started on devid 2
[ 4394.497311] BTRFS info (device vdb): scrub: finished on devid 4 with status: 0
[ 4394.530402] 
[ 4394.532133] ======================================================
[ 4394.534771] WARNING: possible circular locking dependency detected
[ 4394.536949] 5.7.0-rc5-default+ #1100 Not tainted
[ 4394.538809] ------------------------------------------------------
[ 4394.541508] fsstress/15173 is trying to acquire lock:
[ 4394.542204] BTRFS info (device vdb): scrub: finished on devid 2 with status: 0
[ 4394.544236] ffff9a5c7153c980 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_chunk_alloc+0x137/0x3e0 [btrfs]
[ 4394.544274] 
[ 4394.544274] but task is already holding lock:
[ 4394.553183] ffff9a5c74857458 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_commit_inode_delayed_items+0x58/0x510 [btrfs]
[ 4394.557542] 
[ 4394.557542] which lock already depends on the new lock.
[ 4394.557542] 
[ 4394.561420] 
[ 4394.561420] the existing dependency chain (in reverse order) is:
[ 4394.565023] 
[ 4394.565023] -> #2 (&delayed_node->mutex){+.+.}-{3:3}:
[ 4394.567738]        __lock_acquire+0x581/0xae0
[ 4394.568965]        lock_acquire+0xa3/0x400
[ 4394.570307]        __mutex_lock+0xa0/0xaf0
[ 4394.571983]        __btrfs_release_delayed_node.part.0+0x3f/0x310 [btrfs]
[ 4394.574411]        btrfs_evict_inode+0x3b7/0x550 [btrfs]
[ 4394.576443]        evict+0xd6/0x1c0
[ 4394.578185]        dispose_list+0x48/0x70
[ 4394.579583]        prune_icache_sb+0x54/0x80
[ 4394.581163]        super_cache_scan+0x121/0x1a0
[ 4394.583106]        do_shrink_slab+0x175/0x420
[ 4394.585205]        shrink_slab+0xb1/0x2e0
[ 4394.587248]        shrink_node+0x162/0x5c0
[ 4394.588947]        balance_pgdat+0x324/0x750
[ 4394.590764]        kswapd+0x236/0x530
[ 4394.592227]        kthread+0x130/0x150
[ 4394.593454]        ret_from_fork+0x24/0x30
[ 4394.594737] 
[ 4394.594737] -> #1 (fs_reclaim){+.+.}-{0:0}:
[ 4394.597285]        __lock_acquire+0x581/0xae0
[ 4394.598822]        lock_acquire+0xa3/0x400
[ 4394.600814]        fs_reclaim_acquire.part.0+0x25/0x30
[ 4394.602349]        __kmalloc_track_caller+0x4a/0x370
[ 4394.603671]        kstrdup+0x2e/0x60
[ 4394.604706]        __kernfs_new_node.constprop.0+0x41/0x1c0
[ 4394.605874]        kernfs_new_node+0x25/0x50
[ 4394.606856]        kernfs_create_link+0x34/0xa0
[ 4394.607871]        sysfs_do_create_link_sd+0x5e/0xd0
[ 4394.609063]        btrfs_sysfs_add_devices_dir+0x65/0x100 [btrfs]
[ 4394.610879]        btrfs_init_new_device+0x44b/0x1300 [btrfs]
[ 4394.612519]        btrfs_ioctl+0xc3c/0x2590 [btrfs]
[ 4394.614139]        ksys_ioctl+0x68/0xa0
[ 4394.615490]        __x64_sys_ioctl+0x16/0x20
[ 4394.616988]        do_syscall_64+0x50/0x210
[ 4394.618235]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
[ 4394.619541] 
[ 4394.619541] -> #0 (&fs_info->chunk_mutex){+.+.}-{3:3}:
[ 4394.621414]        check_prev_add+0x98/0xa20
[ 4394.622859]        validate_chain+0xa6c/0x29e0
[ 4394.623992]        __lock_acquire+0x581/0xae0
[ 4394.625165]        lock_acquire+0xa3/0x400
[ 4394.626628]        __mutex_lock+0xa0/0xaf0
[ 4394.627990]        btrfs_chunk_alloc+0x137/0x3e0 [btrfs]
[ 4394.629365]        find_free_extent+0xb47/0xfb0 [btrfs]
[ 4394.630642]        btrfs_reserve_extent+0x9b/0x180 [btrfs]
[ 4394.631977]        btrfs_alloc_tree_block+0xc1/0x350 [btrfs]
[ 4394.633273]        alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
[ 4394.635117]        __btrfs_cow_block+0x143/0x7a0 [btrfs]
[ 4394.636408]        btrfs_cow_block+0x15f/0x310 [btrfs]
[ 4394.638120]        btrfs_search_slot+0x937/0xf70 [btrfs]
[ 4394.639746]        btrfs_insert_empty_items+0x64/0xc0 [btrfs]
[ 4394.641636]        __btrfs_commit_inode_delayed_items+0xaf/0x510 [btrfs]
[ 4394.643733]        __btrfs_run_delayed_items+0x8e/0x140 [btrfs]
[ 4394.645344]        btrfs_commit_transaction+0x312/0xae0 [btrfs]
[ 4394.646804]        btrfs_sync_file+0x345/0x490 [btrfs]
[ 4394.648369]        do_fsync+0x38/0x70
[ 4394.649732]        __x64_sys_fsync+0x10/0x20
[ 4394.651214]        do_syscall_64+0x50/0x210
[ 4394.652691]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
[ 4394.654307] 
[ 4394.654307] other info that might help us debug this:
[ 4394.654307] 
[ 4394.666340] Chain exists of:
[ 4394.666340]   &fs_info->chunk_mutex --> fs_reclaim --> &delayed_node->mutex
[ 4394.666340] 
[ 4394.669883]  Possible unsafe locking scenario:
[ 4394.669883] 
[ 4394.671702]        CPU0                    CPU1
[ 4394.672939]        ----                    ----
[ 4394.674445]   lock(&delayed_node->mutex);
[ 4394.675745]                                lock(fs_reclaim);
[ 4394.677590]                                lock(&delayed_node->mutex);
[ 4394.679685]   lock(&fs_info->chunk_mutex);
[ 4394.681219] 
[ 4394.681219]  *** DEADLOCK ***
[ 4394.681219] 
[ 4394.683928] 2 locks held by fsstress/15173:
[ 4394.685460]  #0: ffff9a5c72851698 (sb_internal#2){.+.+}-{0:0}, at: start_transaction+0x409/0x5e0 [btrfs]
[ 4394.688402]  #1: ffff9a5c74857458 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_commit_inode_delayed_items+0x58/0x510 [btrfs]
[ 4394.691958] 
[ 4394.691958] stack backtrace:
[ 4394.693535] CPU: 3 PID: 15173 Comm: fsstress Not tainted 5.7.0-rc5-default+ #1100
[ 4394.695708] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 4394.698798] Call Trace:
[ 4394.699882]  dump_stack+0x71/0xa0
[ 4394.701212]  check_noncircular+0x16f/0x190
[ 4394.702598]  check_prev_add+0x98/0xa20
[ 4394.703937]  validate_chain+0xa6c/0x29e0
[ 4394.705332]  ? btrfs_sync_file+0x344/0x490 [btrfs]
[ 4394.706947]  ? btrfs_sync_file+0x344/0x490 [btrfs]
[ 4394.708510]  __lock_acquire+0x581/0xae0
[ 4394.709719]  lock_acquire+0xa3/0x400
[ 4394.710743]  ? btrfs_chunk_alloc+0x137/0x3e0 [btrfs]
[ 4394.711960]  __mutex_lock+0xa0/0xaf0
[ 4394.712969]  ? btrfs_chunk_alloc+0x137/0x3e0 [btrfs]
[ 4394.714301]  ? lock_acquire+0xa3/0x400
[ 4394.715359]  ? btrfs_chunk_alloc+0x60/0x3e0 [btrfs]
[ 4394.716540]  ? btrfs_chunk_alloc+0x115/0x3e0 [btrfs]
[ 4394.718071]  ? btrfs_chunk_alloc+0x137/0x3e0 [btrfs]
[ 4394.719301]  ? sched_clock+0x5/0x10
[ 4394.720295]  ? sched_clock_cpu+0x15/0x130
[ 4394.721589]  ? btrfs_chunk_alloc+0x137/0x3e0 [btrfs]
[ 4394.723112]  btrfs_chunk_alloc+0x137/0x3e0 [btrfs]
[ 4394.724618]  find_free_extent+0xb47/0xfb0 [btrfs]
[ 4394.726111]  ? kvm_sched_clock_read+0x14/0x30
[ 4394.727509]  ? sched_clock+0x5/0x10
[ 4394.728768]  btrfs_reserve_extent+0x9b/0x180 [btrfs]
[ 4394.730391]  btrfs_alloc_tree_block+0xc1/0x350 [btrfs]
[ 4394.732123]  alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
[ 4394.733863]  __btrfs_cow_block+0x143/0x7a0 [btrfs]
[ 4394.735463]  btrfs_cow_block+0x15f/0x310 [btrfs]
[ 4394.736755]  btrfs_search_slot+0x937/0xf70 [btrfs]
[ 4394.738465]  btrfs_insert_empty_items+0x64/0xc0 [btrfs]
[ 4394.740230]  __btrfs_commit_inode_delayed_items+0xaf/0x510 [btrfs]
[ 4394.742450]  __btrfs_run_delayed_items+0x8e/0x140 [btrfs]
[ 4394.743916]  btrfs_commit_transaction+0x312/0xae0 [btrfs]
[ 4394.745409]  btrfs_sync_file+0x345/0x490 [btrfs]
[ 4394.746958]  do_fsync+0x38/0x70
[ 4394.747900]  __x64_sys_fsync+0x10/0x20
[ 4394.749010]  do_syscall_64+0x50/0x210
[ 4394.750312]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[ 4394.751628] RIP: 0033:0x7f139f754683
[ 4394.758709] RSP: 002b:00007ffc208bf158 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
[ 4394.761394] RAX: ffffffffffffffda RBX: 0000000000000032 RCX: 00007f139f754683
[ 4394.763330] RDX: 00007ffc208bf0c0 RSI: 00007ffc208bf0c0 RDI: 0000000000000003
[ 4394.764955] RBP: 0000000000000003 R08: 0000000000000001 R09: 00007ffc208bf16c
[ 4394.766611] R10: 000000000040108e R11: 0000000000000246 R12: 0000000000000017
[ 4394.768113] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
